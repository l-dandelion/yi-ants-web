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

                                <p><label>解析函数</label></p>
                                <p name="parserModel" index="1">
                                	<label>类型:</label><br/>
                                	source
                                	<input type="radio" checked="checked" name="parserModelType1" value="source"/>
                                	template
                                	<input type="radio" name="parserModelType1" value="template"/>
                                	<br/>
                                	<label>接受的url:</label><br/>
                                	<textarea name="parserModelAccepted1"></textarea><br/>
                                	<label>想要的url:</label><br/>
                                	<textarea name="parserModelWanted1"></textarea><br/>
                                	<label>规则:</label><br/>
                                	<textarea name="parserModelRule1"></textarea><br/>
                                	<label>想添加的url:</label><br/>
                                    <textarea name="parserModelAddQueue1"></textarea><br/>
                                </p>

                                <p><label>处理函数</label></p>
                                <div name="processorModel" index="1">
                                	<label>类型:</label><br/>
                                	source
                                	<input type="radio" checked="checked" name="processorModelType1" value="source"/>
                                	mysql
                                	<input type="radio" name="processorModelType1" value="mysql"/>
                                	<br/>
                                	console
                                    <input type="radio" name="processorModelType1" value="console"/>
                                    <br/>
                                	<label>规则:</label><br/>
                                	<textarea name="processorModelRule1"></textarea><br/>
                                </div>

                                <p><label>初始url</label></p>
                                <textarea name="urls" type="text"></textarea>
                                <p><span class="help-block"><code>*以;分割</code></span></p>
                            </fieldset>
                        </form>
                        <button class="btn" onclick="Add()">提交</button>
    				</div>
    			</div>
    		</div>
    	</div>
    </div>

    <script src="/static/vendor/layer/layer.js"></script>
    <script type="text/javascript">
        function GetParserModels() {
            prefix = "parserModel"
            var models = new Array()
            parserModels = document.getElementsByName(prefix)
            for(var i = 0; i < parserModels.length; i ++) {
                var model = new Object()
                parserModel = parserModels[i]
                index = parserModels[i].getAttribute("index")
                model.type = $("input[name='"+prefix+"Type"+index+"']:checked").val()
                model.accepted = $("textarea[name='"+prefix+"Accepted"+index+"']").val()
                model.wanted = $("textarea[name='"+prefix+"Wanted"+index+"']").val()
                model.rule = $("textarea[name='"+prefix+"Rule"+index+"']").val()
                model.addQueue = $("textarea[name='"+prefix+"AddQueue"+index+"']").val()
                models.push(model)
            }
            console.log(models)
            return models
        }
        function GetProcessorModels() {
            prefix = "processorModel"
            var models = new Array()
            parserModels = document.getElementsByName(prefix)
            for(var i = 0; i < parserModels.length; i ++) {
                var model = new Object()
                parserModel = parserModels[i]
                index = parserModels[i].getAttribute("index")
                model.type = $("input[name='"+prefix+"Type"+index+"']:checked").val()
                model.rule = $("textarea[name='"+prefix+"Rule"+index+"']").val()
                models.push(model)
            }
            console.log(models)
            return models
        }
        function Add() {
            mdata = new Object()
            mdata.name = $("input[name='name']").val()
            mdata.depth = $("input[name='depth']").val()
            mdata.domains = $("textarea[name='domains']").val()
            mdata.parserModels = GetParserModels()
            mdata.processorModels = GetProcessorModels()
            mdata.urls = $("textarea[name='urls']").val()
            $.ajax({
                url: "/api/spider/add",
                type: "post",
                data: {
                    "jsonInfo": JSON.stringify(mdata)
                },
                success:function(data){
                    console.log(data);
                },
                error:function(e){
                    alert("错误！！");
                }
            });
        }


    </script>

</body>
</html>
