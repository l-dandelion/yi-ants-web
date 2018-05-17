<!DOCTYPE HTML>
<html>
<head>
<style type="text/css">
*{margin:0;padding:0;list-style-type:none;}
a,img{border:0;}
table{empty-cells:show;border-collapse:collapse;border-spacing:0; table-layout:fixed;/* 只有定义了表格的布局算法为fixed，下面td的定义才能起作用。 */}
td{
    width:100%;
    word-break:keep-all;/* 不换行 */
    white-space:nowrap;/* 不换行 */
    overflow:hidden;/* 内容超出宽度时隐藏超出部分的内容 */
    text-overflow:ellipsis;/* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用。*/
}
body{font:12px/180% Arial, Helvetica, sans-serif, "新宋体";}

.thinkcss{margin:40px auto}
.thinkcss h2{font-size:18px;height:52px;color:#3366cc;text-align:center;}
.listext th{background:#eee;color:#3366cc;}
.listext th,.listext td{border:solid 1px #ddd;text-align:left;padding:10px;font-size:14px;}

.rc-handle-container{position:relative;}
.rc-handle{position:absolute;width:7px;cursor:ew-resize;*cursor:pointer;margin-left:-3px;}

#n{margin:10px auto; width:920px; border:1px solid #CCC;font-size:12px; line-height:30px;}
#n a{ padding:0 4px; color:#333}
</style>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
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
<title>节点管理</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 数据库 <span class="c-gray en">&gt;</span> 表查询 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
	<div class="thinkcss">
	<table class="table listext" data-resizable-columns-id="demo-table">
		<thead>
			<tr class="text-c">
			    {{range $index, $filed := .filedNames}}
			        {{range $index2, $f := $filed}}
                        {{if eq $index 0}}
                            <th width="30">{{$f}}</th>
                        {{else}}
                            <th>{{$f}}</th>
                        {{end}}
			        {{end}}
                {{end}}
			</tr>
		</thead>
		<tbody>
			{{range $index, $params := .paramsList}}
				<tr　class="text-c">
				{{range $index2, $param := $params}}
					<td>{{$param}}</td>
                {{end}}
				</tr>
			{{end}}
		</tbody>
	</table>
	</br>
	<div class="row cl pull-right">
            {{if ne .next 1}}
                <button class="btn btn-primary radius" onclick="window.open('/database/table?tablename={{.tablename}}&page={{.last}}&limit={{.limit}}', '_self')">&nbsp;&nbsp;下一页&nbsp;&nbsp;</button>
            {{end}}
            <button class="btn btn-primary radius" onclick="window.open('/database/table?tablename={{.tablename}}&page={{.next}}&limit={{.limit}}', '_self')">&nbsp;&nbsp;下一页&nbsp;&nbsp;</button>
    </div>
	</div>

</div>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="/static/h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript" src="/static/js/jq.resizableColumns.js"></script>
<script>
    $(function(){
    	$("table").resizableColumns({});
    });
</script>


<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="/lib/laypage/1.2/laypage.js"></script>
</body>
</html>