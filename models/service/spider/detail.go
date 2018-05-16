package spider

import (
	"github.com/l-dandelion/yi-ants-web/global"
	"github.com/l-dandelion/yi-ants-go/lib/constant"
	"github.com/l-dandelion/yi-ants-go/core/spider"
)

func GetSpiderInfoMap(spiderName string) (totalSpiderInfo *SpiderInfo,spiderInfoMap map[string]*SpiderInfo, yierr *constant.YiError) {
	spiderStatusMap, yierr := global.RpcClient.GetSpiderStatusMapBySpiderName(spiderName)
	if yierr != nil {
		return
	}
	spiderInfoMap = make(map[string]*SpiderInfo)
	var (
		status string
		totalSpiderStatus *spider.SpiderStatus
	)
	for nodeName, spiderStatus := range spiderStatusMap {
		totalSpiderStatus = megerSpiderStatus(totalSpiderStatus, spiderStatus)
		if spiderStatus.CompilingStatus != constant.COMPLILING_STATUS_COMPLILED {
			status = constant.GlobalArrComplilingStatusDesc[spiderStatus.CompilingStatus]
		} else {
			status = constant.GlobalArrRunningStatusDesc[spiderStatus.Status]
		}
		spiderInfoMap[nodeName] = &SpiderInfo{
			Name:      spiderStatus.Name,
			Status:    status,
			Success:   spiderStatus.Success,
			Crawled:   spiderStatus.Crawled,
			Running:   spiderStatus.Running,
			Waiting:   spiderStatus.Waiting,
			StartTime: spiderStatus.StartTime,
			EndTime:   spiderStatus.EndTime,
			Extra:     spiderStatus.ComplilingError,
		}
	}
	if totalSpiderStatus.CompilingStatus != constant.COMPLILING_STATUS_COMPLILED {
		status = constant.GlobalArrComplilingStatusDesc[totalSpiderStatus.CompilingStatus]
	} else {
		status = constant.GlobalArrRunningStatusDesc[totalSpiderStatus.Status]
	}
	totalSpiderInfo = &SpiderInfo{
		Name:      totalSpiderStatus.Name,
		Status:    status,
		Success:   totalSpiderStatus.Success,
		Crawled:   totalSpiderStatus.Crawled,
		Running:   totalSpiderStatus.Running,
		Waiting:   totalSpiderStatus.Waiting,
		StartTime: totalSpiderStatus.StartTime,
		EndTime:   totalSpiderStatus.EndTime,
		Extra:     totalSpiderStatus.ComplilingError,
	}
	return
}

//合并不同节点的爬虫信息
func megerSpiderStatus(a *spider.SpiderStatus, b *spider.SpiderStatus) *spider.SpiderStatus {
	if a == nil {
		return b
	}
	if b.CompilingStatus != constant.COMPLILING_STATUS_COMPLILED {
		a.CompilingStatus = b.CompilingStatus
		a.ComplilingError = b.ComplilingError
	}
	a.Crawled += b.Crawled
	a.Running += b.Running
	a.Success += b.Success
	a.Waiting += b.Waiting
	return a
}
