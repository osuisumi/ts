<%@ tag import="com.haoyu.sip.file.utils.FileUtils"%>
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<spring:url value="/images" var="imageUrl" />
<%@ attribute name="avatar" type="java.lang.String" required="true"%>
<c:choose>
	<c:when test="${not empty avatar}">
		<img src="<%=FileUtils.getHttpHost() %>${avatar}" alt="">
	</c:when>
	<c:otherwise>
		<img src="${imageUrl}/defaultAvatar.png" alt="">
	</c:otherwise>
</c:choose>

