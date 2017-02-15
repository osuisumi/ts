<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<div class="m-sd-dt">
	<c:choose>
		<c:when test="${not empty discoverys }">
			<ul class="trend-lst new-find">
				<c:forEach items="${discoverys }" var="discovery">
					<li>
						<p class="lst-btm">
							<span>${sipc:formatDate(discovery.createTime, 'yyyy/MM/dd') }</span>
						</p>
						<p class="lst-tit">
							分享了&nbsp;&nbsp;<a onclick="viewDiscovery('${discovery.id}')">${discovery.title}</a>
						</p>
					</li>
				</c:forEach>
			</ul>
		</c:when>
		<c:otherwise>
			<tag:noContent msg="暂无发现" height="255"/>
		</c:otherwise>
	</c:choose>
</div>

