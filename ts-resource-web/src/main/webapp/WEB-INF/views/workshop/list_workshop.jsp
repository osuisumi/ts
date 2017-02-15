<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<ul class="m-figure-lst2">
<c:forEach items="${workshops}" var="workshop">
	<li>
		<div class="m-figure-block2">
			<a onclick="viewWorkshop('${workshop.id}')" class="head-box">
			<c:choose>
				<c:when test="${not empty workshop.imageUrl }">
					<img class="u-head-img" src="${file:getFileUrl(workshop.imageUrl) }">
				</c:when>
				<c:otherwise>
					<img class="u-head-img" src="${ctx }/images/defaultWorkshopImg.png">
				</c:otherwise>
			</c:choose>
			</a>	
			<h4 class="u-tit">
				<a onclick="viewWorkshop('${workshop.id}')">${workshop.name }</a>
			</h4>
			<p class="u-info">坊主：
				<c:forEach items="${workshop.masters }" var="master">
					${master.realName}&nbsp;
				</c:forEach>
			</p>
			<p class="u-info">研修活动${workshop.workshopRelations[0].activityNum }个，资源${workshop.workshopRelations[0].resourceNum }个</p>
		</div>
	</li>
</c:forEach>
</ul>