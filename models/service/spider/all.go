package spider

import (
	"github.com/l-dandelion/yi-ants-go/lib/constant"
	"github.com/l-dandelion/yi-ants-web/global"
	"time"
)

type SpiderInfo struct {
	Name      string
	Status    string
	Crawled   int
	Success   int
	Running   int
	Waiting   int
	StartTime time.Time
	EndTime   time.Time
	Extra     interface{}
}

func GetSpiders() ([]*SpiderInfo, *constant.YiError) {
	var status string
	sis := []*SpiderInfo{}
	ssl, yierr := global.RpcClient.SpiderStatusList()
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
