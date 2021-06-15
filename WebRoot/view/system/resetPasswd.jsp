<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="${ctx}/styles/css/style.css" rel="stylesheet" type="text/css" />
</head>

<body>

	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="${ctx}/ms/main">首页</a></li>
    <li><a href="#">修改密码</a></li>
    </ul>
    </div>
    <form action="${ctx}/updatePassowrd">
    <div class="formbody">
    
    <div class="formtitle"><span>密码信息</span></div>
    
    <ul class="forminfo">
    <li><label>&nbsp;</label><font color="red">${error}</font></li>
    <li><label>新密码</label><input name="npassWord"  type="password" value=""  class="loginpwd" onclick="JavaScript:this.value=''"/><i>输入新密码</i></li>
    <li><label>确认新密码</label><input name="rpassWord" type="password" value="" class="loginpwd"  onclick="JavaScript:this.value=''"/><i>再次输入密码</i></li>   
    <li><label>&nbsp;</label><input name="subbtn" type="submit" class="btn" value="确认修改"/>&nbsp;<input name="returnBtn" type="button" onclick="javascript:window.location='${ctx}/ms'" class="btn" value="返回"/></li>
 	</ul>   
    </div>
	</form> 
</body>

</html>
