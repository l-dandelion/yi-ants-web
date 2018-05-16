package routers

import (
	"github.com/astaxie/beego"
	"github.com/l-dandelion/yi-ants-web/controllers/cluster"
	"github.com/l-dandelion/yi-ants-web/controllers/home"
	"github.com/l-dandelion/yi-ants-web/controllers/spider"
	"github.com/l-dandelion/yi-ants-web/controllers/statistics"
)

var mappingMethods string = "*:Process"

func init() {
	beego.Router("/", &home.IndexController{}, mappingMethods)
	beego.Router("/home/desktop", &home.DesktopController{}, mappingMethods)
	beego.Router("/spider/all", &spider.AllController{}, mappingMethods)
	beego.Router("/spider/add", &spider.AddController{}, mappingMethods)
	beego.Router("/spider/detail", &spider.DetailController{}, mappingMethods)
	beego.Router("/cluster/all", &cluster.AllController{}, mappingMethods)
	beego.Router("/cluster/detail", &cluster.DetailController{}, mappingMethods)
	beego.Router("/statics/spider", &statistics.SpiderController{}, mappingMethods)
	beego.Router("/statics/postspider", &statistics.PostSpiderController{}, mappingMethods)

	beego.Router("/api/statics/postspider", &statistics.PostSpiderController{}, mappingMethods)
	beego.Router("/api/cluster/crawlersummary", &cluster.CrawlerSummaryController{}, mappingMethods)
	beego.Router("/api/spider/add", &spider.PostAddController{}, mappingMethods)
	beego.Router("/api/spider/init", &spider.InitController{}, mappingMethods)
	beego.Router("/api/spider/start", &spider.StartController{}, mappingMethods)
	beego.Router("/api/spider/stop", &spider.StopController{}, mappingMethods)
	beego.Router("/api/spider/pause", &spider.PauseController{}, mappingMethods)
	beego.Router("/api/spider/recover", &spider.RecoverController{}, mappingMethods)
	beego.Router("/api/spider/complile", &spider.ComplileController{}, mappingMethods)
	beego.Router("/api/spider/delete", &spider.DeleteController{}, mappingMethods)
	beego.Router("/api/spider/detail", &spider.DetailController{}, mappingMethods)
	//beego.Router("/api/test", &test.IndexController{}, mappingMethods)
}
