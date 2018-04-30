package spider

import (
	"github.com/l-dandelion/yi-ants-go/lib/base"
	"github.com/l-dandelion/yi-ants-web/global"
)

type StopController struct {
	base.BaseController
}

func (c *StopController) Prepare() {
	c.BaseController.Prepare()
}

func (c *StopController) Process() {
	spiderName := c.GetString("spider")
	yierr := global.RpcClient.StopSpider(spiderName)
	if yierr != nil {
		c.SetError(yierr)
		c.SetOutMapData("Success", false)
		return
	}
	c.SetOutMapData("Success", true)
}
