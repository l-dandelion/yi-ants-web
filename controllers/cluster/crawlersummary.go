package cluster

import (
	"github.com/l-dandelion/yi-ants-go/lib/base"
	"github.com/l-dandelion/yi-ants-web/global"
)

type CrawlerSummaryController struct {
	base.BaseController
}

func (c *CrawlerSummaryController) Prepare() {
	c.BaseController.Prepare()
}

func (c *CrawlerSummaryController) Process() {
	nodeName := c.GetString("node")
	summary, yierr := global.RpcClient.CrawlerSummary(nodeName)
	if yierr != nil {
		c.SetError(yierr)
		return
	}
	c.SetOutMapData("summary", summary)
}
