<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="saveUserForm" action="${ctx}/user" method="post">
	<c:if test="${not empty user.id }">
		<input type="hidden" name="id" value="${user.id }">
		<input type="hidden" name="account.id" value="${user.account.id }">
		<input type="hidden" name="userDept.id" value="${user.userDept.id }">
		<script>
			$('#saveUserForm').attr('action', '${ctx}/user/${user.id }');
			$('#saveUserForm').attr('method', 'PUT');
		</script>
	</c:if>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="alter-table-v">
		<tbody>
			<tr>
				<td width="15%">用户名:</td>
				<td width="35%" style="text-align: left;"><input id="userNameParam" type="text" name="account.userName" class="easyui-textbox" data-options="required:true,validType:'userName[\'${user.account.userName }\']'" value="${user.account.userName}" style="width: 95%" /></td>
			</tr>
			<c:if test="${empty user.id }">
				<tr>
					<td width="15%">密码:</td>
					<td width="35%" style="text-align: left;"><input id="passwordParam" type="password" name="account.password" class="easyui-textbox" data-options="required:true" value="${user.account.password}" style="width: 95%" /></td>
				</tr>
				<tr>
					<td width="15%">密码确认:</td>
					<td width="35%" style="text-align: left;"><input id="repswParam" type="password" class="easyui-textbox" data-options="required:true,validType:'same[\'passwordParam\']'" value="${user.account.password}" style="width: 95%" /></td>
				</tr>
			</c:if>
			<tr>
				<td width="15%">角色授权:</td>
				<td width="35%" style="text-align: left;">
					<input id="roleCodeComboBox" name="authRole.id" class="easyui-combobox" value="${user.authRole.id }" style="width:200px;"
					data-options="
						valueField: 'id',    
				        textField: 'name',    
				        url: '${ctx }/auth/role/listData',
				        method: 'get',
				        required:true,
				        onLoadSuccess: function(){
				        	$('#roleCodeComboBox').combobox('setValue', '${user.authRole.id }');
				        }   
				        " />  
				</td>
			<tr>
				<td width="15%">姓名:</td>
				<td width="35%" style="text-align: left;"><input type="text" name="realName" class="easyui-textbox" required value="${user.realName}" style="width: 95%" /></td>
			</tr>
			<c:if test="${empty user.id }">
				<tr>
					<td width="15%">身份证号:</td>
					<td width="35%" style="text-align: left;"><input type="text" name="paperworkNo" class="easyui-textbox" data-options="required:true,validType: ['idcard', 'paperworkNo[\'${user.paperworkNo }\']']" value="${user.paperworkNo}" style="width: 95%" /></td>
				</tr>
			</c:if>
			<tr>
				<td width="15%">所在单位:</td>
				<td width="35%" style="text-align: left;">
					<input id="deptComboBox" name="userDept.deptId" class="easyui-combobox" value="${user.department.id }" style="width:200px;" data-options="    
				        valueField: 'id',    
				        textField: 'deptName',    
				        url: '${ctx }/dept/listData',
				        method: 'get',
				        required:true,
				        onLoadSuccess: function(){
				        	$('#deptComboBox').combobox('setValue', '${user.department.id}');
				        }   
				        " />  
				</td>
			</tr>
			<tr>
				<td width="15%">性别:</td>
				<td width="35%" style="text-align: left;">
					<select class="easyui-combobox" name="sex" style="width:200px;">   
					    ${dict:getEntryOptionsSelected('SEX', user.sex) }
					</select> 
				</td>
			</tr>
			<tr>
				<td width="15%">联系电话:</td>
				<td width="35%" style="text-align: left;"><input type="text" name="phone" class="easyui-textbox" value="${user.phone}" style="width: 95%" /></td>
			</tr>
			<tr>
				<td width="15%">电子邮箱:</td>
				<td width="35%" style="text-align: left;"><input type="text" name="email" class="easyui-textbox" data-options="validType:'email'" value="${user.email}" style="width: 95%" /></td>
			</tr>
		</tbody>
	</table>
	<br>
	<div style="text-align: center">
		<button type="button" onclick="saveUser()" class="easyui-linkbutton">
			<i class="fa fa-floppy-o"></i> 保 存
		</button>
	</div>
</form>
<script type="text/javascript">
	function saveUser() {
		if(!$('#saveUserForm').form('validate')){
			return false;
		}
		var data = $.ajaxSubmit('saveUserForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listUserForm', 'layout_center_tabs');
				easyui_modal_close('editUserDiv');
			});
		}
	}
</script>