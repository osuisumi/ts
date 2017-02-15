<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div id="g-wrap">
	<div id="g-content-wp">
		<div class="g-content-inner">
			<div class="container-fluid">
				<div class="g-inner-mod">
					<ul class="g-dashboard-lst">
						<li class="item">
							<a href="javascript:void(0);" onclick="addResource()" class="m-dashboard-stats stats1"> 
								<span class="ico"></span> <strong>上传资源</strong>
							</a> 
						</li>
						<li class="item">
							<a href="javascript:void(0);" onclick="addAnnouncement('2','${sessionScope.loginer.deptId}', 'school')" class="m-dashboard-stats stats2"> 
								<span class="ico"></span> <strong>发布资讯</strong>
							</a>
						</li>
						<li class="item">
							<a href="javascript:void(0);" onclick="addDiscovery()" class="m-dashboard-stats stats3"> 
								<span class="ico"></span> <strong>分享发现</strong>
							</a> 
						</li>
						<li class="item">
							<a href="javascript:void(0);" onclick="addCompetition()" class="m-dashboard-stats stats4"> 
								<span class="ico"></span> <strong>创建活动</strong>
							</a> 
						</li>
					</ul>
				</div>
				<div id="listAnnouncementDiv" class="g-inner-mod">
					<script>
						$('#listAnnouncementDiv').load('${ctx}/announcement/listHomeAnnouncement','paramMap[type]=1&paramMap[relationType]=bms&paramMap[state]=1');
					</script>
				</div>
				<div id="statisticDiv" class="g-inner-mod">
					<script>
						$(function(){
							$('#statisticDiv').load('${ctx}/loadStatistic');
						});
					</script>
				</div>
			</div>
		</div>
		<%-- <jsp:include page="/WEB-INF/views/include/footer.jsp" /> --%>
	</div>
</div>
<script>
function addResource() { 
	var url = '${ctx}/resource/addResource?type=sync';
	easyui_modal_open('editResourceDiv', '新增资源', 800, 600, url, true);
}

function addAnnouncement(type,relationId, relationType) {
	var url = '${ctx}/announcement/create?announcementRelations[0].relation.id=' + relationId+'&type='+type+'&announcementRelations[0].relation.type='+relationType;
	easyui_modal_open('editAnnouncementDiv', '发布通知', 800, 680, url, true);
}

function addDiscovery(){
	var url = '${ctx}/discovery/create';
	easyui_modal_open('editDiscoveryDiv', '新增资源', 800, 500, url, true);
}

function addCompetition() {
	var url = '${ctx}/competition/create';
	easyui_modal_open('editCompetitionDiv', '新增活动', 800, 500, url, true);
}
</script>