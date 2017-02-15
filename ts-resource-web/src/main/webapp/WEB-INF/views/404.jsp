<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-au-Compatible" content="IE=Edge,chrome=1">
<meta http-equiv="Window-target" content="_top">
<link rel="stylesheet" href="${ctx }/css/reset.css">
<link rel="stylesheet" href="${ctx }/css/style.css">
<title>404</title>
</head>
<body id="error404">
	<div id="wrap">
		<div class="errorPageWrap f-auto">
			<div class="error-content">
				<p class="txt">
					<c:choose>
						<c:when test="">
							哇哦，火箭把页面带走咯......<br /> 你访问的页面找不回来了~
						</c:when>
						<c:otherwise>
							${errorMsg }
						</c:otherwise>
					</c:choose>
				</p>
				<div class="btn-box">
					<a href="${retUrl }" class="btn">返回上一页</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>