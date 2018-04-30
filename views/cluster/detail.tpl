<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>爬虫列表</title>
<link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
    <body>
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span12">
                    <ul class="nav nav-tabs">
                        <li>
                            <a href="/">首页</a>
                        </li>
                        <li class="active">
                            <a href="/spider/all">爬虫列表</a>
                        </li>
                        <li>
                            <a href="/cluster/all">节点列表</a>
                        </li>
                         <li>
                            <a href="/spider/add">添加爬虫</a>
                        </li>
                        <li class="dropdown pull-right">
                             <a href="#" data-toggle="dropdown" class="dropdown-toggle">下拉<strong class="caret"></strong></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="#">操作</a>
                                </li>
                                <li>
                                    <a href="#">设置栏目</a>
                                </li>
                                <li>
                                    <a href="#">更多设置</a>
                                </li>
                                <li class="divider">
                                </li>
                                <li>
                                    <a href="#">分割线</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div class="span12">
                        <div class="row-fluid">
                        <div class="span3">
                            <table class="table">
                                <caption><b>本地节点</b></caption>
                                <tbody>
                                    <tr class="info">
                                        <td>
                                            节点名
                                        </td>
                                        <td>
                                             {{.nodeInfo.Name}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            IP
                                        </td>
                                        <td>
                                            {{.nodeInfo.Ip}}
                                        </td>
                                    </tr>
                                    <tr class="info">
                                        <td>
                                            TCP端口
                                        </td>
                                        <td>
                                            {{.nodeInfo.Port}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            HTTP端口
                                        </td>
                                        <td>
                                            {{.nodeInfo.Settings.HttpPort}}
                                        </td>
                                    </tr>
                                    <tr class="info">
                                        <td>
                                            待分配队列大小
                                        </td>
                                        <td>
                                            {{.distributeQeueuSize}}
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="span12">
                            <table class="table">
                                <caption><b>爬虫列表</b></caption>
                                <thead>
                                    <tr>
                                        <td>编号</td>
                                        <td>爬虫名</td>
                                        <td>状态</td>
                                        <td>已抓取</td>
                                        <td>成功</td>
                                        <td>抓取中</td>
                                        <td>等待中</td>
                                        <td>开始时间</td>
                                        <td>结束时间</td>
                                        <td>备注</td>
                                        <td>操作</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    {{range $index, $si := .spiderInfos}}
                                    <tr>
                                        <td>{{$index}}</td>
                                        <td>{{$si.Name}}</td>
                                        <td>{{$si.Status}}</td>
                                        <td>{{$si.Crawled}}</td>
                                        <td>{{$si.Success}}</td>
                                        <td>{{$si.Running}}</td>
                                        <td>{{$si.Waiting}}</td>
                                        <td>{{$si.StartTime}}</td>
                                        <td>{{$si.EndTime}}</td>
                                        <td>{{$si.Extra}}</td>
                                        <td>
                                            <div class="btn-group">
                                              <button class="btn">Action</button>
                                              <button data-toggle="dropdown" class="btn dropdown-toggle"><span class="caret"></span></button>
                                              <ul class="dropdown-menu">
                                                <li><a href="#" onclick="action('complile', '{{$si.Name}}')">编译</a></li>
                                                <li><a href="#" onclick="action('init', '{{$si.Name}}')">准备</a></li>
                                                <li><a href="#" onclick="action('start', '{{$si.Name}}')">开始</a></li>
                                                <li><a href="#" onclick="confirmAction('stop', '{{$si.Name}}')">终止</a></li>
                                                <li><a href="#" onclick="action('pause', '{{$si.Name}}')">暂停</a></li>
                                                <li><a href="#" onclick="action('recover', '{{$si.Name}}')">恢复</a></li>
                                                <li><a href="#" onclick="confirmAction('delete', '{{$si.Name}}')">删除</a></li>
                                              </ul>
                                            </div>
                                        </td>
                                    </tr>
                                    {{end}}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="/static/vendor/layer/layer.js"></script>
        <script type="text/javascript">
                function action(actionName, spiderName) {
                    $.ajax({
                        type: "GET",//方法类型
                        dataType: "json",//预期服务器返回的数据类型
                        url: "/api/spider/" + actionName + "?spider=" + spiderName,//url
                        success: function (result) {
                            console.log(result)
                            if(result.ErrMsg == ""){
                                layer.msg('操作成功', {icon:1})
                            } else {
                                layer.alert('操作失败(' + result.ErrMsg + ')')
                            }
                        },
                        error : function() {
                            layer.msg('操作失败,请稍后重试...', {icon:2})
                        }
                    });
                }
                function confirmAction(actionName, spiderName) {
                    layer.confirm(actionName + " " + spiderName + "?", {
                      btn: ['Yes','No']
                    }, function(){
                      action(actionName, spiderName)
                    }, function(){
                    });
                }
        </script>
    </body>
</html>