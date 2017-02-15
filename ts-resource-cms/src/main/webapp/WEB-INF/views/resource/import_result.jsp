<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<h2>导入成功的数据列表</h2>
<table class="easyui-datagrid" rownumbers="true" fitColumns="true" singleSelect="false" checkOnSelect="true" selectOnCheck="true">
	<thead>
		<tr>
			<th width="20" data-options="field:'fileName'">文件名</th>
			<th width="20" data-options="field:'resourceName'">资源</th>
			<th width="20" data-options="field:'url'">目录</th>
			<th width="20" data-options="field:'type'">类型</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="result" items="${resultMap.successList }">
			<tr>
				<td>${result.fileName}</td>
				<td>${result.resourceName}</td>
				<td>${result.url}</td>
				<td>${result.type }</td> 
			</tr>
		</c:forEach>
	</tbody>
</table>
<h2>导入失败的数据列表</h2>
<table class="easyui-datagrid" rownumbers="true" fitColumns="true" singleSelect="false" checkOnSelect="true" selectOnCheck="true">
	<thead>
		<tr>
			<th width="20" data-options="field:'result'">失败信息</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="result" items="${resultMap.failList }">
			<tr>
				<td>${result}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<script>
	
</script>