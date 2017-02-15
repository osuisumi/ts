<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<body class="easyui-layout">  
<table class="easyui-datagrid" data-options="fit:'true'">
	<thead>
		<tr>
			<th width="10%" data-options="field:'code'">项目</th>
			<th width="90%" data-options="field:'name'">本次导入完成</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>学段</td>
			<td><c:forEach items="${resultMap.stageResult}" var="stage">
			${stage},	
		</c:forEach></td>
		</tr>
		<tr>
			<td>学科</td>
			<td><c:forEach items="${resultMap.subjectResult}" var="subject">
			${subject},	
		</c:forEach></td>
		</tr>
		<tr>
			<td>年级</td>
			<td><c:forEach items="${resultMap.gradeResult}" var="grade">
			${grade},	
		</c:forEach></td>
		</tr>
		<tr>
			<td>版本</td>
			<td><c:forEach items="${resultMap.versionResult}" var="version">
			${version},	
		</c:forEach></td>
		</tr>
		<tr>
			<td>章</td>
			<td><c:forEach items="${resultMap.chapterResult}" var="chapter">
			${chapter},	
		</c:forEach></td>
		</tr>
		<tr>
			<td>节</td>
			<td><c:forEach items="${resultMap.sectionResult}" var="section">
			${section},	
		</c:forEach></td>
		</tr>
	<tbody>
</table>
</body>
