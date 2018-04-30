package spider

import (
	"github.com/l-dandelion/yi-ants-go/lib/base"
	"github.com/l-dandelion/yi-ants-web/global"
)

type InitController struct {
	base.BaseController
}

func (c *InitController) Prepare() {
	c.BaseController.Prepare()
}

func (c *InitController) Process() {
	spiderName := c.GetString("spider")
	yierr := global.RpcClient.InitSpider(spiderName)
	if yierr != nil {
		c.SetError(yierr)
		c.SetOutMapData("Success", false)
		return
	}
	c.SetOutMapData("Success", true)
}
