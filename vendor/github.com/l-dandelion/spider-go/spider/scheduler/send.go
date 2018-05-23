package scheduler

import (
	"strings"

	"github.com/l-dandelion/spider-go/spider/module/data"
	log "github.com/sirupsen/logrus"
	"github.com/l-dandelion/yi-ants-go/lib/constant"
)

/*
 * send request to request buffer pool
 */
func (sched *myScheduler) sendReq(req *data.Request) bool {
	if req == nil {
		return false
	}
	if sched.canceled() {
		return false
	}
	httpReq := req.HttpReq
	if httpReq == nil {
		//log.Warnln("Ignore the request! Its HTTP request is invalid!")
		return false
	}
	reqURL := httpReq.URL
	if reqURL == nil {
		//log.Warnln("Ignore the request! Its URL is invalid!")
		return false
	}
	scheme := strings.ToLower(reqURL.Scheme)
	if scheme != "http" && scheme != "https" {
		//log.Warnf("Ignore the request! Its URL scheme is %q, but should be %q or %q. (URL: %s)\n", scheme, "http", "https", reqURL)
		return false
	}
	if v := sched.urlMap.Get(reqURL.String()); v != nil {
		//log.Warnf("Ignore the request! Its URL is repeated. (URL: %s)\n", reqURL)
		return false
	}
	pd, _ := getPrimaryDomain(httpReq.Host)
	if sched.acceptedDomainMap.Get(pd) == nil {
		//log.Warnf("Ignore the request! Its host %q is not in accepted primary domain map. (URL: %s)\n", httpReq.Host, reqURL)
		return false
	}
	if req.Depth > sched.maxDepth {
		//log.Warnf("Ignore the request! Its depth %d is greater than %d. (URL: %s)\n", req.Depth(), sched.maxDepth, reqURL)
		return false
	}
	if sched.distributeQeueu != nil {
		req.SetSpiderName(sched.name)
		go func(req *data.Request) {
			if err := sched.distributeQeueu.Put(req); err != nil {
				log.Warnln("The distribute buffer pool was closed. Ignore request sending.")
			}
			if constant.RunMode == "dev" {
				log.Infof("Send req distribute, %v Size: %d", req, sched.distributeQeueu.Total())
			}
		}(req)
		sched.urlMap.Put(reqURL.String(), struct{}{})
	} else {
		go func(req *data.Request) {
			ctx := data.NewContext(req)
			if err := sched.reqBufferPool.Put(ctx); err != nil {
				log.Warnln("The request buffer pool was closed. Ignore request sending.")
			}
		}(req)
		sched.urlMap.Put(reqURL.String(), struct{}{})
	}
	return true
}


/*
 * send request to request buffer pool
 */
func (sched *myScheduler) AcceptReq(req *data.Request) bool {
	go func(req *data.Request) {
		ctx := data.NewContext(req)
		if err := sched.reqBufferPool.Put(ctx); err != nil {
			log.Warnln("The request buffer pool was closed. Ignore request sending.")
		}
		if constant.RunMode == "dev" {
			log.Infof("Accept request: %v request buffer size: %d", req, sched.reqBufferPool.Total())
		}
	}(req)
	return true
}


/*
 * send response to response buffer pool
 */
func (sched *myScheduler) sendResp(ctx *data.Context) bool {
	respBufferPool := sched.respBufferPool
	if ctx == nil || respBufferPool == nil || respBufferPool.Closed() {
		return false
	}
	go func(ctx *data.Context) {
		if err := respBufferPool.Put(ctx); err != nil {
			log.Warnln("The response buffer pool was closed. Ignore response sending.")
		}
	}(ctx)
	return true
}


/*
 * send item to item buffer pool
 */
func (sched *myScheduler) sendItem(ctx *data.Context) bool {
	itemBufferPool := sched.itemBufferPool
	if ctx == nil || itemBufferPool == nil || itemBufferPool.Closed() {
		return false
	}
	go func(ctx *data.Context) {
		if err := itemBufferPool.Put(ctx); err != nil {
			log.Warnln("The item buffer pool was closed. Ignore item sending.")
		}
	}(ctx)
	return true
}


/*
 * send error to error buffer pool
 */
func (sched *myScheduler)sendError(errs ...error) {
	for _, err := range errs {
		errorBufferPool := sched.errorBufferPool
		if err == nil || errorBufferPool == nil || errorBufferPool.Closed() {
			continue
		}
		if errorBufferPool.Closed() {
			return
		}
		go func(err error) {
			if err := errorBufferPool.Put(err); err != nil {
				log.Warnln("The error buffer pool was closed. Ignore error sending.")
			}
		}(err)
	}
}
