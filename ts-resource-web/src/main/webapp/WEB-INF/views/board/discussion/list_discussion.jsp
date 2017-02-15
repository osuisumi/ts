<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="discussionForm" action="${ctx}/board/discussion">
	<input type="hidden" name="paramMap[relationId]" value="${searchParam.paramMap.relationId}" /> 
	<input type="hidden" name="paramMap[relationName]" value="${searchParam.paramMap.relationName}" /> 
	<input type="hidden" name="paramMap[boardImgUrl]" value="${searchParam.paramMap.boardImgUrl}" />
	<input type="hidden" name="orders" value="IS_TOP.DESC,IS_ESSENCE.DESC,REPLY_NUM.DESC,CREATE_TIME.DESC" />
	<div class="m-community-con">
		<c:choose>
			<c:when test="${not empty discussions}">
				<ul class="u-con-ul education-theory z-crt" style="min-height:680px">
					<c:forEach items="${discussions}" var="discussion" varStatus="index">
						<li class="li-odd u-zrt"><c:choose>
								<c:when test="${index.index eq 0}">
									<div class="u-fon-sec">
										<a onclick="viewBoardDiscussion('${discussion.id}')" class="u-figure">
										<c:choose>
											<c:when test="${searchParam.paramMap.boardImgUrl == ''}">
												<img src="${ctx}/images/figure-imgs1.jpg">
											</c:when>
											<c:otherwise>
												<img src="${searchParam.paramMap.boardImgUrl}">
											</c:otherwise>
										</c:choose>
										</a>
										<h3>
											<a onclick="viewBoardDiscussion('${discussion.id}')">${discussion.title}</a>
										</h3>
										<p class="u-intro-txt">${sipc:split(discussion.content,discussion.id,1)}</p>
										<p class="btm-user-intro">
											<a href="javascript:void(0);" class="u-head"> <tag:avatar userId="${discussion.creator.id }" avatar="${discussion.creator.avatar}"></tag:avatar><span>${discussion.creator.realName}</span></a> <span class="u-pbl">发表于${sipc:formatDate(discussion.createTime,'yyyy-MM-dd')}</span> <a class="u-pl" onclick="goNewstDiscussionPost('${discussion.id}','${discussion.discussionRelations[0].lastPost.targetId}')"><i></i>${discussion.discussionRelations[0].replyNum}</a>
										</p>
									</div>
								</c:when>
								<c:otherwise>
									<div class="u-fon-fir" style="display: block">
										<h3>
											<a onclick="viewBoardDiscussion('${discussion.id}')">${discussion.title}</a> <!-- <i class="u-small-ico u-hot">热</i> -->
											<c:if test="${discussion.discussionRelations[0].isTop eq 'Y' }">
												<i class="u-small-ico u-top">顶</i>
											</c:if>
											<c:if test="${discussion.discussionRelations[0].isEssence eq 'Y' }">
												<i class="u-small-ico u-nice">精</i>
											</c:if>
										</h3>
										<p class="u-con-txt">${sipc:split(discussion.content,discussion.id,1)}</p>
										<div class="u-btn-info">
											<p class="u-lt">
												<a class="u-name" href="javascript:void(0);">${discussion.creator.realName}</a> 于 ${sipc:formatDate(discussion.createTime,'yyyy-MM-dd HH:mm:ss')}&nbsp;&nbsp;发表于&nbsp;【${searchParam.paramMap.relationName}】 <a class="u-pl" onclick="goNewstDiscussionPost('${discussion.id}','${discussion.discussionRelations[0].lastPost.targetId}')"><i></i>${discussion.discussionRelations[0].replyNum}</a>
											</p>
											<c:if test="${(not empty discussion.discussionRelations[0].lastPost) && (not empty discussion.discussionRelations[0].lastPost.creator.id)}">
												<p class="u-rt">
													${sipc:prettyTime(discussion.discussionRelations[0].lastPost.createTime)}&nbsp;&nbsp;来自:${discussion.discussionRelations[0].lastPost.creator.realName}
												</p>
											</c:if>
										</div>
									</div>
								</c:otherwise>
							</c:choose></li>
					</c:forEach>
				</ul>
			</c:when>
			<c:otherwise>
				<tag:noContent msg="没有相关帖子"></tag:noContent>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="am-pageturn">
		<jsp:include page="/WEB-INF/views/include/pagination.jsp">
			<jsp:param value="discussionForm" name="pageForm" />
			<jsp:param value="discussionsPaginator" name="paginatorName" />
			<jsp:param value="discussionContent" name="divId" />
			<jsp:param value="ajax" name="type" />
		</jsp:include>
	</div>
</form>
<script>
	function goNewstDiscussionPost(id, targetId) {
		window.location.href = $('#ctx').val()+"/board/discussion/"+id+"/view?targetId="+targetId;
	}
</script>