<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="msg" type="java.lang.String" required="true"%>
<%@ attribute name="top" type="java.lang.String" required="false"%>
<%@ attribute name="height" type="java.lang.String" required="false"%>
<div class="m-no-res" style="<c:if test='${not empty top }'>margin-top:${top }px</c:if><c:if test='${not empty height }'>height:${height }px</c:if>">
       <div class="u-nores-bg">
       	<p>
			<c:choose>
				<c:when test="${not empty msg }">
					${msg }
				</c:when>
				<c:otherwise>
					暂无数据
				</c:otherwise>
			</c:choose>
		</p>
	</div>
</div>

