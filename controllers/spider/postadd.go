package spider

import (
	"github.com/l-dandelion/yi-ants-go/lib/base"
	"github.com/l-dandelion/yi-ants-go/lib/constant"
	"github.com/l-dandelion/yi-ants-web/models/service/spider"
	"encoding/json"
	"github.com/l-dandelion/yi-ants-web/global"
	"github.com/astaxie/beego"
)

type PostAddController struct {
	base.BaseController
}

func (c *PostAddController) Prepare() {
	c.InputData.OutputType = constant.OutputTypeJson
	c.BaseController.Prepare()
}

func (c *PostAddController) Process() {
	//name := c.GetString("name")
	//if name == "" {
	//	c.SetErrorf(constant.ERR_ARGS, "Empty Names.")
	//	return
	//}
	//
	//maxDepth, err := c.GetInt("depth", 0)
	//if name == "" {
	//	c.SetErrorf(constant.ERR_ARGS, "Get max depth fail, err: %s", err)
	//	return
	//}
	//if maxDepth == 0 {
	//	maxDepth = math.MaxInt32
	//}
	//
	//domainStr := c.GetString("domains")
	//domains := utils.SplitAndTrimSpace(domainStr, ";")
	//fmt.Println(domainStr)
	//fmt.Println(domains)
	//if len(domains) == 0 {
	//	c.SetErrorf(constant.ERR_ARGS, "Empty domains")
	//	return
	//}
	//
	//urlStr := c.GetString("urls")
	//urlStrs := utils.SplitAndTrimSpace(urlStr, ";")
	//if len(urlStrs) == 0 {
	//	c.SetErrorf(constant.ERR_ARGS, "Empty urls")
	//	return
	//}
	//
	//parserStr := c.GetString("genparsers")
	//
	//processorStr := c.GetString("genprocessors")
	//
	//sp, yierr := spider.GenSpiderFromStr(name, maxDepth, domains, parserStr, processorStr, urlStrs)

	var jsonInfo string
	c.Ctx.Input.Bind(&jsonInfo, "jsonInfo")
	model := &spider.Model{}
	err := json.Unmarshal([]byte(jsonInfo), model)
	if err != nil {
		c.SetError(err)
		return
	}
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
	beego.Info(model)
}
