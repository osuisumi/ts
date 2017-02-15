<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="m-sd-tt new-tit">
	<h2 class="tt">活动公告</h2>
	<a onclick="listMoreAnnouncement('${searchParam.paramMap.relationId }')" class="more">更多&gt;</a>
</div>
<c:choose>
	<c:when test="${not empty announcements}">
		<div class="g-inside-dt">
			<ul class="m-news-lst m-txt-lst">
				<c:forEach items="${announcements}" var="announcement">
					<li>
						<a onclick="viewAnnouncement('${announcement.id}')">${announcement.title}</a> 
							<c:if test="${not empty sessionScope.loginer }">
								<c:if test="${empty announcement.announcementUser.id}">
										<i class="u-new-ico"></i>
								</c:if>
							</c:if>
						<span class="time">${sipc:formatDate(announcement.createTime,'yyyy-MM-dd')}</span>
					</li>
				</c:forEach>
			</ul>
		</div>
	</c:when>
	<c:otherwise>
		<tag:noContent msg="暂无活动公告"></tag:noContent>
	</c:otherwise>
</c:choose>




