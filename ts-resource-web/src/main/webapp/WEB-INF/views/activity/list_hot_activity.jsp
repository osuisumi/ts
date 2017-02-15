<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="m-hot hot-act">
	<h3 class="tit-h3 hot-tit">
		热门活动<a onclick="listMoreHotActivity('${searchParam.paramMap.relationId}')">更多></a>
	</h3>
	<c:choose>
		<c:when test="${not empty activities }">
			<ul class="ul-hot-act" id="ul-hot-act">
				<c:forEach items="${activities }" var="activity">
					<li>
						<div class="li-tit u-first" style="display: block">
							<!-- <span class="u-new u-xk">必修</span>  -->
							<span class="u-tl">
								<c:choose>
									<c:when test="${activity.activityType eq 'discussion' }">
										[教学研讨]
									</c:when>
									<c:when test="${activity.activityType eq 'lesson_plan' }">
										[集体备课]
									</c:when>
									<c:when test="${activity.activityType eq 'jxgm' }">
										[教学观摩]
									</c:when>
								</c:choose>
							</span> 
							<a onclick="viewActivity('${activity.id}')" class="theme-tit">${activity.title }</a>
						</div>
					</li>
				</c:forEach>
			</ul>
		</c:when>
		<c:otherwise>
			<tag:noContent msg="暂未发布活动"  />
		</c:otherwise>
	</c:choose>
</div>
<script>
function listMoreHotActivity(relationId){
	$('#content').load('${ctx}/activity/listMoreHotActivity','orders=PARTICIPATE_NUM.DESC&paramMap[relationId]='+relationId);
}
</script>