<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="discussionPostForm" action="${ctx}/board/discussion/post">
<input class="relationId" type="hidden" name="paramMap[discussionRelationId]" value="${searchParam.paramMap.discussionRelationId}">
<input id="totalPage" type="hidden" value="${discussionPostsPaginator.totalCount}">
<input id="relationId" type="hidden" value="${searchParam.paramMap.relationId}">
<c:choose>
	<c:when test="${empty page[0]}">
		<c:set var="page" value="0"></c:set>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${page[0] eq 0 }">
				<c:set var="page" value="0"></c:set>
			</c:when>
			<c:otherwise>
				<c:set var="page" value="${page[0]-1}"></c:set>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>
<c:forEach items="${discussionPosts}" var="discussionPost" varStatus="index">
	<div class="mod clearfix discussionPost">
		<input class="mainPostId" type="hidden" value="${discussionPost.id}">
		<div class="col_l">
			<a class="pic" href="#"><tag:avatar userId="${discussionPost.creator.id}" avatar="${discussionPost.creator.avatar }"></tag:avatar></a> <a class="name" href="#">${discussionPost.creator.realName}</a>
		</div>
		<div class="col_r clearfix">
			<p class="txt1">
				<span class="u-time">发表于：${sipc:prettyTime(discussionPost.createTime)}</span><span id="floor${10*page+index.index+1}" value="${10*page+index.index+1}" class="u-floor">${10*page+index.index+1}楼</span>
			</p>
			${discussionPost.content}
			<div class="operate clearfix">
				<div class="btn second-reply attitude_num">
					<a class="reply" onclick="loadChildDiscussionPost('discussionChildPost${index.index}','${discussionPost.id }')">回复(<span class="replyCount">${discussionPost.childPostCount}</span>)</a> <a onclick="attitude_support('${discussionPost.id}','discussionPost',this)" class="agree" value="${discussionPost.id }">赞同(<span class="sup_num">${discussionPost.supportNum }</span>)</a>
				</div>
				<div id="discussionChildPost${index.index}" class="pop_reply"></div>
			</div>
		</div>
	</div>
</c:forEach>
		<div class="am-pageturn">
			<jsp:include page="/WEB-INF/views/include/pagination.jsp">
				<jsp:param value="discussionPostForm" name="pageForm" />
				<jsp:param value="discussionPostsPaginator" name="paginatorName" />
				<jsp:param value="discussionPostDiv" name="divId" />
				<jsp:param value="ajax" name="type" />
			</jsp:include>
		</div>
</form>

<script>
	$(function() {
		showReply();
		$('#discussionPost').find('.relationId').val($('#relationId').val());
	})
	//定位回复
	$(function(){
		var targetId = $('#targetId').val();
		if(targetId!=''){
			if(!isNaN(targetId)){
				var floor = document.getElementById('floor'+targetId);
				if(floor != null){
					floor.scrollIntoView();
				}
			}
		}
	})
	
	function showReply() { //显示回复内容
		var btn = $(".second-reply .reply");
		var con = $(".pop_reply");
		btn.on('click', function() {
			var _this = $(this);
			var pop_reply = _this.parent().siblings(".pop_reply");
			if (!_this.hasClass("cur")) {
				btn.removeClass("cur");
				con.hide();
				_this.addClass("cur");
				_this.parent().siblings(".pop_reply").show();
			} else {
				_this.removeClass("cur");
				_this.parent().siblings(".pop_reply").hide();
			}
		});
	}
	//子回复
	function saveChildDiscussionPost(btn){
		var mainPostId = $(btn).closest('.discussionPost').find('.mainPostId').val();
		var content = $(btn).prev('textarea').val();
		var targetId = $(btn).closest('.discussionPost').find('.u-floor').attr('value');
		$.post('${ctx}/board/discussion/post/save',{
			"discussionUser.discussionRelation.discussion.id":$('#discussionId').val(),
			"discussionUser.discussionRelation.relation.id":$('#relationId').val(),
			"discussionUser.discussionRelation.relation.type":$('#relationType').val(),
			"discussionUser.discussionRelation.id":$('#relation_Id').val(),
			"content":content,
			"mainPostId":mainPostId,
			"targetId":targetId
		},function(response){
			if(response.responseCode == '00'){
				alert('操作成功');
				$(btn).closest('.pop_reply').load('${ctx}/board/discussion/post/child?paramMap[mainPostId]='+mainPostId);
				var replyCountSpan = $(btn).closest('.discussionPost').find('.replyCount');
				replyCountSpan.text(parseInt(replyCountSpan.text())+1);
			}
		});
	}
	
	$(function(){
		$('.txt1').nextAll('p').attr('class','txt');
	})
	
	function loadChildDiscussionPost(childDiscussionPostDiv,mainPostId){
		$('#'+childDiscussionPostDiv).load('${ctx}/board/discussion/post/child?paramMap[mainPostId]='+mainPostId+'&paramMap[relationId]=${searchParam.paramMap.relationId}');
	}
	
</script>

