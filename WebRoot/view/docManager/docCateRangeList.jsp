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
			<li><a href="#">归档范围参考</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<div class="formbody">
			<form id="searchForm">
				<ul class="seachform">

					<li><label>归档范围</label> <input type="text" name="name"
						value="" class="scinput" /></li>

					<li><label>&nbsp;</label><input name="btnSrearch"
						type="submit" class="button button-primary" value="查询" /></li>

				</ul>
			</form>
		</div>
	</div>
	<div id="content" class="hide">
		<div class="row">
			<form class="form-horizontal">

				<div class="control-group">
					<label class="control-label"><s>*</s>一级类目：</label>
					<div class="controls">
						<input type="text" id="f_show" name="fir_categories" data-rules="{required:true}"/> <input
							type="hidden" id="f_hide" name="fir_identity" />
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">二级类目：</label>
					<div class="controls">						
							<input type="text" id="s_show" name="sec_categories"/> <input
							type="hidden" id="s_hide" name="sec_identity" />
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">归档范围：</label>
					<div class="controls control-row-auto">
						<textarea name="range_da"
							class="input-large control-text control-row4"></textarea>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">备注：</label>
					<div class="controls">
						<input name="remark" type="text" class="input-noraml control-text" />

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
		BUI.use(['bui/extensions/treepicker', 'bui/tree','bui/grid', 'bui/data' ], function(TreePicker, Tree,Grid, Data) {

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
			var store = new Data.Store({
				url : '/ms/docCateRange/docCateRangeList',
				autoLoad : true, //自动加载数据
				pageSize : 5,
				proxy : {
					method : 'POST', //更改为POST
					save : {
						addUrl : '/ms/docCateRange/save',//新增提交的URL
						removeUrl : '/ms/docCateRange/delete',//删除提交的URL
						updateUrl : '/ms/docCateRange/update'//编辑提交的URL
					},
					ajaxOptions : {
						error : function(jqXHR, textStatus, responseText) {
							BUI.Message.Alert("网络错误，" + jqXHR.status, "error");
						}
					}
				}
			});

			var grid = new Grid.Grid({
				render : '#grid',
				width : '100%',//如果表格使用百分比，这个属性一定要设置
				columns : [ {
					title : '编号',
					dataIndex : 'id',
					width : '8%'
				}, {
					title : '一级类目',
					dataIndex : 'fir_categories',
					width : '13%'
				}, {
					title : '二级类目',
					dataIndex : 'sec_categories',
					width : '13%'
				}, {
					title : '归档范围',
					dataIndex : 'range_da',
					width : '46%'
				}, {
					title : '备注',
					dataIndex : 'remark',
					width : '10%'
				}, {
					title : '操作',
					dataIndex : 'd',
					width : '10%',
					renderer : function(value, obj) {
						return '<button class="button button-mini button-primary btn-edit"><i class="icon icon-white icon-edit btn-edit"></i>编辑</button>';
					}
				} ],
				loadMask : true, //加载数据时显示屏蔽层
				store : store,
				plugins : [Grid.Plugins.AutoFit,Grid.Plugins.CheckSelection,editing],
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
					BUI.Message.Alert('更新成功！');
				} else {
					BUI.Message.Alert('删除成功！');
				}
			});
			//保存或者读取失败
			store.on('exception', function(ev) {
				BUI.Message.Alert(ev.error);
			});
			//文档分类树
			var fstore = new Data.TreeStore({				
				url : '/ms/docCate/docCateTree',
				autoLoad : true
			/**/
			}),
			//由于这个树，不显示根节点，所以可以不指定根节点
			ftree = new Tree.TreeList({
				store : fstore,
				//dirSelectable : false,//阻止树节点选中
				showLine : true, //显示连接线
				checkType : false
			});
			var sstore = new Data.TreeStore({				
				url : '/ms/docCate/docCateTree',
				autoLoad : true
			/**/
			}),
			stree = new Tree.TreeList({
				store : sstore,
				//dirSelectable : false,//阻止树节点选中
				showLine : true, //显示连接线
				checkType : false
			});
			var fpicker = new TreePicker({
				trigger : '#f_show',
				valueField : '#f_hide', //如果需要列表返回的value，放在隐藏域，那么指定隐藏域
				width : 150, //指定宽度
				children : [ ftree ]
			//配置picker内的列表
			}).render();
			var spicker = new TreePicker({
				trigger : '#s_show',
				valueField : '#s_hide', //如果需要列表返回的value，放在隐藏域，那么指定隐藏域
				width : 150, //指定宽度
				children : [ stree ]
			//配置picker内的列表
			}).render();
			//树操作
			ftree.on('itemclick', function(ev) {
				var item = ev.item;				
				fpicker.setSelectedValue(item.text);				
			});
			stree.on('itemclick', function(ev) {
				var item = ev.item;				
				spicker.setSelectedValue(item.text);				
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
					$.post("/ms/docCateRange/deleteBatch", {
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
