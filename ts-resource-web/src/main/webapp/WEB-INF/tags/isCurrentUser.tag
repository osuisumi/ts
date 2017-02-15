<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<%@ attribute name="userId" type="java.lang.String" required="true"%>
<%@ tag import="org.apache.shiro.subject.*,java.util.*"  %>
<%@ tag import="org.apache.shiro.SecurityUtils"  %>
<shiro:user> 
	<c:if test="${not empty userId}">
		<%
			Subject subject = SecurityUtils.getSubject();
			PrincipalCollection principals = subject.getPrincipals();
			List<Object> listPrincipals = principals.asList();
			if(listPrincipals!=null&&listPrincipals.size()>1){
				Map<String, String> attributes = (Map<String, String>) listPrincipals.get(1);
				String id = attributes.get("id");
				if(id.equals(userId)){
		%>
			<jsp:doBody />
		<%} }%>
	</c:if>
</shiro:user>