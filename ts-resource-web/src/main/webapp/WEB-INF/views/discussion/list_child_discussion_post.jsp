<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="hasMasterRole" value="${sipc:getBooleanFromRequest(pageContext.request, 'hasMasterRole') }" /> 
<c:set var="hasMemberRole" value="${sipc:getBooleanFromRequest(pageContext.request, 'hasMemberRole') }" /> 
<c:set var="inCurrentDate" value="${sipc:getBooleanFromRequest(pageContext.request, 'inCurrentDate') }" /> 
<div class="ag-is-comment" style="display: block">
	<i class="ua-comment-trg"></i>
	<ul class="aag-cmt-lst">
		<c:forEach items="${childPosts }" var="childPost">
			<li class="am-cmt-block">
				<div class="c-info">
					<a class="au-cmt-headimg">
						<tag:avatar userId="${childPost.creator.id}" avatar="${childPost.creator.avatar}"/>
					</a>
					<p class="tp">
						<a class="name">${childPost.creator.realName }</a>
						<span class="time">${sipc:prettyTime(childPost.createTime)}</span>
					</p>
					<p class="cmt-dt">${childPost.content }</p>
				</div>
			</li>
		</c:forEach>
	</ul>
	<c:if test="${(hasMasterRole or hasMemberRole) and inCurrentDate }">
		<div class="am-isComment-box am-ipt-mod">
			<textarea name="content" class="au-textarea" placeholder="我也说一句" style="height:40px"></textarea>
			<div class="am-cmtBtn-block f-cb" style="display: block;">  
				<a href="javascript:void(0);" class="au-cmtPublish-btn au-confirm-btn1" onclick="saveChildPost(this)">发表</a>
			</div>
		</div>
	</c:if>
</div>