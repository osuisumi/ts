<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="g-mn-mod" style="padding-bottom: 20px;">
	<div class="m-mn-tt tea">
		<span class="lb"></span>
		<h2 class="tt small-size">发表的讨论</h2>
	</div>
	<form id="listDiscussionForm" action="${ctx}/zone/personal/discussion">
	<input type="hidden" name="limit" value="${limit }">
	<input type="hidden" name="orders" value="${orders }">
	<input type="hidden" name="paramMap[creator]" value="${searchParam.paramMap.creator }">
	<input type="hidden" name="paramMap[relationType]" value="${searchParam.paramMap.relationType }">
	<div class="m-mn-dt">
		<ul class="u-con-ul education-theory z-crt">
		<c:choose>
			<c:when test="${not empty discussions}">
				<c:forEach items="${discussions }" var="discussion" >
					<li>
						<div class="u-fon-fir">
							<h3>
								<a onclick="viewBoardDiscussion('${discussion.id}')">${discussion.title}</a>
							</h3>
							<p class="u-con-txt">${sipc:split(discussion.content,discussion.id,1)}</p>
							<div class="u-btn-info">
								<p class="u-lt">
									<a class="u-name" href="javascript:void(0);">${discussion.creator.realName}</a> 于 ${sipc:formatDate(discussion.createTime,'yyyy-MM-dd HH:mm:ss')}&nbsp;&nbsp;12:05:44&nbsp;&nbsp;发表于&nbsp;【${discussion.discussionRelations[0].relation.type}】  <a class="u-pl" href="javascript:void(0);"><i></i>${discussion.discussionRelations[0].replyNum}</a>
								</p>
								<c:if test="${not empty discussion.discussionRelations[0].lastPost }">
									<p class="u-rt">
										${sipc:prettyTime(discussion.discussionRelations[0].lastPost.createTime)}
										&nbsp;&nbsp;
										来自：${discussion.discussionRelations[0].lastPost.creator.realName}
									</p>
								</c:if>
							</div>
						</div>
					</li>
				</c:forEach>
			</c:when>
		</c:choose>
		</ul>
		<div class="am-pageturn">
			<jsp:include page="/WEB-INF/views/include/pagination.jsp">
				<jsp:param value="listDiscussionForm" name="pageForm" />
				<jsp:param value="discussionsPaginator" name="paginatorName" />
				<jsp:param value="personalContent" name="divId" />
				<jsp:param value="ajax" name="type" />
			</jsp:include>
		</div>
	</div>
	</form>
</div>