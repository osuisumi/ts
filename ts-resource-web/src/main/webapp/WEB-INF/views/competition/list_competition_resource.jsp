<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="listCompetitionResourceForm" action="${ctx}/competition/resource">
<input type="hidden" name="paramMap[relationId]" value="${searchParam.paramMap.relationId }">
<input type="hidden" name="orders" value="${orders}">
<input type="hidden" name="limit" value="${limit }">
	<ul id="moreCompetitionFile" class="m-arr-lst m-res-lst work-show z-crt">
		<c:forEach items="${resources }" var="resource">
			<li class="m-arr-block"><i class="type-ico"></i>
				<h4 class="tt">
					<a onclick="viewResource('${resource.id}')">${resource.title }</a>
				</h4>
				<p>
					${resource.creator.realName }&nbsp;&nbsp;上传于&nbsp;&nbsp;${sipc:formatDate(resource.createTime ,'yyyy-MM-dd HH:mm') }<i class="u-line">|</i>
					<span>类型：${dict:getEntryName('RESOURCE_SYNC_TYPE', resource.resourceExtend.type) }</span><i class="u-line">|</i>
					<span>下载量：${resource.resourceRelations[0].downloadNum }</span><i class="u-line">|</i>
					<span>浏览量：${resource.resourceRelations[0].browseNum }</span>
				</p>
				<div class="u-vote attitude_num">
					<p class="u-num">得票数：<span class="sup_num">${resource.resourceRelations[0].voteNum }</span></p>
					<c:choose>
						<c:when test="${resource.isVote eq 'Y'}">
							<p class="u-yt z-crt">已投票</p>
						</c:when>
						<c:otherwise>
							<a class="u-tp z-crt" onclick="vote('${resource.id}','${resource.resourceRelations[0].relation.id}',this)">投一票</a>
						</c:otherwise>
					</c:choose>
				</div>
			</li>
		</c:forEach>
	</ul>
	<div class="am-pageturn">
		<jsp:include page="/WEB-INF/views/include/pagination.jsp">
			<jsp:param value="listCompetitionResourceForm" name="pageForm" />
			<jsp:param value="resourcesPaginator" name="paginatorName" />
			<jsp:param value="listCompetitionResourceDiv" name="divId" />
			<jsp:param value="ajax" name="type" />
		</jsp:include>
	</div>
</form>
<script>
	$(function(){
		changeFileType($('#moreCompetitionFile'),'li',' ','li',0,'a',0);
	})
	
</script>