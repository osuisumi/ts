<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="g-mn-dt">
	<c:choose>
		<c:when test="${not empty resources }">
			<ul class="m-bResource-lst">
				<c:forEach items="${resources }" var="resource">
					<li>
						<div class="m-bRsc-block">
							<a onclick="viewResource('${resource.id}')"><i class="type-ico"></i></a>
							<h4 class="tt">
								<a onclick="viewResource('${resource.id}')">${resource.title }</a>
							</h4>
							<p class="info">
								<span>${resource.creator.realName }</span> <span>上传于&nbsp;&nbsp;${sipc:formatDate(resource.createTime, 'yyyy/MM/dd') }</span>
							</p>
							<div class="btn-row">
								<a onclick="downloadFile('${resource.fileInfos[0].id}','${resource.fileInfos[0].fileName}','resources','${resource.id }')" class="u-theme-btn"><i class="u-sDownload-ico"></i>${resource.resourceRelations[0].downloadNum }</a>
							</div>
						</div>
					</li>
				</c:forEach>
			</ul>
		</c:when>
		<c:otherwise>
			<tag:noContent msg="没有相关资源" />
		</c:otherwise>
	</c:choose>	
</div>

<script type="text/javascript">
changeFileType($('.m-bResource-lst'),"li"," ","div",0,"a",1);
</script>
