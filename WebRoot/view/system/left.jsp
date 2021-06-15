﻿<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="${ctx}/styles/css/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="${ctx}/styles/js/jquery.js"></script>

<script type="text/javascript">
$(function(){	
	//导航切换
	$(".menuson li").click(function(){
		$(".menuson li.active").removeClass("active")
		$(this).addClass("active");
	});
	
	$('.title').click(function(){
		var $ul = $(this).next('ul');
		$('dd').find('ul').slideUp();
		if($ul.is(':visible')){
			$(this).next('ul').slideUp();
		}else{
			$(this).next('ul').slideDown();
		}
	});
})	
</script>


</head>

<body style="background:#f0f9fd;">
	<div class="lefttop"><span></span>导航菜单</div>
    
    <dl class="leftmenu">
     <!-- 
    <dd>
    <div class="title">
    <span><img src="${ctx}/styles/images/leftico01.png" /></span>管理信息
    </div>
    	<ul class="menuson">
        <li><cite></cite><a href="/ms" target="rightFrame">首页</a><i></i></li>
         <li><cite></cite><a href="/ms/doc" target="rightFrame">文书管理</a><i></i></li>
        <li class="active"><cite></cite><a href="/ms/com/right" target="rightFrame">数据列表</a><i></i></li>
        <li><cite></cite><a href="/ms/com/imgtable" target="rightFrame">图片数据表</a><i></i></li>
        <li><cite></cite><a href="/ms/com/form" target="rightFrame">添加编辑</a><i></i></li>
        <li><cite></cite><a href="/ms/com/imglist" target="rightFrame">图片列表</a><i></i></li>
        <li><cite></cite><a href="/ms/com/imglist1" target="rightFrame">自定义</a><i></i></li>
        <li><cite></cite><a href="/ms/com/tools" target="rightFrame">常用工具</a><i></i></li>
        <li><cite></cite><a href="/ms/com/filelist" target="rightFrame">信息管理</a><i></i></li>
        <li><cite></cite><a href="/ms/com/tab" target="rightFrame">Tab页</a><i></i></li>
        <li><cite></cite><a href="/ms/com/error" target="rightFrame">404页面</a><i></i></li>
        </ul>    
    </dd>
        
    
    <dd>
    <div class="title">
    <span><img src="${ctx}/styles/images/leftico02.png" /></span>其他设置
    </div>
    <ul class="menuson">
        <li><cite></cite><a href="#">编辑内容</a><i></i></li>
        <li><cite></cite><a href="#">发布信息</a><i></i></li>
        <li><cite></cite><a href="#">档案列表显示</a><i></i></li>
        </ul>     
    </dd> 
    
    
    <dd><div class="title"><span><img src="${ctx}/styles/images/leftico03.png" /></span>编辑器</div>
    <ul class="menuson">
        <li><cite></cite><a href="#">自定义</a><i></i></li>
        <li><cite></cite><a href="#">常用资料</a><i></i></li>
        <li><cite></cite><a href="#">信息列表</a><i></i></li>
        <li><cite></cite><a href="#">其他</a><i></i></li>
    </ul>    
    </dd>  
    
    
    <dd><div class="title"><span><img src="${ctx}/styles/images/leftico04.png" /></span>日期管理</div>
    <ul class="menuson">
        <li><cite></cite><a href="#">自定义</a><i></i></li>
        <li><cite></cite><a href="#">常用资料</a><i></i></li>
        <li><cite></cite><a href="#">信息列表</a><i></i></li>
        <li><cite></cite><a href="#">其他</a><i></i></li>
    </ul>
    
    </dd>   
     -->   
     <frame:menu></frame:menu>
    </dl>
    
</body>
</html>
