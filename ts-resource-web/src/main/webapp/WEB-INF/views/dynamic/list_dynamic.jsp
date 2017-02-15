<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="g-sd-mod" style="min-height: 370px">
	<div class="m-new-trend">
		<div class="m-sd-tt">
			<h3 class="tt">最新动态</h3>
		</div>
		<div class="m-sd-dt" >
			<c:choose>
				<c:when test="${not empty dynamics}">
					<ul class="trend-lst">
						<c:forEach items="${dynamics}" var="dynamic">
							<li>
								<p class="lst-tit">
								    <%-- 这里的“分享了”还得与type搭钩 --%>
									<a href="javascript:void(0);"><span>${dynamic.creator.realName}</span></a>
								    <c:choose>
										<c:when test="${dynamic.dynamicSourceType == 'discussion' }">发帖 
											<a href="javascript:viewBoardDiscussion('${dynamic.dynamicSourceId}');">《${dynamic.content}》</a>
										</c:when>
										<%-- 帖子回复，跳转到该帖子就好  --%>
										<c:when test="${dynamic.dynamicSourceType == 'discussionpost' }">回复  
											<a href="javascript:viewBoardDiscussion('${dynamic.dynamicSourceId}');">《${dynamic.content}》</a>
										</c:when>	
										<%-- 活动，跳转到该活动就好 --%>									
										<c:when test="${dynamic.dynamicSourceType == 'competition'}">参与了
											<a href="javascript:viewCompetition('${dynamic.dynamicSourceId}');">${dynamic.content}</a>
										</c:when>
										<%-- 后面的都直接跳转到对应的资源页面 --%>
										<c:when test="${dynamic.dynamicSourceType == 'discovery' }">分享了
											<a href="javascript:viewDiscovery('${dynamic.dynamicSourceId}');">《${dynamic.content}》</a>
										</c:when> 
										<%--剩余的情况就只有resource --%>
										<c:otherwise>分享了
											 <a href="javascript:viewResource('${dynamic.dynamicSourceId}');">《${dynamic.content}》</a>
										</c:otherwise>
								    </c:choose>									   					    									   
								</p>
								<p class="lst-btm">
									<span>${sipc:prettyTime(dynamic.createTime)}</span>
								</p> <a href="javascript:void(0);" class="user-img"><tag:avatar userId="${user.id}" avatar="${user.avatar}"/></a>
							</li>
						</c:forEach>
					</ul>
				</c:when>
				<c:otherwise>
					<tag:noContent msg="没有相关动态" height="140" />
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<!--end m-new-trend-->
</div>
<!--end g-sd-mod-->

