<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<shiro:hasRole name="${searchParam.paramMap.relationId}_master">
	<c:set var="hasMasterRole" value="true"  />
</shiro:hasRole>
<div class="m-new-notice">
	<div class="notice-tit">
		<h3>
			最新通知<a onclick="listMoreWorkshopAnnouncement('${searchParam.paramMap.relationId}','workshop')">更多&gt;</a>
		</h3>
		<c:if test="${hasMasterRole }">
			<a class="u-add" onclick="addAnnouncement('${searchParam.paramMap.relationId}','2')"><i>+</i>添加通知</a>
		</c:if>
	</div>
	<c:choose>
		<c:when test="${not empty announcements }">
			<ul>
				<c:forEach items="${announcements }" var="announcement">
					<li>
						<i class="li-bg"></i> 
						<a class="ntc-txt" onclick="viewAnnouncement('${announcement.id}','${announcement.announcementRelations[0].id }')">${announcement.title }</a>
						<c:if test="${empty announcement.announcementUser }">
							<i class="u-new">新</i> 
						</c:if>
						<span class="ntc-dt">${sipc:formatDate(announcement.createTime, 'MM/dd') }</span>
					</li>
				</c:forEach>
			</ul>
		</c:when>
		<c:otherwise>
			暂无通知
		</c:otherwise>
	</c:choose>
</div>
<div id="editAnnouncementDiv" class="add-specia-layer layer"></div>
<script>

</script>