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
			<li><a href="${ctx}/ms">首页</a></li>
			<li><a href="#">实体分类</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<div class="formbody">
			<form id="searchForm">
				<ul class="seachform">

					<li><label>名称</label> <input type="text" name="name" value=""
						class="scinput" /></li>
					<li><label>&nbsp;</label><input name="btnSrearch"
						type="submit" class="button button-primary" value="查询" /></li>

				</ul>
			</form>
		</div>
		<div id="content" class="hide">
			<form class="well form-inline">
				<div class="row">
					<div class="control-group span8">
						<label class="control-label"><s>*</s>标识：</label>
						<div class="controls">
							<input name="identity" type="text" data-rules="{required:true}"
								class="input-normal control-text" />
						</div>
					</div>
					<div class="control-group span8">
						<label class="control-label"><s>*</s>标识名称：</label>
						<div class="controls">
							<input name="name" type="text" data-rules="{required:true}"
								class="input-normal control-text" />
						</div>
					</div>
					<div class="control-group span10">
						<label class="control-label">上级标识：</label>
						<div class="controls">
							<input type="text" id="show" name="pname" /> <input
								type="hidden" id="hide" name="p_id" />
						</div>
					</div>
				</div>
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
		BUI.use([ 'bui/grid', 'bui/data', 'bui/tree',
				'bui/extensions/treepicker' ], function(Grid, Data, Tree,
				TreePicker) {

			var editing = new Grid.Plugins.DialogEditing({
				contentId : 'content',//弹出框显示的内容的id
				triggerCls : 'btn-edit',//点击表格行时触发编辑的 css				
				editor : {
					title : '信息管理',
					width : 400,
				},
				autoSave : true
			//自动添加和更新

			});
			var store = new Data.Store({
				url : '/ms/docCate/docCateList',
				autoLoad : true, //自动加载数据
				pageSize : 8, // 配置分页数目
				proxy : {
					method : 'POST', //更改为POST
					save : {
						addUrl : '/ms/docCate/save',//新增提交的URL
						removeUrl : '/ms/docCate/delete',//删除提交的URL
						updateUrl : '/ms/docCate/update'//编辑提交的URL
					},
					ajaxOptions : {
						error : function(jqXHR, textStatus, responseText) {
							BUI.Message.Alert("网络错误，" + jqXHR.status, "error");
						}
					}
				}
			}), grid = new Grid.Grid({
				render : '#grid',
				width : '100%',
				store : store,
				columns : [ {
					title : '标识名称',
					dataIndex : 'name',
					width : '30%'
				}, {
					title : '标识',
					dataIndex : 'identity',
					width : '20%'
				}, {
					title : '上级标识名称',
					dataIndex : 'pname',
					width : '20%'
				}, {
					title : '操作',
					dataIndex : 'd',
					width : '10%',
					renderer : function(value, obj) {
						return '<button class="button button-mini button-primary btn-edit"><i class="icon icon-white icon-edit btn-edit"></i>编辑</button>';
					}
				} ],
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
			//树选择框
			var treestore = new Data.TreeStore({
				/*root : {
				  id : '0',
				  text : '0',		            
				},  
				 */
				url : '/ms/docCate/docCateTree',
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
			});
			picker.render();
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
				//obj.start = 0; //返回第一页
				store.load(obj);
				return false;
			});

			function addFunction() {
				var newData = {};
				editing.add(newData); //直接弹出框编辑				
			}
			function delFunction() {
				var selections = grid.getSelection();//获取表格选择的数据行
				if (!selections || selections.length <= 0) {
					BUI.Message.Alert("请选择要删除数据项，可多选", "warning");
					return;
				}
				BUI.Message.Confirm('确认删除么？', function() {
					var ids = new Array();//批量删除的数组ID
					for (var i = 0; i < selections.length; i++) {
						ids.push(selections[i].id);
					}
					$.post("/ms/docCate/deleteBatch", {
						ids : ids.toString()
					}, function(data, status) {

						if (data.success) {
							store.remove(selections);//删除成功重载grid表格数据
						} else {
							BUI.Message.Alert("删除错误", "error");
						}
					});
				}, 'question');
				return false;
			}
			;
		});
	</script>
</body>

</html>
