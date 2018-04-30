package spider

import (
	"github.com/l-dandelion/yi-ants-go/lib/base"
	"github.com/l-dandelion/yi-ants-web/global"
)

type RecoverController struct {
	base.BaseController
}

func (c *RecoverController) Prepare() {
	c.BaseController.Prepare()
}

func (c *RecoverController) Process() {
	spiderName := c.GetString("spider")
	yierr := global.RpcClient.RecoverSpider(spiderName)
	if yierr != nil {
		c.SetError(yierr)
		c.SetOutMapData("Success", false)
		return
	}
	c.SetOutMapData("Success", true)
}
