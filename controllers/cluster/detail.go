package cluster

import (
	"github.com/l-dandelion/yi-ants-go/lib/base"
	"github.com/l-dandelion/yi-ants-web/models/service/spider"
	"github.com/l-dandelion/yi-ants-web/global"
)

type DetailController struct {
	base.BaseController
}

func (c *DetailController) Prepare() {
	c.BaseController.Prepare()
}

func (c *DetailController) Process() {
	nodeName := c.GetString("node")
	nodeInfo, yierr := global.RpcClient.GetNodeInfoByNodeName(nodeName)
	if yierr != nil {
		c.SetError(yierr)
		return
	}
	c.SetOutMapData("nodeInfo", nodeInfo)
	distributeQueueSize, yierr := global.RpcClient.GetDistributeQueueSize(nodeName)
	if yierr != nil {
		c.SetError(yierr)
		return
	}
	c.SetOutMapData("distributeQeueuSize", distributeQueueSize)
	sis, yierr := spider.GetSpidersByNodeName(nodeName)
	if yierr != nil {
		c.SetError(yierr)
		return
	}
	c.SetOutMapData("spiderInfos", sis)
}
