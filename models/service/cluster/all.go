package cluster

import (
	"github.com/l-dandelion/yi-ants-web/global"
)

type NodeInfo struct {
	Name string
	Ip string
	TcpPort int
	HttpPort int
	IsLocal bool
}

func GetNodeInfos() []*NodeInfo {
	nis := []*NodeInfo{}
	ns := global.Cluster.GetAllNode()
	for _, node := range ns {
		isLocal := global.Node.IsMe(node.Name)
		nis = append(nis, &NodeInfo{
			Name: node.Name,
			Ip: node.Ip,
			TcpPort: node.Port,
			HttpPort: node.Settings.HttpPort,
			IsLocal: isLocal,
		})
	}
	return nis
}