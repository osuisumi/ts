<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<shiro:hasRole name="${searchParam.paramMap.relationId }_master">
	<c:set var="hasMasterRole" value="true"  />
</shiro:hasRole>
<div class="m-new-notice m-plan" style="margin-left:10px">
	<h3>
		<i class="u-pl"></i>研修计划
	</h3>
	<c:choose>
		<c:when test="${not empty plan }">
			<p class="pl-dt">
				${sipc:formatDate(plan.planRelations[0].timePeriod.startTime.getTime(), 'MM.dd') }
				&nbsp;至&nbsp;
				${sipc:formatDate(plan.planRelations[0].timePeriod.endTime.getTime(), 'MM.dd') }
			</p>
			<a onclick="viewPlan('${plan.id}')">
			<p class="pl-txt">${plan.title }</p>
			</a>
		</c:when>
		<c:otherwise>
			<p class="pl-dt">暂无研修计划</p>
		</c:otherwise>
	</c:choose>
		<c:choose>
			<c:when test="${hasMasterRole }">
				<a class="u-mg-pl" onclick="listMorePlan('${searchParam.paramMap.relationId }')"><i></i>管理计划</a>
			</c:when>
			<c:otherwise>
				<a class="u-more" onclick="listMorePlan('${searchParam.paramMap.relationId }')">查看全部计划<i></i></a>
			</c:otherwise>
		</c:choose>
</div>
<script>
function listMorePlan(relationId){
	$('#content').load('${ctx}/plan/more.do','orders=CREATE_TIME.DESC&paramMap[relationId]='+relationId);
}

function viewPlan(id) {
	$("#content").load('${ctx}/plan/'+id+'/view.do');
}


</script>