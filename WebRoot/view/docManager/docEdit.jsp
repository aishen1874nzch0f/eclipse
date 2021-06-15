<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="${ctx}/styles/css/style.css" rel="stylesheet" type="text/css" />
</head>

<body>

	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="ms/mian">首页</a></li>
    <li><a href="#">文书编辑</a></li>
    </ul>
    </div>
    <form action="/ms/doc/update" method="post">
    <div class="formbody">
    
    <div class="formtitle"><span>基本信息</span></div>
    
    <ul class="forminfo">
    <li><label>编号</label><input name="docModel.id" value="${docModel.id}" type="text" class="dfinput" readonly="true"/><i>不填，系统编号</i></li>
    <li><label>档号</label><input name="docModel.doc_no" value="${docModel.doc_no}"  type="text" class="dfinput" /><i>全宗-大类-年度-保存期限-件/卷号（小流水号）</i></li>
    <li><label>文号</label><input name="docModel.ref_no" value="${docModel.ref_no}"  type="text" class="dfinput" /><i>电控委[2005]1号</i></li>
    <li><label>责任人</label><input name="docModel.author" value="${docModel.author}"  type="text" class="dfinput" /></li>
    <li><label>题名</label><input name="docModel.name" value="${docModel.name}"  type="text" class="dfinput" /></li>
    <li><label>发文日期</label><input name="docModel.dispatch_date" value="${docModel.dispatch_date}"  type="text" class="dfinput" /></li>
    <li><label>页数</label><input name="docModel.pages" value="${docModel.pages}"  type="text" class="dfinput" /></li>
    <li><label>保管期限</label><input name="docModel.retent_period" value="${docModel.retent_period}"  type="text" class="dfinput"/></li>
    <li><label>位置</label><input name="docModel.place" value="${docModel.place}"  type="text" class="dfinput"/></li>
    <li><label>归档年份</label><input name="docModel.arch_date" value="${docModel.arch_date}"  type="text" class="dfinput" /></li>
    <li><label>备注</label><input name="docModel.remark" value="${docModel.remark}"  type="text" class="dfinput" /></li>       
    <li><label>文件</label><input name="docModel.file_path" value="${docModel.file_path}"  type="file" class="dfinput" /></li>  
    <li><label>&nbsp;</label><input name="subbtn" type="submit" class="btn" value="确认保存"/>&nbsp;<input name="returnBtn" type="button" onclick="javascript:window.location='/ms/doc'" class="btn" value="返回"/></li>
    </ul>  
    </div>
	</form>    

</body>

</html>
