<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="g-mn-mod">
	<div class="m-cloud-box">
		<div class="m-mn-tt">
			<h3 class="tt small">我的讨论</h3>
			<a href="../community/index.html" class="more" style="float: right;">查看全部讨论&gt;&gt;</a>
		</div>
		<div class="m-mn-dt">
			<ul class="u-con-ul education-theory z-crt">
				<c:choose>
					<c:when test="${not empty myDiscussions}">
						<c:forEach items="${myDiscussions }" var="discussion">
							<li>
								<div class="u-fon-fir">
									<h3>
										<a onclick="viewBoardDiscussion('${discussion.id}')">${discussion.title}</a>
									</h3>
									<p class="u-con-txt">${sipc:split(discussion.content,discussion.id,1)}</p>
									<div class="u-btn-info">
										<p class="u-lt">
											<a class="u-name" href="javascript:void(0);">${discussion.creator.realName}</a> 于 ${sipc:formatDate(discussion.createTime,'yyyy-MM-dd HH:mm:ss')}&nbsp;&nbsp;12:05:44&nbsp;&nbsp;发表于&nbsp;【${discussion.discussionRelations[0].relation.type}】 <a class="u-pl" href="javascript:void(0);"><i></i>${discussion.discussionRelations[0].replyNum}</a>
										</p>
										<c:if test="${not empty discussion.discussionRelations[0].lastPost }">
										<p class="u-rt">${sipc:prettyTime(discussion.discussionRelations[0].lastPost.createTime)}&nbsp;&nbsp;来自：${discussion.discussionRelations[0].lastPost.creator.realName}</p>
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
					<jsp:param value="myDiscussionsPaginator" name="paginatorName" />
					<jsp:param value="zoneContend" name="divId" />
					<jsp:param value="ajax" name="type" />
				</jsp:include>
			</div>
		</div>
	</div>
</div>

