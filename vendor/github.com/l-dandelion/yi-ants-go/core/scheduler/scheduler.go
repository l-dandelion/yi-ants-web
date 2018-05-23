package scheduler

import (
	"context"
	"fmt"
	"sync"

	"github.com/l-dandelion/yi-ants-go/core/module"
	"github.com/l-dandelion/yi-ants-go/core/module/data"
	"github.com/l-dandelion/yi-ants-go/lib/constant"
	"github.com/l-dandelion/yi-ants-go/lib/library/buffer"
	"github.com/l-dandelion/yi-ants-go/lib/library/cmap"
	log "github.com/sirupsen/logrus"
	"time"
)

type Scheduler interface {
	SchedulerName() string
	Init(RequestArgs, DataArgs, ModuleArgs) *constant.YiError
	Start(initialReqs []*data.Request) *constant.YiError
	Pause() *constant.YiError
	Recover() *constant.YiError
	Stop() *constant.YiError
	Status() int8
	ErrorChan() <-chan *constant.YiError // get error
	Idle() bool                          // check whether the job is finished
	Summary() SchedSummary               // get schduler summary
	SendReq(req *data.Request) bool
	SetDistributeQueue(pool buffer.Pool)
	SignRequest(request *data.Request)
	HasRequest(request *data.Request) bool
}

/*
 * create an instance of interface Scheduler by name
 */
func New(name string) Scheduler {
	return &myScheduler{name: name}
}

/*
 * create an instance of interface Scheduler
 */
func NewScheduler() Scheduler {
	return &myScheduler{}
}

/*
 * implementation of interface Scheduler
 */
type myScheduler struct {
	name              string
	maxDepth          uint32             // the max crawl depth
	acceptedDomainMap cmap.ConcurrentMap // accepted domain
	reqBufferPool     buffer.Pool        // request buffer pool
	respBufferPool    buffer.Pool        // response buffer pool
	itemBufferPool    buffer.Pool        // item buffer pool
	errorBufferPool   buffer.Pool        // error buffer pool
	urlMap            cmap.ConcurrentMap // url map
	ctx               context.Context    // used for stoping
	cancelFunc        context.CancelFunc // used for stoping
	status            int8               // running status
	statusLock        sync.RWMutex       // status lock
	summary           SchedSummary       // sched summary
	downloader        module.Downloader  // downloader
	analyzer          module.Analyzer    // analyzer
	pipeline          module.Pipeline    // pipeline
	distributeQeueu   buffer.Pool
}

/*
 * get scheduler name
 */
func (sched *myScheduler) SchedulerName() string {
	return sched.name
}

/*
 * initialize schduler
 */
func (sched *myScheduler) Init(
	requestArgs RequestArgs,
	dataArgs DataArgs,
	moduleArgs ModuleArgs) (yierr *constant.YiError) {
	//check status
	log.Info("Check status for initialization...")
	oldStatus, yierr := sched.checkAndSetStatus(constant.RUNNING_STATUS_PREPARING)
	if yierr != nil {
		return
	}
	defer func() {
		sched.statusLock.Lock()
		if yierr != nil {
			sched.status = oldStatus
		} else {
			sched.status = constant.RUNNING_STATUS_PREPARED
		}
		sched.statusLock.Unlock()
	}()

	//check arguments
	log.Info("Check request arguments...")
	if yierr = requestArgs.Check(); yierr != nil {
		return
	}
	log.Info("Request arguments are valid.")

	log.Info("Check data arguments...")
	if yierr = dataArgs.Check(); yierr != nil {
		return
	}
	log.Info("Data arguments are valid.")

	log.Info("Check module arguments...")
	if yierr = moduleArgs.Check(); yierr != nil {
		return
	}
	log.Info("Module arguments are valid.")

	// initialize internal fields
	log.Info("Initialize Scheduler's fields...")
	sched.maxDepth = requestArgs.MaxDepth
	log.Infof("-- Max depth: %d", sched.maxDepth)

	sched.acceptedDomainMap, _ = cmap.NewConcurrentMap(1, nil)
	for _, domain := range requestArgs.AcceptedDomains {
		sched.acceptedDomainMap.Put(domain, struct{}{})
	}
	log.Infof("-- Accepted primay domains: %v", requestArgs.AcceptedDomains)

	sched.urlMap, _ = cmap.NewConcurrentMap(16, nil)
	log.Infof("-- URL map: length: %d, concurrency: %d", sched.urlMap.Len(), sched.urlMap.Concurrency())

	//initialize modules
	sched.downloader = moduleArgs.Downloader
	sched.analyzer = moduleArgs.Analyzer
	sched.pipeline = moduleArgs.Pipeline

	sched.initBufferPool(dataArgs)
	sched.resetContext()

	sched.summary = newSchedSummary(requestArgs, dataArgs, moduleArgs, sched)

	log.Info("Scheduler has been initialized.")
	return
}

/*
 * start scheduler
 */
func (sched *myScheduler) Start(initialReqs []*data.Request) (yierr *constant.YiError) {
	defer func() {
		if p := recover(); p != nil {
			errMsg := fmt.Sprintf("Fatal Scheduler error: %s", p)
			log.Fatal(errMsg)
			yierr = constant.NewYiErrorf(constant.ERR_CRAWL_SCHEDULER, errMsg)
		}
	}()
	log.Info("Start Scheduler ...")
	log.Info("Check status for start ...")
	var oldStatus int8
	oldStatus, yierr = sched.checkAndSetStatus(constant.RUNNING_STATUS_STARTING)
	if yierr != nil {
		return
	}
	defer func() {
		sched.statusLock.Lock()
		if yierr != nil {
			sched.status = oldStatus
		} else {
			sched.status = constant.RUNNING_STATUS_STARTED
		}
		sched.statusLock.Unlock()
	}()
	//log.Info("Check initial request list...")
	//if initialReqs == nil {
	//	yierr = constant.NewYiErrorf(constant.ERR_CRAWL_SCHEDULER, "Nil initial HTTP request list")
	//	return
	//}
	//log.Info("Initial HTTP request list is valid.")

	log.Info("Get the primary domain...")

	for _, req := range initialReqs {
		httpReq := req.HTTPReq()
		log.Infof("-- Host: %s", httpReq.Host)
		var primaryDomain string
		primaryDomain, yierr = getPrimaryDomain(httpReq.Host)
		if yierr != nil {
			return
		}
		ok, _ := sched.acceptedDomainMap.Put(primaryDomain, struct{}{})
		if ok {
			log.Infof("-- Primary domain: %s", primaryDomain)
		}
	}

	if yierr = sched.checkBufferForStart(); yierr != nil {
		return
	}
	sched.download()
	sched.analyze()
	sched.pick()
	log.Info("The Scheduler has been started.")
	for _, req := range initialReqs {
		sched.sendReq(req)
	}
	return nil
}

/*
 * pause scheduler
 */
func (sched *myScheduler) Pause() (yierr *constant.YiError) {
	//check status
	log.Info("Pause Scheduler ...")
	log.Info("Check status for pause ...")
	var oldStatus int8
	oldStatus, yierr = sched.checkAndSetStatus(constant.RUNNING_STATUS_PAUSING)
	if yierr != nil {
		return
	}
	defer func() {
		sched.statusLock.Lock()
		if yierr != nil {
			sched.status = oldStatus
		} else {
			sched.status = constant.RUNNING_STATUS_PAUSED
		}
		sched.statusLock.Unlock()
	}()
	log.Info("Scheduler has been paused.")
	return nil
}

/*
 * recover scheduler
 */
func (sched *myScheduler) Recover() (yierr *constant.YiError) {
	log.Info("Recover Scheduler ...")
	log.Info("Check status for recover ...")
	var oldStatus int8
	oldStatus, yierr = sched.checkAndSetStatus(constant.RUNNING_STATUS_STARTING)
	if yierr != nil {
		return
	}
	defer func() {
		sched.statusLock.Lock()
		if yierr != nil {
			sched.status = oldStatus
		} else {
			sched.status = constant.RUNNING_STATUS_STARTED
		}
		sched.statusLock.Unlock()
	}()
	log.Info("Scheduler has been recovered.")
	return nil
}

/*
 * stop scheduler
 */
func (sched *myScheduler) Stop() (yierr *constant.YiError) {
	log.Info("Stop Scheduler ...")
	log.Info("Check status for stop ...")
	var oldStatus int8
	oldStatus, yierr = sched.checkAndSetStatus(constant.RUNNING_STATUS_STOPPING)
	if yierr != nil {
		return
	}
	defer func() {
		sched.statusLock.Lock()
		if yierr != nil {
			sched.status = oldStatus
		} else {
			sched.status = constant.RUNNING_STATUS_STOPPED
		}
		sched.statusLock.Unlock()
	}()

	sched.cancelFunc()
	sched.reqBufferPool.Close()
	sched.respBufferPool.Close()
	sched.itemBufferPool.Close()
	sched.errorBufferPool.Close()
	log.Info("Scheduler has been stopped.")
	return nil
}

/*
 * get error chan
 */
func (sched *myScheduler) ErrorChan() <-chan *constant.YiError {
	errBuffer := sched.errorBufferPool
	errCh := make(chan *constant.YiError, errBuffer.BufferCap())
	go func(errBuffer buffer.Pool, errCh chan *constant.YiError) {
		for {
			//stopped
			if sched.canceled() {
				close(errCh)
				break
			}
			//paused
			if sched.Status() == constant.RUNNING_STATUS_PAUSED {
				time.Sleep(100 * time.Millisecond)
				continue
			}
			datum, err := errBuffer.Get()
			if err != nil {
				log.Warnln("The error buffer pool was closed. Break error reception.")
				close(errCh)
				break
			}
			yierr, ok := datum.(*constant.YiError)
			if !ok {
				yierr := constant.NewYiErrorf(constant.ERR_CRAWL_SCHEDULER,
					"Incorrect error type: %T", datum)
				sched.sendError(yierr)
				continue
			}
			if sched.canceled() {
				close(errCh)
				break
			}
			errCh <- yierr
		}
	}(errBuffer, errCh)
	return errCh
}

/*
 * check whether all are finished.
 */
func (sched *myScheduler) Idle() bool {
	if sched.downloader.HandlingNumber() > 0 ||
		sched.analyzer.HandlingNumber() > 0 ||
		sched.pipeline.HandlingNumber() > 0 {
		return false
	}
	if sched.reqBufferPool.Total() > 0 ||
		sched.respBufferPool.Total() > 0 ||
		sched.itemBufferPool.Total() > 0 {
		return false
	}
	return true
}

/*
 * get the scheduler summary
 */
func (shced *myScheduler) Summary() SchedSummary {
	return shced.summary
}

/*
 * check status
 * set new status if check status success
 * return the old status if success, or an error return
 */
func (sched *myScheduler) checkAndSetStatus(wantedStatus int8) (oldStatus int8, yierr *constant.YiError) {
	sched.statusLock.Lock()
	defer sched.statusLock.Unlock()
	oldStatus = sched.status
	yierr = checkStatus(oldStatus, wantedStatus)
	if yierr == nil {
		sched.status = wantedStatus
	}
	return
}

/*
 * initialize buffer pools
 */
func (sched *myScheduler) initBufferPool(dataArgs DataArgs) {
	if sched.reqBufferPool != nil && !sched.reqBufferPool.Closed() {
		sched.reqBufferPool.Close()
	}
	sched.reqBufferPool, _ = buffer.NewPool(dataArgs.ReqBufferCap, dataArgs.ReqMaxBufferNumber)
	log.Infof("-- Request buffer pool: bufferCap: %d, maxBufferNumber: %d", dataArgs.ReqBufferCap, dataArgs.ReqMaxBufferNumber)

	if sched.respBufferPool != nil && !sched.respBufferPool.Closed() {
		sched.respBufferPool.Close()
	}
	sched.respBufferPool, _ = buffer.NewPool(dataArgs.RespBufferCap, dataArgs.RespMaxBufferNumber)
	log.Infof("-- Response buffer pool: bufferCap: %d, maxBufferNumber: %d", dataArgs.RespBufferCap,
		dataArgs.RespMaxBufferNumber)

	if sched.itemBufferPool != nil && !sched.itemBufferPool.Closed() {
		sched.itemBufferPool.Closed()
	}
	sched.itemBufferPool, _ = buffer.NewPool(dataArgs.ItemBufferCap, dataArgs.ItemMaxBufferNumber)
	log.Infof("-- Item buffer pool: bufferCap: %d, maxBufferNumber: %d", dataArgs.ItemBufferCap, dataArgs.ItemMaxBufferNumber)

	if sched.errorBufferPool != nil && !sched.errorBufferPool.Closed() {
		sched.errorBufferPool.Close()
	}
	sched.errorBufferPool, _ = buffer.NewPool(dataArgs.ErrorBufferCap, dataArgs.ErrorMaxBufferNumber)
	log.Info("-- Error buffer pool: bufferCap: %d, maxBufferNumber: %d", dataArgs.ErrorBufferCap, dataArgs.ErrorMaxBufferNumber)
}

/*
 * check buffer for start
 */
func (sched *myScheduler) checkBufferForStart() *constant.YiError {
	if sched.reqBufferPool == nil {
		return constant.NewYiErrorf(constant.ERR_CRAWL_SCHEDULER, "Nil request buffer pool.")
	}
	if sched.reqBufferPool.Closed() {
		sched.reqBufferPool, _ = buffer.NewPool(sched.reqBufferPool.BufferCap(), sched.reqBufferPool.MaxBufferNumber())
	}

	if sched.respBufferPool == nil {
		return constant.NewYiErrorf(constant.ERR_CRAWL_SCHEDULER, "Nil response buffer pool.")
	}
	if sched.respBufferPool.Closed() {
		sched.respBufferPool, _ = buffer.NewPool(sched.respBufferPool.BufferCap(), sched.respBufferPool.MaxBufferNumber())
	}

	if sched.itemBufferPool == nil {
		return constant.NewYiErrorf(constant.ERR_CRAWL_SCHEDULER, "Nil item buffer pool.")
	}
	if sched.itemBufferPool.Closed() {
		sched.itemBufferPool, _ = buffer.NewPool(sched.itemBufferPool.BufferCap(), sched.itemBufferPool.MaxBufferNumber())
	}

	if sched.errorBufferPool == nil {
		return constant.NewYiErrorf(constant.ERR_CRAWL_SCHEDULER, "Nil error buffer pool.")
	}
	if sched.errorBufferPool.Closed() {
		sched.errorBufferPool, _ = buffer.NewPool(sched.errorBufferPool.BufferCap(), sched.errorBufferPool.MaxBufferNumber())
	}
	return nil
}

/*
 * reset context
 */
func (sched *myScheduler) resetContext() {
	sched.ctx, sched.cancelFunc = context.WithCancel(context.Background())
}

/*
 * check whether the scheduler is stopped
 */
func (sched *myScheduler) canceled() bool {
	select {
	case <-sched.ctx.Done():
		return true
	default:
		return false
	}
}

/*
 * get running status
 */
func (sched *myScheduler) Status() int8 {
	sched.statusLock.RLock()
	defer sched.statusLock.RUnlock()
	return sched.status
}

/*
 * set distribute queue
 */
func (sched *myScheduler) SetDistributeQueue(pool buffer.Pool) {
	sched.distributeQeueu = pool
}

/*
 * sign request
 */
func (sched *myScheduler) SignRequest(req *data.Request) {
	sched.urlMap.Put(req.HTTPReq().URL.String(), struct{}{})
}

/*
 * check whether it has request
 */
func (sched *myScheduler) HasRequest(req *data.Request) bool {
	return sched.urlMap.Get(req.HTTPReq().URL.String()) != nil
}