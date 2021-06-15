<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<%@ include file="/common/meta.jsp"%> 
<style type="text/css">
  /** read状态 **/
  .bui-grid-row-read{
   color:#777666;   
  }
</style>
</head>
<body>

	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="${ctx}/ms">首页</a></li>
			<li><a href="#">资源列表</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<div class="formbody">
			<form id="searchForm" class="form-horizontal">
				<label>资源名称：</label>
				<input type="text" name="name" value="" class="scinput" />
				<label>&nbsp;</label><input name="btnSrearch" type="submit"
					class="button button-primary" value="查询"/>
			</form>
		</div>
	</div>
		<div id="content" class="hide">
			<form class="form-horizontal">
				<div class="control-group">
					<label class="control-label"><s>*</s>上级菜单：</label>
					<div class="controls">
						<input type="text" id="show" name="parentName" data-rules="{required:true}"/><cite> 注：如果为一级菜单，请任意输入一个值！</cite>
						<input type="hidden" id="hide" name="pid" />						
					</div>
				</div>
				<div class="control-group">
					<label class="control-label"><s>*</s>菜单名称：</label>
					<div class="controls">
						<input name="name" type="text" class="input-normal control-text" data-rules="{required:true}"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label"><s>*</s>菜单URL：</label>
					<div class="controls control-row-auto">
						<textarea name="url" class="input-large control-text  control-row2" data-rules="{required:true}"></textarea>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">描述：</label>
					<div class="controls control-row-auto">
						<textarea name="desc" type="text" class="input-large control-text  control-row2" ></textarea>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">顺序：</label>
					<div class="controls">
						<input name="seq" type="text" class="input-large control-text"  data-messages="{regexp:'不是有效的数字'}" data-rules="{regexp:/^\d+$/}"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">类型：</label>
					<div class="controls">
						<select name="type">
						<option value="1">菜单</option>
						<option value="2">权限</option>
						</select>
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
		BUI.use(['bui/tree','bui/grid', 'bui/data','bui/extensions/treepicker'], function(
				Tree,Grid, Data,TreePicker) {

			var editing = new Grid.Plugins.DialogEditing({
				contentId : 'content',//弹出框显示的内容的id
				triggerCls : 'btn-edit',//点击表格行时触发编辑的 css				
				editor : {
					title : '菜单信息管理',
					width : 600
				},
				autoSave : true
			//自动添加和更新
			});
			columns = [ {
				title : '菜单名称',
				dataIndex : 'name',
				width : '10%'
			}, {
				title : '菜单URL',
				dataIndex : 'url',
				width : '20%'
			}, {
				title : '描述',
				dataIndex : 'desc',
				width : '20%'
			}, {
				title : '图标',
				dataIndex : 'icon',
				width : '8%',
				renderer : function(value) {
					return "<i class="+value+"></i>";				
				}
			}, {
				title : '顺序',
				dataIndex : 'seq',
				width : '8%'
			}, {
				title : '类型',
				dataIndex : 'type',
				width : '8%',
				elCls :'center',
				renderer : function(value) {
					if (value == '1') {
						return "<span class='label label-success'>菜单</span>";
					} 
					else
						return "<span class='label label-info'>权限</span>";
				}
			}, {
				title : '上级菜单',
				dataIndex : 'parentName',
				width : '15%',
				renderer : function(value) {
					if (value == null) {
						return "<span class='label label-important'>根菜单</span>";
					 }
					else
						return value;
				}
			},
			{
				title : '操作',
				dataIndex : 'd',
				width:'15%',
				elCls :'center',
				renderer : function (value,obj) {				
	            	return '<button class="button button-mini button-primary btn-edit"><i class="icon icon-white icon-edit btn-edit"></i>编辑</button>';
	          }}			
			];			
			var store = new Data.Store({
				url : '${ctx}/ms/shiro/res/resList',
				autoLoad : true, //自动加载数据				
				pageSize : 10,
				proxy : {
					method : 'POST', //更改为POST
					save : {
						addUrl : '${ctx}/ms/shiro/res/save',//新增提交的URL
						removeUrl : '${ctx}/ms/shiro/res/delete',//删除提交的URL
						updateUrl : '${ctx}/ms/shiro/res/update'//编辑提交的URL
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
				width:'100%',//如果表格使用百分比，这个属性一定要设置
				innerBorder: false,
				columns : columns,				
				loadMask : true, //加载数据时显示屏蔽层
				itemStatusFields : { //设置数据跟状态的对应关系		             
		              read : 'pid' //如果pid : true,则附加 bui-grid-row-read 样式
		            },
				store : store,				
				plugins : [Grid.Plugins.RowNumber,Grid.Plugins.AutoFit,Grid.Plugins.CheckSelection,editing ],
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
					window.parent.frames[ "rightFrame"].location.reload();	
					//BUI.Message.Alert('添加成功！');
				} else if (type == 'update') {
					store.load();
					//BUI.Message.Alert('更新成功！');
					window.parent.frames[ "rightFrame"].location.reload();					
				} else {
					BUI.Message.Alert('删除成功！');
				}
			});
			//保存或者读取失败
			store.on('exception', function(ev) {
				BUI.Message.Alert(ev.error);
			});
			//菜单树选择
			var treestore = new Data.TreeStore({
				url : '${ctx}/ms/shiro/res/resTree',
				autoLoad : true
			/**/
			}),
			//由于这个树，不显示根节点，所以可以不指定根节点
			tree = new Tree.TreeList({				
				//root : {id: '0',text : '根节点',expanded:true},
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
				BUI.Message.Confirm('确认删除么？',function() {
					var ids = new Array();//批量删除的数组ID
					for (var i = 0; i < selections.length; i++) {
						ids.push(selections[i].id);
					}
					$.post("${ctx}/ms/shiro/res/deleteBatch",{ids : ids.toString()},function(data,status) {
							if (data.success) {
								store.remove(selections);//删除成功重载grid表格数据
							} else {
								BUI.Message.Alert("删除错误","error");
							}
						});
					}, 'question');
				return false;
			};
		});
	</script>
</body>

</html>
