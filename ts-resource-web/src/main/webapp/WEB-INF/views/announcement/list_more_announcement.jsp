<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<tag:mainLayout>
<form id="listAnnouncementForm" action="${ctx}/announcement/more">
<input type="hidden" name="paramMap[relationId]" value="${searchParam.paramMap.relationId }">
<input type="hidden" name="orders" value="${orders }">
<input type="hidden" name="paramMap[state]" value="${searchParam.paramMap.state }">
<input type="hidden" name="limit" value="${limit}">
<div class="f-auto">
	<div class="g-mn-mod">
		<div class="m-mn-tt">
			<h2 class="tt" id="h2Title">通知公告</h2>
		</div>
		<div class="g-inside-dt">
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
					<jsp:param value="listAnnouncementForm" name="pageForm" />
					<jsp:param value="announcementsPaginator" name="paginatorName" />
					<jsp:param value="post" name="type" />
				</jsp:include>
			</div>
		</div>
	</div>
</div>
</form>
</tag:mainLayout>
