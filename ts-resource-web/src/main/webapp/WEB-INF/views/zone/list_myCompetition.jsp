<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:choose>
	<c:when test="${not empty myCompetitions}">
		<div  class="m-mn-dt2">
			<form id="listMyCompetitionForm" action="${ctx}/zone/myCompetition/list">
				<input type="hidden" name="orders" value="${orders }"> 
				<input type="hidden" name="limit" value="${limit }"> 
				<input type="hidden" name="paramMap[creator]" value="${sessionScope.loginer.id}">
				<ul class="m-figure-lst1">
					<c:forEach items="${myCompetitions }" var="myCompetition">
						<li class="m-figure-block1 activity"><a onclick="viewCompetition('${myCompetition.id}')" class="figure">
						<img src="${file:getFileUrl(myCompetition.imageUrl) }" alt="">
						</a>
							<h4 class="tt">
								<a onclick="viewCompetition('${myCompetition.id}')">${myCompetition.title }</a>
							</h4>
							<p>
								<span>主&nbsp;&nbsp;办&nbsp;方：${myCompetition.mainOrganization }</span>
							</p>
							<p>
								<span>活动时间：<fmt:formatDate value="${myCompetition.competitionTimePeriod.startTime }" pattern="yyyy-MM-dd"></fmt:formatDate>至<fmt:formatDate value="${myCompetition.competitionTimePeriod.endTime }" pattern="yyyy-MM-dd"></fmt:formatDate></span>
							</p>
							<p>
								<span>活动状态： <c:choose>
										<c:when test="${!sipc:hasBegun(myCompetition.competitionTimePeriod.startTime) }">
											<span>即将开始</span>
										</c:when>
										<c:when test="${sipc:hasEnded(myCompetition.competitionTimePeriod.endTime) }">
											<span>已结束</span>
										</c:when>
										<c:otherwise>
											<span>正在进行</span>
										</c:otherwise>
									</c:choose>
								</span>
							</p>
							<div class="btn-box">
								<a onclick="myResource('${myCompetition.id}');" class="u-btn-com u-download">我的作品</a>
							</div></li>
					</c:forEach>
				</ul>
				<div class="am-pageturn">
					<jsp:include page="/WEB-INF/views/include/pagination.jsp">
						<jsp:param value="listMyCompetitionForm" name="pageForm" />
						<jsp:param value="myCompetitionsPaginator" name="paginatorName" />
						<jsp:param value="listMyCompetitionDiv" name="divId" />
						<jsp:param value="ajax" name="type" />
					</jsp:include>
				</div>
			</form>
		</div>
	</c:when>
	<c:otherwise>
		<tag:noContent msg="没有参加活动"></tag:noContent>
	</c:otherwise>
</c:choose>

