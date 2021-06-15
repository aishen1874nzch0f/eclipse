<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<%@ include file="/common/meta.jsp"%>
</head>

<body>

	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="${ctx}/ms">首页</a></li>
			<li><a href="#">组织机构列表</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<div class="formbody">
			<form id="searchForm" class="form-horizontal">
				<label>机构名称：</label> <input type="text" name="name"
						value="" class="scinput" />
					<label>&nbsp;</label><input name="btnSrearch"
						type="submit" class="button button-primary" value="查询"/>

				
			</form>
		</div>
		</div>
		
		<div id="content" class="hide">
			<form class="form-horizontal">
				<div class="control-group">
					<label class="control-label"><s>*</s>机构名称：</label>
					<div class="controls">
						<input name="name" type="text" class="input-normal control-text" data-rules="{required:true}"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">描述：</label>
					<div class="controls control-row-auto">
						<textarea name="desc" class="input-large control-text  control-row2" ></textarea>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">全称：</label>
					<div class="controls">
						<input name="fullname" type="text" class="input-large control-text" />
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">是否启用：</label>
					<div class="controls">
						<select name="active">
						<option value="0">启用</option>
						<option value="1">停用</option>						
						</select>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">类型：</label>
					<div class="controls">
						<select name="type">
						<option value="0">集团公司</option>
						<option value="1">集团部门</option>
						<option value="2">子公司</option>
						<option value="3">子公司部门</option>
						<option value="4">小组</option>
						</select>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label"><s>*</s>上级机构：</label>
					<div class="controls">
						<input type="text" id="show" name="pname" data-rules="{required:true}"/> <input
						type="hidden" id="hide" name="parent_org" />
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
		BUI.use(['bui/grid', 'bui/data', 'bui/tree','bui/extensions/treepicker'],
						function(Grid, Data, Tree,TreePicker) {
							//组织结构树选择框
							var treestore = new Data.TreeStore({
								url : '${ctx}/ms/shiro/org/orgTree',
								autoLoad : true
							/**/
							}),
							//由于这个树，不显示根节点，所以可以不指定根节点
							tree = new Tree.TreeList({
								store : treestore,
								//dirSelectable : false,//阻止树节点选中								
								showLine : true, //显示连接线
								checkType : false
							});
				
							var picker = new TreePicker({
								trigger : '#show',
								valueField : '#hide', //如果需要列表返回的value，放在隐藏域，那么指定隐藏域
								width : 150, //指定宽度
								children : [ tree ]
							//配置picker内的列表
							}).render();
							//树操作
							tree.on('itemclick', function(ev) {
								var item = ev.item;
								picker.setSelectedValue(item.text);
							});
							var editing = new Grid.Plugins.DialogEditing({
								contentId : 'content',//弹出框显示的内容的id
								triggerCls : 'btn-edit',//点击表格行时触发编辑的 css				
								editor : {
									title : '组织信息管理',
									width : 500
								},
								autoSave : true
							//自动添加和更新
							});
							columns = [
									{
										title : '上级机构',
										dataIndex : 'pname',
										elCls:'center',
										width : '20%',
										renderer : function(value) {
										if (value == null) {
											return "<span class='label label-success'>无</span>";
										 }
										else
											return value;
										}
									},
									{
										title : '简称',
										dataIndex : 'name',
										elCls:'center',
										width : '10%'
									},
									{
										title : '描述',
										dataIndex : 'desc',
										width : '20%'
									},
									{
										title : '是否启用',
										dataIndex : 'active',
										width : '8%',
										elCls:'center',
										renderer : function(value) {
											if (value == '0') {
												return '<span class="label label-success">启用</span>';
											}
											else if(value == '1') {
												return '<span class="label">停用</span>';	
											}										
										}
									},
									{
										title : '类型',
										dataIndex : 'type',
										width : '15%',
										elCls:'center',
										renderer : function(value) {
											if (value == '0') {
												return '集团公司';
											} else if (value == '1') {
												return '集团部门';
											} else if (value == '2') {
												return '子公司';
											} else if(value == '3'){
												return '子公司部门';
											}else{
											 return '小组';
											}
												
										}
									},
									{
										title : '操作',
										dataIndex : 'd',
										width : '15%',
										elCls:'center',
										renderer : function(value, obj) {
											if(obj.active=='0'){
												return '<button class="button button-mini button-primary btn-edit"><i class="icon icon-white icon-edit btn-edit"></i>编辑</button>&nbsp;&nbsp;<button class="button button-mini button-warning btn-active"><i class="icon icon-white icon-ban-circle btn-active"></i>冻结</button>';
											}
											else if(obj.active=='1'){
												return '<button class="button button-mini button-primary btn-edit"><i class="icon icon-white icon-edit btn-edit"></i>编辑</button>&nbsp;&nbsp;<button class="button button-mini button-warning btn-active"><i class="icon icon-white icon-ban-circle btn-active"></i>激活</button>';
											}											
										}
									} ];
							
							var store = new Data.Store({
								url : '${ctx}/ms/shiro/org/orgList',
								autoLoad : true, //自动加载数据								
								pageSize : 10,
								proxy : {
									method : 'POST', //更改为POST
									save : {
										addUrl : '${ctx}/ms/shiro/org/save',//新增提交的URL
										removeUrl : '${ctx}/ms/shiro/org/delete',//删除提交的URL
										updateUrl : '${ctx}/ms/shiro/org/update'//编辑提交的URL
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
								//forceFit: true,
								width : '100%',//如果表格使用百分比，这个属性一定要设置
								height:'350',
								innerBorder: false,
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
										btnCls : 'button button-primary',
										text : "<i class='icon-plus icon-white'></i>添加",
										listeners : {
											'click' : addFunction
										}
									}, {
										btnCls : 'button button-warning',
										text : "<i class='icon-remove icon-white'></i>删除",
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
							}
							;
							function delFunction() {
								var selections = grid.getSelection();//获取表格选择的数据行
								if (!selections || selections.length <= 0) {
									BUI.Message.Alert("请选择要删除数据项，可多选",
											"warning");
									return;
								}
								BUI.Message.Confirm('确认删除么？',function() {
									var ids = new Array();//批量删除的数组ID
									for (var i = 0; i < selections.length; i++) {
										ids.push(selections[i].id);
									}
									$.post("${ctx}/ms/shiro/org/deleteBatch",{ids : ids.toString()},function(data,status) {
											if (data.success) {
												store.load();//删除成功重载grid表格数据
											} else {
												BUI.Message.Alert("删除错误","error");
											}
										});
									}, 'question');
								return false;
							};
							grid.on('cellclick',function(ev) {
								var record = ev.record, //点击行的记录
								field = ev.field, //点击对应列的dataIndex
								target = $(ev.domTarget); //点击的元素
								if (target.hasClass('btn-active')) {
									$.post("${ctx}/ms/shiro/org/active?id="+ record['id']+"&active="+record['active'],
										function(data,status) {
											if (data.success) {
												store.load();//成功重载grid表格数据
											} else {
												BUI.Message.Alert("系统错误","error");
											}
										});
								};								
							});

						});		
	</script>
</body>

</html>
