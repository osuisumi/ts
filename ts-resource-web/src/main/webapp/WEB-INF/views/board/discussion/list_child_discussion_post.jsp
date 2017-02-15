<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<shiro:hasRole name="${searchParam.paramMap.relationId }_master">
	<c:set var="hasMasterRole" value="true"></c:set>
</shiro:hasRole>
<form id="discussionChildPostForm" action="${ctx}/board/discussion/post/child">
	<div>
		<ul class="reply_con">
			<c:forEach items="${childPosts}" var="childPost">
				<li class="clearfix"><a class="pop_pic" href="#"><tag:avatar userId="${discussionPost.creator.id }" avatar="${discussionPost.creator.avatar }"></tag:avatar></a>
					<div class="pop_txt">
						<p>
							<a class="name" href="#">${childPost.creator.realName}：</a> ${childPost.content}
						</p>
						<p class="operation">
								<span class="time">${sipc:prettyTime(childPost.createTime)}</span>
								<c:if test="${(sessionScope.loginer!=null && (sessionScope.loginer.id eq childPost.creator.id)) || hasMasterRole}">
									<a class="reply" onclick="deleteDiscussionChildPost('${childPost.id}','${childPost.mainPostId }',this)"><i class="u-del"></i>删除</a>
								</c:if>
						</p>
					</div></li>
			</c:forEach>
		</ul>
		<c:choose>
			<c:when test="${empty sessionScope.loginer }">
				<div class="m-sd-dt">
					<div class="u-user-logn">
						<p>
							您需要登录后方可评论，请<a onclick="goLoginForDiscussionChildPost(this)">登录</a>
						</p>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="reply_fra">
					<textarea placeholder="请输入回复的内容"></textarea>
					<a class="reply_fra_btn" onclick="saveChildDiscussionPost(this)">确定回复</a>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</form>
<script>
	function deleteDiscussionChildPost(id,mainPostId,a){
		$.ajaxDelete("${ctx}/board/discussion/post/"+id+"?mainPostId="+mainPostId+"&discussionUser.discussionRelation.relation.id="+$('#boardId').val(),{
		
		},function(response){
			if(response.responseCode == '00'){
				alert('删除成功');
				var replyCountSpan = $(a).closest('.discussionPost').find('.replyCount');
				replyCountSpan.text(parseInt(replyCountSpan.text())-1);
				$(a).closest('.clearfix').remove();
			}
		});
	}
	
	function goLoginForDiscussionChildPost(a){
		var mainPostId = $(a).closest('.discussionPost').find('.u-floor').attr('value');
		goLogin(function(){
			//$('#content').load("${ctx}/board/discussion/"+$('#discussionId').val()+"/view","targetId="+mainPostId+"&page="+Math.ceil(mainPostId/10));
			window.location.href = "${ctx}/board/discussion/"+$('#discussionId').val()+"/view"+"?targetId="+mainPostId+"&page="+Math.ceil(mainPostId/10);
		});
	}
</script>