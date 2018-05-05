package test

//import (
//	parsermodel "github.com/l-dandelion/yi-ants-go/core/parsers/model"
//	processormodel "github.com/l-dandelion/yi-ants-go/core/processors/model"
//	"github.com/l-dandelion/yi-ants-go/lib/base"
//	"github.com/l-dandelion/yi-ants-web/global"
//	"github.com/l-dandelion/yi-ants-web/models/service/spider"
//)
//
//type IndexController struct {
//	base.BaseController
//}
//
//func (c *IndexController) Prepare() {
//	c.BaseController.Prepare()
//}
//
//func (c *IndexController) Process() {
//	name := "test"
//	maxDepth := 3
//	domains := []string{"pixabay.com"}
//	parserModel := &parsermodel.Model{
//		Type: "template",
//		AddQueue: []string{"{$img}"},
//		AcceptedRegUrls: []string{".*"},
//		//WantedRegUrls: []string{".*"},
//		Rule: map[string]string{
//			"node": "array|.item",
//			"href": "attr.href|a",
//			"tags": "attr.alt|img",
//		},
//	}
//	processorModel := &processormodel.Model{Type:"console"}
//	urlStrs := []string{"https://pixabay.com/zh/photos/?q=&hp=&image_type=all&order=&cat=&min_width=&min_height="}
//	sp, yierr := spider.GenSpiderFromModel(name,
//		maxDepth,
//		domains,
//		parserModel,
//		processorModel,
//		urlStrs,
//	)
//	if yierr != nil {
//		c.SetError(yierr)
//	}
//	yierr = global.RpcClient.AddSpider(sp)
//	if yierr != nil {
//		c.SetError(yierr)
//	}
//}
