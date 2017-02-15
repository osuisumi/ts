<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:choose>
	<c:when test="${user.authRole.id != null}">
		<form id="saveUserRoleForm" action="${ctx}/user/updateUserRole" method="put">
	</c:when>
	<c:otherwise>
		<form id="saveUserRoleForm" action="${ctx}/user/createUserRole" method="post">
	</c:otherwise>
</c:choose>
	<input type="hidden" name="id" value="${user.id }">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="alter-table-v">
		<tbody>
			<tr>
				<td width="15%">用户名:</td>
				<td width="35%" style="text-align: left;"><input id="userNameParam" type="text" name="account.userName" class="easyui-textbox" value="${user.account.userName}" style="width: 95%" readonly="readonly" /></td>
			</tr>
			<tr>
				<td width="15%">角色授权:</td>
				<td width="35%" style="text-align: left;">
					<input id="roleCodeComboBox" name="authRole.id" class="easyui-combobox" value="${user.authRole.id }" style="width:200px;" 
					data-options="
						valueField: 'id',    
				        textField: 'name',    
				        url: '${ctx }/auth/role/listData',
				        method: 'get',
				        onLoadSuccess: function(){
				        	$('#roleCodeComboBox').combobox('setValue', '${user.authRole.id }');
				        }   
				        " />  
				</td>
			<tr>
				<td width="15%">姓名:</td>
				<td width="35%" style="text-align: left;"><input type="text" name="realName" class="easyui-textbox" readonly="readonly" value="${user.realName}" style="width: 95%" /></td>
			</tr>
		</tbody>
	</table>
	<br>
	<div style="text-align: center">
		<button type="button" onclick="saveUserRole()" class="easyui-linkbutton">
			<i class="fa fa-floppy-o"></i> 保 存
		</button>
	</div>
</form>
<script type="text/javascript">
	function saveUserRole() {
		if(!$('#saveUserRoleForm').form('validate')){
			return false;
		}
		var data = $.ajaxSubmit('saveUserRoleForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listUserForm', 'layout_center_tabs');
				easyui_modal_close('editUserRoleDiv');
			});
		}
	}
</script>