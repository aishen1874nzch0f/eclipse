<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>后台管理系统</title>
</head>
<frameset rows="88,*" cols="*" frameborder=no border="no" framespacing="0">
  <frame src="${ctx}/ms/top" name="topFrame" scrolling="no"  id="topFrame"/>
  <frameset cols="187,*" frameborder="no" border="0" framespacing="0">
    <frame src="${ctx}/ms/left" name="leftFrame" scrolling="no" id="leftFrame"/>
    <frame src="${ctx}/ms/index" name="rightFrame" id="rightFrame"/>
  </frameset>
</frameset>

</html>
