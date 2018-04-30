package spider

import (
	"github.com/l-dandelion/yi-ants-go/lib/constant"
	"github.com/l-dandelion/yi-ants-web/global"
)

func GetSpidersByNodeName(nodeName string) ([]*SpiderInfo, *constant.YiError) {
	var status string
	sis := []*SpiderInfo{}
	ssl, yierr := global.RpcClient.GetSpiderStatusListByNodeName(nodeName)
	if yierr != nil {
		return nil, yierr
	}
	for _, spiderStatus := range ssl {
		if spiderStatus.CompilingStatus != constant.COMPLILING_STATUS_COMPLILED {
			status = constant.GlobalArrComplilingStatusDesc[spiderStatus.CompilingStatus]
		} else {
			status = constant.GlobalArrRunningStatusDesc[spiderStatus.Status]
		}
		sis = append(sis, &SpiderInfo{
			Name:      spiderStatus.Name,
			Status:    status,
			Success:   spiderStatus.Success,
			Crawled:   spiderStatus.Crawled,
			Running:   spiderStatus.Running,
			Waiting:   spiderStatus.Waiting,
			StartTime: spiderStatus.StartTime,
			EndTime:   spiderStatus.EndTime,
			Extra:     spiderStatus.ComplilingError,
		})
	}
	return sis, nil
}