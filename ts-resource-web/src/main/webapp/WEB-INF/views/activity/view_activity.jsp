<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<shiro:hasRole name="${activity.activityRelations[0].relation.id }_master">
	<c:set var="hasMasterRole" value="true" />
</shiro:hasRole>
<shiro:hasRole name="${activity.activityRelations[0].relation.id }_member">
	<c:set var="hasMemberRole" value="true" />
</shiro:hasRole>
<form id="activityDataForm">
	<input id="aid" type="hidden" name="aid" value="${activity.id }">
	<input id="rid" type="hidden" name="rid" value="${activity.activityRelations[0].relation.id }">
	<input type="hidden" name="activityType" value="${activity.activityType }">
	<input type="hidden" name="entityId" value="${activity.entityId }">
</form>
<div id="viewActivityDiv">

</div>
<script>
$(function(){
	$('#hasMasterRole').val('${hasMasterRole}');
	/* $('#hasAssistRole').val('${hasAssistRole}'); */
	$('#hasMemberRole').val('${hasMemberRole}');
	$('#inCurrentDate').val('${sipc:hasBegun(activity.activityRelations[0].timePeriod.startTime) and not sipc:hasEnded(activity.activityRelations[0].timePeriod.endTime) }');
	
	if('${activity.activityType}' =='discussion'){
		$('#viewActivityDiv').load('${ctx}/discussion/${activity.entityId}/view',$('#roleForm').serialize());
	}else if('${activity.activityType}' == 'lesson_plan'){
		$('#viewActivityDiv').load('${ctx}/lesson_plan/${activity.entityId}/view',$('#roleForm').serialize());
	}else if('${activity.activityType}' == 'assignment'){
		if('${hasMasterRole}' == 'true'){
			$('#viewActivityDiv').load('${ctx}/assignment/user','assignment.id=${activity.entityId}&relation.id=${activity.activityRelations[0].relation.id}');
		}else{
			$('#viewActivityDiv').load('${ctx}/assignment/${activity.entityId}/view',$('#roleForm').serialize());
		}
	}else if('${activity.activityType}' == 'jxgm'){
		$('#viewActivityDiv').load('${ctx}/courseware/${activity.entityId}/view',"type=jxgm&"+$('#roleForm').serialize());
	}
});
</script>