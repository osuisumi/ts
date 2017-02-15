<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="saveAnnouncementForm" action="${ctx}/announcement/save" >
	<input type="hidden" name="id" value="${announcement.id }" />
	<input type="hidden" name="announcementRelations[0].relation.id" value="${announcement.announcementRelations[0].relation.id }" /> 
	<input type="hidden" name="announcementRelations[0].relation.type" value="${announcement.announcementRelations[0].relation.type }" /> 
	<input type="hidden" name="type" value="${announcement.type }" />
	<div class="tit">
		<div class="title">
			<span>最新通知</span>
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
					<input name="title" type="text" class="{required:true,byteMaxLength:80}" value="${announcement.title }" placeholder="请输入计划标题...">
				</div>
			</div>
		</div>
		<div class="infor-input-box">
			<div class="box-l">
				<span>内容：</span>
			</div>
			<div class="box-r">
				<div class="textarea-input">
					<textarea name="content" class="{required:true}">${announcement.content }</textarea>
				</div>
			</div>
		</div>
		<div class="infor-input-box">
			<div class="box-l">
				<span>附件：</span>
			</div>
			<div class="box-r">
				<tag:fileUpload relationId="${announcement.id }" />
			</div>
		</div>
		<div class="infor-input-box">
			<div class="box-l"></div>
			<div class="box-r">
				<div class="btnDiv">
					<a class="confirm-btn main-btn btn" onclick="saveAnnouncement()">保存</a>
					<button type="button" class="cancel-btn gray-btn btn">取消</button>
				</div>
			</div>
		</div>
	</div>
</form>
<script>
	$(function(){
		commonCssUtils.bindCloseWindowEvent($('#editAnnouncementDiv'));
	});
	function saveAnnouncement() {
		if (!$('#saveAnnouncementForm').validate().form()) {
			return false;
		}
		var data = $.ajaxSubmit('saveAnnouncementForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			alert('保存成功');
			commonCssUtils.closeModelWindow($('#editAnnouncementDiv'));
			if($('#listMoreWorkshopAnnouncementForm').length > 0){
				$.ajaxQuery('listMoreWorkshopAnnouncementForm', 'content');
			}else{
				listMoreWorkshopAnnouncement('${announcement.announcementRelations[0].relation.id}');
			}
		}
	}
</script>