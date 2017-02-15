var uploadUtils = {

	setFileParam : function(formId, fileListName) {
		$('#'+formId+' .uploadify-queue-item.cancel').empty();
		var fileNameArr = $('#'+formId+' .fileParam.fileName');
		var fileId = $('#'+formId+' .fileParam.fileId');
		var fileUrl = $('#'+formId+' .fileParam.url');
		fileNameArr.each(function(index, obj) {
			obj.name = fileListName+'[' + index + '].fileName';
		});
		fileId.each(function(index, obj) {
			obj.name = fileListName+'[' + index + '].id';
		});
		fileUrl.each(function(index, obj) {
			obj.name = fileListName+'[' + index + '].url';
		});
	},
	
	uploadSuccess : function(file, data,formId, fileListName) {
		var callbackData = jQuery.parseJSON(data);
		if (callbackData != null && callbackData.responseCode == '00') {
			var responseData = $.parseJSON(callbackData.responseData);
			$('#' + file.id).append('<input class="fileParam fileName" type="hidden" value="' + responseData.fileName + '">');
			$('#' + file.id).append('<input class="fileParam fileId" type="hidden" value="' + responseData.id + '">');
			$('#' + file.id).append('<input class="fileParam url" type="hidden" value="' + responseData.url + '">');
			$('#' + file.id + ' .uploadbtn').hide();
		} else {
			alert(callbackData.responseMsg);
			$('#' + file.id).remove();
		}
	//	uploadUtils.setFileParam(formId, fileListName);
	},

	cancel : function(file, formId, fileListName) {
		if ($('#' + file.id).find('.fileParam').length > 0) {
			$.ajax({
				type : 'POST',
				url : $('#ctx').val() + '/file/removeTempFile.do',
				data : 'url=' + $('#' + file.id).find('.fileParam.url').val()
			});
		}
		$('#' + file.id).addClass('cancel');
		uploadUtils.setFileParam(formId, fileListName);
	}
}