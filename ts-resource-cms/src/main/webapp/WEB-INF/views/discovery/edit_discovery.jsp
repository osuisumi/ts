<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="discoveryForm" action="${ctx}/discovery/save">
	<input id="id" type="hidden" name="id" value="${discovery.id}">
	<input type="hidden" name="state" value="${dict:getEntryValue('EDIT_STATE','已审核') }"> 
	<input type="hidden" name="type" value="discovery"> 
	<input type="hidden" id="relation" name="resourceRelations[0].relation.id" value="${sessionScope.loginer.deptId}">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="alter-table-v">
		<tbody>
			<tr style="height: 100px">
				<td>封面图片:</td>
				<td colspan="3" style="text-align: left; height: 200px;">
					<ul style="min-height:120px" id="fileList" class="m-upload-lst">
						<c:forEach items="${discovery.fileInfos}" var="fileInfo">
							<li style="display:inline-block" id="${fileInfo.id}" fileId="${fileInfo.id}" url="${fileInfo.url}" fileName="fileInfo.fileName" class="upload-state-done"><img style="height:100px;width:100px;" src="${file:getFileUrl(fileInfo.url)}"> <a onclick="deleteImage(this)" class="close" title="删除图片">×</a></li>
						</c:forEach>
					</ul>
					<a class="l-btn" id="filePicker" style="margin-bottom: 10px"><span>上传图片</span></a> 
					<span class="help-block">仅支持JPG、JPEG、PNG格式（2M以下）</span>
					<div id="fileForm">
						<c:forEach items="${discovery.fileInfos}" var="fileInfo" varStatus="index">
							<input class="fileParam ${fileInfo.id}" name="fileInfos[${index.index}].id" value="${fileInfo.id}" type="hidden" />
							<input class="fileParam ${fileInfo.id}" name="fileInfos[${index.index}].fileName" value="${fileInfo.fileName}" type="hidden" />
							<input class="fileParam ${fileInfo.id}" name="fileInfos[${index.index}].url" value="${fileInfo.url}" type="hidden" />
						</c:forEach>
					</div>
				</td>
			</tr>
			<tr>
				<td width="10%">发现什么:</td>
				<td width="90%" style="text-align: left;" colspan="3"><input value="${discovery.title }" type="text" class="easyui-textbox" required style="width: 200px" name="title" placeholder="请输入发现标题" aria-describedby="basic-addon1"></td>
			</tr>
			<tr>
				<td width="10%">有啥亮点:</td>
				<td width="40%" style="text-align: left;"><input value="${discovery.summary}" type="text" class="easyui-textbox required:true" name="summary" multiline="true" style="width: 478px; height: 100px"></td>
			</tr>
			<tr>
				<td width="10%">资源网址:</td>
				<td width="40%" style="text-align: left;"><input value="${discovery.resourceExtend.previewUrl}" type="text" class="easyui-textbox" name="resourceExtend.previewUrl" placeholder="请输入发现标题" aria-describedby="basic-addon1"></td>
			</tr>
			<tr>
				<td width="10%">属于:</td>
				<td width="90%" colspan="3" style="text-align: left;">
				<select id="stateSelect" class="easyui-combobox" name="resourceExtend.type" style="padding-top: 5px; width: 100px"> 
				${dict:getEntryOptionsSelected('RESOURCE_DISCOVERY_TYPE',discovery.resourceExtend.type)}
				</select></td>
			</tr>
		</tbody>
	</table>
	<br>
	<div style="text-align: center">
		<button type="button" onclick="saveDiscovery()" class="easyui-linkbutton">
			<i class="fa fa-floppy-o"></i> 保 存
		</button>
	</div>
</form>
<script>
	$(function() {
		$('.c-center').css('padding-top', '7px');
		initImagesUploader('${discovery.id}', 'discovery');
	})

	function saveDiscovery() {
		var imgCount = $('#fileList img').size();
		if (imgCount > 9) {
			$.messager.alert('提示信息', '请不要上传大于九张图片');
			return false;
		}
		if (imgCount <= 0) {
			$.messager.alert('提示信息', '请至少上传一张图片');
			return false;
		}
		if ($('#discoveryType').val() == '') {
			$.messager.alert('提示信息', '请选择发现的类别');
			return false;
		}
		if (!$('#discoveryForm').form('validate')) {
			return false;
		}
		data = $.ajaxSubmit('discoveryForm');
		data = $.parseJSON(data);
		if (data.responseCode == '00') {
			$.messager.alert('提示信息', '操作成功');
			easyui_tabs_update('listDiscoveryForm', 'layout_center_tabs');
			easyui_modal_close('editDiscoveryDiv');
		}
	}

	function deleteDiscovery() {
		var row = $('#listDiscoveryForm').datagrid('getSelections');
		var ids = '';
		$.each($(row), function(i, r) {
			ids = ids + r.id + ",";
		});
		ids = ids.substr(0, ids.length - 1);
		if (row.length <= 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		} else {
			$.messager.confirm('确认', '确认要删除选中记录吗？', function(r) {
				if (r) {
					$.ajaxDelete('${ctx}/discovery/deleteByIds', $('#listDiscoveryForm').serialize(), function() {
						easyui_tabs_update('listDiscoveryForm', 'layout_center_tabs');
					});
				}
			});
		}
	}
	
</script>
