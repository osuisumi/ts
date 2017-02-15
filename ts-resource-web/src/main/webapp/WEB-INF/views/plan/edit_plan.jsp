<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="savePlanForm" action="${ctx}/plan/save" >
<input id="" type="hidden" name="planRelations[0].relation.id" value="${plan.planRelations[0].relation.id }"/>
<input id="planId" type="hidden" name="id" value="${plan.id }">
	<div class="tit">
		<div class="title">
			<span>研修计划</span>
		</div>
		<a href="javascript:void(0);" class="colse-btn">×</a>
	</div>
	<div class="cont">
		<div class="infor-input-box">
			<div class="box-l">
				<span>标题：</span>
			</div>
			<div class="box-r">
				<div class="text-input">
					<input name="title" type="text" class="{required:true,byteMaxLength:80}" value="${plan.title }" placeholder="请输入计划标题...">
				</div>
			</div>
		</div>
		<div class="infor-input-box">
			<div class="box-l">
				<span>起始时间：</span>
			</div>
			<div class="c-center">
				<div class="am-time-mod f-cb">
					<div class="am-slt-time">
						<input id="startTime" type="text" name="startTime" class="au-ipt" placeholder="${nowDate }" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd', minDate: '%y-%M-%d', maxDate: '#F{$dp.$D(\'endTime\')}' })" value='<fmt:formatDate value="${plan.planRelations[0].timePeriod.startTime }"/>' > <a href="javascript:void(0);" class="au-calendar-ico" style="right:0"></a>
					</div>
					<span class="au-time-txt">至</span>
					<div class="am-slt-time">
						<input id="endTime" type="text" name="endTime" class="au-ipt" placeholder="${nowDate }" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd', minDate: '#F{$dp.$D(\'startTime\')}' })" value='<fmt:formatDate value="${plan.planRelations[0].timePeriod.endTime }"/>'> <a href="javascript:void(0);" class="au-calendar-ico" style="right:0"></a>
					</div>
				</div>
			</div>
		</div>
		<div class="infor-input-box">
			<div class="box-l">
				<span>内容：</span>
			</div>
			<div class="box-r">
				<div class="textarea-input">
					<textarea name="content" class="{required:true}">${plan.content }</textarea>
				</div>
			</div>
		</div>
 		<div class="infor-input-box">
			<div class="box-l">
				<span>附件：</span>
			</div>
			<div class="box-r">
				<tag:fileUpload relationId="${plan.id }"/>
			</div>
		</div>
		<div class="infor-input-box">
			<div class="box-l"></div>
			<div class="box-r">
				<div class="btnDiv">
					<a class="confirm-btn main-btn btn" onclick="savePlan()">保存</a>
					<button type="button" class="cancel-btn gray-btn btn">取消</button>
				</div>
			</div>
		</div>
	</div>
</form>
<script>
	$(function(){
		$('.textarea-input').css('height','100px');
		if('${plan.content}'){
			$('.textarea-input').val('${plan.content}');
		}
	})
	$(function(){
		commonCssUtils.bindCloseWindowEvent($('#editPlanDiv'));
	});
	function savePlan() {
		if (!$('#savePlanForm').validate().form()) {
			return false;
		}
		var data = $.ajaxSubmit('savePlanForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			alert('保存成功');
			commonCssUtils.closeModelWindow($('#editPlanDiv'));
			if($('#planId').val() == '')
				$.ajaxQuery('listMorePlanForm', 'content');
			else
				viewPlan($('#planId').val());
		}
	}
	
	$(function(){
		$('.au-ipt').attr('style','height:30px');
	})
</script>