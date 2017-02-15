<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-au-Compatible" content="IE=Edge,chrome=1">
<meta http-equiv="Window-target" content="_top">
<title>${sipc:getProperty('app.name')}</title>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/inc.jsp"%>
</head>
<body>
	<input id="backName" type="hidden">
	<div class="m-blackbg"></div>
	<div id="wrap">
		<div id="top">
			<%@ include file="/WEB-INF/views/include/top.jsp"%>
		</div>
		<div id="content">
		
		</div>
		<%@ include file="/WEB-INF/views/include/footer.jsp"%>
		<input type="hidden" id="loadDivId" value="content" />
		<div class="blackBg"></div>
		<div class="blackBg1"></div>
		<div class="whiteBg"></div>
		<div class="ag-whitebg"></div>
		<div class="ag-blackbg"></div>
	</div>
	<form id="downloadFileForm" action="${ctx }/file/downloadFile.do" method="post" target="_blank">
		<input type="hidden" name="id">
		<input type="hidden" name="fileName">
		<input type="hidden" name="fileRelations[0].type">
		<input type="hidden" name="fileRelations[0].relation.id">
	</form>
	<form id="updateFileForm" target="_blank">
		<input type="hidden" name="id">
		<input type="hidden" name="fileName">
	</form>
	<form id="deleteFileRelationForm" target="_blank">
		<input type="hidden" name="fileId">
		<input type="hidden" name="relation.id">
		<input type="hidden" name="type">
	</form>
</body>
</html>
<script>
	$(function(){
		home();
		changeTab('home');
	});
</script>