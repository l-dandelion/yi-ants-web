package cluster

import (
	"github.com/l-dandelion/yi-ants-go/lib/base"
	"github.com/l-dandelion/yi-ants-web/models/service/cluster"
)

type AllController struct {
	base.BaseController
}

func (c *AllController) Prepare() {
	c.BaseController.Prepare()
}

func (c *AllController) Process() {
	nis := cluster.GetNodeInfos()
	c.SetOutMapData("nodeInfos", nis)
}
