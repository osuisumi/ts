<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="saveCommentForm" action="${ctx }/comment" method="post">
	<input type="hidden" name="relation.id" value="${param.relationId }"> 
	<input type="hidden" name="relation.type" value="${param.relationType }">
	<input type="hidden" name="content">
	<input type="hidden" name="mainId">
	<input type="hidden" name="evaluateScore" value="0" id="evaluateScoreParam">
	<input id="isEvaluate" type="hidden" name="isEvaluate" value="${param.isEvaluate}">
</form>
<div class="g-mn-mod">
	<div class="m-your-comment">
		<c:choose>
			<c:when test="${empty sessionScope.loginer }">
				<div class="m-sd-dt">
					<div class="u-user-logn">
						<p>
							您需要登录后方可评论，请<a onclick="goLoginForComment()">登录</a>
						</p>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div id="commentDiv">
					<div class="m-sd-tt">
						<h3 class="tt">您的评论</h3>
						<div id="evaluateScoreDiv" class="u-stars">
							<i class="u-one u-null"></i> <i class="u-two u-null"></i> <i class="u-thr u-null"></i> <i class="u-for u-null"></i> <i class="u-fiv u-null"></i>
						</div>
						<script>
							$(function(){
								$('#evaluateScoreDiv i').click(function(){
									var index = $('#evaluateScoreDiv i').index($(this));
									$('#evaluateScoreParam').val(index+1);
								});
							});
						</script>
					</div>
					<div class="m-sd-dt">
						<div class="m-comment-box">
							<textarea id="commentContent" name="content" placeholder="说一句吧~"></textarea>
							<div class="b">
								<!-- <span class="user"> 
									<img src="../images/headImg5.jpg"> 
									<span>崔圆圆</span>
								</span>  -->
								<a onclick="saveComment()" class="u-btn-com u-publish-btn">提交</a>
							</div>
						</div>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	<div id="listCommentDiv">
	
	</div>
</div>
<script>
	$(function() {
		listComment();
		
		if('${param.isEvaluate}' == 'true' && '${not empty sessionScope.loginer }' == 'true'){
			$.get('${ctx}/comment/getMyCommentNum','paramMap[relationId]=${param.relationId}',function(data){
				if(data > 0){
					$('#commentDiv').hide();
				}
			});
		}
	});

	function listComment() {
		$('#listCommentDiv').load('${ctx}/comment/list'
			,'orders=CREATE_TIME.DESC&paramMap[relationId]=${param.relationId}&'+$('#roleForm').serialize());
	}
	function saveComment() {
		var content = $('#commentContent').val();
		if (content == '') {
			alert('发表内容不能为空！');
			return false;
		}
		$('#saveCommentForm input[name="content"]').val(content);
		var data = $.ajaxSubmit('saveCommentForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			alert('操作成功！');
			$('#commentContent').val('');
			$.ajaxQuery('listCommentForm','listCommentDiv');
			if('${param.isEvaluate}' == 'true'){
				$('#commentDiv').hide();
			}
		} else {
			alert('操作失败！');
		}
	}
	
	function saveChildComment(obj){
		var _parent = $(obj).parents('.listChildCommentDiv');
		var content = _parent.find('.commentTextarea').val();
		if(content == ''){
			alert('发表的内容不能为空!');
			return false;
		}
		var mainId = _parent.attr('mainId');
		$('#saveCommentForm input[name="content"]').val(content);
		$('#saveCommentForm input[name="mainId"]').val(mainId);
		$.ajax({
			url: $('#saveCommentForm').attr('action'),
			type: 'post',
			data: $('#saveCommentForm').serialize(),
			success: function(data){
				if(data.responseCode == '00'){
					alert('发表成功!');
					$.ajaxQuery('listCommentForm','listCommentDiv');
				} 
			}
		});
	}
	
	function goLoginForComment(){
		if('${param.isEvaluate}' == 'true'){
			goLogin(function(){
				viewResource('${param.relationId}');
			});
		}else{
			goLogin(function(){
				viewDiscovery('${param.relationId}');
			});
		}
	}
</script>