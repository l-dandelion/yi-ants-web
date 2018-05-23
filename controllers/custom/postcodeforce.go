package custom

import (
	"github.com/l-dandelion/yi-ants-go/lib/base"
	"github.com/l-dandelion/yi-ants-web/models/service/custom"
	"github.com/l-dandelion/yi-ants-web/models/service/spider"
	"github.com/l-dandelion/yi-ants-web/global"
)


type PostCodeforceController struct {
	base.BaseController
}

func (c *PostCodeforceController) Prepare() {
	c.BaseController.Prepare()
}

func (c *PostCodeforceController) Process() {
	name := c.GetString("name")
	usernames := c.GetString("usernames")
	model := custom.GenCodeforcesModel(name, usernames)
	sp, yierr := spider.GenSpiderFromModel(model)
	if yierr != nil {
		c.SetError(yierr)
		return
	}

	yierr = global.RpcClient.AddSpider(sp)
	if yierr != nil {
		c.SetOutMapData("Success", false)
		c.SetError(yierr)
		return
	}
	c.SetOutMapData("Success", true)
}
