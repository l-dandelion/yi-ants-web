package statistics

import (
	"github.com/l-dandelion/yi-ants-go/lib/base"
	"github.com/l-dandelion/yi-ants-web/global"
)

type SpiderController struct {
	base.BaseController
}

func (c *SpiderController) Prepare() {
	c.BaseController.Prepare()
}

func (c *SpiderController) Process() {
	nodeInfos := global.Cluster.GetAllNode()
	spiderNames := global.Node.GetSpidersName()
	c.SetOutMapData("nodeInfos", nodeInfos)
	c.SetOutMapData("spiderNames", spiderNames)
}
