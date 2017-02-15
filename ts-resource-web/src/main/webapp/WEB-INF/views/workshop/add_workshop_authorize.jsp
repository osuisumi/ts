<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="g-layer-hd">
	<h3>添加成员</h3>
	<a href="javascript:void(0);" class="u-close-btn">×</a>
</div>
<form id="saveAuthorizeForm" action="${ctx }/workshop/authorize/batch">
	<input type="hidden" name=id value="${workshopAuthorize.workshop.id }">
	<input type="hidden" name="workshopRelations[0].id" value="${workshopAuthorize.workshopRelation.id }">
	<div class="g-layer-bd">
		<div class="g-layer-iptLst">
			<div class="m-pb-mod">
				<div class="c-txt">
					<em></em><span>添加成员：</span>
				</div>
				<div class="c-center">
					<div class="m-add-tag f-cb m-add-tag-user">
						<div class="m-tagipt m-ipt-mod">
							<span class="userType" style="display:none">member</span>
							<input type="text" placeholder="请输入成员名字" value="" class="u-ipt"> 
							<a href="javascript:void(0);" class="u-nbtn u-add-tag">+添加</a>
							<div class="l-slt-lst" style="display: none;">
								<i class="trg"></i> <i class="trgs"></i>
								<div class="lst">
								
								</div>
							</div>
						</div>
						<ul class="m-tag-lst" id="memberList">
						
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
<div class="g-layer-ft">
	<a onclick="saveAuthorize()" class="u-confirm-btn">确定</a> 
	<a href="javascript:void(0);" class="u-cancel-btn">取消</a>
</div>
<script>
$(function(){
	initUserLabelUtils();
});

function saveAuthorize(){
	var count = $('#memberList').find('li').length;
	if(count == 0){
		alert('还未添加成员');	
		return false;
	}
	var data = $.ajaxSubmit('saveAuthorizeForm');
	var json = $.parseJSON(data);
	if(json.responseCode == '00'){
		alert('提交成功');
		$('.u-cancel-btn').trigger('click');
		$.ajaxQuery('listAuthorizeForm','content');
	}
}
</script>