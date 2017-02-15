<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="saveWorkshopForm" action="${ctx }/workshop/${workshop.id }" method="put">
	<input type="hidden" name="id" value="${workshop.id }">
	<div class="tit">
		<div class="title">
			<span>编辑工作坊</span>
		</div>
		<a href="javascript:void(0);" class="colse-btn">×</a>
	</div>
	<div class="cont">
		<div class="infor-input-box">
			<div class="box-r">
				<div class="upload-hImg clearfix">
					<div class="show-img">
						<c:choose>
							<c:when test="${not empty workshop.imageUrl }">
								<img id="imagePreView" src="${file:getFileUrl(workshop.imageUrl) }" alt="">
							</c:when>
							<c:otherwise>
								<img id="imagePreView" src="${ctx}/images/img/defaultWorkshopImg.png" alt="">
							</c:otherwise>
						</c:choose>
					</div>
					<div class="opa">
						<div class="file-input">
							<a id="picker" class="file-show-btn main-btn btn">
								<em>+</em>上传照片
							</a>
						</div>
						<p class="ex">仅支持JPG、JPEG、PNG格式（2M以下）</p>
					</div>
					<ul id="fileList">
							
					</ul>
				</div>
			</div>
		</div>
		<div class="infor-input-box">
			<div class="box-l">
				<em>*</em><span>工作坊名称：</span>
			</div>
			<div class="box-r">
				<div class="text-input">
					<input type="text" name="name" value="${workshop.name }" placeholder="请输入工作坊名称..." class="required">
				</div>
			</div>
		</div>
		<div class="infor-input-box">
			<div class="box-l">
				<em>*</em><span>简介：</span>
			</div>
			<div class="box-r">
				<div class="textarea-input">
					<textarea name="summary" id="" placeholder="请输入简介内容..." class="required">${workshop.summary }</textarea>
				</div>
			</div>
		</div>
		<div class="infor-input-box">
			<div class="box-l"></div>
			<div class="box-r">
				<div class="btnDiv">
					<button type="button" onclick="saveWorkshop()" class="confirm-btn main-btn btn">提交</button>
					<button type="button" class="cancel-btn gray-btn btn">取消</button>
				</div>
			</div>
		</div>
	</div>
</form>
<input type="hidden" id="realPath" value="<%=request.getContextPath()%>">
<script>
	$(function() {
		initImageUploader('${workshop.id}', 'workshop');
		commonCssUtils.bindCloseWindowEvent($('#editWorkshopDiv'));
	});
	
	function saveWorkshop(){
		if(!$('#saveWorkshopForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('saveWorkshopForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			alert('提交成功');
			viewWorkshop('${workshop.id}');
			//$('#content').load('${ctx}/workshop/${workshop.id}/view');
			commonCssUtils.closeModelWindow($('#editWorkshopDiv'));
		}
	}
</script>