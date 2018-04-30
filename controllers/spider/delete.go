package spider

import (
	"github.com/l-dandelion/yi-ants-go/lib/base"
	"github.com/l-dandelion/yi-ants-web/global"
)

type DeleteController struct {
	base.BaseController
}

func (c *DeleteController) Prepare() {
	c.BaseController.Prepare()
}

func (c *DeleteController) Process() {
	spiderName := c.GetString("spider")
	yierr := global.RpcClient.DeleteSpider(spiderName)
	if yierr != nil {
		c.SetError(yierr)
		c.SetOutMapData("Success", false)
		return
	}
	c.SetOutMapData("Success", true)
}
