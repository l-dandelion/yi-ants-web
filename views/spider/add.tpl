<!--_meta 作为公共模版分离出去-->
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="Bookmark" href="/favicon.ico" >
<link rel="Shortcut Icon" href="/favicon.ico" />
<!--[if lt IE 9]>
<script type="text/javascript" src="/lib/html5shiv.js"></script>
<script type="text/javascript" src="/lib/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="/static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="/static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="/static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="/static/h-ui.admin/css/style.css" />
<!--[if IE 6]>
<script type="text/javascript" src="/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<!--/meta 作为公共模版分离出去-->

<title>添加用户 - H-ui.admin v3.1</title>
<meta name="keywords" content="H-ui.admin v3.1,H-ui网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
<meta name="description" content="H-ui.admin v3.1，是一款由国人开发的轻量级扁平化网站后台模板，完全免费开源的网站后台管理系统模版，适合中小型CMS后台系统。">
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 爬虫中心 <span class="c-gray en">&gt;</span> 添加爬虫 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<article class="page-container">
	<form action="" method="post" class="form form-horizontal" id="form-member-add">
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>爬虫名：</label>
			<div class="formControls col-xs-2 col-sm-2">
				<input type="text" class="input-text" value="" placeholder="" id="spidername" name="name">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>最大深度：</label>
			<div class="formControls col-xs-2 col-sm-2">
				<input type="text" class="input-text" value="" placeholder="默认为无穷大" id="maxdepth" name="depth">
			</div>
		</div>

		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>抓取域名：</label>
			<div class="formControls col-xs-2 col-sm-2">
				<textarea name="domains" cols="" rows="" class="textarea"></textarea>
				<p class="textarea-numberbar"><em class="textarea-length">以<span class="c-red"><b>;</b></span>隔开</p>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">解析函数：</label>
			<div class="formControls col-xs-6 col-sm-6">
				<button class="btn btn-success radius" onclick="addParserItem('Huifold1')">添加</button>
				<ul id="Huifold1" class="Huifold">
				</ul>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">处理函数：</label>
			<div class="formControls col-xs-6 col-sm-6">
				<button class="btn btn-success radius" onclick="addProcessorItem('Huifold2')">添加</button>
				<ul id="Huifold2" class="Huifold">
				  
				</ul>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>初始URL：</label>
			<div class="formControls col-xs-2 col-sm-2">
				<textarea name="urls" cols="" rows="" class="textarea"></textarea>
				<p class="textarea-numberbar"><em class="textarea-length">以<span class="c-red"><b>;</b></span>隔开</p>
			</div>
		</div>
		<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
			<input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
			</div>
		</div>
		
	</form>
</article>

<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="/lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="/static/h-ui/js/H-ui.min.js"></script> 
<script type="text/javascript" src="/static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本--> 
<script type="text/javascript" src="/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="/lib/jquery.validation/1.14.0/jquery.validate.js"></script> 
<script type="text/javascript" src="/lib/jquery.validation/1.14.0/validate-methods.js"></script> 
<script type="text/javascript" src="/lib/jquery.validation/1.14.0/messages_zh.js"></script>
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
		console.log(mdata)
		$.ajax({
		    url: "/api/spider/add",
		    type: "post",
		    data: {
		        "jsonInfo": JSON.stringify(mdata)
		    },
		    success:function(data){
		       	if(data.ErrMsg == ""){
		       		layer.msg('操作成功', {icon:1})
		       		setTimeout(function(){ location.reload(); }, 1000);
		    	} else {
		    		layer.alert('操作失败(' + data.ErrMsg + ')')
		    	}
		    },
		    error:function(e){
		         layer.msg('操作失败,请稍后重试...', {icon:2})
		    }
		});
	}
	
</script>
<script type="text/javascript">
$(function(){
	jQuery.Huifold = function(obj,obj_c,speed,obj_type,Event){
	if(obj_type == 2){
		$(obj+":first").find("b").html("-");
		$(obj_c+":first").show()}
	$(obj).bind(Event,function(){
		if($(this).next().is(":visible")){
			if(obj_type == 2){
				return false}
			else{
				$(this).next().slideUp(speed).end().removeClass("selected");
				$(this).find("b").html("+")}
		}
		else{
			if(obj_type == 3){
				$(this).next().slideDown(speed).end().addClass("selected");
				$(this).find("b").html("-")}else{
				$(obj_c).slideUp(speed);
				$(obj).removeClass("selected");
				$(obj).find("b").html("+");
				$(this).next().slideDown(speed).end().addClass("selected");
				$(this).find("b").html("-")}
		}
	})}
	$('.skin-minimal input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
	});
	
	$("#form-member-add").validate({
		rules:{
			name:{
				required:true,
				minlength:2,
				maxlength:16
			},
			depth:{
				required:true,
				digits:true,
				min:0,
			},
			domains:{
				required:true,
			},
			urls:{
				required:true,
			}
		},
		onkeyup:false,
		focusCleanup:true,
		success:"valid",
		submitHandler:function(form){
			Add();
		}
	});
	//$.Huifold("#Huifold1 .item h4","#Huifold1 .item .info","fast",1,"click"); /*5个参数顺序不可打乱，分别是：相应区,隐藏显示的内容,速度,类型,事件*/
	$.Huifold("#Huifold2 .item h4","#Huifold2 .item .info","fast",1,"click"); /*5个参数顺序不可打乱，分别是：相应区,隐藏显示的内容,速度,类型,事件*/
});
</script> 

<script type="text/javascript">
var number1 = 0;
function addParserItem(huifoldId) {
	console.log("in")
	huifold = document.getElementById(huifoldId);
	
	number1++;
	var number = number1;
	var li = document.createElement("li");
	li.setAttribute("class", "item");
	li.setAttribute("id", "li"+number)
	
	li.innerHTML = 
	'<h4>函数'+number+'<b>+</b></h4>\
	<div class="info">\
		<input class="btn btn-danger radius" type="button" value="删除" onclick="delItem(\'li'+number+'\')">\
		<div name="parserModel" index="'+number+'">\
			<div class="row cl">\
				<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>类型：</label>\
            	<div class="formControls col-xs-8 col-sm-9 skin-minimal">\
					<div class="radio-box">\
						<input name="parserModelType'+number+'" type="radio" checked="checked" id="parserModelType'+number+'-1" value="source">\
						<label>source</label>\
					</div>\
					<div class="radio-box">\
						<input type="radio" id="parserModelType'+number+'-2" name="parserModelType'+number+'" value="template">\
						<label>template</label>\
					</div>\
				</div>\
			</div>\
        	<div class="row cl">\
				<label class="form-label col-xs-2 col-sm-2">接受的URL：</label>\
				<div class="formControls col-xs-5 col-sm-5">\
					<textarea name="parserModelAccepted'+number+'" cols="" rows="" class="textarea"></textarea>\
					<p class="textarea-numberbar"><em class="textarea-length">以<span class="c-red"><b>;</b></span>隔开</p>\
				</div>\
			</div>\
			<div class="row cl">\
				<label class="form-label col-xs-2 col-sm-2">想要的URL：</label>\
				<div class="formControls col-xs-5 col-sm-5">\
					<textarea name="parserModelWanted'+number+'" cols="" rows="" class="textarea"></textarea>\
					<p class="textarea-numberbar"><em class="textarea-length">以<span class="c-red"><b>;</b></span>隔开</p>\
				</div>\
			</div>\
			<div class="row cl">\
				<label class="form-label col-xs-2 col-sm-2">规则：</label>\
				<div class="formControls col-xs-8 col-sm-8">\
					<textarea name="parserModelRule'+number+'" cols="" rows="" class="textarea"></textarea>\
				</div>\
			</div>\
        	<div class="row cl">\
				<label class="form-label col-xs-2 col-sm-2">想添加的URL：</label>\
				<div class="formControls col-xs-5 col-sm-5">\
					<textarea name="parserModelAddQueue'+number+'" cols="" rows="" class="textarea"></textarea>\
					<p class="textarea-numberbar"><em class="textarea-length">以<span class="c-red"><b>;</b></span>隔开</p>\
				</div>\
			</div>\
        </div>\
	</div>'
	huifold.appendChild(li);
	$("#" + huifoldId + " .item h4").unbind("click");
	$.Huifold("#" + huifoldId + " .item h4","#" + huifoldId + " .item .info","fast",1,"click"); /*5个参数顺序不可打乱，分别是：相应区,隐藏显示的内容,速度,类型,事件*/
	console.log("out")
}

var number2 = 0;
function addProcessorItem(huifoldId){
	number2 ++;
	console.log("in")
	huifold = document.getElementById(huifoldId);
	var number = number2;
	var li = document.createElement("li");
	li.setAttribute("class", "item");
	li.setAttribute("id", "li"+number)
	li.innerHTML = 
	'<h4>函数'+number+'<b>+</b></h4>\
	<div class="info">\
		<p name="processorModel" index="'+number+'">\
			<div class="row cl">\
				<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>类型：</label>\
            	<div class="formControls col-xs-8 col-sm-9 skin-minimal">\
					<div class="radio-box">\
						<input name="processorModelType1" type="radio" checked="checked" id="processorModelType'+number+'-1" value="source">\
						<label>source</label>\
					</div>\
					<div class="radio-box">\
						<input type="radio" id="processorModelType'+number+'-2" name="processorModelType'+number+'" value="mysql">\
						<label>mysql</label>\
					</div>\
					<div class="radio-box">\
						<input type="radio" id="processorModelType'+number+'-3" name="processorModelType'+number+'" value="console">\
						<label>console</label>\
					</div>\
				</div>\
			</div>\
			<div class="row cl">\
				<label class="form-label col-xs-2 col-sm-2">规则：</label>\
				<div class="formControls col-xs-8 col-sm-8">\
					<textarea name="processorModelRule'+number+'" cols="" rows="" class="textarea"></textarea>\
				</div>\
			</div>\
        </p>\
	</div>'
	huifold.appendChild(li);
	$("#" + huifoldId + " .item h4").unbind("click");
	$.Huifold("#" + huifoldId + " .item h4","#" + huifoldId + " .item .info","fast",1,"click"); /*5个参数顺序不可打乱，分别是：相应区,隐藏显示的内容,速度,类型,事件*/
	console.log("out")
}

function delItem(id){
	item = document.getElementById(id);
	item.parentNode.removeChild(item);
}
</script>
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>
