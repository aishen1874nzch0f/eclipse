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
    <li><a href="/ms/main">首页</a></li>
    <li><a href="#">用户信息</a></li>
    </ul>
    </div>
    <form action="${ctx}/ms/shiro/user/update" method="post">
    <div class="formbody">
    
    <div class="formtitle"><span>基本信息</span></div>
    
    <ul class="forminfo">
    <li><label>编号</label><input name="userInfo.id" value="${userInfo.id}" type="hidden" /><i></i></li>
    <li><label>全称</label><input name="userInfo.fullname" value="${userInfo.fullname}"  type="text" class="dfinput" readonly="readonly" /><i></i></li>
    <li><label>账号</label><input name="userInfo.username" value="${userInfo.username}"  type="text" class="dfinput" readonly="readonly" /><i></i></li>
    <li><label>头像</label><input name="userInfo.icon" value="${userInfo.author}"  type="text"  class="dfinput" readonly="readonly" /></li> 
    <li><label>邮箱</label><input name="userInfo.email" value="${userInfo.email}"  type="text" class="dfinput" readonly="readonly" /></li>   
    <li><label>创建时间</label><input name="userInfo.create_date" value="${userInfo.create_date}"  type="text" class="dfinput" readonly="readonly"/></li>
    <li><label>账号状态</label><input name="userInfo.account_status" value="${userInfo.account_status}"  type="text" class="dfinput" readonly="readonly"/></li>       
    <li><label>部门</label><input name="userInfo.orgName" value="${userInfo.orgName}"  type="text" class="dfinput" readonly="readonly"/></li>  
    <li><label>&nbsp;</label><input name="returnBtn" type="button" onclick="javascript:window.location='/ms'" class="btn" value="返回"/></li>
    </ul>  
    </div>
	</form>    

</body>

</html>
