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

	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="/ms">首页</a></li>
			<li><a href="#">用户任务</a></li>
		</ul>
	</div>
	<div class="content">
		<div class="row">
			<div class="panel panel-info span24">
				<div class="panel-header clearfix">
					<h3 class="pull-left">待办任务</h3>
				</div>
				<div class="panel-body">
					<div id="grid"></div>
				</div>
			</div>
			<div class="panel panel-info span24">
				<div class="panel-header clearfix">
					<h3 class="pull-left">协办任务</h3>
				</div>
				<div class="panel-body">
					<div id="grid"></div>
				</div>
			</div>
			<div class="panel panel-info span24">
				<div class="panel-header clearfix">
					<h3 class="pull-left">抄送任务</h3>
				</div>
				<div class="panel-body">
					<div id="grid"></div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		BUI.use([ 'bui/grid', 'bui/data', ], function(Grid, Data) {

			columns = [ {
				title : '任务名称',
				dataIndex : 'task_Name',
				width : '20%'
			}, {
				title : '任务显示名称',
				dataIndex : 'display_Name',
				width : '20%'
			}, {
				title : '任务类型',
				dataIndex : 'task_Type',
				width : '10%'
			}, {
				title : '任务处理人',
				dataIndex : 'operator',
				width : '10%'

			}, {
				title : '任务创建时间',
				dataIndex : 'create_Time',
				width : '15%'
			}, {
				title : '任务期望完成时间',
				dataIndex : 'expire_Time',
				width : '15%'
			}, {
				title : '处理',
				dataIndex : 'action_Url',
				width : '10%',
				renderer : function(value, obj) {
					return '<a href='+value+'>处理</a>';
				}
			} ];
			var store = new Data.Store({
				url : '/ms/flow/task/toDoList',
				autoLoad : true, //自动加载数据				
				pageSize : 10
			// 配置分页数目
			}), grid = new Grid.Grid({
				render : '#grid',
				width : '100%',//如果表格使用百分比，这个属性一定要设置
				columns : columns,
				loadMask : true, //加载数据时显示屏蔽层
				store : store,
				plugins : [ Grid.Plugins.RowNumber, Grid.Plugins.AutoFit ],
				// 底部工具栏
				bbar : {
					// pagingBar:表明包含分页栏
					pagingBar : true
				}
			}).render();
		});
	</script>
</body>

</html>
