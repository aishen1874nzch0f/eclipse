<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="${ctx}/styles/css/style.css" rel="stylesheet" type="text/css"/> 
<script language="JavaScript" src="${ctx}/styles/js/jquery.js"></script>
<script type="text/javascript">
$(function(){	
	//顶部导航切换
	$(".nav li a").click(function(){
		$(".nav li a.selected").removeClass("selected")
		$(this).addClass("selected");
	})	
})	
</script>

</head>

<body style="background:url(${ctx}/styles/images/topbg.gif) repeat-x;">

    <div class="topleft">
    <a href="${ctx}/ms/main" target="_parent"><img src="${ctx}/styles/images/logo.png" title="系统首页" /></a>
    </div>
        
    <ul class="nav">
    <li><a href="${ctx}/ms" target="rightFrame"><img src="${ctx}/styles/images/icon01.png" title="首页" /><h2>首页</h2></a></li>
    <!-- 
    <shiro:hasAnyRoles name="admin">
    <li><a href="javascript:void(0)" target="rightFrame"><img src="${ctx}/styles/images/icon03.png" title="工作台" /><h2>任务管理</h2></a></li>   
    <li><a href="javascript:void(0)" target="rightFrame"><img src="${ctx}/styles/images/icon02.png" title="模型管理" /><h2>模型管理</h2></a></li>
    <li><a href="javascript:void(0)"  target="rightFrame"><img src="${ctx}/styles/images/icon03.png" title="模块设计" /><h2>模块设计</h2></a></li>  
    <li><a href="javascript:void(0)"  target="rightFrame"><img src="${ctx}/styles/images/icon04.png" title="常用工具" /><h2>常用工具</h2></a></li>
    <li><a href="javascript:void(0)" target="rightFrame"><img src="${ctx}/styles/images/icon05.png" title="文件管理" /><h2>文件管理</h2></a></li>
    <li><a href="javascript:void(0)"  target="rightFrame"><img src="${ctx}/styles/images/icon06.png" title="系统设置" /><h2>系统设置</h2></a></li>       
    </shiro:hasAnyRoles>
     -->
    </ul>
            
    <div class="topright">    
    <ul>    
    <li><a href="${ctx}/ms/resetpasswd" target="rightFrame">修改密码</a></li>
    <li><a href="${ctx}/ms/doLogout" target="_parent">退出</a></li>
    </ul>
     
    <div class="user">
    <span><shiro:principal/>,你好！</span>   
    </div>    
    
    </div>   
   
</body>
</html>
