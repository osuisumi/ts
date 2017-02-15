 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="/WEB-INF/views/include/taglib.jsp"%>
 <script src="${ctx}/js/activity-function1.js" type="text/javascript"></script>
<!--start .m-alterComment-layer 观点编辑弹出框-->
<form id="editDiscussionPostForm" action="${ctx}/board/discussion/post/saveDiscussionPost.do" method="post">
  <div class="am-layer m-alterComment-layer">
 	<input type="hidden" name="id" value="${discussionPost.id }">
     <div class="am-layer-hd">
         <h3>编辑评论</h3>
         <a  class="au-close-btn">×</a>
     </div>
     <div class="am-layer-bd">
        <div class="g-ipt-box">
             <div class="am-ipt-mod">
                 <textarea id="" class="u-textarea " style="height: 150px;" name="content">${discussionPost.content}</textarea>
             </div>
        </div>
     </div>
     <div class="am-layer-ft">
         <a  class="au-confirm-btn" onclick="save('${discussionPost.id}')">确定</a>
         <a  class="au-cancel-btn">取消</a>
     </div>
 </div>
 </form>
<script>
	function save(id){
		var content = $('#editDiscussionPostForm textarea[name="content"]').val().trim();
		if(content == ''){
			alert('内容不能为空！');
			return false;
		}
		var data = $.ajaxSubmit('editDiscussionPostForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			$('#cmt-dt_'+id).text(content);
			closeAjumpLayerForPost($(".m-alterComment-layer"));
		}else{
			alert('操作失败！');
		}
	}
</script>
 