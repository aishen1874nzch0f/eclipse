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
			<li><a href="${ctx}/ms/main">首页</a></li>
			<li><a href="#">角色列表</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<div class="formbody">
			<form id="searchForm" class="form-horizontal">
					<label>角色名称：</label> <input type="text" name="name"
						value="" class="scinput" />
					<label>&nbsp;</label>
					<input name="btnSrearch"
						type="submit" class="button button-primary" value="查询"/>
			</form>
		</div>
		</div>
		<div id="content" class="hide">
			<form class="form-horizontal">
				<div class="control-group">
					<label class="control-label"><s>*</s>角色名：</label>
					<div class="controls">
						<input name="name" type="text" class="input-normal control-text" data-rules="{required:true}"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">角色描述：</label>
					<div class="controls control-row-auto">
						<textarea name="desc" class="input-large control-text  control-row2"  ></textarea>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">顺序：</label>
					<div class="controls">
						<input name="seq" type="text" class="input-large control-text"  data-messages="{regexp:'不是有效的数字'}" data-rules="{regexp:/^\d+$/}"/>
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
		BUI.use([ 'bui/overlay','bui/tree','bui/grid', 'bui/data' ],function(Overlay,Tree,Grid, Data) {

					var editing = new Grid.Plugins.DialogEditing({
						contentId : 'content',//弹出框显示的内容的id
						triggerCls : 'btn-edit',//点击表格行时触发编辑的 css				
						editor : {
							title : '角色信息管理',
							width : 500,							
						},
						autoSave : true
					//自动添加和更新
					});						     
					//列表字段
					columns = [
							{
								title : '角色名称',
								dataIndex : 'name',
								elCls:'center',
								width : '10%'
							},
							{
								title : '描述',
								dataIndex : 'desc',
								elCls:'center',
								width : '20%'
							},
							{
								title : '图标',
								dataIndex : 'icon',
								width : '10%',
								elCls:'center',
								renderer : function(value) {
									return "<i class="+value+"></i>";				
								}
							},
							{
								title : '状态',
								dataIndex : 'status',
								width : '10%',								
								elCls : 'center',
								renderer : function(value) {
									if (value == '0') {
										return "<span class='label label-success'>正常</span>";
									} else if (value == '-1') {
										return "删除";
									} else if (value == '1') {
										return "<span class='label label-info'>未激活</span>";
									} else
										return "锁定";
								}
							},{	
								title : '顺序',
								dataIndex : 'seq',
								elCls:'center',
								width : '5%'
							},{
								title : '创建时间',
								dataIndex : 'create_date',
								elCls:'center',
								width : '15%'
							},
							{
								title : '更新时间',
								dataIndex : 'updated_date',
								elCls:'center',
								width : '15%'
							},
							{
								title : '操作',
								dataIndex : 'd',
								width : '15%',
								elCls:'center',
								renderer : function(value, obj) {
									if(obj.status=='0'){
										return '<button class="button button-mini button-primary btn-edit"><i class="icon icon-white icon-edit btn-edit"></i>编辑</button>&nbsp;&nbsp;<button class="button button-mini button-warning btn-active"><i class="icon icon-white icon-ban-circle btn-active"></i>停用</button>';
									}
									else{
										return '<button class="button button-mini button-primary btn-edit"><i class="icon icon-white icon-edit btn-edit"></i>编辑</button>&nbsp;&nbsp;<button class="button button-mini button-success btn-active"><i class="icon icon-ok icon-white btn-active"></i>激活</button>';
									}
								}
							} ];

							//创建表单，表单中的日历，不需要单独初始化

							var store = new Data.Store({
								url : '${ctx}/ms/shiro/role/roleList',
								autoLoad : true, //自动加载数据								
								pageSize : 8,
								proxy : {
									method : 'POST', //更改为POST
									save : {
										addUrl : '${ctx}/ms/shiro/role/save',//新增提交的URL
										removeUrl : '${ctx}/ms/shiro/role/delete',//删除提交的URL
										updateUrl : '${ctx}/ms/shiro/role/update'//编辑提交的URL
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
								plugins : [Grid.Plugins.RowNumber,Grid.Plugins.AutoFit,Grid.Plugins.RadioSelection,editing],
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
									},{
										btnCls : 'button button-success',
										text : "<i class='icon-certificate icon-white'></i>授权",
										listeners : {
											'click' : certFunction
										}
									}
									]
								}

							}).render();
							//树弹出框
							var selectRoleId='${ctx}/ms/shiro/res/resTree';
							var treestore = new Data.TreeStore({
								url : selectRoleId,
								autoLoad : false								
							});
							var tree = new Tree.TreeList({
								//render : '#tree',									
								store : treestore,
								showLine : true,								
								checkType : 'all'								
							});					
							 var dialog = new Overlay.Dialog({
						          title:'选择资源',
						          width:400,
						          height:400,				         
						          children : [tree],
						          childContainer : '.bui-stdmod-body',
						          success:function () {
						        	  var checkedNodes = tree.getCheckedNodes();	//获取树所有选择节点
						        	  var selections = grid.getSelection(); //获取列表的值						        	 
						        	  if(selections.length>0){						        		  
										if (checkedNodes.length>0) {
									        var ids = new Array();
									        BUI.each(checkedNodes,function(node){
									        	if(node.id!=0){
									        		ids.push(node.id);
									        	}									        	
									        });
									        var roleids= new Array();
							                for (var i = 0; i < selections.length; i++) {
							                	roleids.push(selections[i].id);
							                } 
											$.post("${ctx}/ms/shiro/res/setRes",{ids : ids.toString(),roleId:roleids.toString()},
													function(data,status) {										
														if (data.success) {
															BUI.Message.Alert("设置成功！");	
															//window.parent.frames[ "rightFrame"].location.reload();	
														} else {
															BUI.Message.Alert("删除错误","error");
													}
											});
										}								
										this.close();
						        	  }
						        	  else{
						        		  BUI.Message.Alert("请选择需要设置权限角色","error");
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
								BUI.Message.Confirm('确认删除么？',function() {
													var ids = new Array();//批量删除的数组ID
													for (var i = 0; i < selections.length; i++) {
														ids.push(selections[i].id);
													}
													$.post("${ctx}/ms/shiro/role/deleteBatch",{ids : ids.toString()},
															function(data,status) {

																if (data.success) {
																	store.remove(selections);//删除成功重载grid表格数据
																} else {
																	BUI.Message.Alert("删除错误","error");
																}
															});
												}, 'question');
								return false;
							};
							//弹出菜单选择树
							function certFunction(){
								
								var selections = grid.getSelection();	
								if (!selections||selections.length <=0) {								
									  BUI.Message.Alert("请选择需要设置权限角色","error");
									  return;
								}								  
								dialog.show();								
							}
							/**
							function setTree(roleIds){								
								$.ajax({     
						            //要用post方式      
						            type: "post",     
						            //方法所在页面和方法名      
						            url: "/ms/shiro/res/resSelect?roleid="+roleIds,     
						            contentType: "application/json; charset=utf-8",     
						            dataType: "json",     
						            success: function(data) { 
						            	var myobj=eval(data); 						            					            	
						            	for(var i=0;i<myobj.length;i++){						            		
						            		console.log('========'+myobj[i].id);
						            		var node =  tree.findNode(myobj[i].id);
						            		tree.setChecked(node);
						            		console.log(treestore.reloadNode());
						            	}
						            },     
						            error: function(err) {     
						                alert(err);     
						            }     
						       	 }); 
							}**/
							//grid单击操作。
							grid.on('cellclick', function(ev) {
								var record = ev.record, //点击行的记录								
								//field = ev.field, //点击对应列的dataIndex
								target = $(ev.domTarget); //点击的元素	
								//根据角色获取已经设置的菜单
								if(record['id']!=null){
									selectRoleId='${ctx}/ms/shiro/res/resTree?roleid=';
									selectRoleId+=record['id'];
									treestore.get('proxy').set('url',selectRoleId);									
					        		treestore.load();					        		
								}
								if (target.hasClass('btn-active')) {
									$.post("${ctx}/ms/shiro/role/active?id="+ record['id']+"&active="+record['status'], function(data,status) {
										if (data.success) {
											BUI.Message.Alert("操作成功");
											store.load();//重载grid表格数据
										} else {
											BUI.Message.Alert("操作失败", "error");
										}
									});
								}

							});
						});
	</script>
</body>

</html>
