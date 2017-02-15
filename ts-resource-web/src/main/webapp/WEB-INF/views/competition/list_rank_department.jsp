<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="m-sd-rank">
	<div class="m-sd-tt">
		<h3 class="tt">作品数量</h3>
	</div>
	<div class="m-sd-small-tt">
		<p class="u-sort">排名</p>
		<p class="u-name">学校</p>
		<p class="u-num">作品数</p>
	</div>
	<div class="m-sd-dt">
		<ul class="m-arr-lst m-work-lst">
			<c:forEach items="${departments}" var="department" varStatus="index">
					
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
							<li class="m-arr-block li-even">
						</c:otherwise>
					</c:choose>
					<strong class="rank">${index.index+1 }</strong>
						<h4 class="tt">
							<p class="scl-name">
								<a href="###">${department.deptName}</a>
							</p>
							<p class="work-num">${department.uploadNum }</p>
						</h4>
					</li>
			</c:forEach>
		</ul>
	</div>
</div>