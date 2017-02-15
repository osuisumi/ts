<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="saveRoleForm" action="${ctx}/auth/role" method="post">
	<c:if test="${not empty role.id }">
		<input id="roleId" type="hidden" name="id" value="${role.id }">
		<script>
			$('#saveRoleForm').attr('action', '${ctx}/auth/role/${role.id }');
			$('#saveRoleForm').attr('method', 'PUT');
		</script>
	</c:if>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="alter-table-v">
		<tbody>
			<tr>
				<td width="15%">角色名称:</td>
				<td width="35%" style="text-align: left;"><input type="text" name="name" class="easyui-textbox" required value="${role.name}" style="width: 95%" /></td>
			</tr>
			<tr>
				<td width="15%">角色标识:</td>
				<td width="35%" style="text-align: left;"><input type="text" name="code" class="easyui-textbox" required value="${role.code}" style="width: 95%" /></td>
			</tr>
			<tr>
				<td width="15%">内容:</td>
				<td width="35%" style="text-align: left; height: 120px;"><input type="text" name="summary" class="easyui-textbox" value="${role.summary}" style="width: 95%;" data-options="multiline:true, height:100" /></td>
			</tr>
		</tbody>
	</table>
	<br>
	<div style="text-align: center">
		<button type="button" onclick="saveRole()" class="easyui-linkbutton">
			<i class="fa fa-floppy-o"></i> 保 存
		</button>
	</div>
</form>
<script type="text/javascript">
	function saveRole() {
		if(!$('#saveRoleForm').form('validate')){
			return false;
		}
		var data = $.ajaxSubmit('saveRoleForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listRoleForm', 'layout_center_tabs');
				easyui_modal_close('editRoleDiv');
			});
		}
	}
</script>