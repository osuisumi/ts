<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="m-sd-rank">
	<div class="m-sd-tt">
		<h3 class="tt">本周资源下载排行</h3>
	</div>
	<div class="m-sd-dt">
		<c:choose>
			<c:when test="${not empty resources }">
				<ul class="m-arr-lst">
					<c:forEach items="${resources }" var="resource" varStatus="vs">
						<li class="m-arr-block 
							<c:choose>
								<c:when test="${vs.count == 1 }">
									first
								</c:when>
								<c:when test="${vs.count == 2 }">
									second
								</c:when>
								<c:when test="${vs.count == 3 }">
									thirdly
								</c:when>
							</c:choose>
						">
							<strong class="rank">${vs.count }</strong>
							<h4 class="tt">
								<a onclick="viewResource('${resource.id}')">${resource.title }</a>
							</h4>
							<p class="info">
								<span>来源：${resource.creator.realName }</span> 
								<span>下载：${resource.resourceRelations[0].downloadNum }</span>
							</p>
						</li>
					</c:forEach>
				</ul>
			</c:when>
			<c:otherwise>
				<tag:noContent msg="没有相关资源" />
			</c:otherwise>
		</c:choose>
	</div>
</div>