<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="listMoreActivityForm" action="${ctx }/activity/listMoreHotActivity">
	<input type="hidden" name="orders" value="${orders}">
	<input type="hidden" name="paramMap[relationId]" value="${searchParam.paramMap.relationId }">
    <div class="m-crm" style="height:20px;padding-left:0px;margin-top:5px">
       <span class="txt">您当前的位置： </span><a href="../../index.html" title="首页" class="u-goto-index">
           <i class="u-sHome-ico"></i>
       </a>
       <span class="trg">&gt;</span>
       <a onclick="workshopIndex()">工作室</a>
       <span class="trg">&gt;</span>
       <a onclick="viewWorkshop('${searchParam.paramMap.relationId}')"  class="backName"></a>
       <span class="trg">&gt;</span>
       <em>研修活动</em>
    </div>
	<script>
		$('.backName').text($('#backName').val());
	</script>
	<div id="at-activity-listing" class="space-content-page">
		<div class="cmnt-activity-mod cmnt-mod">
			<div class="cmnt-detail">
				<c:choose>
					<c:when test="${empty activities }">
						<tag:noContent msg="暂未发布活动" />
					</c:when>
					<c:otherwise>
						<ul class="activity-list">
							<c:forEach items="${activities }" var="activity">
								<li class="block">
									<div class="activity-block">
										<div class="t">
											<a href="###" onclick="viewActivity('${activity.id}')" title="${activity.title }" class="title"> 
												<c:choose>
													<c:when test="${activity.activityType eq 'discussion' }">
														【教学研讨】
													</c:when>
													<c:when test="${activity.activityType eq 'lessonPlan' }">
														【集体备课】
													</c:when>
													<c:when test="${activity.activityType eq 'jxgm' }">
														【教学观摩】
													</c:when>
												</c:choose>
												${activity.title }
											</a>
											<%-- <c:if test="${activity.activityRelations[0].isTop eq 'Y' }">
												<i class="s-type-piece blue">顶</i>	
											</c:if>
											<c:if test="${activity.activityRelations[0].isEssence eq 'Y' }">
												<i class="s-type-piece green">精</i>	
											</c:if> --%>
											<c:if test="${activity.activityRelations[0].participateNum >= sipc:getProperty('activity.hot.standard') }">
												<i class="s-type-piece orange">热</i>
											</c:if>
											<c:if test="${activity.state eq 'auditing' }">
												<i class="s-type-piece red">待审核</i>
											</c:if>
											<c:if test="${activity.state eq 'reject' }">
												<i class="s-type-piece red">不通过</i>
											</c:if>
										</div>
										<div class="b">
											<div class="l">
												<span class="time"> 
													<i class="time-ico cmnt-ico"></i> <em>${sipc:prettyTime(activity.createTime)}</em>
												</span>
											</div>
											<div class="t-opa space-opa" style="padding-left: 120px;">
												<%-- <c:if test="${hasMasterRole and activity.state eq 'published'}">
													<c:choose>
														<c:when test="${activity.isTop eq 'Y' }">
															<a href="###" onclick="updateActivityState('isTop','N','${activity.id}')">取消置顶</a>
														</c:when>
														<c:otherwise>
															<a href="###" onclick="updateActivityState('isTop','Y','${activity.id}')">置顶</a>
														</c:otherwise>
													</c:choose>
													<span class="halving">|</span>
													<c:choose>
														<c:when test="${act.isEssence eq 'Y' }">
															<a href="###" onclick="updateActivityState('isEssence','N','${activity.id}')">取消设为精华</a>
														</c:when>
														<c:otherwise>
															<a href="###" onclick="updateActivityState('isEssence','Y','${activity.id}')">设为精华</a>
														</c:otherwise>
													</c:choose>
												</c:if>
												<c:if test="${hasMasterRole or (hasMemberRole and activity.creator eq sessionScope.loginer.id) }">
													<a href="###" onclick="goEditActivity('${act.id}')">编辑</a>
													<span class="halving">|</span>
													<a href="###" onclick="removeActivity('${act.id}')">删除</a>
												</c:if> --%>
												<c:if test="${hasMasterRole and activity.state eq 'auditing' }">
													<span class="halving">|</span>
													<a href="###" onclick="updateActivity('${activity.id}', 'published')">审核通过</a>
													<span class="halving">|</span>
													<a href="###" onclick="auditActivity('${activity.id}', 'reject')">审核不通过</a>
												</c:if>
											</div>
										</div>
									</div> 
								</li>
							</c:forEach>
						</ul>
						<jsp:include page="/WEB-INF/views/include/pagination.jsp">
							<jsp:param value="listMoreActivityForm" name="pageForm" />
							<jsp:param value="ajax" name="type" />
							<jsp:param value="content" name="divId" />
							<jsp:param value="activitiesPaginator" name="paginatorName" />
						</jsp:include>
					</c:otherwise>
				</c:choose>		
			</div>
		</div>
	</div>
</form>
<script>
$(function() {
	/*haoyuJs.selectSearchBox.init();
	
	$('.h-block a').click(function(){
		$('#activityType').val($(this).attr('name'));
	});
	
	$('.h-block a[name=${searchParam.paramMap.activityType}]').trigger('click');*/
});

function updateActivity(id, state){
	$.put('${ctx}/activity/'+id, 'state='+state, function(data){
		if(data.responseCode == '00'){
			alert('提交成功'); 
			$.ajaxQuery('listMoreActivityForm','content');
		}
	});
}

function goEditActivity(activityId){
	$('#content').load('${ctx}/workshop/editActivity.do','id='+activityId);
}

function removeActivity(activityId){
	confirm('确定要删除活动吗?',function(){
		$.ajax({
			url:'${ctx}/activity/removeActivity.do',
			type:'post',
			data:'id='+activityId,
			success:function(data){
				var json = $.parseJSON(data);
				if(json.responseCode == '00'){
					alert('删除成功');
					$.ajaxQuery('listMoreActivityForm','content');
				}
			}
		});
	});
}


function searchActivity(){
	$('#listMoreActivityForm input[name="pagination.currentPage"]').val(1);
	$.ajaxQuery('listMoreActivityForm','content');
}
</script>