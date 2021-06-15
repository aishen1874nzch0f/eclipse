<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<%@ include file="/common/meta.jsp"%>
</head>

<body>

	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">首页</a></li>
		</ul>
	</div>

	<div class="row">
		<div class="panel  span20">
			<div class="panel-header clearfix">
				<h3 class="pull-left">文书统计</h3>
			</div>
			<div class="panel-body">
				<div class="detail-section">
					<div id="canvas1"></div>
				</div>
			</div>
		</div>
		<div class="panel span10">
			<div class="panel-header clearfix">
				<h3 class="pull-left">欢迎使用文档档案一体化管理系统！</h3>
			</div>
			<div class="panel-body">
				<div class="detail-section">
					<span><img src="${ctx}/styles/images/sun.png" alt="你好" /></span> <b>早上好，<shiro:principal /></b>
					<span><a href="#" id="btnShow"><img	src="${ctx}/styles/images/time.png" alt="日历" /></a></span> <br />
					<span><img src="${ctx}/styles/images/ico01.png"	alt="部门" /></span> <b> 您的部门：</b>${org} <br /> 
					<span><img src="${ctx}/styles/images/dp.png" alt="账号" /></span> <b>登陆账号：</b>${name}
					&nbsp;&nbsp; <i><a href="${ctx}/ms/shiro/user/view">账户信息查看</a></i>					
					
					<div style="height: 195px"></div>
				</div>
			</div>
		</div>		
	</div>

	<script type="text/javascript">
		BUI.use([ 'bui/overlay', 'bui/grid', 'bui/data', 'bui/calendar' ],
				function(Overlay, Grid, Data, Calendar) {

					var calendar = new Calendar.Calendar({
						render : '#calendar'
					});

					var dialog = new Overlay.Dialog({
						title : '查看日历',
						width : 270,
						height :380,
						children : [ calendar ]

					});
					$('#btnShow').on('click', function() {
						dialog.show();
					});
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
									'font-size' : '14px'
								}
							}

						} ]

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
