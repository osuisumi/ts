<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="editCommentForm" action="${ctx }/comment/${comment.id }" method="put">
	<div class="am-layer am-editComment-layer">
        <div class="am-layer-hd">
            <h3>编辑评论</h3>
            <a href="javascript:void(0);" class="au-close-btn">×</a>
        </div>
        <div class="am-layer-bd">
		    <div class="cont">
           		<textarea id="" class="au-textarea" style="height: 150px;" name="content">${comment.content}</textarea>
        	</div>
        </div>
        <div class="am-layer-ft">
            <a onclick="editComment()" class="au-confirm-btn">确定</a>
            <a href="javascript:void(0);" class="au-cancel-btn">取消</a>
        </div>
    </div>
</form>
<script>
function editComment(){
	var data = $.ajaxSubmit('editCommentForm');
	var json = $.parseJSON(data);
	if(json.responseCode == '00'){
		alert('编辑成功');
		$('.u-close-btn').trigger('click');
		$.ajaxQuery('listCommentForm','listCommentDiv');
	}
}
</script>