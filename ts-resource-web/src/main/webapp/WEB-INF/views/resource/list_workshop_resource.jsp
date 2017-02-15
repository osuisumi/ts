<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<shiro:hasRole name="${searchParam.paramMap.relationId}_master">
	<c:set var="hasMasterRole" value="true"  />
</shiro:hasRole>
<shiro:hasRole name="${searchParam.paramMap.relationId}_member">
	<c:set var="hasMemberRole" value="true"  />
</shiro:hasRole>
<div class="m-active yx-res">
	<h3 class="tit-h3">
		研修资源<a onclick="resourceIndex('${searchParam.paramMap.relationId}')">更多&gt;</a>
	</h3>
	<c:if test="${hasMasterRole or hasMemberRole }">
		<a class="u-add" onclick="addResource('workshop', '${searchParam.paramMap.relationId}')"><i>+</i>添加研修资源</a>
	</c:if>
	<c:choose>
		<c:when test="${not empty resources }">
			<c:forEach items="${resources }" var="resource">
				<ul class="ul-res">
					<li>
						<i class="u-res u-w"></i> 
						<a onclick="viewResource('${resource.id}')" class="u-lk">${resource.title }</a> 
						<span class="u-dt">${sipc:prettyTime(resource.createTime) }</span> 
						<span class="u-sc">上传于</span> 
						<a href="javascript:void(0);" class="u-tea">${resource.creator.realName }</a>
					</li>
				</ul>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tag:noContent msg="还未上传资源" />
		</c:otherwise>
	</c:choose>
</div>
<div id="editResourceDiv" class="new-resource-layer layer"></div>
<script>
/* function addResource(relationId, relationType){
	$('#content').load('${ctx}/resource/create','resourceRelations[0].relation.id='+relationId+'&resourceRelations[0].relation.type='+relationType);
} */

function listMoreResource(relationId){
	$('#content').load('${ctx}/resource/more','orders=CREATE_TIME.DESC&paramMap[relationId]='+relationId);
}
</script>
