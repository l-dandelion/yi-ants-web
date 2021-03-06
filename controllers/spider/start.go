package spider

import (
	"github.com/l-dandelion/yi-ants-go/lib/base"
	"github.com/l-dandelion/yi-ants-web/global"
)

type StartController struct {
	base.BaseController
}

func (c *StartController) Prepare() {
	c.BaseController.Prepare()
}

func (c *StartController) Process() {
	spiderName := c.GetString("spider")
	yierr := global.RpcClient.StartSpider(spiderName)
	if yierr != nil {
		c.SetError(yierr)
		c.SetOutMapData("Success", false)
		return
	}
	c.SetOutMapData("Success", true)
}
