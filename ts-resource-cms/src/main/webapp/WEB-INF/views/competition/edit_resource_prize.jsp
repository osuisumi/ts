<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="resourcePrizeForm" action="${ctx}/competition/prize/save">
<input name="resourceId" type="hidden" value="${searchParam.paramMap.ids }"/>
	<select name="prize" id="cc" class="easyui-combobox" name="dept" style="width: 200px;">
	 ${dict:getEntryOptions('RESOURCE_PRIZE') }
	</select>
	
	<div style="text-align: center">
		<button type="button" onclick="saveResourcePrize()" class="easyui-linkbutton">
			<i class="fa fa-floppy-o"></i> 保 存
		</button>
	</div>
</form>
<script>
	function saveResourcePrize(){
		var response = $.ajaxSubmit('resourcePrizeForm');
		response = $.parseJSON(response);
		if(response.responseCode == '00'){
			alert('操作成功');
			easyui_window_update('listCompetitionResourceForm', 'listCompetitionResourceDiv');
			easyui_modal_close('prizeDiv');
		}
	}
</script>