<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<shiro:hasRole name="${searchParam.paramMap.relationId}_master">
	<c:set var="hasMasterRole" value="true"  />
</shiro:hasRole>
<shiro:hasRole name="${searchParam.paramMap.relationId}_member">
	<c:set var="hasMemberRole" value="true"  />
</shiro:hasRole>
<div class="m-active">
	<h3 class="tit-h3">
		研修活动<a onclick="listMoreActivity('${searchParam.paramMap.relationId}')">更多&gt;</a>
	</h3>
	<c:if test="${hasMasterRole or hasMemberRole}">
		<a class="u-add" onclick="addActivity('${searchParam.paramMap.relationId}', 'workshop')"><i>+</i>添加研修活动</a>
	</c:if>
	<c:choose>
		<c:when test="${not empty activities }">
			<ul class="ul-act">
				<c:forEach items="${activities }" var="activity">
					<li>
						<div class="u-ac-num">
							<div class="num-top">
								<i></i>
							</div>
							<div class="num-bottom">${activity.activityRelations[0].replyNum }</div>
						</div>
						<div class="u-ac-con">
							<div class="con-tit">
								<a onclick="viewActivity('${activity.id}')">
									<c:choose>
										<c:when test="${activity.activityType eq 'discussion' }">
											【教学研讨】
										</c:when>
										<c:when test="${activity.activityType eq 'lesson_plan' }">
											【集体备课】
										</c:when>
										<c:when test="${activity.activityType eq 'jxgm' }">
											【教学观摩】
										</c:when>
									</c:choose>
									${activity.title }
								</a> 
								<c:if test="${activity.activityRelations[0].isTop eq 'Y' }">
									<span class="u-new up">顶</span> 
								</c:if>
								<c:if test="${activity.activityRelations[0].participateNum >= sipc:getProperty('activity.hot.standard') }">
									<span class="u-new hot">热</span> 
								</c:if>
								<c:if test="${activity.activityRelations[0].isEssence eq 'Y' }">
									<span class="u-new nice">精</span>
								</c:if>
								<c:if test="${activity.state eq 'auditing' }">
									<span class="u-new nopub">待审核</span>
								</c:if>
								<c:if test="${activity.state eq 'reject' }">
									<span class="u-new nopub">不通过</span>
								</c:if>
							</div>
							<div class="con-info-wrap">
                                <div class="con-info">
									<p class="u-p-num">
										<i></i>共有<b>${activity.activityRelations[0].participateNum }</b>人参与
									</p>
									<p class="u-time">
										<i></i>${sipc:prettyTime(activity.createTime)}
									</p>
								</div>
                                <div class="con-info-handle">
                                   <!--  <a href="javascript:void(0);">编辑</a>
                                    <i></i><a href="javascript:void(0);">删除</a>
                                    <i></i><a href="javascript:void(0);">置顶</a>
                                    <i></i><a href="javascript:void(0);">取消置顶</a>
                                    <i></i><a href="javascript:void(0);">加精</a>
                                    <i></i><a href="javascript:void(0);">取消精华</a>
                                    <i></i> -->
                                    <c:if test="${hasMasterRole}">
                                    	<c:choose>
                                    		<c:when test="${not (activity.activityRelations[0].isTop eq 'Y') }">
                                    			<a onclick="changeTop('${activity.id}','Y','${activity.activityRelations[0].id }')">置顶</a>
                                    		</c:when>
                                    		<c:otherwise>
                                    			<i></i><a onclick="changeTop('${activity.id}','N','${activity.activityRelations[0].id }')">取消置顶</a>
                                    		</c:otherwise>
                                    	</c:choose>
                                    	<c:choose>
                                    		<c:when test="${not (activity.activityRelations[0].isEssence eq 'Y') }">
                                    			<i></i><a onclick="changeEssence('${activity.id}','Y','${activity.activityRelations[0].id}')">加精</a>
                                    		</c:when>
                                    		<c:otherwise>
                                    			<i></i><a onclick="changeEssence('${activity.id}','N','${activity.activityRelations[0].id}')">取消精华</a>
                                    		</c:otherwise>
                                    	</c:choose>
                                    </c:if>
                                    <c:if test="${hasMasterRole and activity.state eq 'auditing' }">
                                    	<a onclick="updateActivity('${activity.id}', 'published')">审核通过</a>
                                   	 	<i></i>
                                   	 	<a onclick="updateActivity('${activity.id}', 'reject')">审核不通过</a>
                                    </c:if>
                                </div>
                            </div>
						</div>
					</li>
				</c:forEach>
			</ul>
		</c:when>
		<c:otherwise>
			<tag:noContent msg="暂未发布活动" />
		</c:otherwise>
	</c:choose>
</div>
<script>
function updateActivity(id, state){
	$.put('${ctx}/activity/'+id, 'state='+state, function(data){
		if(data.responseCode == '00'){
			alert('提交成功'); 
			listActivity();
		}
	});
}

function listMoreActivity(relationId){
	var hasMasterRole = "${hasMasterRole}";
	if(hasMasterRole == 'true'){
		$('#content').load('${ctx}/activity/listMoreActivity','orders=CREATE_TIME.DESC&paramMap[relationId]='+relationId+'&'+$('#roleForm').serialize());
	}else{
		$('#content').load('${ctx}/activity/listMoreActivity','paramMap[creator]=${sessionScope.loginer.id}&paramMap[others]=publishedOrCreator&orders=CREATE_TIME.DESC&paramMap[relationId]='+relationId+'&'+$('#roleForm').serialize());
	}
	
}
function changeTop(id,operation,rid){
	$.put('${ctx}/activity/'+id+'?activityRelations[0].id='+rid+'&activityRelations[0].isTop='+operation+"&"+$('#roleForm').serialize(),null,function(response){
			if(response.responseCode=='00'){
				$('#listActivityDiv').load('${ctx}/activity/listActivity','orders=IS_TOP.DESC,CREATE_TIME.DESC&paramMap[relationId]=${searchParam.paramMap.relationId}'); 
			}
	});
	
}

function changeEssence(id,operation,rid){
	$.put('${ctx}/activity/'+id+'?activityRelations[0].id='+rid+'&activityRelations[0].isEssence='+operation+"&"+$('#roleForm').serialize(),null,function(response){
			if(response.responseCode=='00'){
				$('#listActivityDiv').load('${ctx}/activity/listActivity','orders=IS_TOP.DESC,CREATE_TIME.DESC&paramMap[relationId]=${searchParam.paramMap.relationId}'); 
			}
	});
}


</script>