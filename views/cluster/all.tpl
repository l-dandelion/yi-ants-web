<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>节点列表</title>
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
                    <li>
                        <a href="/spider/all">爬虫列表</a>
                    </li>
                    <li class="active">
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
    			<div class="row-fluid">
    				<div class="span3">
    					<table class="table">
    					    <caption><b>节点列表</b></caption>
    					    <thead>
    					        <tr>
    					            <td>编号</td>
    					            <td>节点名</td>
    					            <td>IP</td>
    					            <td>TCP端口</td>
    					            <td>HTTP端口</td>
    					            <td>本地节点</td>
    					        </tr>
    					    </thead>
    						<tbody>
    						    {{range $index, $ni := .nodeInfos}}
    							<tr>
    								<td>{{$index}}</td>
    								<td><a href="/cluster/detail?node={{$ni.Name}}">{{$ni.Name}}</a></td>
    								<td>{{$ni.Ip}}</td>
    								<td>{{$ni.TcpPort}}</td>
    								<td>{{$ni.HttpPort}}</td>
    								<td>{{$ni.IsLocal}}</td>
    							</tr>
    							{{end}}
    						</tbody>
    					</table>
    				</div>
    				<div class="span6">
    				</div>
    				<div class="span3">
    				</div>
    			</div>
    		</div>
    	</div>
    </div>
</body>
</html>