<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="dict" uri="http://dictionary.haoyi.com"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="file" uri="http://file.haoyu.com" %>
<%@ taglib prefix="sipc" uri="http://sip.haoyu.com/core" %>
<%@ taglib prefix="tb" uri="http://textBook.haoyu.com" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-au-Compatible" content="IE=Edge,chrome=1">
<meta http-equiv="Window-target" content="_top">
<title>${sipc:getProperty('app.name')}</title>
</head>
<body>
	<c:set var="ctx" value="${pageContext.request.contextPath}"/>
	<input id="ctx" type="hidden" value="${pageContext.request.contextPath}">
	<jsp:include page="/WEB-INF/views/include/inc.jsp" />
	<input id="backName" type="hidden">
	<div class="m-blackbg"></div>
	<div id="wrap">
		<div id="top">
			<jsp:include page="/WEB-INF/views/include/top.jsp" />
		</div>
		<div id="content">
			<jsp:doBody />
		</div>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
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