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
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 系统统计 <span class="c-gray en">&gt;</span> 实时数据 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<article class="page-container">
	<div class="cl pd-5 bg-1 bk-gray mt-20"> 
		<span class="l">
			<a href="javascript:;" onclick="show()" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 当前窗口打开</a>
			<a href="javascript:;" onclick="create()" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 新窗口打开</a>
		</span>
	</div>
	<form action="/statics/postspider" method="post" class="form form-horizontal" id="form-member-add">
		<div class="row cl">
			<label class="form-label col-xs-3 col-sm-3">选择爬虫：</label>
			<div class="formControls col-xs-3 col-sm-3"> <span class="select-box">
				<select class="select" size="1" name="spidername" id="spidername">
					<option value="" selected>全部</option>
					{{range $index, $name := .spiderNames}}
					<option value="{{$name}}">{{$name}}</option>
					{{end}}
				</select>
				</span> </div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-3 col-sm-3">选择节点：</label>
			<div class="formControls col-xs-3 col-sm-3"> <span class="select-box">
				<select class="select" size="1" name="nodename" id="nodename">
					<option value="" selected>全部</option>
					{{range $index, $ni := .nodeInfos}}
					<option value="{{$ni.Name}}">{{$ni.Name}}</option>
					{{end}}
				</select>
				</span> </div>
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
function show() {
	spidername = document.getElementById("spidername").value
	nodename = document.getElementById("nodename").value
	spidernamedesc = spidername
	nodenamedesc = nodename
	if(spidernamedesc==""){
		spidernamedesc="全部"
	}
	if(nodenamedesc==""){
		nodenamedesc="全部"
	}
	layer_show(spidernamedesc+"/"+nodenamedesc,'/statics/postspider?spidername=' + spidername + '&nodename=' + nodename, '1080','720')
}
function create() {
	spidername = document.getElementById("spidername").value
	nodename = document.getElementById("nodename").value
	spidernamedesc = spidername
	nodenamedesc = nodename
	if(spidernamedesc==""){
		spidernamedesc="全部"
	}
	if(nodenamedesc==""){
		nodenamedesc="全部"
	}
	creatIframe('/statics/postspider?spidername=' + spidername + '&nodename=' + nodename,"实时数据:"+spidernamedesc+"/"+nodenamedesc);  
}
</script> 
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>
