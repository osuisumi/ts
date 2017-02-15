<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
	<ul id="file" class="am-file-lst f-cb">
		<c:forEach items="${myResources}" var="resource">
			<li>
				<div class="am-file-block am-file">
				<div class="file-view">
					<a onclick="viewResource('${resource.id}')" class="au-file"></a>
					<c:choose>
						<c:when test="${dict:getEntryValue('EDIT_STATE','已审核') eq resource.state}">
							<i class="u-state pass">已审核</i>
						</c:when>
						<c:when test="${dict:getEntryValue('EDIT_STATE','待审核') eq resource.state}">
							<i class="u-state wait">待审核</i>
						</c:when>
						<c:when test="${dict:getEntryValue('EDIT_STATE','不通过') eq resource.state}">
							<i class="u-state no">未通过</i>
						</c:when>
					</c:choose>
				</div>
				<a onclick="viewResource('${resource.id}')"><b class="f-name"> <span> ${resource.fileInfos[0].fileName } </span></b></a>
				<div class="f-info">
					<span class="u-name">${resource.creator.realName }</span> <span class="time">${sipc:formatDate(resource.createTime,'yyyy-MM-dd') }</span>
				</div>
				</div>
			</li>
		</c:forEach>
	</ul>
		<div class="am-pageturn">
			<jsp:include page="/WEB-INF/views/include/pagination.jsp">
				<jsp:param value="listMyResourceForm" name="pageForm" />
				<jsp:param value="myResourcesPaginator" name="paginatorName" />
				<jsp:param value="myResourcesDiv" name="divId" />
				<jsp:param value="ajax" name="type" />
			</jsp:include>
		</div>

<script>

$(function(){
	changeFileType($('.am-file-lst'),'li','-','a',0,'span',0);
})

</script>