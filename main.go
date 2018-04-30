package main

import (
	_ "github.com/l-dandelion/yi-ants-web/routers"
	"github.com/astaxie/beego"
	"github.com/l-dandelion/yi-ants-go/lib/constant"
	"github.com/l-dandelion/yi-ants-go/lib/utils"
	"github.com/l-dandelion/yi-ants-go/core/node"
	"github.com/l-dandelion/yi-ants-go/core/cluster"
	"github.com/l-dandelion/yi-ants-go/core/action/rpc"
	"github.com/l-dandelion/yi-ants-go/core/action/watcher"
	"github.com/l-dandelion/yi-ants-web/global"
)

func main() {
	beego.Run()
}

func init() {
	constant.RunMode = beego.BConfig.RunMode
	tcpPort, err := beego.AppConfig.Int("tcpport")
	if err != nil {
		panic(err)
	}
	httpPort, err := beego.AppConfig.Int("httpPort")
	if err != nil {
		panic(err)
	}
	settings := &utils.Settings{
		Name: beego.AppConfig.String("appname"),
		TcpPort: tcpPort,
		HttpPort: httpPort,
	}
	mnode, yierr := node.New(settings)
	if yierr != nil {
		panic(yierr)
	}
	mcluster := cluster.New(settings, mnode.GetNodeInfo())
	rpcClient := rpc.NewRpcClient(mnode, mcluster)
	distributer := watcher.NewDistributer(mnode, mcluster, rpcClient)
	rpcClient.Start()
	rpc.NewRpcServer(mnode, mcluster, tcpPort, rpcClient, distributer)
	distributer.Start()
	global.Cluster = mcluster
	global.Node = mnode
	global.Distributer = distributer
	global.RpcClient = rpcClient

	IsFirst := beego.AppConfig.DefaultBool("isfirst", false)
	if !IsFirst {
		friendIp := beego.AppConfig.String("friendip")
		frientPort, err := beego.AppConfig.Int("friendport")
		if err != nil {
			panic(err)
		}
		yierr := rpcClient.LetMeIn(friendIp, frientPort)
		if yierr != nil {
			panic(yierr)
		}
	}
}

