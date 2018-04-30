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
                    <li>
                        <a href="/spider/all">爬虫列表</a>
                    </li>
                    <li>
                        <a href="/cluster/all">节点列表</a>
                    </li>
                    <li class="active">
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
    				<div class="span12">
                        <form action="/api/spider/add" method="post">
                            <fieldset>
                                <p><label>爬虫名</label></p>
                                <p><input name="name" placeholder="唯一标识" type="text" /></p>
                                <p><span class="help-block"><code>*必填项</code></span></p>

                                <p><label>最大深度</label></p>
                                <p><input name="depth" placeholder="默认为无穷大" type="text"/></p>

                                <p><label>抓取域名</label></p>
                                <textarea rows=3 name="domains" type="text"></textarea>
                                <p><span class="help-block"><code>*以;分割</code></span></p>

                                <p><label>生成解析函数</label></p>
                                <textarea rows=5 cols=100 name="genparsers" type="text"></textarea>
                                <p><span class="help-block" ><code>*必填项</code></span></p>

                                <p><label>生成处理函数</label></p>
                                <textarea rows=5 cols=100 name="genprocessors" type="text"></textarea>
                                <p><span class="help-block"><code>*必填项</code></span></p>

                                <p><label>初始url</label></p>
                                <textarea name="urls" type="text"></textarea>
                                <p><span class="help-block"><code>*以;分割</code></span></p>

                                <button class="btn" type="submit">提交</button>
                            </fieldset>
                        </form>
    				</div>
    			</div>
    		</div>
    	</div>
    </div>
</body>
</html>
