package spider

import (
	"github.com/l-dandelion/yi-ants-go/lib/base"
	"github.com/l-dandelion/yi-ants-web/global"
)

type ComplileController struct {
	base.BaseController
}

func (c *ComplileController) Prepare() {
	c.BaseController.Prepare()
}

func (c *ComplileController) Process() {
	spiderName := c.GetString("spider")
	go global.RpcClient.ComplileSpider(spiderName)
	c.SetOutMapData("Success", true)
}
