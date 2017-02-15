<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="m-new-resource">
	<div class="m-sd-tt">
		<h3 class="tt">最新上传资源</h3>
	</div>
	<div class="m-sd-dt">
		<c:choose>
			<c:when test="${not empty resources }">
				<ul id="newResourceFile" class="m-arr-lst">
					<c:forEach items="${resources }" var="resource">
						<li class="m-arr-block"><i class="type-ico"></i>
							<h4 class="tt">
								<a onclick="viewResource('${resource.id}')">${resource.title }</a>
							</h4>
							<p class="info">
								<span>上传于：${sipc:formatDate(resource.createTime, 'yyyy/MM/dd') }</span>
							</p>
						</li>
					</c:forEach>
				</ul>
			</c:when>
			<c:otherwise>
				<tag:noContent msg="没有相关资源" />
			</c:otherwise>
		</c:choose>
	</div>
</div>
<script>
changeFileType($('.m-arr-lst'),'li',' ','li',0,'a',0);
</script>