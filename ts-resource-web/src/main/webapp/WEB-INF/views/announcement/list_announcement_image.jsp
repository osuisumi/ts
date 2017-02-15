<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="g-mn-mod" style="height:185px">
	<div class="m-news-box">
		<c:choose>
			<c:when test="${empty announcements }">
				<tag:noContent msg="暂无资讯"  />
			</c:when>
			<c:otherwise>
				<div class="m-news-slide" id="newsSilde">
					<c:choose>
						<c:when test="${not empty announcementImages}">
							<ul class="lst">
								<c:forEach items="${announcementImages }" var="announcementImage">
									<li><a onclick="viewAnnouncement('${announcementImage.announcement.id}')" class="img figure"> ${announcementImage.imageUrl} </a> <span class="shadow"></span> <a onclick="viewAnnouncement('${announcementImage.announcement.id}')" class="txt">${announcementImage.announcement.title }</a></li>
								</c:forEach>
							</ul>
						</c:when>
					</c:choose>
					<div class="focus">
						<c:if test="${not empty announcementImages}">
							<c:forEach items="${announcementImages }" var="announcementImage" varStatus="index">
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
				</div>
				<div class="m-news-info">
					<c:if test="${not empty announcements }">
						<div class="m-imp-news">
							<strong><a onclick="viewAnnouncement('${announcements[0].id}')">${announcements[0].title}</a></strong>
							<p>
								<a onclick="viewAnnouncement('${announcements[0].id}')">${sipc:split(announcements[0].content,announcements[0].id,1)}</a>
							</p>
						</div>
						<ul class="m-news-lst">
							<c:forEach items="${announcements }" var="announcement" varStatus="index" end="2">
								<c:if test="${index.index != 0 }">
									<li><a onclick="viewAnnouncement('${announcement.id}')">${announcement.title }</a></li>
								</c:if>
							</c:forEach>
						</ul>
					</c:if>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<script>
$(function(){
    //news silde
    $('#newsSilde').dsTab({
        itemEl        : '.lst li',
        btnElName     : 'focus',
        btnItem       : 'a',
        currentClass  : 'z-crt',
        maxSize       : 5,
        changeType    : 'fade',
        change        : true,
        changeTime    : 4000,
        autoCreateTab : false
    });
   // resourceChart(30,"chartMain");

})
</script>


