<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>欢迎登录后台管理系统</title>
<link href="${ctx}/styles/css/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="${ctx}/styles/js/jquery.js"></script>
<script src="${ctx}/styles/js/cloud.js" type="text/javascript"></script>

<script language="javascript">
	$(function(){
    $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
	$(window).resize(function(){  
    $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
    });
	
});  
	if (top.location !== self.location) { 
	    top.location=self.location; 
	} 
</script> 

</head>

<body style="background-color:#1c77ac; background-image:url(${ctx}/styles/images/light.png); background-repeat:no-repeat; background-position:center top; overflow:hidden;">


	<div id="mainBody">
      <div id="cloud1" class="cloud"></div>
      <div id="cloud2" class="cloud"></div>
     
    </div>
    
    <div class="loginbody">   
    <span class="systemlogo"></span>     
    <div class="loginbox">    
    <form action="${ctx}/dologin" method="post">
    <ul>
    <li><input name="userName" type="text" class="loginuser" placeholder="用户名" onclick="JavaScript:this.value=''"/>${usernameMsg}</li>
    <li><input name="passWord" type="password" class="loginpwd" placeholder="密码"/>${passwordMsg}</li>
    <li><input name="subBtn" type="submit" class="loginbtn" value="登录" /><label><input name="remeber" type="checkbox" value="true"/>记住密码</label></li>
    </ul>
    </form>    
    </div>
    <div style="text-align:center;color:#F00;font-size:20px;font-weight:bold">${error}</div>
    </div>
    
</body>

</html>
