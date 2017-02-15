<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="m-sd-rank">
	<div class="m-sd-tt">
		<h3 class="tt">人气排名</h3>
	</div>
	<div class="m-sd-dt">
		<ul class="m-arr-lst">
			<c:forEach items="${resources}" var="resource" varStatus="index">
				<c:choose>
					<c:when test="${index.index eq 0 }">
						<li class="m-arr-block first">
					</c:when>
					<c:when test="${index.index eq 1 }">
						<li class="m-arr-block second">
					</c:when>
					<c:when test="${index.index eq 2 }">
						<li class="m-arr-block thirdly">
					</c:when>
					<c:otherwise>
						<li class="m-arr-block">
					</c:otherwise>
				</c:choose>
				<strong class="rank">${index.index+1 }</strong>
					<h4 class="tt">
						<a onclick="viewResource('${resource.id}')">${resource.title }</a>
					</h4>
					<p class="info">
						<span>来源：${resource.creator.realName }</span> <span>下载：${resource.resourceRelations[0].downloadNum }</span>
					</p>
				</li>
			</c:forEach>
		</ul>
	</div>
</div>