<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/common/meta.jsp"%>
</head>
<body>

  <div class="demo-content">
  <style type="text/css">
    /**内容超出 出现滚动条 **/
    .bui-stdmod-body{
      overflow-x : hidden;
      overflow-y : auto;
    }
  </style>
    <div>
      <button id="btnShow" class="button button-primary">显示</button>
    </div>
    	<div id="tree"></div>
    </div>
    <script type="text/javascript">
    BUI.use(['bui/overlay','bui/grid','bui/data','bui/tree'],function(Overlay,Grid,Data,Tree){
    	
    	var treestore = new Data.TreeStore({
			url : '/ms/shiro/res/resTree',
			autoLoad : true
		}), tree = new Tree.TreeList({
			//render : '#tree',									
			store : treestore,
			showLine : true,			
			checkType : 'all'
			
		})
		tree.on('selectedchange', function(ev) {
			var node = ev.item;								
			if (node.leaf) { //只有点击叶子节点才能加载Grid
				//加载对应的数据，同时将分页回复到第一页
				alert(node.id)
											
			}
		});

			//创建表单，表单中的日历，不需要单独初始化
			
		    var dialog = new Overlay.Dialog({
		          title:'选择资源',
		          width:500,
		          height:320,
		          align: {
		            //node : '#t1',//对齐的节点
		            points: ['tl','tl'], //对齐参考：http://dxq613.github.io/#positon
		            offset: [10,10] //偏移
		          },
		          children : [tree],
		          childContainer : '.bui-stdmod-body',
		          success:function () {
		        	  var selections = grid.getSelection();//获取表格选择的数据行
						if (!selections || selections.length <= 0) {
							//BUI.Message.Alert("请选择要删除数据项，可多选","warning");
							return;
						}
						else
							alert(selections[0].id);
		            this.close();
		          }
		        });
		      $('#btnShow').on('click',function () {
		        dialog.show();
		      });
    });
  </script>
</body>
</html>