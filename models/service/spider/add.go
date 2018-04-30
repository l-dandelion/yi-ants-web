package spider

import (
	"github.com/l-dandelion/yi-ants-go/core/scheduler"
	"github.com/l-dandelion/yi-ants-go/lib/constant"
	"github.com/l-dandelion/yi-ants-go/core/spider"
	"os"
	"io/ioutil"
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

	sp, yierr := spider.New(name,
		requestArgs,
		dataArgs,
		urlStrs,
		nil,
		string(byteGenParsers),
		string(byteGenProcessors))
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
	sp, yierr := spider.New(name,
		requestArgs,
		dataArgs,
		urlStrs,
		nil,
		parserStr,
		processorStr)
	return sp, yierr
}