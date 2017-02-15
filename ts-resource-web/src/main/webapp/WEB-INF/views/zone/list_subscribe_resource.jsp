<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="listSubscribeResourceForm" action="${ctx}/zone/myZone/subscribe/resource">
<input type="hidden" name="paramMap[stage]" value="${searchParam.paramMap.stage}">
<input type="hidden" name="paramMap[subject]" value="${searchParam.paramMap.subject}">
<input type="hidden" name="paramMap[grade]" value="${searchParam.paramMap.grade}">
<ul class="m-arr-lst m-res-lst z-crt">
	<c:choose>
		<c:when test="${not empty resources}">
			<c:forEach items="${resources}" var="resource">
				<li class="m-arr-block"><i class="type-ico"></i>
					<h4 class="tt">
						<a onclick="viewResource('${resource.id}')">${resource.title}</a>
					</h4>
					<p>
						${resource.creator.realName }&nbsp;&nbsp;上传于&nbsp;&nbsp;${sipc:formatDate(resource.createTime, 'yyyy-MM-dd HH:mm:ss') }<i class="u-line">|</i><span>类型：${dict:getEntryName('RESOURCE_SYNC_TYPE', resource.resourceExtend.type) }</span><i class="u-line">|</i><span>下载量：${resource.resourceRelations[0].downloadNum }</span><i class="u-line">|</i><span>浏览量：${resource.resourceRelations[0].browseNum }</span>
					</p>
					<div class="u-stars">
						<c:forEach begin="1" end="${resource.resourceExtend.evaluateResult }" >
							<i class="u-full"></i> 
						</c:forEach>
						<c:if test="${resource.resourceExtend.evaluateResult % 1 > 0 }">
							<i class="u-half"></i> 
						</c:if>
						<c:forEach begin="1" end="${5 - resource.resourceExtend.evaluateResult }" >
							<i class="u-null"></i>
						</c:forEach>
					</div>
				</li>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tag:noContent msg="暂时没有资源"></tag:noContent>
		</c:otherwise>
	</c:choose>
</ul>
		<div class="am-pageturn">
			<jsp:include page="/WEB-INF/views/include/pagination.jsp">
				<jsp:param value="listSubscribeResourceForm" name="pageForm" />
				<jsp:param value="resourcesPaginator" name="paginatorName" />
				<jsp:param value="subscribeResourceContent" name="divId" />
				<jsp:param value="ajax" name="type" />
			</jsp:include>
		</div>
</form>
<script>
$(function(){
	changeFileType($('.m-arr-lst'),'li',' ','li',0,'a',0);
})
</script>