<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="hasMasterRole" value="${sipc:getBooleanFromRequest(pageContext.request, 'hasMasterRole') }" /> 
<c:set var="hasMemberRole" value="${sipc:getBooleanFromRequest(pageContext.request, 'hasMemberRole') }" /> 
<c:set var="inCurrentDate" value="${sipc:getBooleanFromRequest(pageContext.request, 'inCurrentDate') }" />
<c:if test="${inCurrentDate and (hasMasterRole or hasMemberRole)  }">
	<div class="am-comment-box am-ipt-mod">
		<label>
			<span class="comment-placeholder"></span>
			<textarea id="postContent" class="au-textarea" style="height:40px"></textarea>
		</label>
		<div class="am-cmtBtn-block f-cb">
			<a onclick="savePost()" class="u-cmtPublish-btn au-confirm-btn1">发表</a>
		</div>
	</div>
</c:if>
<form id="listDiscussionPostForm" action="${ctx }/discussion/post">
	<input type="hidden" name="paramMap[discussionRelationId]" value="${searchParam.paramMap.discussionRelationId }">
	<input type="hidden" name="paramMap[discussionId]" value="${searchParam.paramMap.discussionId }">
	<input type="hidden" name="paramMap[relationId]" value="${searchParam.paramMap.relationId }">
	<input type="hidden" name="orders" value="${orders[0] }">
	<input type="hidden" name="hasMasterRole" value="${hasMasterRole }">
	<input type="hidden" name="hasMemberRole" value="${hasMemberRole }">
	<input type="hidden" name="inCurrentDate" value="${inCurrentDate }">
	<div class="ag-comment-layout">
		<div class="am-coment-tp">
			<div class="c-sttc1">
				已有&nbsp;<strong id="discussionPostReplyNumTxt"></strong>&nbsp;条评论
			</div>
			<div class="am-slt-sort" id="listDiscussionPostByOrderOpa">
				<a orders="CREATE_TIME.DESC" class="orderOpa" onclick="searchForm(this)">时间</a> 
				<a orders="CHILD_POST_COUNT.DESC" class="orderOpa" onclick="searchForm(this)">评论数</a> 
				<!-- <a orders="SUPPORT_COUNT.DESC" class="orderOpa" onclick="searchForm(this)">点赞数</a> -->
				<script>
					$('.am-slt-sort a').removeClass('z-crt');
					$('.am-slt-sort a[orders="${orders[0]}"]').addClass('z-crt');
				</script>
			</div>
		</div>
		<div class="ag-comment-main">
			<c:choose>
				<c:when test="${empty discussionPosts }">
					<div class="ag-no-content ag-no-comment">
	                    <p>还没有其他评论，快成为第一个提出评论的人~</p>
	                </div>
				</c:when>
				<c:otherwise>
					<ul class="ag-cmt-lst ag-cmt-lst-p">
						<c:forEach items="${discussionPosts }" var="post">
							<li class="am-cmt-block">
								<div class="c-info">
									<a href="#" class="au-cmt-headimg"> 
										<tag:avatar userId="${post.creator.id}" avatar="${post.creator.avatar}"/>
									</a>
									<p class="tp">
										<a class="name">${post.creator.realName }</a>
										<span class="time">${sipc:prettyTime(post.createTime)}</span>
									</p>
									<p class="cmt-dt">${post.content }</p>
									<div class="ag-opa">
	                                    <!-- <a href="javascript:void(0);" class="ua-praise">
	                                        <i class="au-praise-ico"></i>赞同<b>（189）</b>
	                                    </a> 
	                                    <i class="ua-opa-dot"></i>
	                                    <a href="javascript:void(0);" class="au-alter au-editComment-btn">
	                                           <i class="au-alter-ico"></i>编辑
	                                    </a>
	                                     <i class="au-opa-dot"></i>
	                                    -->
	                                    <a onclick="listChildPost('${post.id}')" class="ua-comment">
	                                        <i class="au-comment-ico"></i>评论<b>（${post.childPostCount }）</b>
	                                    </a>
	                                    <c:if test="${post.creator.id eq sessionScope.loginer.id or hasMasterRole}">
	                                    	<i class="ua-opa-dot"></i> 
		                                    <a  onclick="deletePost('${post.id}','${post.mainPostId }', this)" class="au-dlt"> 
		                                    	<i class="au-dlt-ico"></i>删除
		                                    </a>
	                                    </c:if>
	                                </div>
	                                <div id="listChildPostDiv_${post.id }" class="listChildPostDiv" mainPostId="${post.id }">
	                                
	                                </div>    
								</div>
							</li>
						</c:forEach>
					</ul>
					<div class="am-pageturn">
						<jsp:include page="/WEB-INF/views/include/pagination.jsp">
							<jsp:param value="listDiscussionPostForm" name="pageForm" />
							<jsp:param value="ajax" name="type" />
							<jsp:param value="listDiscussionPostDiv" name="divId" />
							<jsp:param value="discussionPostsPaginator" name="paginatorName" />
						</jsp:include>
			        </div>
			        <br><br>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</form>
<form id="saveDiscussionPostForm" action="${ctx }/discussion/post/save">
	<input type="hidden" name="discussionUser.discussionRelation.id" value="${searchParam.paramMap.discussionRelationId }">
	<input type="hidden" name="discussionUser.discussionRelation.discussion.id" value="${searchParam.paramMap.discussionId }">
	<input type="hidden" name="discussionUser.discussionRelation.relation.id" value="${searchParam.paramMap.relationId }">
	<input type="hidden" name="mainPostId">
	<input type="hidden" name="content">
</form>
<form id="deletePostForm" method="delete">
	<input type="hidden" name="discussionUser.discussionRelation.id" value="${searchParam.paramMap.discussionRelationId }">
	<input type="hidden" name="discussionUser.discussionRelation.discussion.id" value="${searchParam.paramMap.discussionId }">
	<input type="hidden" name="discussionUser.discussionRelation.relation.id" value="${searchParam.paramMap.relationId }">
	<input type="hidden" name="mainPostId">
</form>
<script>
	$(function() {
		activityJs.fn.init();
		
		var replyNum = '${requestScope.discussionPostsPaginator.totalCount}';
		$('#discussionPostReplyNumTxt').text(replyNum);
	});

	function editDiscussionPost(id) {
		$('#editDiscussionPostDiv').load('${ctx}/discussion/post/editDiscussionPost.do', 'id=' + id, function() {
			aJumpLayer($(".ua-editComment-btn"), $(".m-alterComment-layer"));
		});
	}
	
	//发表研讨主贴
	function savePost(){
		var content = $('#postContent').val();
		if(content == ''){
			alert('发表的内容不能为空!');
			return false;
		}
		$('#saveDiscussionPostForm input[name="content"]').val(content);
		$.ajax({
			url: $('#saveDiscussionPostForm').attr('action'),
			type: 'post',
			data: $('#saveDiscussionPostForm').serialize(),
			success: function(data){
				if(data.responseCode == '00'){
					alert('发表成功!');
					$.ajaxQuery('listDiscussionPostForm','listDiscussionPostDiv');
				} 
			}
		});
	}
	
	//发表回复
	function saveChildPost(obj){
		var _parent = $(obj).parents('.listChildPostDiv');
		var content = _parent.find('.au-textarea').val();
		if(content == ''){
			alert('发表的内容不能为空!');
			return false;
		}
		var mainPostId = _parent.attr('mainPostId');
		$('#saveDiscussionPostForm input[name="content"]').val(content);
		$('#saveDiscussionPostForm input[name="mainPostId"]').val(mainPostId);
		$.ajax({
			url: $('#saveDiscussionPostForm').attr('action'),
			type: 'post',
			data: $('#saveDiscussionPostForm').serialize(),
			success: function(data){
				if(data.responseCode == '00'){
					alert('发表成功!');
					$.ajaxQuery('listDiscussionPostForm','listDiscussionPostDiv');
				} 
			}
		});
	}
	
	function listChildPost(mainPostId){
		$('#listChildPostDiv_'+mainPostId).load('${ctx}/discussion/post/child','paramMap[mainPostId]='+mainPostId+'&paramMap[relationId]=${searchParam.paramMap.relationId}&'+$('#roleForm').serialize());
	}
	
	function searchForm(obj){
		$('#listDiscussionPostForm input[name="orders"]').val($(obj).attr('orders'));
		$.ajaxQuery('listDiscussionPostForm','listDiscussionPostDiv');
	}
	
	function deletePost(id, mainPostId, obj){
		confirm('是否删除此回复?',function(){
			$('#deletePostForm input[name="mainPostId"]').val(mainPostId);
			$('#deletePostForm').attr('action','${ctx}/discussion/post/'+id);
			var data = $.ajaxSubmit('deletePostForm');
			var json = $.parseJSON(data);
			if(json.responseCode == '00'){
				$(obj).parents('li').remove();
			} 
		});
	}
</script>
