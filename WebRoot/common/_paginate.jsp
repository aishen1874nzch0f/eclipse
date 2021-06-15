<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%
// 如下参数需要在 include 该页面的地方被赋值才能使用，以下是示例
/*  
	<c:set var="currentPage" value="${blogPage.pageNumber}" />
	<c:set var="totalPage" value="${blogPage.totalPage}" />
	<c:set var="actionUrl" value="/blog/" />
	<c:set var="urlParas" value="" />
*/
%>

<c:if test="${urlParas == null}">
	<c:set var="urlParas" value="" />
</c:if>
<c:if test="${(totalPage > 0) && (currentPage <= totalPage)}">
	<c:set var="startPage" value="${currentPage - 4}" />
	<c:if test="${startPage < 1}" >
		<c:set var="startPage" value="1" />
	</c:if>
	<c:set var="endPage" value="${currentPage + 4}" />
	<c:if test="${endPage > totalPage}" >
		<c:set var="endPage" value="totalPage" />
	</c:if>
	
	<div class="pagin">
	<div class="message">共<i class="blue">${totalRow}&nbsp;</i>条记录，当前显示第&nbsp;<i class="blue">${currentPage}&nbsp;</i>页</div>
		<c:if test="${currentPage <= 8}">
			<c:set var="startPage" value="1" />
		</c:if>
		
		<c:if test="${(totalPage - currentPage) < 8}">
			<c:set var="endPage" value="${totalPage}" />
		</c:if>
		<ul class="paginList">
		<c:choose>
			<c:when test="${currentPage == 1}">			
       			<li class="paginItem"><a href="javascript:;"><span class="pagepre"></span></a></li>				
			</c:when>
			<c:otherwise>
				<li class="paginItem"><a href="${actionUrl}${currentPage - 1}${urlParas}"><span class="pagepre"></span></a></li>
			</c:otherwise>
		</c:choose>
		
		<c:if test="${currentPage > 8}">
			<li class="paginItem"><a href="${actionUrl}${1}${urlParas}">${1}</a></li>
			<li class="paginItem"><a href="${actionUrl}${2}${urlParas}">${2}</a></li>
			<li class="paginItem more"><a href="javascript:;">…</a></li>
		</c:if>
		
		<c:forEach begin="${startPage}" end="${endPage}" var="i">
			<c:choose>
				<c:when test="${currentPage == i}">
					 <li class="paginItem"><a href="javascript:;">${i}</a></li>
				</c:when>
				<c:otherwise>
					 <li class="paginItem"><a href="${actionUrl}${i}${urlParas}">${i}</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:if test="${(totalPage - currentPage) >= 8}">
			 <li class="paginItem more"><a href="javascript:;">…</a></li>
			 <li class="paginItem"><a href="${actionUrl}${totalPage - 1}${urlParas}">${totalPage - 1}</a></li>
			 <li class="paginItem"><a href="${actionUrl}${totalPage}${urlParas}">${totalPage}</a></li>
		</c:if>
		
		<c:choose>
			<c:when test="${currentPage == totalPage}">				
				 <li class="paginItem"><a href="javascript:;"><span class="pagenxt"></span></a></li>
			</c:when>
			<c:otherwise>
				 <li class="paginItem"><a href="${actionUrl}${currentPage + 1}${urlParas}" ><span class="pagenxt"></span></a></li>
			</c:otherwise>
		</c:choose>
		</ul>
	</div>
</c:if>
