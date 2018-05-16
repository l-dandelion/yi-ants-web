<!DOCTYPE HTML>
<html>
<head>
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

<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 爬虫中心 <span class="c-gray en">&gt;</span> 爬虫列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
	<div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l"><a href="javascript:;" onclick="member_add('添加爬虫','/spider/add','1080','720')" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 添加爬虫</a></span></div>
	<div class="mt-20">
	<table class="table table-border table-bordered table-hover table-bg table-sort">
		<thead>
			<tr class="text-c">
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
            <tr class="text-c">
                <td>{{$index}}</td>
                <td><u style="cursor:pointer" class="text-primary" onclick="member_show('{{$si.Name}}','/spider/detail?spider={{$si.Name}}','10001','1080','720')">{{$si.Name}}</u></td>
                <td>{{$si.Status}}</td>
                <td>{{$si.Crawled}}</td>
                <td>{{$si.Success}}</td>
                <td>{{$si.Running}}</td>
                <td>{{$si.Waiting}}</td>
                <td>{{$si.StartTime}}</td>
                <td>{{$si.EndTime}}</td>
                <td>{{$si.Extra}}</td>
                <td>
                    <span class="dropDown"> <a class="dropDown_A" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><font color="blue">操作</font></a>
						<ul class="dropDown-menu menu radius box-shadow">
							<li><a href="#" onclick="action('complile', '{{$si.Name}}')">编译</a></li>
                            <li><a href="#" onclick="action('init', '{{$si.Name}}')">准备</a></li>
                            <li><a href="#" onclick="action('start', '{{$si.Name}}')">开始</a></li>
                            <li><a href="#" onclick="confirmAction('stop', '{{$si.Name}}')">终止</a></li>
                            <li><a href="#" onclick="action('pause', '{{$si.Name}}')">暂停</a></li>
                            <li><a href="#" onclick="action('recover', '{{$si.Name}}')">恢复</a></li>
                            <li><a href="#" onclick="confirmAction('delete', '{{$si.Name}}')">删除</a></li>
						</ul>
					</span>
                </td>
            </tr>
            {{end}}
		</tbody>
	</table>
	</div>
</div>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="/lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="/static/h-ui/js/H-ui.min.js"></script> 
<script type="text/javascript" src="/static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="/lib/My97DatePicker/4.8/WdatePicker.js"></script> 
<script type="text/javascript" src="/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript">
$(function(){
	$('.table-sort').dataTable({
		"aaSorting": [[ 1, "desc" ]],//默认第几个排序
		"bStateSave": true,//状态保存
		"aoColumnDefs": [
		  //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
		  //{"orderable":false,"aTargets":[0,8,9]}// 制定列不参与排序
		]
	});
	
});
/*用户-添加*/
function member_add(title,url,w,h){
	layer_show(title,url,w,h);
}
/*用户-查看*/
function member_show(title,url,id,w,h){
	layer_show(title,url,w,h);
}
/*用户-停用*/
function member_stop(obj,id){
	layer.confirm('确认要停用吗？',function(index){
		$.ajax({
			type: 'POST',
			url: '',
			dataType: 'json',
			success: function(data){
				$(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="member_start(this,id)" href="javascript:;" title="启用"><i class="Hui-iconfont">&#xe6e1;</i></a>');
				$(obj).parents("tr").find(".td-status").html('<span class="label label-defaunt radius">已停用</span>');
				$(obj).remove();
				layer.msg('已停用!',{icon: 5,time:1000});
			},
			error:function(data) {
				console.log(data.msg);
			},
		});		
	});
}

/*用户-启用*/
function member_start(obj,id){
	layer.confirm('确认要启用吗？',function(index){
		$.ajax({
			type: 'POST',
			url: '',
			dataType: 'json',
			success: function(data){
				$(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="member_stop(this,id)" href="javascript:;" title="停用"><i class="Hui-iconfont">&#xe631;</i></a>');
				$(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已启用</span>');
				$(obj).remove();
				layer.msg('已启用!',{icon: 6,time:1000});
			},
			error:function(data) {
				console.log(data.msg);
			},
		});
	});
}
/*用户-编辑*/
function member_edit(title,url,id,w,h){
	layer_show(title,url,w,h);
}
/*密码-修改*/
function change_password(title,url,id,w,h){
	layer_show(title,url,w,h);	
}
/*用户-删除*/
function member_del(obj,id){
	layer.confirm('确认要删除吗？',function(index){
		$.ajax({
			type: 'POST',
			url: '',
			dataType: 'json',
			success: function(data){
				$(obj).parents("tr").remove();
				layer.msg('已删除!',{icon:1,time:1000});
			},
			error:function(data) {
				console.log(data.msg);
			},
		});		
	});
}
</script> 
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
                    setTimeout(function(){ location.reload(); }, 1000);
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
