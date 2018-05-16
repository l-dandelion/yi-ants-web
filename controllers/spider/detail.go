package spider

import (
	"github.com/l-dandelion/yi-ants-go/lib/base"
	"github.com/l-dandelion/yi-ants-go/lib/constant"
	"github.com/l-dandelion/yi-ants-web/models/service/spider"
)

type DetailController struct {
	base.BaseController
}

func (c *DetailController) Prepare() {
	c.BaseController.Prepare()
}

func (c *DetailController) Process() {
	spiderName := c.GetString("spider")
	if spiderName == "" {
		yierr := constant.NewYiErrorf(constant.ERR_ARGS, "Empty spider name.")
		c.SetError(yierr)
		return
	}
	totalSpiderInfo, spiderInfoMap, yierr := spider.GetSpiderInfoMap(spiderName)
	if yierr != nil {
		c.SetError(yierr)
		return
	}
	c.SetOutMapData("spiderInfoMap", spiderInfoMap)
	c.SetOutMapData("totalSpiderInfo", totalSpiderInfo)
}