<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="importUserForm" action="${ctx}/user/importUser" method="post">
	<input type="hidden" name="authRole.id" value="4">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="alter-table-v">
		<tbody>
			<tr>
				<td width="15%">文件:</td>
				<td width="35%" style="text-align: left; height: 100px;">
					<ul id="fileList" class="am-ful-lst">
					</ul>
					<br>
					<a id="picker" type="button" class="l-btn">
						选择文件
					</a> 
					<input id="fileUrl" type="hidden" name="url">
					<p><a href="###" onclick="downloadExcel('import_user.xls')" style="color: orange">模板下载</a></p>
				</td>
			</tr>
		</tbody>
	</table>
	<br>
	<div style="text-align: center">
		<button type="button" onclick="importUser()" class="easyui-linkbutton">
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
			    extensions: 'xls, xlsx'
			}
		});
		uploader.on('fileQueued', function(file) {
			$list = $('#fileList');
			$list.html('<li id="' + file.id + '" class="fileLi fileItem item">' + '<a href="#" class="txt">' + file.name + '</a>' + '<div class="state">' + '<span class="status">等待上传...</span>' + '</div>' + '</li>');
			uploader.upload();
		});
		uploader.on('uploadProgress', function(file, percentage) {
			var $li = $('#' + file.id), $percent = $li.find('.sche');
			if (!$percent.length) {
				$li.find('.state').html('<div class="sche">' + '<div class="bl">' + '<div class="bs" role="progressbar" style="width: 0%"></div>' + '</div>' + '<span class="num">' + '0%' + '</span>' + '<span class="status"></span>' + '</div>');
				$percent = $li.find('.sche');
			}
			var progress = Math.round(percentage * 100);
			$percent.find('.bs').css('width', progress + '%');
			$percent.find('.num').text(progress + '%');
			$percent.find('.status').text('上传中');
		});
		uploader.on('uploadSuccess', function(file, response) {
			if (response != null && response.responseCode == '00') {
				var fileInfo = response.responseData;
				$('#fileUrl').val(fileInfo.url);
				$('#' + file.id).find('.state .status').text('已上传');
			}
		});
		uploader.on('error', function(type) {
			if (type == 'Q_TYPE_DENIED') {
				alert('不支持该类型的文件');
			}
		});
	});

	function importUser() {
		if($('#fileUrl').val() == null || $('#fileUrl').val() == ''){
			alert('请先选择文件');
			return false;
		}
		$('#layout_center_tabs').tabs('getSelected').panel('refresh','${ctx}/user/importUser?'+$('#importUserForm').serialize());
		//easyui_tabs_add($('#layout_center_tabs'), '${ctx}/user/importUser?'+$('#importUserForm').serialize(), '教师管理 ');
		easyui_modal_close('importUserDiv');
	}
</script>