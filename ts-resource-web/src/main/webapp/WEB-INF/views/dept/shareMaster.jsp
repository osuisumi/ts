<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="g-mn-mod" style="min-height: 390px">
	<div class="m-share-people">
		<div class="m-mn-tt">
			<h2 class="tt small">
				分享达人
				<!-- <a href="javascript:void(0);" class="u-more">更多&gt;</a> -->
			</h2>
		</div>	
		<div class="g-mn-dt">
			<div class="m-people-lst">
			<c:choose>
				<c:when test="${not empty users}">
					<ul class="people-ul">
						<c:forEach items="${users }" var="user">
							<li>
								<a title="${user.realName}" href="javascript:void(0);" class="user"> 
									<tag:avatar userId="${user.id}" avatar="${user.avatar }" />
									<p class="name">${user.realName}</p>
								</a>
								<p class="info">
									<a href="javascript:void(0);">${tb:getEntryName('STAGE',user.stage)}</a>&nbsp; 
									<a href="javascript:void(0);">${tb:getEntryName('SUBJECT',user.subject)}</a>
								</p>
							</li>
						</c:forEach>				
					</ul>
				</c:when>
				<c:otherwise>
					<tag:noContent msg="没有相关信息" />
				</c:otherwise>
			</c:choose>
			</div>
		</div>
	</div>
</div>
