<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<style>
.text-details .text-middle-cont img{
	display: block;
	margin: 0px auto;
	max-width: 100%;
}
</style>
<tag:mainLayout_yx>
<div id="space-course-index" class="space-content-page">
	<div class="text-contents">
		<div class="cmnt-text-mod cmnt-mod">
			<div class="cmnt-tit clearfix">
				<div class="cmnt-tit-nav clearfix">
					<a href="${ctx }/index.do" >首页</a>
					<span class="t-trag"></span>
					<c:choose>
						<c:when test="${announcement.announcementRelations[0].relation.id eq 'system' }">
							<c:choose>
								<c:when test="${announcement.type eq 'xxzn' }">
									<strong>学习指南详情</strong>
								</c:when>
								<c:otherwise>
									<strong>通知公告详情</strong>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<a onclick="viewWorkshop('${announcement.announcementRelations[0].relation.id}')" class="backName"></a>
							<span class="t-trag"></span>
							<strong>通知公告详情</strong>
						</c:otherwise>
					</c:choose>
				</div>
				<script>
					$('.backName').text($('#backName').val());
				</script>
			</div>
			<div class="cmnt-detail">
				<div class="text-details">
					<div class="text-top">
						<h3>${announcement.title }</h3>
						<div class="time">
							发布日期：${sipc:formatDate(announcement.createTime,"yyyy-MM-dd HH:mm") }
						</div>
					</div>
					<div class="text-middle-cont">
						${announcement.content }
						<br><br>
						<c:if test="${not empty announcement.fileInfos }">
							<div class="download-file">
								<span>点击此处下载：</span>
								<c:forEach items="${announcement.fileInfos }" var="file" varStatus="vs">
									<div><a href="#" onclick="downloadFile('${file.id}','${file.fileName}')">${file.fileName }</a></div>
								</c:forEach>
							</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</tag:mainLayout_yx>
