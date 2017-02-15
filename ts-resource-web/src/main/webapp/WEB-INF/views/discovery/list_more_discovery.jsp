<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="discoveryListForm" action="${ctx}/discovery/more" method="get">
	<input id="discoveryType" type="hidden" name="paramMap[extendType]" value="${searchParam.paramMap.extendType}">
	<input type="hidden" name="paramMap[type]" value="discovery">
	<input type="hidden" name="limit" value="${limit }">
	<input type="hidden" name="orders" value="CREATE_TIME.DESC">
	<input type="hidden" name="paramMap[state]" value="${searchParam.paramMap.state}">
	<div id="wrap">
		<div class="g-mn-dt1">
			<c:choose>
				<c:when test="${not empty discoverys}">
					<ul class="m-figure-lst bor-bt">
						<c:forEach items="${discoverys}" var="discovery">
							<li>
								<div class="m-figure-block">
									<a onclick="viewDiscovery('${discovery.id}')" class="figure"> <img src="${file:getFileUrl(discovery.fileInfos[0].url)}" alt="">
										<%-- <p class="u-ltl-box">
											<c:forEach items="${discovery.tags }" var="tag">
												<span style="width:60px" class="u-ltl-ico u-gd">${tag.name}</span>
											</c:forEach>
										</p> --%>
									</a>
									<h4 class="tt">
										<a onclick="viewDiscovery('${discovery.id}')">${discovery.title }</a>
									</h4>
									<p class="ex">${discovery.summary }</p>
									<div class="info">
										<a href="javascript:void(0);" class="user"> <tag:avatar userId="${discovery.creator.id}" avatar="${discovery.creator.avatar }"></tag:avatar> <span>${discovery.creator.realName }</span>
										</a> <span class="time">${sipc:formatDate(discovery.createTime, 'yyyy/MM/dd') }</span>
									</div>
								</div>
							</li>
						</c:forEach>
					</ul>
				</c:when>
				<c:otherwise>
					<tag:noContent msg="没有相关发现" />
				</c:otherwise>
			</c:choose>
		</div>
		<div class="am-pageturn">
			<jsp:include page="/WEB-INF/views/include/pagination.jsp">
				<jsp:param value="discoveryListForm" name="pageForm" />
				<jsp:param value="discoverysPaginator" name="paginatorName" />
				<jsp:param value="discoveryContent" name="divId" />
				<jsp:param value="ajax" name="type" />
			</jsp:include>
		</div>
	</div>
</form>
