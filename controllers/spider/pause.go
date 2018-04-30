package spider

import (
	"github.com/l-dandelion/yi-ants-go/lib/base"
	"github.com/l-dandelion/yi-ants-web/global"
)

type PauseController struct {
	base.BaseController
}

func (c *PauseController) Prepare() {
	c.BaseController.Prepare()
}

func (c *PauseController) Process() {
	spiderName := c.GetString("spider")
	yierr := global.RpcClient.PauseSpider(spiderName)
	if yierr != nil {
		c.SetError(yierr)
		c.SetOutMapData("Success", false)
		return
	}
	c.SetOutMapData("Success", true)
}
