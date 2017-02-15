<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="listCompetitionForm" action="${ctx}/competition/list/more">
	<input type="hidden" name="paramMap[timeState]" value="${searchParam.paramMap.timeState}">
	<input type="hidden" name="orders" value="${orders}">
	<input type="hidden" name="limit" value="${limit }">
	<c:choose>
		<c:when test="${not empty competitions }">
				<ul class="m-figure-lst1">
				<c:forEach items="${competitions}" var="competition">
					<li class="m-figure-block1">
						<c:choose>
							<c:when test="${not empty competition.imageUrl }">
								<a onclick="viewCompetition('${competition.id}')" class="figure">
								<img src="${file:getFileUrl(competition.imageUrl) }" alt="">
								</a>
							</c:when>
						</c:choose>
						<h4 class="tt">
							<a onclick="viewCompetition('${competition.id}')">${competition.title}</a>
						</h4>
						<p>
							<span>参赛对象：${competition.faceGroup }</span>
						</p>
						<p>
							<span>主&nbsp;&nbsp;办&nbsp;方： ${competition.mainOrganization }</span>
						</p>
						<p>
							<span>活动时间：<fmt:formatDate value="${competition.competitionTimePeriod.startTime }" type="date" pattern="yyyy-MM-dd" />至<fmt:formatDate value="${competition.competitionTimePeriod.endTime }" type="date" pattern="yyyy-MM-dd" /></span>
						</p> <c:choose>
							<c:when test="${!sipc:hasBegun(competition.competitionTimePeriod.startTime) }">
								<span class="u-act-type type2"> <i class="trg"></i> 即将开始
								</span>
							</c:when>
							<c:when test="${sipc:hasEnded(competition.competitionTimePeriod.endTime) }">
								<span class="u-act-type type3"> <i class="trg"></i> 已结束
								</span>
							</c:when>
							<c:otherwise>
								<span class="u-act-type type1"> <i class="trg"></i> 正在进行
								</span>
							</c:otherwise>
						</c:choose></li>
				</c:forEach>
			</ul>
			<div class="am-pageturn">
				<jsp:include page="/WEB-INF/views/include/pagination.jsp">
					<jsp:param value="listCompetitionForm" name="pageForm" />
					<jsp:param value="competitionsPaginator" name="paginatorName" />
					<jsp:param value="listCompetitionDiv" name="divId" />
					<jsp:param value="ajax" name="type" />
				</jsp:include>
			</div>
		</c:when>
		<c:otherwise>
			<tag:noContent msg="暂无活动"></tag:noContent>
		</c:otherwise>
	</c:choose>
</form>
<script>
	$(function() {
		changeTab('competition');
	})

</script>