<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ attribute name="title" type="java.lang.String" required="true" %>
<%@ attribute name="javascripts" type="java.lang.String" required="false" %>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8"/>
		<title><c:out value="${title}"/></title>
		<spring:url value="/css" var="styleUrl" />
		<spring:url value="/js" var="scriptUrl" />		
		<link rel="stylesheet" href="${styleUrl}/reset.css"/>
		<link rel="stylesheet" href="${styleUrl}/activity.css"/>		
		<link rel="stylesheet" href="${styleUrl}/research.css"/>
		<link type="text/css" rel="stylesheet" href="${scriptUrl}/validation/css/cmxform.css">
		<script type="text/javascript" src="${ctx }/js/jquery.js"></script>
		<script type="text/javascript" src="${ctx }/library/jqthumb.min.js"></script>
		<script type="text/javascript" src="${ctx }/js/research.js"></script>
		<script type="text/javascript" src="${ctx}/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="${ctx }/js/ipanther-common.js"></script>
		<script type="text/javascript" src="${ctx }/js/validation/lib/jquery.metadata.js"></script> 
		<script type="text/javascript" src="${ctx }/js/validation/jquery.validate.js"></script> 
		<script type="text/javascript" src="${ctx }/js/validation/expand.js"></script> 
		<script type="text/javascript" src="${ctx }/js/validation/localization/messages_cn.js"></script>
		<script type="text/javascript" src="${ctx }/js/activity-function1.js"></script>
		<script type="text/javascript" src="${ctx }/js/webuploader/webuploader.js"></script>
		<script type="text/javascript" src="${ctx }/js/fileUtils.js"></script>
		<script type="text/javascript" src="${ctx }/js/userLabelUtils.js"></script>
		<script type="text/javascript" src="${ctx }/js/aJumpLayer.js"></script>
		<script type="text/javascript" src="${ctx }/library/echarts/build/dist/echarts.js"></script>
		<script type="text/javascript" src="${ctx }/js/sip-common.js"></script>
		<c:if test="${not empty javascripts}">
			<c:forTokens items="${javascripts}" delims="," var="url">
			    <script type="text/javascript" src="${url}"></script>
			</c:forTokens>
		</c:if>
	</head>
	
	<body>
		<div class="m-whitebg"></div>
		<div class="m-blackbg"></div>
		<div class="hint-blackbg"></div>
		<div id="wrap">
			<jsp:include page="/WEB-INF/views/include/top.jsp"></jsp:include>
			<div id="content">
				<div id="ag-bd">
					<jsp:doBody />
				</div>
			</div>
			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
		</div>
	</body>
</html>
