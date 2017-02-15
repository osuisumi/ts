<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<shiro:hasRole name="${searchParam.paramMap.relationId}_master">
	<c:set var="hasMasterRole" value="true"  />
</shiro:hasRole>
<form id="listMorePlanForm" action="${ctx }/plan/more">
	<input type="hidden" name="paramMap[relationId]" value="${searchParam.paramMap.relationId }">
	<input type="hidden" name="orders" value="${orders }">
    <div class="m-crm" style="height:20px;padding-left:0px;margin-top:5px">
      <span class="txt">您当前的位置： </span><a href="../../index.html" title="首页" class="u-goto-index">
          <i class="u-sHome-ico"></i>
      </a>
      <span class="trg">&gt;</span>
      <a onclick="workshopIndex()">工作室</a>
      <span class="trg">&gt;</span>
      <a onclick="viewWorkshop('${searchParam.paramMap.relationId}')"  class="backName"></a>
      <span class="trg">&gt;</span>
      <em>研修计划</em>
		<c:if test="${hasMasterRole }">
		<a  onclick="addTrainPlan()" class="add-study-plan main-btn btn">
			<i class="add-ico cmnt-ico"></i>发布研修计划
		</a>
		</c:if>
    </div>
	<script>
		$('.backName').text($('#backName').val());
	</script>
	<div id="ws-plan-listing" class="space-content-page">
		<div class="plan-time-shaft-mod cmnt-mod">
			<div class="cmnt-detail">
				<div class="timer-shaft">
					<c:choose>
						<c:when test="${empty plans }">
							<tag:noContent msg="目前暂研修训计划" />
						</c:when>
						<c:otherwise>
							<ul class="timer-shaft-list">
								<c:forEach items="${plans }" var="plan">
									<li class="block">
										<div class="timer-shaft-block">
											<div class="padding">
												<div class="timer-absolute">
													<span class="time">${sipc:formatDate(plan.planRelations[0].timePeriod.startTime.getTime(), 'MM月dd日') }</span> 
													<em>-</em> 
													<span class="time">${sipc:formatDate(plan.planRelations[0].timePeriod.endTime.getTime(),'MM月dd日') }</span> 
													<i class="circle-ico cmnt-ico"></i>
												</div>
												<div class="cont">
													<div class="infor">
														<div class="t clearfix">
															<p class="txt">
																<a onclick="viewPlan('${plan.id}')">${plan.title }</a>
															</p>
 															<c:if test="${hasMasterRole}">
																<a href="###" onclick="editPlan('${plan.id}')" class="alter-sp alter-opa">
																	<i class="alter-ico cmnt-ico"></i>编辑
																</a>
																<a href="###" onclick="deletePlan('${plan.id}','${searchParam.paramMap.relationId }')" class="alter-sp alter-opa">
																	<i class="alter-ico cmnt-ico"></i>删除
																</a>
															</c:if>
														</div>
													</div>
												</div>
											</div>
										</div>
									</li>
								</c:forEach>
							</ul>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
<div id="editPlanDiv" class="new-plan-layer layer"></div>
</form>
<script>

function addTrainPlan(){
	$('#editPlanDiv').load('${ctx}/plan/create.do','planRelations[0].relation.id=${searchParam.paramMap.relationId }',function() {
		commonCssUtils.openModelWindow($('#editPlanDiv'));
	});
}


</script>