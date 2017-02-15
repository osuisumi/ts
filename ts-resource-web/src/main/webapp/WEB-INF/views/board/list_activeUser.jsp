<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<ul class="m-arr-lst hot-user">
	<c:forEach items="${activeUsers}" var="activeUser" varStatus="index">
	<c:choose>
		<c:when test="${index.index eq 0 }">
			<li class="m-arr-block first"><strong class="rank">1</strong>
		</c:when>
		<c:when test="${index.index eq 1 }">
			<li class="m-arr-block second"><strong class="rank">2</strong>
		</c:when>
		<c:when test="${index.index eq 2}">
			<li class="m-arr-block thirdly"><strong class="rank">3</strong>
		</c:when>
	</c:choose>
		
		<div class="u-user-img">
				<a href="javascript:void(0);"><tag:avatar userId="${activeUser.id}" avatar="${activeUser.avatar}"></tag:avatar></a>
			</div>
			<div class="u-user-info">
				<p class="u-user-name">
					<a href="javascript:void(0);">${activeUser.realName }</a>
				</p>
				<div class="u-user-txt">
					<p class="u-pl-txt">
						<span class="u-num">发帖量：${activeUser.discussionCount}</span><span class="u-score">积分：${activeUser.score }</span>
					</p>
				</div>
			</div>
		</li>
	</c:forEach>
</ul>
