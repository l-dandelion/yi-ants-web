package home

import (
	"github.com/l-dandelion/yi-ants-go/lib/base"
	"github.com/l-dandelion/yi-ants-web/global"
)

type IndexController struct {
	base.BaseController
}

func (c *IndexController) Prepare() {
	c.BaseController.Prepare()
}

func (c *IndexController) Process() {
	nodeInfo := global.Node.GetNodeInfo()
	c.SetOutMapData("nodeInfo", nodeInfo)
}
