<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div>
	<div>
		<div>
			<div style="text-align: center;">
				<h3>${announcement.title}</h3>
				<p><fmt:formatDate value="${announcement.publishTime}" pattern="yyyy-MM-dd" /></p>
			</div>
		</div>
		<div style="padding: 5px 30px 0 30px; overflow: auto;">
			<p>${announcement.content}</p> 
			<div style="margin-top: 50px;">
				<c:if test="${not empty announcement.fileInfos }">
					<span>附件：</span>
					<ul class="am-ful-lst" style="padding-left:20px;">
						<c:forEach items="${announcement.fileInfos}" var="fileInfo">
						<li class="fileLi success">
							<a class="txt">${fileInfo.fileName}</a>
						</li>
						</c:forEach>
					</ul>
				</c:if>
			</div>
		</div>
	</div>
</div>


