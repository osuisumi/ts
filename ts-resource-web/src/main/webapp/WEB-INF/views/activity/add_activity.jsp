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
					<strong>添加活动</strong>
				</div>
				<script>
					$('.backName').text($('#backName').val());
				</script>
			</div>			
			<form id="saveActivityForm" method="post">
				<input type="hidden" class="relationType" value="${activity.activityRelations[0].relation.type}">
				<input type="hidden" class="relationId" value="${activity.activityRelations[0].relation.id }" />
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
									<div class="am-pb-tabli">
										<a class="tb1 z-crt" onclick="goAddActivity('discussion')">教学研讨</a> 
										<!-- <a class="tb2 " onclick="goAddActivity('lessonPlan')">集体备课</a> --> 
										<!-- <a class="tb3" onclick="goAddActivity('JXGM')">教学观摩</a> --> 
										<!-- <a class="tb4">公开课</a> -->
										<!-- <a class="tb5" onclick="addDebate()">辩论</a> -->
									</div>
									<script>
										$('.am-pb-tabli a').click(function(){
											$(this).siblings().removeClass('z-crt');
											$(this).addClass('z-crt');
										});
									</script>
									<div class="ag-pb-tabcon">
										<div class="ag-pb-tablst">
											<div class="ag-pb-lst">
												<div id="addActivityDiv" >
												
												</div>
												<div class="am-pb-mod">
													<div class="c-center">
														<div class="am-btnBlock">
															<a class="au-confirm-btn" onclick="saveActivity()">发布</a> 
															<a class="au-cancel-btn" onclick="cancel()">取消</a>
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
	goAddActivity('discussion');
});

function goAddActivity(type){
	if(type =="TKPK" || type == "JXGM"){
		$('#saveActivityForm .relationType').attr('name','coursewareRelations[0].relation.type');
		$('#saveActivityForm .relationId').attr('name','coursewareRelations[0].relation.id');
	}else{
		$('#saveActivityForm .relationType').attr('name',type+'Relations[0].relation.type');
		$('#saveActivityForm .relationId').attr('name',type+'Relations[0].relation.id');
	}
	if(type == 'discussion'){
		$('#addActivityDiv').load('${ctx}/discussion/create');
	}else if(type == 'lessonPlan'){
		$('#addActivityDiv').load('${ctx}/lesson_plan/create');
	}else if(type=='JXGM'){
		$('#addActivityDiv').load('${ctx}/courseware/create',"type=jxgm");
	}
}

function saveActivity() {
	if (!$('#saveActivityForm').validate().form()) {
		return false;
	}
	var data = $.ajaxSubmit('saveActivityForm');
	var json = $.parseJSON(data);
	if (json.responseCode == '00') {
		alert('操作成功！');
		cancel();
	}
}

function cancel(){
	if('${activity.activityRelations[0].relation.type}' == 'workshop'){
		viewWorkshop('${activity.activityRelations[0].relation.id}')
	}else{
		loadMySchoolIndex('activity');
	}
}
</script>