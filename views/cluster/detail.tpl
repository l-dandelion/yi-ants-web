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
<title>节点查看</title>
</head>
<body>
<div class="pd-20">
	<div class="row cl">
		<div class="col-xs-4 col-sm-4">
			<table class="table">
				<tbody>
					<tr>
						<th class="text-r">节点名：</th>
						<td>{{.nodeInfo.Name}}</td>
					</tr>
					<tr>
						<th class="text-r" width="80">IP：</th>
						<td>{{.nodeInfo.Ip}}</td>
					</tr>
					<tr>
						<th class="text-r">TCP端口：</th>
						<td>{{.nodeInfo.Port}}</td>
					</tr>
					<tr>
						<th class="text-r"> HTTP端口：</th>
						<td>{{.nodeInfo.Settings.HttpPort}}</td>
					</tr>
					<tr>
						<th class="text-r" width="200">待分配队列大小：</th>
						<td>{{.distributeQeueuSize}}</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div id="container" class="col-xs-8 col-sm-8" style="min-width:400px;height:200px"></div>
		<div id="container2" class="col-xs-12 col-sm-12" style="min-width:400px;height:200px"></div>
	</div>
</div>
<div class="page-container">
	<div class="mt-20">
	<table class="table table-border table-bordered table-hover table-bg table-sort">
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
            <tr class="text-c">
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
	</div>
</div>


	
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="/static/h-ui.admin/js/H-ui.admin.js"></script> 

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
</script>
<!--/_footer 作为公共模版分离出去-->

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

<script src="/static/js/highcharts.js"></script>
<script src="/static/js/highcharts-zh_CN.js"></script>
<script src="/static/js/exporting.js"></script>
<script type="text/javascript">
    Highcharts.setOptions({
            global: {
                    useUTC: false
            }
    });
    function activeLastPointToolip(chart) {
            var points = chart.series[0].points;
            chart.tooltip.refresh(points[points.length -1]);
    }
    var chart = Highcharts.chart('container', {
            chart: {
                    type: 'spline',
                    marginRight: 10,
                    events: {
                            load: function () {
                                    var series = this.series[0], series2 = this.series[1],
                                            chart = this;
                                    activeLastPointToolip(chart);
                                    setInterval(function () {
                                            var x = (new Date()).getTime();
                                            activeLastPointToolip(chart);
                                            $.ajax({
                                                url: "/api/cluster/crawlersummary?node={{.nodeInfo.Name}}",
                                                type: "get",
                                                success:function(data){
                                                   series.addPoint([x, data.Data.summary.Crawled], true, false);
                                                   series2.addPoint([x, data.Data.summary.Success], true, false);
                                                   //console.log(data);
                                                },
                                                error:function(e){
                                                    console.log("错误");
                                                }
                                            });
                                    }, 3000);

                            }
                    }
            },
            title: {
                    text: '抓取量实时数据'
            },
            xAxis: {
                    type: 'datetime',
                    tickPixelInterval: 150
            },
            yAxis: {
                    title: {
                            text: null
                    }
            },
            tooltip: {
                    formatter: function () {
                            return '<b>' + this.series.name + '</b><br/>' +
                                    Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '<br/>' +
                                    Highcharts.numberFormat(this.y, 2);
                    }
            },
            legend: {
                    enabled: false
            },
            series: [{
                    name: '已抓取',
                    data: (function () {
                            // 生成随机值
                            var data = [],
                                    time = (new Date()).getTime(),
                                    i;
                            for (i = -0; i <= 0; i += 1) {
                                    data.push({
                                            x: time + i * 1000,
                                            y: {{.summary.Crawled}},
                                    });
                            }
                            return data;
                    }())
            },{
                  name: '成功',
                  data: (function () {
                          // 生成随机值
                          var data = [],
                                  time = (new Date()).getTime(),
                                  i;
                          for (i = -0; i <= 0; i += 1) {
                                  data.push({
                                          x: time + i * 1000,
                                          y: {{.summary.Success}},
                                  });
                          }
                          return data;
                  }())
          }]
    });
</script>

<script type="text/javascript">
	var lastTime = (new Date()).getTime();
	var lastVal = {{.summary.Crawled}}
    var chart2 = Highcharts.chart('container2', {
            chart: {
                    type: 'spline',
                    marginRight: 10,
                    events: {
                            load: function () {
                                    var series = this.series[0], series2 = this.series[1],
                                            chart = this;
                                    activeLastPointToolip(chart);
                                    setInterval(function () {
                                            var x = (new Date()).getTime();
                                            activeLastPointToolip(chart);
                                            $.ajax({
                                                url: "/api/cluster/crawlersummary?node={{.nodeInfo.Name}}",
                                                type: "get",
                                                success:function(data){
                                                   series.addPoint([x, (data.Data.summary.Crawled-lastVal)/(x-lastTime)*1000], true, false);
                                                   lastVal = data.Data.summary.Crawled;
                                                   lastTime = x;
                                                   //console.log(data);
                                                },
                                                error:function(e){
                                                    console.log("错误");
                                                }
                                            });
                                    }, 6000);

                            }
                    }
            },
            title: {
                    text: '抓取速度实时数据'
            },
            xAxis: {
                    type: 'datetime',
                    tickPixelInterval: 150
            },
            yAxis: {
                    title: {
                            text: null
                    }
            },
            tooltip: {
                    formatter: function () {
                            return '<b>' + this.series.name + '</b><br/>' +
                                    Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '<br/>' +
                                    Highcharts.numberFormat(this.y, 2);
                    }
            },
            legend: {
                    enabled: false
            },
            series: [{
                    name: '抓取速度',
                    data: (function () {
                            // 生成随机值
                            var data = [],
                                    time = (new Date()).getTime(),
                                    i;
                            for (i = -0; i <= 0; i += 1) {
                                    data.push({
                                            x: time + i * 1000,
                                            y: 0,
                                    });
                            }
                            return data;
                    }())
            }]
    });
</script>

<!--请在下方写此页面业务相关的脚本-->
</body>
</html>
