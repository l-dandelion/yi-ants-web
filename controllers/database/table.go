package database

import (
	"github.com/l-dandelion/yi-ants-go/lib/base"
	"github.com/astaxie/beego/orm"
)

type TableController struct {
	base.BaseController
}

func (c *TableController) Prepare() {
	c.BaseController.Prepare()
}

func (c *TableController) Process() {
	tablename := c.GetString("tablename")
	limit, err := c.GetInt64("limit", 0)
	if err != nil {
		c.SetError(err)
		return
	}
	if limit > 1000 {
		limit = 1000
	}
	page, err := c.GetInt64("page", 0)
	if err != nil {
		c.SetError(err)
		return
	}
	o := orm.NewOrm()
	filedNames := []orm.ParamsList{}
	_, err = o.Raw("select COLUMN_NAME from information_schema.COLUMNS where table_name = ?", tablename).ValuesList(&filedNames)
	if err != nil {
		c.SetError(err)
		return
	}
	paramsList := []orm.ParamsList{}
	_, err = o.Raw("select * from " + tablename + " limit ?,?", page*limit, limit).ValuesList(&paramsList)
	if err != nil {
		c.SetError(err)
		return
	}
	c.SetOutMapData("filedNames", filedNames)
	c.SetOutMapData("paramsList", paramsList)
	c.SetOutMapData("tablename", tablename)
	c.SetOutMapData("limit", limit)
	c.SetOutMapData("page", page)
	c.SetOutMapData("next", page+1)
	c.SetOutMapData("last", page-1)
}
