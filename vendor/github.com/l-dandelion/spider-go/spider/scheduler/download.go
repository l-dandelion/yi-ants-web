package scheduler

import (
	"time"

	"github.com/l-dandelion/spider-go/spider/module/data"
	"github.com/l-dandelion/yi-ants-go/lib/constant"
	log "github.com/sirupsen/logrus"
)

/*
 * start download
 */
func (sched *myScheduler) download() {
	go func() {
		for {
			// stopped
			if sched.canceled() {
				break
			}
			// paused
			if sched.Status() == constant.RUNNING_STATUS_PAUSED {
				time.Sleep(100 * time.Millisecond)
				continue
			}
			datum, err := sched.reqBufferPool.Get()
			if err != nil {
				log.Warnln("The request buffer pool was closed. Break request reception.")
				return
			}

			downloaderPool.Add()
			go func(datum interface{}) {
				defer downloaderPool.Done()
				req, ok := datum.(*data.Request)
				if !ok {
					yierr := constant.NewYiErrorf(constant.ERR_CRAWL_SCHEDULER,
						"Incorrect request type: %T", datum)
					sched.sendError(yierr)
					return
				}
				sched.downloadOne(req)
			}(datum)
		}
		downloaderPool.Wait()
	}()
}

/*
 * download one
 */
func (sched *myScheduler) downloadOne(ctx *data.Context) {
	if ctx == nil {
		return
	}
	if sched.canceled() {
		return
	}
	downloader := sched.downloader
	downloader.Download(ctx)
	if ctx.HTTPResp() != nil {
		sched.sendResp(ctx)
	}
	if ctx.ErrorList != nil {
		sched.sendError(ctx.ErrorList...)
	}
}
