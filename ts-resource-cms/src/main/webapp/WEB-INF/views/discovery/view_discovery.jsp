<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="alter-table-v">
	<tbody>
		<tr>
			<td>发现预览:</td>
			<td colspan="3" style="text-align: left; height: 200px;">
				<ul style="min-height: 120px" id="fileList" class="m-upload-lst">
					<c:forEach items="${discovery.fileInfos}" var="fileInfo">
						<li style="display: inline-block" id="${fileInfo.id}" fileId="${fileInfo.id}" url="${fileInfo.url}" fileName="fileInfo.fileName" class="upload-state-done"><img style="height: 100px; width: 100px;" src="${file:getFileUrl(fileInfo.url)}"></li>
					</c:forEach>
				</ul>
			</td>
		</tr>
		<tr>
			<td width="10%">发现什么:</td>
			<td width="35%" style="text-align: left;">${discovery.title }</td>
		</tr>
		<tr>
			<td width="15%">有啥亮点:</td>
			<td width="35%" style="text-align: left;width: 478px; height: 100px">${discovery.summary }</td>
		</tr>
		<tr>
			<td width="15%">资源网址:</td>
			<td width="35%" style="text-align: left;">${discovery.resourceExtend.previewUrl}</td>
		</tr>
		<tr>
			<td width="15%">属于:</td>
			<td width="35%" style="text-align: left;">${dict:getEntryName('RESOURCE_DISCOVERY_TYPE',discovery.resourceExtend.type)}</td>
		</tr>
	</tbody>
</table>
