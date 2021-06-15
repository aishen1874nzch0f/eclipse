<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript">
	BUI.use('common/page');
</script>
</head>

<body>

	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="/ms">首页</a></li>
			<li><a href="#">档号标识</a></li>
		</ul>
	</div>
	<div id="content" class="hide">
		<form class="well form-inline">
			<div class="row">
				  <div class="control-group span10">
					<label class="control-label"><s>*</s>分类标识：</label>
					<div class="controls">
						<input type="text" id="show" name="name" data-rules="{required:true}"/> <input
							type="hidden" id="hide" name="cate_identity" />
					</div>
				</div>
				<div class="control-group span8">
					<label class="control-label"><s>*</s>序号：</label>
					<div class="controls">
						<input name="seq" type="text" data-rules="{required:true,number:true}"
							class="input-normal control-text" />
					</div>
				</div>
				<div class="control-group span10">
					<label class="control-label">分类号：</label>
					<div class="controls">
						<select name="item" class="input-normal">							
							<option value="CZ">全宗号</option>
							<option value="DL">大类号</option>
							<option value="GD">归档年度</option>
							<option value="QX">保存期限</option>
							<option value="LX">流水号</option>
						</select>
					</div>
				</div>
				<div class="control-group span10">
					<label class="control-label">长度：</label>
					<div class="controls">
						<select name="length" class="input-normal">							
							<option value="4">4</option>
							<option value="8">8</option>
							<option value="12">12</option>
						</select>
					</div>
				</div>
				<div class="control-group span10">
					<label class="control-label">分隔符：</label>
					<div class="controls">
						<select name="split" class="input-normal">							
							<option value="-">-</option>
							<option value="*">*</option>
							<option value="@">@</option>
							<option value="#">#</option>
						</select>
					</div>
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
		BUI.use([ 'bui/extensions/treepicker', 'bui/tree', 'bui/grid',
				'bui/data' ], function(TreePicker, Tree, Grid, Data) {

			var columns = [ {
				title : '档号组成项',
				dataIndex : 'item',
				width : '20%'
			}, {
				title : '长度',
				dataIndex : 'length',
				width : '10%'
			}, {
				title : '分隔符',
				dataIndex : 'split',
				width : '10%'
			}, {
				title : '所属实体分类名称',
				dataIndex : 'name',
				width : '16%'
			},{
				title : '顺序',
				dataIndex : 'seq',
				width : '8%'
			}, {
				title : '操作',
				dataIndex : 'd',
				width : '12%',
				renderer : function(value, obj) {
					return '<button class="button button-mini button-primary btn-edit"><i class="icon icon-white icon-edit btn-edit"></i>编辑</button>';
				}
			} ],

			store = new Data.Store({
				url : '/ms/docNo/docNoList',
				autoLoad : true, //自动加载数据
				//params : { //配置初始请求的参数
				//  a : 'a1',
				// b : 'b1'
				//},
				sortInfo : { //需要设置排序字段和排序方向
					field : 'cate_identity',
					direction : 'ASC'
				},
				pageSize : 5, // 配置分页数目
				proxy : {
					method : 'POST', //更改为POST
					save : {
						addUrl : '/ms/docNo/save',//新增提交的URL
						//removeUrl: '/admin/hscode/ajaxdeletehscode',//删除提交的URL
						updateUrl : '/ms/docNo/update'//编辑提交的URL
					},
					ajaxOptions : {
						error : function(jqXHR, textStatus, responseText) {
							BUI.Message.Alert("网络错误，" + jqXHR.status, "error");
						}
					}
				}

			});

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
			var editing = new Grid.Plugins.DialogEditing({
				contentId : 'content',//弹出框显示的内容的id
				triggerCls : 'btn-edit',//点击表格行时触发编辑的 css				
				editor : {
					title : '信息管理',
					width : 500,
				},
				autoSave : true
			//自动添加和更新

			});
			grid = new Grid.Grid({
				render : '#grid',
				width : '100%',//如果表格使用百分比，这个属性一定要设置
				columns : columns,
				loadMask : true, //加载数据时显示屏蔽层
				store : store,
				plugins : [Grid.Plugins.RowNumber, Grid.Plugins.AutoFit,Grid.Plugins.CheckSelection, editing],				
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
			});

			grid.render();
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
					store.update();
					BUI.Message.Alert('更新成功！');
				} else {
					//BUI.Message.Alert('删除成功！');
				}
			});
			//保存或者读取失败
			store.on('exception', function(ev) {
				BUI.Message.Alert(ev.error);
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
					$.post("/ms/docNo/deleteBatch", {
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