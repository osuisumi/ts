<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="listCommentForm" action="${ctx }/comment/list">
	<input type="hidden" name="paramMap[relationId]" value="${searchParam.paramMap.relationId }"> 
	<input type="hidden" name="orders" value="${orders[0] }"> 
	<div class="m-user-comment">
		<div class="m-sd-tt">
			<h3 class="tt">
				用户评论<span>（<span id="commentCountTxt"></span>）</span>
			</h3>
			<span class="u-bor1"></span> <span class="u-bor2"></span>
		</div>
		<div class="m-sd-dt">
			<div class="m-pl-lst">
				<c:choose>
					<c:when test="${not empty comments }">
						<ul class="g-cmt-lst">
							<c:forEach items="${comments }" var="comment">
								<li class="am-cmt-block">
									<div class="c-info">
										<div class="u-user-img">
											<a href="javascript:void(0);"> 
												<tag:avatar userId="${comment.creator.id}" avatar="${comment.creator.avatar}" />
											</a>
										</div>
										<div class="u-user-info">
											<p class="u-user-name">
												<a href="javascript:void(0);">${comment.creator.realName}</a> <span>${sipc:prettyTime(comment.createTime)}</span>
											</p>
											<div class="u-user-txt">
												<p class="u-pl-txt">${comment.content}</p>
											</div>
											<div class="u-user-pl">
												<p class="u-btn-lst">
													<a class="u-btn u-pl-btn" onclick="listChildComment('${comment.id}')"><i></i>（${comment.childNum }）</a>
												</p>
											</div>
										</div>
										<div class="u-small-stars">
											<c:forEach begin="1" end="${comment.evaluateScore }" >
												<i class="u-full"></i> 
											</c:forEach>
											<c:if test="${comment.evaluateScore % 1 > 0 }">
												<i class="u-half"></i> 
											</c:if>
											<c:forEach begin="1" end="${5 - comment.evaluateScore }" >
												<i class="u-null"></i>
											</c:forEach>
										</div>
									</div>
									<div class="listChildCommentDiv" style="display:none" id="listChildCommentDiv_${comment.id }" mainId="${comment.id }">
									
									</div>
								</li>
							</c:forEach>
						</ul>
						<div class="am-pageturn">
							<jsp:include page="/WEB-INF/views/include/pagination.jsp">
								<jsp:param value="listCommentForm" name="pageForm" />
								<jsp:param value="commentsPaginator" name="paginatorName" />
								<jsp:param value="listCommentDiv" name="divId" />
								<jsp:param value="ajax" name="type" />
							</jsp:include>
						</div>
					</c:when>
					<c:otherwise>
						<tag:noContent msg="还没有人发表评论" />
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</form>
<div id="editCommentDiv"></div>
<br>
<script>
	$(function() {
		$('#commentCountTxt').text('${requestScope.commentsPaginator.totalCount}');
	});

	function deleteComment(obj, commentId) {
		confirm('是否要删除该评论?！', function() {
			$(obj).parents('.mainComment').remove();
			$.ajaxDelete('${ctx }/comment/'+commentId, '', function(data) {
				if (data.responseCode == '00') {
					var commentCount = parseInt($('#commentCountTxt').text().trim());
					$('#commentCountTxt').text(commentCount - 1);
					updateRelationForDelete();
					alert('删除成功！');
				} else {
					alert('删除失败！');
				}
			});
		});
	}

	function goEditComment(commentId) {
		$('#editCommentDiv').load('${ctx }/comment/edit', 'id=' + commentId, function() {
			activityJs.fn.aJumpLayer(".am-editComment-layer");
		});
	}

	function listChildComment(mainId) {
		$('#listChildCommentDiv_' + mainId).toggle();
		$('#listChildCommentDiv_' + mainId).load('${ctx}/comment/child', 'paramMap[mainId]=' + mainId + '&' + $('#roleForm').serialize());
	}

	function searchForm(obj) {
		$('#listCommentForm input[name="orders"]').val($(obj).attr('orders'));
		$.ajaxQuery('listCommentForm', 'listCommentDiv');
	}
	
	showComment();
    function showComment(){
         $(".u-pl-btn").click(function(){            //点击评论按钮显示评论列表
            var this_is = $(this);
            if(this_is.hasClass("z-crt")){
                this_is.removeClass("z-crt");
            }else{
                this_is.addClass("z-crt");
            }
            this_is.parents(".c-info").next(".g-is-comment").toggle();
            this_is.parents(".am-cmt-block").siblings().find(".g-is-comment").hide();
            this_is.parents(".am-cmt-block").siblings().find(".u-pl-btn").removeClass("z-crt");
        });
    }
    
    $(function(){
    	var isEvaluate = $('#isEvaluate').val();
    	if(isEvaluate == 'false'){
    		$('.u-small-stars').hide();
    		$('#evaluateScoreDiv').hide();
    	}
    })
</script>