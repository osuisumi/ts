<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="g-mn-mod" style="padding-bottom: 20px;">
	<div class="m-mn-tt tea">
		<span class="lb"></span>
		<h2 class="tt small-size">教育资源</h2>
		<c:if test="${sessionScope.loginer.id eq searchParam.paramMap.creator}">
			<a style="float:right" onclick="addResource()">+上传资源</a>
		</c:if>
	</div>
	<form id="listPersonalResourceForm" action="${ctx }/zone/personal/resource">
		<input type="hidden" name="paramMap[typeNotEquils]" value="discovery">
		<input id="creatorOrFollowCreator" type="hidden" name="paramMap[creatorOrFollowCreator]" value="${searchParam.paramMap.creatorOrFollowCreator}">
		<input id="creator" type="hidden" name="paramMap[creator]" value="${searchParam.paramMap.creator}">
		<input id="followCreator" type="hidden" name="paramMap[followCreator]" value="${searchParam.paramMap.followCreator }">
		<input type="hidden" name="orders" value="CREATE_TIME.DESC">
		<input type="hidden" name="limit" value="12">
	<div class="g-res-con">
		<ul id="moreResourceFile" class="m-arr-lst m-res-lst z-crt">
			<c:forEach items="${myResources }" var="resource">
				<li class="m-arr-block"><i class="type-ico"></i>
					<h4 class="tt">
						<a onclick="viewResource('${resource.id}')">${resource.title }</a>
					</h4>
					<p>
						${resource.creator.realName }&nbsp;&nbsp;上传于&nbsp;&nbsp;
						${sipc:formatDate(resource.createTime, 'yyyy-MM-dd HH:mm:ss') }<i class="u-line">|</i>
						<span>类型：${dict:getEntryName('RESOURCE_SYNC_TYPE', resource.resourceExtend.type) }</span><i class="u-line">|</i>
						<span>下载量：${resource.resourceRelations[0].downloadNum }</span><i class="u-line">|</i>
						<span>浏览量：${resource.resourceRelations[0].browseNum }</span>
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
		</ul>
		<div class="am-pageturn">
			<jsp:include page="/WEB-INF/views/include/pagination.jsp">
				<jsp:param value="listPersonalResourceForm" name="pageForm" />
				<jsp:param value="myResourcesPaginator" name="paginatorName" />
				<jsp:param value="personalContent" name="divId" />
				<jsp:param value="ajax" name="type" />
			</jsp:include>
		</div>
	</div>
	</form>
</div>
<script>
	changeFileType($('.am-file-lst'),'li','-','a',0,'span',0);
</script>