<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="m-mod-tt">
	<h2 class="tt">
		<i class="u-tt-ico ico17"></i>站内通知
	</h2>
</div>
<div class="g-mod-dt">
	<ul class="m-news-lst">
		<c:forEach items="${announcements }" var="announcement">
			<li class="item">
				<div class="block">
					<a href="javascript:void(0);" onclick="viewAnnouncement('${announcement.id}')">${announcement.title }</a> 
					<span class="time">${sipc:formatDate(announcement.createTime, 'yyyy-MM-dd') }</span>
				</div>
			</li>
		</c:forEach>
	</ul>
</div>
<script>
function viewAnnouncement(id) {
	var url = '${ctx}/announcement/' + id + '/view';
	easyui_modal_open('viewAnnouncementDiv', '查看通知', 800, 600, url, true);
}
</script>