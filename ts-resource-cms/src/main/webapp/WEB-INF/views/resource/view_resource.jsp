<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="alter-table-v">
	<tbody>
		<tr>
			<td>资源预览:</td>
			<td colspan="3" style="text-align: left; height: 400px;">
				<tag:previewFile url="${resource.fileInfos[0].url }" />
			</td>
		</tr>
		<tr>
			<td width="15%">资源描述:</td>
			<td width="35%" style="text-align: left;">${resource.summary}</td>
		</tr>
		<tr>
			<td width="15%">资源描述:</td>
			<td width="35%" style="text-align: left;">
				<c:choose>
					<c:when test="${resource.type eq 'sync' }">
						同步资源
					</c:when>
					<c:otherwise>
						分类资源
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<c:choose>
			<c:when test="${resource.type eq 'sync' }">
				<tr>
					<td width="15%">系统分类:</td>
					<td width="35%" style="text-align: left;">${dict:getEntryName('RESOURCE_SYNC_TYPE', resource.resourceExtend.type) }</td>
				</tr>
				<tr>
					<td width="15%">学段:</td>
					<td width="35%" style="text-align: left;">${tb:getEntryName('STAGE', resource.resourceExtend.stage) }</td>
				</tr>
				<tr>
					<td width="15%">学科:</td>
					<td width="35%" style="text-align: left;">${tb:getEntryName('SUBJECT', resource.resourceExtend.subject) }</td>
				</tr>
				<tr>
					<td width="15%">教材版本:</td>
					<td width="35%" style="text-align: left;">${tb:getEntryName('VERSION', resource.resourceExtend.tbVersion) }</td>
				</tr>
				<tr>
					<td width="15%">年级/册:</td>
					<td width="35%" style="text-align: left;">${tb:getEntryName('GRADE', resource.resourceExtend.grade) }</td>
				</tr>
				<tr>
					<td width="15%">章:</td>
					<td width="35%" style="text-align: left;">${tb:getEntryName('SECTION', resource.resourceExtend.section) }</td>
				</tr>
				<tr>
					<td width="15%">节:</td>
					<td width="35%" style="text-align: left;">${tb:getEntryName('SECTION', resource.resourceExtend.chapter) }</td>
				</tr>
			</c:when>
			<c:otherwise>
				<tr>
					<td width="15%">系统分类:</td>
					<td width="35%" style="text-align: left;">${dict:getEntryName('RESOURCE_CLASSIFY_TYPE', resource.resourceExtend.type) }</td>
				</tr>
				<tr>
					<td width="15%">岗位:</td>
					<td width="35%" style="text-align: left;">${dict:getEntryName('POST', resource.resourceExtend.post) }</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</tbody>
</table>
