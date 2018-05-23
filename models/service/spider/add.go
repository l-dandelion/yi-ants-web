package spider

import (
	"encoding/json"
	parsermodel "github.com/l-dandelion/yi-ants-go/core/parsers/model"
	processormodel "github.com/l-dandelion/yi-ants-go/core/processors/model"
	"github.com/l-dandelion/yi-ants-go/core/scheduler"
	"github.com/l-dandelion/yi-ants-go/core/spider"
	"github.com/l-dandelion/yi-ants-go/lib/constant"
	"github.com/l-dandelion/yi-ants-go/lib/utils"
	"io/ioutil"
	"os"
	"strconv"
	"github.com/astaxie/beego"
)

func ReadAll(filePth string) ([]byte, error) {
	f, err := os.Open(filePth)
	if err != nil {
		return nil, err
	}
	return ioutil.ReadAll(f)
}

func GenSpiderFromFile(name string, maxDepth int, domains []string, parserFileName, processorFileName string, urlStrs []string) (spider.Spider, *constant.YiError) {
	requestArgs := scheduler.RequestArgs{
		MaxDepth:        uint32(maxDepth),
		AcceptedDomains: domains,
	}
	dataArgs := scheduler.DataArgs{
		ReqBufferCap:         1000,
		ReqMaxBufferNumber:   10000,
		RespBufferCap:        50,
		RespMaxBufferNumber:  100,
		ItemBufferCap:        50,
		ItemMaxBufferNumber:  1000,
		ErrorBufferCap:       50,
		ErrorMaxBufferNumber: 1,
	}
	byteGenParsers, err := ReadAll("./parser.go")
	if err != nil {
		return nil, constant.NewYiErrore(constant.ERR_READ_FILE, err)
	}
	byteGenProcessors, err := ReadAll("./processor.go")
	if err != nil {
		return nil, constant.NewYiErrore(constant.ERR_READ_FILE, err)
	}

	parsersModel := &parsermodel.Model{
		Type: "source",
		Rule: map[string]string{
			"GenParsers": string(byteGenParsers),
		},
	}

	processorsModel := &processormodel.Model{
		Type: "source",
		Rule: map[string]string{
			"GenProcessors": string(byteGenProcessors),
		},
	}

	sp, yierr := spider.New(name,
		requestArgs,
		dataArgs,
		urlStrs,
		nil,
		[]*parsermodel.Model{parsersModel},
		[]*processormodel.Model{processorsModel})
	return sp, yierr
}

func GenSpiderFromStr(name string, maxDepth int, domains []string, parserStr, processorStr string, urlStrs []string) (spider.Spider, *constant.YiError) {
	requestArgs := scheduler.RequestArgs{
		MaxDepth:        uint32(maxDepth),
		AcceptedDomains: domains,
	}
	dataArgs := scheduler.DataArgs{
		ReqBufferCap:         1000,
		ReqMaxBufferNumber:   10000,
		RespBufferCap:        50,
		RespMaxBufferNumber:  100,
		ItemBufferCap:        50,
		ItemMaxBufferNumber:  1000,
		ErrorBufferCap:       50,
		ErrorMaxBufferNumber: 1,
	}

	parsersModel := &parsermodel.Model{
		Type: "source",
		Rule: map[string]string{
			"GenParsers": parserStr,
		},
	}

	processorsModel := &processormodel.Model{
		Type: "source",
		Rule: map[string]string{
			"GenProcessors": processorStr,
		},
	}
	sp, yierr := spider.New(name,
		requestArgs,
		dataArgs,
		urlStrs,
		nil,
		[]*parsermodel.Model{parsersModel},
		[]*processormodel.Model{processorsModel})
	return sp, yierr
}

func GenSpiderFromModels(name string, maxDepth int, domains []string,
	parsersModels []*parsermodel.Model, processorsModels []*processormodel.Model, urlStrs []string) (spider.Spider, *constant.YiError) {
	requestArgs := scheduler.RequestArgs{
		MaxDepth:        uint32(maxDepth),
		AcceptedDomains: domains,
	}
	dataArgs := scheduler.DataArgs{
		ReqBufferCap:         1000,
		ReqMaxBufferNumber:   10000,
		RespBufferCap:        50,
		RespMaxBufferNumber:  100,
		ItemBufferCap:        50,
		ItemMaxBufferNumber:  1000,
		ErrorBufferCap:       50,
		ErrorMaxBufferNumber: 1,
	}

	sp, yierr := spider.New(name,
		requestArgs,
		dataArgs,
		urlStrs,
		nil,
		parsersModels,
		processorsModels)
	return sp, yierr
}

func GenSpiderFromModel(model *Model) (spider.Spider, *constant.YiError) {
	maxDepth, err := strconv.Atoi(model.Depth)
	if err != nil {
		return nil, constant.NewYiErrore(constant.ERR_SPIDER_NEW, err)
	}
	domains := utils.SplitAndTrimSpace(model.Domains, ";")
	urls := utils.SplitAndTrimSpace(model.Urls, ";")
	parserModels, err := GenParserModels(model.ParserModels)
	if err != nil {
		beego.Info("parser error:", err)
		return nil, constant.NewYiErrore(constant.ERR_SPIDER_NEW, err)
	}
	processorModels, err := GenProcessorModels(model.ProcessorModels)
	if err != nil {
		return nil, constant.NewYiErrore(constant.ERR_SPIDER_NEW, err)
	}
	return GenSpiderFromModels(model.Name, maxDepth, domains, parserModels, processorModels, urls)
}

func GenParserModels(models []*ParserModel) ([]*parsermodel.Model, error) {
	parserModels := []*parsermodel.Model{}
	for _, model := range models {
		parserModel := &parsermodel.Model{}
		parserModel.AcceptedRegUrls = utils.SplitAndTrimSpace(model.Accepted, ";")
		parserModel.WantedRegUrls = utils.SplitAndTrimSpace(model.Wanted, ";")
		parserModel.AddQueue = utils.SplitAndTrimSpace(model.AddQueue, ";")
		parserModel.Type = model.Type
		switch parserModel.Type {
		case "source":
			parserModel.Rule = map[string]string{
				"GenParsers": model.Rule,
			}
		case "template":
			parserModel.Rule = map[string]string{}
			err := json.Unmarshal([]byte(model.Rule), &parserModel.Rule)
			if err != nil {
				return nil, err
			}
		}
		parserModels = append(parserModels, parserModel)
	}

	return parserModels, nil
}

func GenProcessorModels(models []*ProcessorModel) ([]*processormodel.Model, error) {
	processorModels := []*processormodel.Model{}
	for _, model := range models {
		processorModel := &processormodel.Model{}
		processorModel.Type = model.Type
		switch processorModel.Type {
		case "source":
			processorModel.Rule = map[string]string{
				"GenProcessors": model.Rule,
			}
		}
		processorModels = append(processorModels, processorModel)
	}
	return processorModels, nil
}

type ParserModel struct {
	Accepted string `json:"accepted"`
	Wanted   string `json:"wanted"`
	AddQueue string `json:"addQueue"`
	Type     string `json:"type"`
	Rule     string `json:"rule"`
}

type ProcessorModel struct {
	Type string `json:"type"`
	Rule string `json:"rule"`
}

type Model struct {
	Name            string            `json:"name"`
	Depth           string            `json:"depth"`
	Domains         string            `json:"domains"`
	ParserModels    []*ParserModel    `json:"parserModels"`
	ProcessorModels []*ProcessorModel `json:"processorModels"`
	Urls            string            `json:"urls"`
}
