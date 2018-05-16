package statistics

import (
	"github.com/l-dandelion/yi-ants-go/lib/base"
	"github.com/l-dandelion/yi-ants-web/global"
	"github.com/l-dandelion/yi-ants-go/core/crawler"
	"github.com/l-dandelion/yi-ants-go/lib/constant"
	"github.com/l-dandelion/yi-ants-go/core/spider"
	spiderModel "github.com/l-dandelion/yi-ants-web/models/service/spider"
)

type PostSpiderController struct {
	base.BaseController
}

func (c *PostSpiderController) Prepare() {
	c.BaseController.Prepare()
}

func (c *PostSpiderController) Process() {
	nodeName := c.GetString("nodename")
	spiderName := c.GetString("spidername")
	c.SetOutMapData("nodename", nodeName)
	c.SetOutMapData("spidername", spiderName)
	var(
		summary *crawler.Summary = &crawler.Summary{}
		yierr *constant.YiError
		spiderStatus *spider.SpiderStatus
	)
	if nodeName == "" && spiderName == ""{
		sis, yierr := spiderModel.GetSpiders()
		if yierr != nil {
			c.SetError(yierr)
			return
		}
		for _, si := range sis {
			summary.Crawled += si.Crawled
			summary.Running += si.Running
			summary.Success += si.Success
			summary.Waiting += si.Waiting
		}
	} else if spiderName == "" {
		summary, yierr = global.RpcClient.CrawlerSummary(nodeName)
	} else if nodeName == "" {
		totalSpiderInfo, _, yierr := spiderModel.GetSpiderInfoMap(spiderName)
		if yierr != nil {
			c.SetError(yierr)
			return
		}
		summary.Crawled += totalSpiderInfo.Crawled
		summary.Running += totalSpiderInfo.Running
		summary.Success += totalSpiderInfo.Success
		summary.Waiting += totalSpiderInfo.Waiting
	} else {
		spiderStatus, yierr = global.RpcClient.GetSpiderStatus(nodeName, spiderName)
		if yierr == nil {
			summary.Crawled = spiderStatus.Crawled
			summary.Running = spiderStatus.Running
			summary.Success = spiderStatus.Success
			summary.Waiting = spiderStatus.Waiting
		}
	}
	c.SetOutMapData("summary", summary)
}
