package spider

import (
	"github.com/l-dandelion/yi-ants-go/lib/base"
	"github.com/l-dandelion/yi-ants-web/models/service/spider"
)

type AllController struct {
	base.BaseController
}

func (c *AllController) Prepare() {
	c.BaseController.Prepare()
}

func (c *AllController) Process() {
	sis, yierr := spider.GetSpiders()
	if yierr != nil {
		c.SetError(yierr)
	}
	c.SetOutMapData("spiderInfos", sis)
}
