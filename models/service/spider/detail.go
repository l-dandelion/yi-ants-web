package spider

import (
	"github.com/l-dandelion/yi-ants-web/global"
	"github.com/l-dandelion/yi-ants-go/lib/constant"
)

func GetSpiderInfoMap(spiderName string) (spiderInfoMap map[string]*SpiderInfo, yierr *constant.YiError) {
	spiderStatusMap, yierr := global.RpcClient.GetSpiderStatusMapBySpiderName(spiderName)
	if yierr != nil {
		return
	}
	spiderInfoMap = make(map[string]*SpiderInfo)
	var status string
	for nodeName, spiderStatus := range spiderStatusMap {
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
	return
}