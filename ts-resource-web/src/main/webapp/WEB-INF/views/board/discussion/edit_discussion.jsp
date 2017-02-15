<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="discussionForm" action="${ctx}/board/discussion/create" method="post">
	<input type="hidden" id="id" name="id" value="${sipc:uuid()}">
	<input type="hidden" name="create" value="true">
	<input id="discussionContent" type="hidden" name="content">
	<input type="hidden" name="discussionRelations[0].isTop" value="N">
	<input type="hidden" name="discussionRelations[0].isEssence" value="N">
	<input type="hidden" name="discussionRelations[0].relation.id" value="${discussion.discussionRelations[0].relation.id}">
	<input type="hidden" name="discussionRelations[0].relation.type" value="board">
	<div id="wrap">
		<div id="g-bd">
			<div class="f-auto">
				<div class="g-circle-wp">
					<div class="m-crm">
						<span class="txt">您当前的位置： </span><a onclick="home()" title="首页" class="u-goto-index"> <i class="u-sHome-ico"></i>
						</a> <span class="trg">&gt;</span> <a onclick="boardIndex('${discussion.discussionRelations[0].relation.id}')">社区</a> <span class="trg">&gt;</span> <em>发表帖子</em>
					</div>
					<div class="g-mn-mod">
						<div class="g-circle-detail w_discuss_con">
							<div class="publish_block">
								<div class="p_block_left">
									<span>讨论标题：</span>
								</div>
								<div class="p_block_right">
									<div class="p_input_text">
										<input id="title" type="text" value="" name="title">
									</div>
									<p class="p_input_hint">还可输入 80 个字符</p>
								</div>
							</div>
							<div class="publish_block">
								<div class="p_block_left">
									<span>讨论内容：</span>
								</div>
								<div class="p_block_right">
									<div class="editor border">
										<script id="editor" type="text/plain" style="width:743px;height:148px;"></script>
									</div>
								</div>
							</div>
							<div class="publish_block">
								<div class="p_block_left"></div>
								<div class="p_block_right">
									<div class="publish_bnt">
										<input style="width:50px; padding-left: 35px;" onclick="saveDiscussion()" class="u-confirm-btn" value="提交">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
<script>
	var ue;
	$(function(){
		UE.delEditor('editor');
		ue = UE.getEditor('editor',{
			toolbars: [
			           [
			               'bold', //加粗
			               'italic', //斜体
			               'underline', //下划线
			               'strikethrough', //删除线
			               'fontborder', //字符边框
			               'horizontal', //分隔线
			               'fontfamily', //字体
			               'fontsize', //字号
			               'justifyleft', //居左对齐
			               'justifyright', //居右对齐
			               'justifycenter', //居中对齐
			               'justifyjustify', //两端对齐
			               'forecolor', //字体颜色
			               'backcolor', //背景色
			               'lineheight', //行间距
			           ]
			       ],
			scaleEnabled: true,
		});
		ue.ready(function() {
		    ue.execCommand('serverparam', {
		        'relations': '${sessionScope.loginer.id}',
		    });
		});
	});

	function saveDiscussion(){
		if (!$('#discussionForm').validate().form()) {
			return false;
		}
		var content = ue.getContent();
		var contentText = ue.getContentTxt();
		if(content.length == 0){
			alert("发表内容不能为空");
			return;
		}
		$('#discussionContent').val(content+$('#id').val()+contentText);
		var data = $.ajaxSubmit('discussionForm');
		data = $.parseJSON(data);
		if(data.responseCode=='00'){
			alert('保存成功');
			boardIndex();
		}
	}
</script>