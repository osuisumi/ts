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
<link rel="stylesheet" href="${ctx }/css/work.css">
<link rel="shortcut icon" href="${ctx }/images/img/favicon.ico">
<link type="text/css" rel="stylesheet" href="${ctx}/css/yx/set.css" />
<link type="text/css" rel="stylesheet" href="${ctx }/css/yx/frame.css">
<link type="text/css" rel="stylesheet" href="${ctx}/css/yx/color.css">
<link type="text/css" rel="stylesheet" href="${ctx }/css/yx/cmnt.css">
<link type="text/css" rel="stylesheet" href="${ctx }/css/yx/new-cmnt.css">
<link rel="stylesheet" href="${ctx }/css/yx/activity-common.css">

<link rel="stylesheet" href="${ctx }/js/webuploader/webuploader.css">
<link type="text/css" rel="stylesheet" href="${ctx }/js/validation/css/cmxform.css">
<link href="${ctx }/js/jplayer/skin/blue.monday/jplayer.blue.monday.css" rel="stylesheet" type="text/css" />
<link href="${ctx }/js/jplayer/skin/blue.monday/jplayer.blue.monday.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${ctx }/js/library/jquery.js"></script>
<script type="text/javascript" src="${ctx }/js/library/jquery.dsTab.js"></script>
<script type="text/javascript" src="${ctx }/js/jplayer/dist/jplayer/jquery.jplayer.min.js"></script>
<script type="text/javascript" src="${ctx }/js/jplayer/jPlayerUtils.js"></script>
<script type="text/javascript" src="${ctx }/js/validation/lib/jquery.metadata.js"></script> 
<script type="text/javascript" src="${ctx }/js/validation/jquery.validate.js"></script> 
<script type="text/javascript" src="${ctx }/js/validation/expand.js"></script> 
<script type="text/javascript" src="${ctx }/js/validation/localization/messages_cn.js"></script>
<script type="text/javascript" src="${ctx }/js/webuploader/webuploader.js"></script>
<script type="text/javascript" src="${ctx}/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.all.js"> </script>
<script type="text/javascript" src="${ctx}/js/ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript" src="${ctx }/js/yx/common-css.js"></script>
<script type="text/javascript" src="${ctx }/js/yx/ipanther-common.js"></script>
<script type="text/javascript" src="${ctx }/js/yx/function.js"></script>
<script type="text/javascript" src="${ctx }/js/yx/fileUtils.js"></script>
<script type="text/javascript" src="${ctx}/js/yx/md5.js" ></script>
<script type="text/javascript" src="${ctx}/js/yx/activity-common.js"></script>
<script type="text/javascript" src="${ctx}/js/yx/activity-file.js"></script>
<script type="text/javascript" src="${ctx}/js/index.js"></script>
</head>
<body>
	<div class="m-blackbg"></div>
	<c:set var="ctx" value="${pageContext.request.contextPath}"/>
	<input id="ctx" type="hidden" value="${pageContext.request.contextPath}">
	<form id="relationDataForm">
		<input type="hidden" name="rid">
		<input type="hidden" name="rtype">
	</form>
	<form id="roleForm">
		<input type="hidden" name="hasMasterRole" id="hasMasterRole" value="false">
		<input type="hidden" name="hasAssistRole" id="hasAssistRole" value="false">
		<input type="hidden" name="hasMemberRole" id="hasMemberRole" value="false">
		<input type="hidden" name=inCurrentDate id="inCurrentDate" value="true">
	</form>
	<input id="backName" type="hidden">
	<div id="wrap">
		<div id="top" style="height: 70px;">
			<jsp:include page="/WEB-INF/views/include/top.jsp" />
		</div>
		<div id="cont-wrap">
			<div class="noViewTeacherSpaceFlagDiv"></div>
			<div class="content-auto auto">
				<div id="content">
					<jsp:doBody />
				</div>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" /> 
		<div class="blackBg"></div>
		<div class="hintBlackBg"></div>
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