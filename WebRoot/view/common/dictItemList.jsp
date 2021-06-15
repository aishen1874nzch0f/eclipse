<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<%@ include file="/common/meta.jsp"%>
<style type="text/css">
    /**内容超出 出现滚动条 **/
    .bui-stdmod-body{
      overflow-x : hidden;
      overflow-y : auto;
    }
 </style>
</head>
<body>

	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="${ctx}/ms">首页</a></li>
			<li><a href="#">字典项列表</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<div class="formbody">
			<form id="searchForm" class="form-horizontal">
				<ul class="seachform">
					<li><label>字典名称</label> <input type="text" name="name"
						value="" class="scinput" /></li>
					<li><label>&nbsp;</label><input name="btnSrearch"
						type="submit" class="scbtn" value="查询" /></li>
						<li><label>&nbsp;</label><input name="return"
						type="button" class="scbtn" value="返回" onclick="javascript:window.location.href = '/ms/sys/dict'"
						/></li>

				</ul>
			</form>
		</div>
	</div>

	<div id="content" class="hide">
		<form class="form-horizontal" method="post">
			<div class="control-group">
				<label class="control-label"><s>*</s>字典项编码：</label>
				<div class="controls">
					<input name="code" type="text"
						class="input-normal control-text" data-rules="{required:true}"/>												
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">字典项名称：</label>
				<div class="controls">
					<input name="name" type="text"
						class="input-normal control-text" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">字典项描述：</label>
				<div class="controls">
					<input name="desc" type="text" class="input-large control-text"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">顺序：</label>
				<div class="controls">
					<input name="seq" type="text" class="input-noraml control-text"/>
					<input name="dict_id" value ="${dictId}" type="hidden"/>
				</div>
			</div>			
		</form>
	</div>
	<div class="content">
		<div class="row">			
			<div class="panel panel-head-borded">
				<div id="grid"></div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		BUI
				.use(
						['bui/grid', 'bui/data'],
						function(Grid, Data) {

							var editing = new Grid.Plugins.DialogEditing({
								contentId : 'content',//弹出框显示的内容的id
								triggerCls : 'btn-edit',//点击表格行时触发编辑的 css				
								editor : {
									title : '字典项管理',
									width : 500
								},
								autoSave : true
							//自动添加和更新
							});
							columns = [
									{
										title : '字典项编号',
										dataIndex : 'code',
										width : '15%'
									},
									{
										title : '字典项名称',
										dataIndex : 'name',
										width : '15%'
									},
									{
										title : '字典项描述',
										dataIndex : 'desc',
										width : '20%'
									},
									{
										title : '顺序',
										dataIndex : 'seq',
										width : '10%'
									},
									{
										title : '所属字典',
										dataIndex : 'cnName',
										width : '15%'
									},
									{
										title : '操作',
										dataIndex : 'd',
										width : '20%',
										renderer : function(value, obj) {
											return '<span class="grid-command btn-edit">编辑</span>';
										}
									} ];

							var store = new Data.Store({
								url : '/ms/sys/dict/dictItemList',
								autoLoad : true, //自动加载数据								
								pageSize : 5,
								proxy : {
									method : 'POST', //更改为POST
									save : {
										addUrl : '/ms/sys/dict/save',//新增提交的URL
										//removeUrl : '/ms/shiro/user/delete',//删除提交的URL
										updateUrl : '/ms/sys/dict/update'//编辑提交的URL
									},
									ajaxOptions : {
										error : function(jqXHR, textStatus,
												responseText) {
											BUI.Message.Alert("网络错误，"
													+ jqXHR.status, "error");
										}
									}
								}
							// 配置分页数目
							}), grid = new Grid.Grid({
								render : '#grid',
								width : '100%',//如果表格使用百分比，这个属性一定要设置
								columns : columns,
								loadMask : true, //加载数据时显示屏蔽层
								store : store,
								plugins : [Grid.Plugins.RowNumber,Grid.Plugins.AutoFit,Grid.Plugins.CheckSelection,editing],
								// 底部工具栏
								bbar : {
									// pagingBar:表明包含分页栏
									pagingBar : true
								},
								tbar : {
									items : [ {
										btnCls : 'button',
										text : "<i class='icon-plus'></i>添加",
										listeners : {
											'click' : addFunction
										}
									}, {
										btnCls : 'button',
										text : "<i class='icon-remove'></i>删除",
										listeners : {
											'click' : delFunction
										}
									} ]
								}

							}).render();													
							
							//保存成功时的回调函数,其实更好的方式是直接在保存成功后调用store.load()方法，更新所有数据
							store.on('saved', function(ev) {
								var type = ev.type, //保存类型，add,remove,update
								saveData = ev.saveData, //保存的数据
								data = ev.data; //返回的数据
								//TO DO
								if (type == 'add') { //新增记录时后台返回id
									saveData.id = data.id;
									grid.updateItem(saveData);
									store.load();
									BUI.Message.Alert('添加成功！');
								} else if (type == 'update') {
									store.load();
									BUI.Message.Alert('更新成功！');
								} else {
									BUI.Message.Alert('删除成功！');
								}
							});
							//保存或者读取失败
							store.on('exception', function(ev) {
								BUI.Message.Alert(ev.error);
							});							
							
							//创建表单，表单中的日历，不需要单独初始化
							var form = new BUI.Form.HForm({
								srcNode : '#searchForm'
							}).render();

							form.on('beforesubmit', function(ev) {
								//序列化成对象
								var obj = form.serializeToObject();
								obj.start = 0; //返回第一页
								store.load(obj);
								return false;
							});

							function addFunction() {
								var newData = {};
								editing.add(newData); //直接弹出框编辑				
							};							
							function delFunction() {
								var selections = grid.getSelection();//获取表格选择的数据行
								if (!selections || selections.length <= 0) {
									BUI.Message.Alert("请选择要删除数据项，可多选",
											"warning");
									return;
								}
								BUI.Message.Confirm(
												'确认删除么？',function() {
													var ids = new Array();//批量删除的数组ID
													for (var i = 0; i < selections.length; i++) {
														ids.push(selections[i].id);
													}
													$.post("/ms/sys/dict/deleteBatch",{ids : ids.toString()},
															function(data,status) {

																if (data.success) {
																	store.load();
																	//store.remove(selections);//删除成功重载grid表格数据
																} else {
																	BUI.Message.Alert("操作失败","error");
																}
															});
												}, 'question');
								return false;
							};								
						});
	</script>
</body>

</html>
