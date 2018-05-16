package home

import (
	"github.com/l-dandelion/yi-ants-go/lib/base"
	"github.com/l-dandelion/yi-ants-web/global"
)

type DesktopController struct {
	base.BaseController
}

func (c *DesktopController) Prepare() {
	c.BaseController.Prepare()
}

func (c *DesktopController) Process() {
	nodeInfo := global.Node.GetNodeInfo()
	c.SetOutMapData("nodeInfo", nodeInfo)
}
