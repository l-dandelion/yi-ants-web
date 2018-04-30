package global

import (
	"github.com/l-dandelion/yi-ants-go/core/action"
	"github.com/l-dandelion/yi-ants-go/core/cluster"
	"github.com/l-dandelion/yi-ants-go/core/node"
)

var (
	Cluster     cluster.Cluster
	Distributer action.Watcher
	RpcClient   action.RpcClientAnts
	Node        node.Node
)
