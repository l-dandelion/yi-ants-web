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
	<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 系统统计 <span class="c-gray en">&gt;</span> 实时数据 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
	<div class="row cl">
		<div id="container" class="col-xs-12 col-sm-12" style="min-width:400px;height:200px"></div>
		<div id="container2" class="col-xs-12 col-sm-12" style="min-width:400px;height:200px"></div>
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
<!--/_footer 作为公共模版分离出去-->


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
                                                url: "/api/statics/postspider?nodename={{.nodename}}&spidername={{.spidername}}",
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
                                                url: "/api/statics/postspider?nodename={{.nodename}}&spidername={{.spidername}}",
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
