<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<%@ include file="/common/meta.jsp"%>
</head>

<body>

	<div class="content">
		<div class="row">
			<ul class="breadcrumb">
				<li><a href="/ms">首页</a> <span class="divider">/</span></li>
				<li><a href="#">工作台</a></li>
			</ul>
		</div>

		<div class="row">
			<div class="panel  panel-info span20">
				<div class="panel-header clearfix">
					<h3 class="pull-left">文书统计</h3>
				</div>
				<div class="panel-body">
					<div class="detail-section">
						<div id="canvas1"></div>
					</div>
				</div>
			</div>
			<div class="panel panel-info span7">
				<div class="panel-header clearfix">
					<h3 class="pull-left">月历</h3>
				</div>
				<div class="panel-body">
					<div id="calendar"></div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="panel  panel-info span17">
				<div class="panel-header clearfix">
					<h3 class="pull-left">代办任务</h3>
				</div>
				<div class="panel-body">
					<iframe width="630px" src=""></iframe>
					<!--<div id="todo_grid"></div>-->
				</div>
			</div>
			<div class="panel panel-info span10">
				<div class="panel-header clearfix">
					<h3 class="pull-left">消息</h3>
				</div>
				<div class="panel-body">
					<div id="mes_grid"></div>
				</div>
			</div>
		</div>
	</div>
	<!-- <script src="http://g.tbcdn.cn/bui/acharts/1.0.32/acharts-min.js"></script> -->
	<!-- https://g.alicdn.com/bui/acharts/1.0.29/acharts-min.js -->

	<script type="text/javascript">
		 BUI.use(['bui/grid','bui/data','bui/calendar'],function(Grid,Data,Calendar){
			 
		     var calendar = new Calendar.Calendar({
		       render:'#calendar'
		     }).render();
		     /**
		     calendar.on('selectedchange',function (ev) {
		       alert(ev.date);
		     });
		     **/		 	

			var taskstore = new Data.Store({
				url : '/ms/flow/task/user',
				autoLoad : true, //自动加载数据								
				pageSize : 5				
			// 配置分页数目
			}), taskgrid = new Grid.Grid({
				render : '#todo_grid',
				width : '100%',//如果表格使用百分比，这个属性一定要设置
				columns : [	{
					title : '流程名称',
					dataIndex : 'processName',
					width : '15%'
				},
				{
					title : '流程编号',
					dataIndex : 'orderNo',
					width : '20%'
				},
				{
					title : '流程启动时间',
					dataIndex : 'orderCreateTime',
					width : '20%'
				},
				{
					title : '任务名称',
					dataIndex : 'taskName',
					width : '20%'
				},
				{
					title : '任务创建时间',
					dataIndex : 'taskCreateTime',
					width : '15%'
				},
				{
					title : '操作',
					dataIndex : 'd',
					width : '10%',
					renderer : function(value, obj) {							
							return '<span class="grid-command btn-cl">处理</span>';
					}
				} ],
				loadMask : true, //加载数据时显示屏蔽层
				store : taskstore,
				plugins : [Grid.Plugins.AutoFit]
				
			}).render();
		     
			var messtore = new Data.Store({
				url : '/ms/flow/task/user',
				autoLoad : true, //自动加载数据								
				pageSize : 5				
			// 配置分页数目
			}), mesgrid = new Grid.Grid({
				render : '#mes_grid',
				width : '100%',//如果表格使用百分比，这个属性一定要设置
				columns : [	{
					title : '消息名称',
					dataIndex : 'processName',
					width : '20%'
				},
				{
					title : '消息编号',
					dataIndex : 'orderNo',
					width : '20%'
				},
				{
					title : '消息发送时间',
					dataIndex : 'orderCreateTime',
					width : '30%'
				},				
				{
					title : '操作',
					dataIndex : 'd',
					width : '20%',
					renderer : function(value, obj) {							
							return '<span class="grid-command btn-cl">查看</span>';
					}
				} ],
				loadMask : true, //加载数据时显示屏蔽层
				store : messtore,
				plugins : [Grid.Plugins.AutoFit]
			}).render();		
		 });
		 
		$(document).ready(function() {

			$.ajax({
				type : 'get',
				url : '/ms/com/tongjiAjax',//请求数据的地址
				success : function(data) {
					var xset = [];//X轴数据集    
					var yset_1 = [];//Y轴数据集    
					//var yset_2 = [];//Y轴数据集 
					$.each(data, function(i, item) {
						xset.push(item.arch_date);
						yset_1.push(item.num);
						//yset_2.push(item.value2);
					});
					var chart1 = new AChart({
						theme : AChart.Theme.SmoothBase,
						id : 'canvas1',
						width : 800,
						height : 290,
						plotCfg : {
							margin : [ 40, 40, 60 ]
						//画板的边距
						},
						xAxis : {
							categories : xset,
							labels : {
								label : {
									//rotate : -45,
									'text-anchor' : 'end'
								}
							}
						},
						yAxis : {
							min : 0
						},
						seriesOptions : { //设置多个序列共同的属性
						/*columnCfg : { //公共的样式在此配置
						
						}*/
						},
						tooltip : {
							valueSuffix : '篇'
						},
						series : [ {
							name : '文书数量',
							type : 'column',
							data : yset_1,
							labels : { //显示的文本信息
								label : {
									rotate : -90,
									y : 10,
									'fill' : '#fff',
									'text-anchor' : 'end',
									textShadow : '0 0 3px black',
									'font-size' : '6px'
								}
							}

						}]

					});
					chart1.render();
				},
				error : function(e) {
				}
			});			
		});
	</script>
</body>
</html>
