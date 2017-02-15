<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>${ipanthercore:getProperty('app.name')}</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="content-type" content="text/html;charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="">
<meta http-equiv="description" content="">
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/inc.jsp"%>
</head>
<body id="index" class="easyui-layout">
	<div data-options="region:'north'" style="height: 86px; border: 0;">
		<jsp:include page="/WEB-INF/views/include/top.jsp" />
	</div>
	<div data-options="region:'west',split:false" title="" class="side-wrap" style="width: 250px; border-left: 0; overflow:auto;">
		<jsp:include page="/WEB-INF/views/include/menu_left.jsp" />
	</div>
	<div data-options="region:'center',title:''" class="center-wrap" style="overflow: hidden;">
		<jsp:include page="/WEB-INF/views/include/center.jsp" />
	</div>
	<%-- <div data-options="region:'south'" style="text-align: center;">
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div> --%>
</body>
</html>