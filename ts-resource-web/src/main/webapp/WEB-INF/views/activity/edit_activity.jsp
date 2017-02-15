<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<shiro:hasRole name="${activity.activityRelations[0].relation.id }_master">
	<c:set var="hasMasterRole" value="true" />
</shiro:hasRole>
<div id="g-bd">
	<div class="f-auto">
		<div class="innerPage">
			<div class="g-crm">
				<div class="m-crm">
					<a class="go-home" href="${ctx }/index.do"><i class="u-home"></i>首页</a>
					<span>&gt;</span>
					<a onclick="viewWorkshop('${activity.activityRelations[0].relation.id}')" class="backName"></a>
					<span>&gt;</span>
					<strong>编辑活动</strong>
				</div>
				<script>
					$('.backName').text($('#backName').val());
				</script>
			</div>			
			<form id="saveActivityForm" method="post">
				<c:choose>
					<c:when test="${hasMasterRole }">
						<input type="hidden" name="state" value="published" />
					</c:when>
					<c:otherwise>
						<input type="hidden" name="state" value="auditing" />
					</c:otherwise>
				</c:choose>
				<div class="g-innerPage-dt">
					<div class="ag-activity">
						<div class="ag-activity-bd">
			        	    <div class="ag-pmain">
								<div class="ag-pb-tabs">
									<div class="ag-pb-tabcon">
										<div class="ag-pb-tablst">
											<div class="ag-pb-lst">
												<div id="editActivityDiv" class="g-pb-lst">
											
												</div>
												<div class="am-pb-mod">
													<div class="c-center">
														<div class="am-btnBlock">
															<a class="au-confirm-btn" onclick="saveActivity()">发布活动</a> 
															<a class="au-cancel-btn" onclick="viewActivity('${activity.id}');">取消</a>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<script>
$(function(){
	if('${activity.activityType}' == 'discussion'){
		$('#editActivityDiv').load('${ctx}/discussion/${activity.entityId}/edit');
	}else if('${activity.activityType}' == 'lesson_plan'){
		$('#editActivityDiv').load('${ctx}/lesson_plan/${activity.entityId}/edit');
	}else if('${activity.activityType}' == 'assignment'){
		$('#editActivityDiv').load('${ctx}/assignment/${activity.entityId}/edit');
	}else if('${activity.activityType}' == 'jxgm'){
		$('#editActivityDiv').load('${ctx}/courseware/${activity.entityId}/edit',"type=jxgm");
	}
});

function saveActivity() {
	if (!$('#saveActivityForm').validate().form()) {
		return false;
	}
	var data = $.ajaxSubmit('saveActivityForm');
	var json = $.parseJSON(data);
	if (json.responseCode == '00') {
		alert('操作成功！');
		viewActivity('${activity.id}');
	}
}
</script>