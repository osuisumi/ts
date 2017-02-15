<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="g-mn-mod">
	<div class="m-mn-tt">
		<h2 class="tt" id="h2Title">教育快讯</h2>
	</div>
	<div class="g-inside-dt">
	<c:choose>
		<c:when test="${not empty  announcements}">
			<ul class="m-txt-lst" style="min-height: 600px;">
				<c:forEach items="${announcements}" var="announcement">
					<li>
						<a onclick="viewAnnouncement('${announcement.id}')">${announcement.title }</a> 
						<c:if test="${not empty sessionScope.loginer }">
							<c:if test="${empty announcement.announcementUser.id}">
								<i class="u-new-ico"></i>
							</c:if>
						</c:if> 
						<span class="time">${sipc:formatDate(announcement.createTime,'yyyy-MM-dd')}</span>
					</li>
				</c:forEach>
			</ul>
			<div class="am-pageturn">
				<jsp:include page="/WEB-INF/views/include/pagination.jsp">
					<jsp:param value="announcementForm" name="pageForm" />
					<jsp:param value="announcementsPaginator" name="paginatorName" />
					<jsp:param value="listMoreAnnouncementDiv" name="divId" />
					<jsp:param value="ajax" name="type" />
				</jsp:include>
			</div>
		</c:when>
		<c:otherwise>
			<tag:noContent msg="暂无内容"></tag:noContent>
		</c:otherwise>
	</c:choose>
	</div>
</div>
<script>
	var type = $('#typeParam').val();
	var title = $('#announcementTitle').val();
	if(type == '1'){
		$('#h2Title').text("通知公告");
	}else{
		$('#h2Title').text("教育快讯");
	}
</script>