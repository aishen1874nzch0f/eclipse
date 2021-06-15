<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
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
			<li><a href="#">用户列表</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<div class="formbody">
			<form id="searchForm" class="form-horizontal">
				<label>账户名称：</label> <input type="text" name="name"
						value="" class="scinput" />
						<label>&nbsp;</label><input name="btnSrearch"
						type="submit" class="button button-primary" value="查询" />
			</form>
		</div>
	</div>

	<div id="content" class="hide">

		<form class="form-horizontal">

			<div class="control-group">
				<label class="control-label"><s>*</s>用户账号：</label>
				<div class="controls">
					<input name="username" type="text"
						class="input-normal control-text" data-rules="{required:true}"/>
							<span class="auxiliary-text">*此账号将用于系统登陆</span>							
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">用户名：</label>
				<div class="controls">
					<input name="fullname" type="text"
						class="input-normal control-text" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">邮箱：</label>
				<div class="controls">
					<input name="email" type="text" class="input-large control-text" data-rules="{email:true}"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label"><s>*</s>部门：</label>
				<div class="controls">
					<input type="text" id="show" name="orgName" data-rules="{required:true}"/>
					 <input	type="hidden" id="hide" name="org" />
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
						['bui/overlay','bui/grid', 'bui/data', 'bui/tree',
								'bui/extensions/treepicker'],
						function(Overlay,Grid, Data, Tree, TreePicker) {

							var editing = new Grid.Plugins.DialogEditing({
								contentId : 'content',//弹出框显示的内容的id
								triggerCls : 'btn-edit',//点击表格行时触发编辑的 css				
								editor : {
									title : '用户信息管理',
									width : 500
								},
								autoSave : true
							//自动添加和更新
							});
							columns = [
									{
										title : '姓名(昵称)',
										dataIndex : 'fullname',
										elCls:'center',
										width : '10%'
									},
									{
										title : '登陆名',
										dataIndex : 'username',
										elCls:'center',
										width : '10%'
									},
									{
										title : '头像',
										dataIndex : 'icon',
										width : '10%',
										elCls:'center',
										renderer : function(value) {
											return "<img src='"+value+"'/>";
										}

									},
									{
										title : '邮箱',
										dataIndex : 'email',
										width : '15%'
									},
									{
										title : '状态',
										dataIndex : 'account_status',
										width : '8%',
										elCls:'center',
										renderer : function(value) {
											if (value == '0') {
												return "<span class='label label-success'>正常</span>";
											} else if (value == '-1') {
												return "<span class='label label-Error'>标记删除</span>";
											} else if (value == '1') {
												return "<span class='label label-info'>未激活</span>";
											} 
										}
									},
									{
										title : '创建时间',
										dataIndex : 'create_date',
										width : '14%'
									},
									{
										title : '更新时间',
										dataIndex : 'last_updated_date',
										width : '14%'
									},
									{
										title : '操作',
										dataIndex : 'd',
										width : '13%',
										renderer : function(value, obj) {
											if(obj.account_status=='1'){
												return '<button class="button button-mini button-primary btn-edit"><i class="icon icon-white icon-edit btn-edit"></i>编辑</button>&nbsp;&nbsp;<button class="button button-mini button-warning btn-active"><i class="icon icon-white icon-ban-circle btn-active"></i>激活</button>';
											}
											else if(obj.account_status=='0'){
												return '<button class="button button-mini button-primary btn-edit"><i class="icon icon-white icon-edit btn-edit"></i>编辑</button>&nbsp;&nbsp;<button class="button button-mini button-warning btn-active"><i class="icon icon-white icon-ban-circle btn-active"></i>冻结</button>';
											}
											else if(obj.account_status=='-1'){
												return '<button class="button button-mini button-primary btn-edit"><i class="icon icon-white icon-edit btn-edit"></i>编辑</button>&nbsp;&nbsp;<button class="button button-mini button-warning btn-active"><i class="icon icon-white icon-ban-circle btn-active"></i>激活</button>';
											}
										}
									} ,
									{
										title : '操作',
										dataIndex : 'e',
										elCls:'center',
										width : '10%',
										renderer : function(value, obj) {
											
												return '<button class="button button-mini button-primary btn-resPwd"><i class="icon icon-white icon-exclamation-sign btn-resPwd"></i>重置密码</button>';
											
										}
									} 
									];

							var store = new Data.Store({
								url : '${ctx}/ms/shiro/user/userList',
								autoLoad : true, //自动加载数据								
								pageSize : 8,
								proxy : {
									method : 'POST', //更改为POST
									save : {
										addUrl : '${ctx}/ms/shiro/user/save',//新增提交的URL
										//removeUrl : '/ms/shiro/user/delete',//删除提交的URL
										updateUrl : '${ctx}/ms/shiro/user/update'//编辑提交的URL
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
									} , {
										btnCls : 'button button-success',
										text : "<i class='icon-certificate icon-white'></i>设置角色",
										listeners : {
											'click' : certFunction
										}
									}]
								}

							}).render();
							//弹出框选择框
							var rolestore = new Data.Store({
								url : '${ctx}/ms/shiro/role/roleList',
								autoLoad : true,
								pageSize:5
							}), rolegrid = new  Grid.Grid({																
								store : rolestore,
								columns :[
											{
												title : '角色名称',
												dataIndex : 'name',
												width : '20%'
											},{
												title : '描述',
												dataIndex : 'desc',
												width : '30%'
											},{
												title : '状态',
												dataIndex : 'status',
												width : '10%',
												renderer : function(value) {
													if (value == '0') {
														return "正常";
													} else if (value == '-1') {
														return "删除";
													} else if (value == '1') {
														return "未激活";
													} else
														return "锁定";
												}
											},{	
												title : '顺序',
												dataIndex : 'seq',
												width : '10%'
											},],
											plugins : [Grid.Plugins.RowNumber,Grid.Plugins.AutoFit,Grid.Plugins.CheckSelection],
											// 底部工具栏
											bbar : {
												// pagingBar:表明包含分页栏
												pagingBar : true
											},
											
							});					
							 var dialog = new Overlay.Dialog({
						          title:'选择角色',
						          width:650,
						          height:400,				         
						          children : [rolegrid],
						          childContainer : '.bui-stdmod-body',
						          success:function () {
						        	  var checkedRoles = rolegrid.getSelection();	//获取角色列表所有选择记录
						        	  var selections = grid.getSelection(); //获取用户列表的值
						        	  if(selections.length>0){
						        		  if (checkedRoles.length>0) {
									        var ids = new Array();
									        BUI.each(checkedRoles,function(node){
									        	ids.push(node.id);
									        });
									        var userIds= new Array();
							                for (var i = 0; i < selections.length; i++) {
							                	userIds.push(selections[i].id);
							                } 
											$.post("${ctx}/ms/shiro/role/setRole",{ids : ids.toString(),userIds:userIds.toString()},
													function(data,status) {										
														if (data.success) {
															BUI.Message.Alert("设置成功！");													
														} else {
															BUI.Message.Alert("设置失败","error");
													}
											});
										}								
										this.close();
						        	  }
						        	  else{
						        		  BUI.Message.Alert("请选择需要设置角色的用户","error");
						        	  }
						          }
						        });			
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
								BUI.Message.Confirm(
												'确认删除么？',function() {
													var ids = new Array();//批量删除的数组ID
													for (var i = 0; i < selections.length; i++) {
														ids.push(selections[i].id);
													}
													$.post("${ctx}/ms/shiro/user/deleteBatch",{ids : ids.toString()},
															function(data,status) {

																if (data.success) {
																	store.load();
																	//store.remove(selections);//删除成功重载grid表格数据
																} else {
																	BUI.Message.Alert("操作操作","error");
																}
															});
												}, 'question');
								return false;
							};	
							//弹出角色选择列表
							function certFunction(){
								dialog.show();   
							}
							grid.on('cellclick',function(ev) {
										var record = ev.record, //点击行的记录
										field = ev.field, //点击对应列的dataIndex
										target = $(ev.domTarget); //点击的元素										
										if (target.hasClass('btn-active')) {											
												$.post("${ctx}/ms/shiro/user/active?id="+ record['id']+"&active="+record['account_status'],
													function(data,status) {
														if (data.success) {
															BUI.Message.Alert(	"操作成功");
															store.load();//重载grid表格数据
														} else {
															BUI.Message.Alert(	"操作失败","error");
														}
														});																							
										}

										if (target.hasClass('btn-resPwd')) {
												$.post("${ctx}/ms/shiro/user/resetPwd/"+ record['id'],
												    function(data,status) {
														if (data.success) {
															BUI.Message.Alert(	"操作成功");
															store.load();//重载grid表格数据
															} 
														else{
															BUI.Message.Alert("操作错误","error");
															}
														});
															
											}										

									});

						});
	</script>
</body>

</html>
