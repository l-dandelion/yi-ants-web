<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>首页</title>
<link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container-fluid">
    	<div class="row-fluid">
    		<div class="span12">
    			<ul class="nav nav-tabs">
    				<li class="active">
                        <a href="/">首页</a>
                    </li>
                    <li>
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
    			<h3>
    				欢迎使用YI-ANTS-GO爬虫系统！
    			</h3>
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
                            </tbody>
                        </table>
                    </div>
    			</div>
    		</div>
    	</div>
    </div>
</body>
</html>