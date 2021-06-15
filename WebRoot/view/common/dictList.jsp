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
			<li><a href="#">字典列表</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<div class="formbody">
			<form id="searchForm" class="form-horizontal" method="post">
				<ul class="seachform">
					<li><label>字典名称</label> <input type="text" name="name"
						value="" class="scinput" /></li>
					<li><label>&nbsp;</label><input name="btnSrearch"
						type="submit" class="scbtn" value="查询" /></li>

				</ul>
			</form>
		</div>
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

							var editing = new Grid.Plugins.RowEditing({
								triggerCls : 'btn-edit',
						        triggerSelected : false,
								autoSave : true
							//自动添加和更新
							});						
							//							
							var dictstore = new Data.Store({
								url : '/ms/sys/dict/dictList',
								autoLoad : true,
								pageSize:10,
								proxy : {
									method : 'POST', //更改为POST
									save : {
										addUrl : '/ms/sys/dict/dictSave',//新增提交的URL
										//removeUrl : '/ms/sys/user/casDelete',//删除提交的URL
										updateUrl : '/ms/sys/dict/dictUpdate'//编辑提交的URL
									},
									ajaxOptions : {
										error : function(jqXHR, textStatus,
												responseText) {
											BUI.Message.Alert("网络错误，"
													+ jqXHR.status, "error");
										}
									}
								}
							}), dictgrid = new  Grid.Grid({																
								store : dictstore,
								render : '#grid',
								width : '100%',//如果表格使用百分比，这个属性一定要设置
								columns :[
											{
												title : '字典名称',
												dataIndex : 'cnName',
												width : '20%',
												editor : {xtype : 'text',rules : {required : true}}
											},{
												title : '描述',
												dataIndex : 'desc',
												width : '30%',
												editor : {xtype : 'text'}
											},{
												title : '英文描述',
												dataIndex : 'name',
												width : '30%',
												editor : {xtype : 'text'}
											},
											{
												title : '操作',
												dataIndex : 'd',
												width : '20%',
												renderer : function(value, obj) {
													return '<span class="grid-command btn-edit">编辑</span><span class="grid-command btn-config">配置</span>';
												}
											}],
											plugins : [editing,Grid.Plugins.RowNumber,Grid.Plugins.AutoFit,Grid.Plugins.RadioSelection],
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
												}]
											}	
							}).render();								
							
							//保存成功时的回调函数,其实更好的方式是直接在保存成功后调用store.load()方法，更新所有数据
							dictstore.on('saved', function(ev) {
								var type = ev.type, //保存类型，add,remove,update
								saveData = ev.saveData, //保存的数据
								data = ev.data; //返回的数据
								//TO DO
								if (type == 'add') { //新增记录时后台返回id
									saveData.id = data.id;
									dictgrid.updateItem(saveData);
									dictstore.load();
									BUI.Message.Alert('添加成功！');
								} else if (type == 'update') {
									dictstore.load();
									BUI.Message.Alert('更新成功！');
								} else {
									BUI.Message.Alert('删除成功！');
								}
							});
							//保存或者读取失败
							dictstore.on('exception', function(ev) {
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
								dictstore.load(obj);
								return false;
							});
							
							dictgrid.on('cellclick',function(ev) {
								var record = ev.record, //点击行的记录
								field = ev.field, //点击对应列的dataIndex
								target = $(ev.domTarget); //点击的元素
								if (target.hasClass('btn-config')) {

									window.location.href = "/ms/sys/dict/itemConfig/"
											+ record['id'];
								}
							});
							function addFunction() {
								var newData = {};
								//editing.add(newData); //直接弹出框编辑
								dictstore.addAt(newData,0);
						        editing.edit(newData,'cnName'); //添加记录后，直接编辑
							};							
							function delFunction() {
								var selections = dictgrid.getSelection();//获取表格选择的数据行
								if (!selections || selections.length <= 0) {
									BUI.Message.Alert("请选择要删除数据项",
											"warning");
									return;
								}
								BUI.Message.Confirm(
												'确认删除么？<br/><h4>*删除同时也会删除所有字典项</h4>',function() {
													var ids = new Array();//批量删除的数组ID
													for (var i = 0; i < selections.length; i++) {
														ids.push(selections[i].id);
													}
													$.post("/ms/sys/dict/casDelete",{ids : ids.toString()},
															function(data,status) {

																if (data.success) {
																	dictstore.load();
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
