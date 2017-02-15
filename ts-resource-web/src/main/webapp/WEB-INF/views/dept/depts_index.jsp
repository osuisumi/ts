<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<tag:mainLayout>
	<script>
	$(function(){
		$('#content').load($('#ctx').val() + '/dept/more?paramMap[deptType]=2&orders=CREATE_TIME.DESC');
	})
	changeTab('school');
	</script>
</tag:mainLayout>