<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="m-news-box">	
	<div class="m-news-slide big"  id="newsSilde">
		<c:choose>
			<c:when test="${not empty announcementImages}">
				<ul class="lst">
					<c:forEach items="${announcementImages }" var="announcementImage">
						<li>
							<a onclick="viewAnnouncement('${announcementImage.announcement.id}')" class="img"> 
							${announcementImage.imageUrl}
								<script type="text/javascript">console.log('${announcementImage.imageUrl}')</script>
							</a>
							<span class="shadow"></span>
							<a onclick="viewAnnouncement('${announcementImage.announcement.id}')" class="txt">${announcementImage.announcement.title}</a>
						</li>
					</c:forEach>
				</ul>
			
				<div class="focus">
					<c:if test="${not empty announcementImages}">
						<c:forEach items="${announcementImages }" var="announcementImage"
							varStatus="index">
							<c:choose>
								<c:when test="${index.index == 0}">
									<a href="javascript:void(0);" class="z-crt"></a>
								</c:when>
								<c:otherwise>
									<a href="javascript:void(0);" class=""></a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:if>
				</div>
			</c:when>
			<c:otherwise>
				<tag:noContent msg="没有相关资讯图片" />
			</c:otherwise>
		</c:choose>
	</div>	
	<div class="m-news-info big">
		<c:choose>
			<c:when test="${not empty announcements}">
				<div class="m-imp-news">
					<strong><a
						onclick="viewAnnouncement('${announcements[0].id}')">${announcements[0].title}</a></strong>
					<p>
						<a onclick="viewAnnouncement('${announcements[0].id}')">${sipc:split(announcements[0].content,announcements[0].id,1)}</a>
					</p>
				</div>
				<ul class="m-news-lst">
					<c:forEach items="${announcements }" var="announcement"
						varStatus="index" end="2">
						<c:if test="${index.index != 0 }">
							<li><a onclick="viewAnnouncement('${announcement.id}')">${announcement.title }</a></li>
						</c:if>
					</c:forEach>
				</ul>
			</c:when>
			<c:otherwise>
				<tag:noContent msg="没有相关资讯" />
			</c:otherwise>
		</c:choose>
	</div>
</div>
<!--end news box -->

<script>
	$(function() {
		//news silde
		$('#newsSilde').dsTab({
			itemEl : '.lst li',
			btnElName : 'focus',
			btnItem : 'a',
			currentClass : 'z-crt',
			maxSize : 5,
			changeType : 'fade',
			change : true,
			changeTime : 4000,
			autoCreateTab : false
		});
		// resourceChart(30,"chartMain");

	})
</script>


