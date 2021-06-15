<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>无标题文档</title>
<%@ include file="/common/meta.jsp"%>
</head>

<body>

	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="${ctx}/ms">首页</a></li>
			<li><a href="#">文书列表</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<form id="searchForm">
			<ul class="seachform">

				<li><label>题名</label> <input type="text" name="name" />
				</li>
				<li><label>归档年份</label> <select name="arch_date">
						<option value="">请选择</option>
						<c:forEach items="${years}" var="year">
							<option value="${year.arch_date}">${year.arch_date}</option>
						</c:forEach>
				</select></li>

				<li><label>责任人</label> <select name="author">
						<option value="">请选择</option>
						<c:forEach items="${authors}" var="author">
							<option value="${author.author}">${author.author}</option>
						</c:forEach>
				</select></li>
				<li><label>&nbsp;</label> <input id="btnSearch" type="submit"
					class="button button-primary" value="查询" /></li>

			</ul>
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
						[ 'bui/grid', 'bui/data' ],
						function(Grid, Data) {

							var gridstore = new Data.Store({
								url : '/ms/doc/docList',
								autoLoad : true, //自动加载数据
								//params : { //配置初始请求的参数
								//  a : 'a1',
								// b : 'b1'
								//},
								pageSize : 8
							// 配置分页数目
							}), grid = new Grid.Grid(
									{
										render : '#grid',
										width : '100%',//如果表格使用百分比，这个属性一定要设置
										columns : [{
													title : '档号',
													dataIndex : 'doc_no',
													width : '10%'
												},
												{
													title : '文号',
													dataIndex : 'ref_no',
													width : '15%'
												},
												{
													title : '责任人',
													dataIndex : 'author',
													width : '8%'
												},
												{
													title : '题名',
													dataIndex : 'name',
													width : '25%'
												},
												{
													title : '发文日期',
													dataIndex : 'dispatch_date',
													width : '12%'
												},
												{
													title : '页数',
													dataIndex : 'pages',
													width : '6%'
												},
												{
													title : '归档年份',
													dataIndex : 'arch_date',
													width : '10%'
												},
												{
													title : '操作',
													dataIndex : 'd',
													width : '14%',
													renderer : function(value,
															obj) {
														return '<button class="button button-mini button-primary btn-edit"><i class="icon icon-white icon-edit btn-edit"></i>编辑</button>&nbsp;&nbsp;<button class="button button-mini button-warning btn-delete"><i class="icon icon-white icon-remove btn-delete"></i>删除</button>';
													}
												} ],
										loadMask : true, //加载数据时显示屏蔽层
										store : gridstore,
										plugins : [ Grid.Plugins.AutoFit,
												Grid.Plugins.CheckSelection ],
										//plugins : [Grid.Plugins.ColumnResize],
										// 底部工具栏
										bbar : {
											// pagingBar:表明包含分页栏
											pagingBar : true
										},
										tbar : {
											items : [
													{
														btnCls : 'button button-primary',
														text : "<i class='icon-plus icon-white'></i>添加",
														listeners : {
															'click' : addFunction
														}
													},
													{
														btnCls : 'button button-warning',
														text : "<i class='icon-remove icon-white'></i>删除",
														listeners : {
															'click' : delFunction
														}
													} ]
										}

									}).render();
							grid.on('cellclick',function(ev) {
								var record = ev.record, //点击行的记录
								field = ev.field, //点击对应列的dataIndex
								target = $(ev.domTarget); //点击的元素
								if (target.hasClass('btn-edit')) {

									window.location.href = "/ms/doc/edit/"
											+ record['id'];
								}

								if (target.hasClass('btn-delete')) {
									BUI.Message.Confirm('确认删除么？',function() {

										$.post("/ms/doc/delete/"+ record['id'],
												function(data,status) {
												if (data.success) {
													gridstore.load();//删除成功重载grid表格数据
												} else {
													BUI.Message.Alert("删除错误","error");
												}
											});
									},
									'question');
								}

							});

							var form = new BUI.Form.HForm({
								srcNode : '#searchForm'
							}).render();

							form.on('beforesubmit', function(ev) {
								//序列化成对象
								var obj = form.serializeToObject();
								obj.start = 0; //返回第一页
								gridstore.load(obj);
								return false;
							});

							function addFunction() {
								window.location.href = "/ms/doc/add/";
							}
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
										$.post("/ms/doc/deleteBatch",{ids : ids.toString()
														},
												function(data,status) {

													if (data.success) {
														gridstore.remove(selections);//删除成功重载grid表格数据
													} else {
														BUI.Message.Alert("删除错误","error");
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