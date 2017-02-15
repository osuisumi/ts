<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="g-sd-mod" style="height: 165px">
	<div class="m-notice-box">
		<div class="m-sd-tt">
			<h3 class="tt">通知公告</h3>
			<a onclick="announcementIndex()" class="more">更多&gt;</a>
		</div>
		<c:choose>
			<c:when test="${not empty announcements}">
				<ul class="m-news-lst small">
					<c:forEach items="${announcements}" var="announcement">
						<li><a onclick="viewAnnouncement('${announcement.id}')">${announcement.title}</a></li>
					</c:forEach>
				</ul>
			</c:when>
			<c:otherwise>
				<tag:noContent msg="暂无通知公告"></tag:noContent>
			</c:otherwise>
		</c:choose>
	</div>
</div>