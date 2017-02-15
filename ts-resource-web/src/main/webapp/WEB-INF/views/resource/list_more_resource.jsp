<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:choose>
	<c:when test="${not empty resources }">
		<ul id="moreResourceFile" class="m-arr-lst m-res-lst z-crt">
			<c:forEach items="${resources }" var="resource">
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
				<jsp:param value="listMoreResourceForm" name="pageForm" />
				<jsp:param value="resourcesPaginator" name="paginatorName" />
				<jsp:param value="listMoreResourceDiv" name="divId" />
				<jsp:param value="ajax" name="type" />
			</jsp:include>
		</div>
	</c:when>
	<c:otherwise>
		<tag:noContent msg="没有相关资源" />
	</c:otherwise>
</c:choose>
<script>
//listId:列表id(ul) listliType:列表项类型(li)  append:追加类型时的分割符号(' ','-')  imgElementType:图标所在的元素类型(a)  imgElementIndex:图标所在元素类型对应的index replaceRule:替换规则
//changeFileType(listId,listliType,append,imgElementType,imgElementIndex,fileElementType,fileElementIndex,replaceRule)
changeFileType($('#moreResourceFile'),'li',' ','li',0,'a',0);
</script>