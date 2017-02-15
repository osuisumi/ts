<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="m-hot hot-res">
	<h3 class="tit-h3 hot-tit">
		热门资源<a onclick="listMoreHotResource('${searchParam.paramMap.relationId}')">更多></a>
	</h3>
	<c:choose>
		<c:when test="${not empty resources }">
			<ul class="ul-hot-res" id="ul-hot-res">
				<c:forEach items="${resources }" var="resource" varStatus="vs">
					<li>
						<div class="li-tit u-first" style="display: block">
							<c:choose>
								<c:when test="${vs.count == 1 }">
									<span class="u-tit-num fir">${vs.count }</span> 
								</c:when>
								<c:when test="${vs.count == 2 }">
									<span class="u-tit-num sec">${vs.count }</span> 
								</c:when>
								<c:when test="${vs.count == 3 }">
									<span class="u-tit-num thir">${vs.count }</span> 
								</c:when>
								<c:otherwise>
									<span class="u-tit-num">${vs.count }</span> 
								</c:otherwise>
							</c:choose>
							<a onclick="viewResource('${resource.id}')" class="theme-tit">${resource.title }</a>
						</div>
					</li>
				</c:forEach>
			</ul>
		</c:when>
		<c:otherwise>
			<tag:noContent msg="暂未上传资源"/>
		</c:otherwise>
	</c:choose>
</div>
<script>
function listMoreHotResource(relationId){
	$('#content').load('${ctx}/resource/listMoreHotResource','orders=DOWNLOAD_NUM.DESC&paramMap[relationId]='+relationId);
}
</script>