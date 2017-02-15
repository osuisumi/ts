<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<shiro:hasRole name="${searchParam.paramMap.relationId}_master">
	<c:set var="hasMasterRole" value="true"  />
</shiro:hasRole>
<div id="editAnnouncementDiv" class="new-plan-layer layer"></div>
<form id="listMoreWorkshopAnnouncementForm" action="${ctx }/announcement/workshop/more">
	<input type="hidden" name="orders" value="${orders }">
	<input type="hidden" name="paramMap[type]" value="${searchParam.paramMap.type }">
	<input type="hidden" name="paramMap[relationId]" value="${searchParam.paramMap.relationId }">
	<input type="hidden" name="paramMap[relationType]" value="${searchParam.paramMap.relationType }">
    <div class="m-crm" style="height:20px;padding-left:0px;margin-top:5px">
        <span class="txt">您当前的位置： </span><a href="../../index.html" title="首页" class="u-goto-index">
            <i class="u-sHome-ico"></i>
        </a>
        <span class="trg">&gt;</span>
        <a onclick="workshopIndex()">工作室</a>
        <span class="trg">&gt;</span>
        <a onclick="viewWorkshop('${searchParam.paramMap.relationId}')"  class="backName"></a>
        <span class="trg">&gt;</span>
        <em>最新通知</em>
       	<c:if test="${hasMasterRole }">
			<a  onclick="addAnnouncement('${searchParam.paramMap.relationId}','2')" class="add-study-plan main-btn btn">
				<i class="add-ico cmnt-ico"></i>发布通知公告
			</a>
		</c:if>
    </div>
	<script>
		$('.backName').text($('#backName').val());
	</script>
	<div id="st-notice-listing" class="space-content-page">
		<div class="page-notice-mod cmnt-mod" style="min-height: 500px;">
			<div class="cmnt-detail">
				<c:choose>
					<c:when test="${empty announcements }">
						<div class="no-contents">
							<div class="g-center">
								<div class="no-contents-txt">目前暂无数据！</div>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<ul class="space-notice-list has-dot has-r">
							<c:forEach items="${announcements }" var="announcement">
								<li class="line"><i class="dots"></i> 
									<a href="#" class="title" onclick="viewAnnouncement('${announcement.id}','${announcement.announcementRelations[0].id }')" title="${announcement.title }"> ${announcement.title }</a>
										<c:if test="${hasMasterRole}">
											<span id="editAnnouncementDiv" style="margin-left: 20px;">
												<a href="###" onclick="editWorkshopAnnouncement('${announcement.id}')" style="color:#2a90ed; margin: 0 10px;" >
													<i style="margin-right: 5px;" class="alter-ico cmnt-ico"></i>编辑
												</a>
												<a style="color:#2a90ed; margin: 0 10px;" href="###" onclick="deleteWorkshopAnnouncement('${announcement.id}','${searchParam.paramMap.relationId}')"  style="color:#2a90ed;">
													<i style="margin-bottom: -3px; margin-right: 5px;" class="delete-ico cmnt-ico"></i>删除
												</a>
											</span>
										</c:if>
									<span class="time"><i class="time-ico cmnt-ico"></i>${sipc:formatDate(announcement.createTime,'yyyy/MM/dd') }</span> 
								</li>
							</c:forEach>
						</ul>
					</c:otherwise>
				</c:choose>
				<jsp:include page="/WEB-INF/views/include/pagination.jsp">
					<jsp:param value="listMoreWorkshopAnnouncementForm" name="pageForm" />
					<jsp:param value="ajax" name="type" />
					<jsp:param value="content" name="divId" />
					<jsp:param value="announcementsPaginator" name="paginatorName" />
				</jsp:include> 
			</div>
		</div>
	</div>
</form>
<script>
	function viewWorkshopAnnouncement(id){
		window.open($('#ctx').val()+"/announcement/workshop/"+id+"/view");
	}
	
	function editWorkshopAnnouncement(id){
		$('#editAnnouncementDiv').load('${ctx}/announcement/'+id+'/edit','',function(){
			commonCssUtils.openModelWindow($('#editAnnouncementDiv'));
		});
	}
</script>
