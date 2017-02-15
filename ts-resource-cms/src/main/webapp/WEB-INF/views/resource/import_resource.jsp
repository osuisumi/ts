<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="importResourceForm" action="${ctx}/resource/importResource" method="post">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="alter-table-v">
		<tbody>
			<tr>
				<td width="15%">文件:</td>
				<td width="35%" style="text-align: left; height: 100px;">
					<a id="picker" type="button" class="l-btn">
						选择文件
					</a> 
					<span id="fileName">未选择文件</span>
					<input id="fileUrl" type="hidden" name="url">
					<p><a href="###" onclick="downloadExcel('import_resource.xls')" style="color: orange">模板下载</a></p>
				</td>
			</tr>
		</tbody>
	</table>
	<br>
	<div style="text-align: center">
		<button type="button" onclick="importResource()" class="easyui-linkbutton">
			<i class="fa fa-floppy-o"></i> 导 入
		</button>
	</div>
</form>
<script type="text/javascript">
	$(function(){
		var uploader = WebUploader.create({
			swf : '${ctx}/js/webuploader/Uploader.swf',
			server : '${ctx}/file/uploadTemp.do',
			pick : '#picker',
			accept : {
			    extensions: 'xls,xlsx'
			}
		});
		uploader.on('fileQueued', function(file) {
			uploader.upload();
		});
		uploader.on('uploadSuccess', function(file, response) {
			if (response != null && response.responseCode == '00') {
				var fileInfo = response.responseData;
				$('#' + file.id).attr('fileId', fileInfo.id);
				$('#' + file.id).attr('url', fileInfo.url);
				$('#' + file.id).attr('fileName', fileInfo.fileName);
				$('#fileName').text(fileInfo.fileName);
				$('#fileUrl').val(fileInfo.url);
			}
		});
		uploader.on('error', function(type) {
			if (type == 'Q_TYPE_DENIED') {
				alert('不支持该类型的文件');
			}
		});
	});

	function importResource() {
		if($('#fileUrl').val() == null || $('#fileUrl').val() == ''){
			alert('请先选择文件');
			return false;
		}
		$('#layout_center_tabs').tabs('getSelected').panel('refresh','${ctx}/resource/importResource?'+$('#importResourceForm').serialize());
		easyui_modal_close('importResourceDiv');
	}
</script>