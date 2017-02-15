<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<h2>导入成功的数据列表</h2>
<table class="easyui-datagrid" rownumbers="true" fitColumns="true" singleSelect="false" checkOnSelect="true" selectOnCheck="true">
	<thead>
		<tr>
			<th width="20" data-options="field:'userName'">姓名</th>
			<th width="20" data-options="field:'realName'">姓名</th>
			<th width="20" data-options="field:'deptName'">所在单位</th>
			<th width="20" data-options="field:'sex'">性别</th>
			<th width="20" data-options="field:'post'">岗位信息</th>
			<th width="20" data-options="field:'phone'">联系电话</th>
			<th width="20" data-options="field:'email'">邮箱</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="result" items="${resultMap.successList }">
			<tr>
				<td>${result.userName}</td>
				<td>${result.realName}</td>
				<td>${result.deptName}</td>
				<td>${result.sex }</td> 
				<td>${result.post }</td>
				<td>${result.phone}</td>
				<td>${result.email}</td> 
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