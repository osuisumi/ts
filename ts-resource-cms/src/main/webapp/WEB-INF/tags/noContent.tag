<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="msg" type="java.lang.String" required="true"%>
<%@ attribute name="size" type="java.lang.String" required="false"%>
<div class="no-contents 
	<c:if test="${not empty size }">
		${size }
	</c:if> 
">
	<div class="g-center">
		<div class="no-contents-txt">
			<c:choose>
				<c:when test="${not empty msg }">
					${msg }
				</c:when>
				<c:otherwise>
					暂无数据
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>