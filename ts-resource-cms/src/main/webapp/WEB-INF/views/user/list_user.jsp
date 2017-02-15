<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="listUserForm_${searchParam.paramMap.roleId }" action="${ctx}/user">
	<input type="hidden" name="orders" value="${orders }">
	<div>
		<table cellpadding="0" cellspacing="0" width="100%" style="padding: 10px;">
			<tr>
				<td width="5%">用户名：</td>
				<td width="10%"><input type="text" class="easyui-textbox" name="paramMap[userName]" value="${searchParam.paramMap.userName}"></td>
				<td width="5%">姓名：</td>
				<td width="10%"><input type="text" class="easyui-textbox" name="paramMap[realName]" value="${searchParam.paramMap.realName}"></td>
				<td width="5%">所在单位：</td>
				<td width="10%"><input type="text" class="easyui-textbox" name="paramMap[deptName]" value="${searchParam.paramMap.deptName}"></td>
				<td width="5%">角色：</td>
				<td width="10%">
					<input id="roleCodeComboBox" name="paramMap[roleCode]" class="easyui-combobox" value="${searchParam.paramMap.roleCode }" 
					data-options="
						valueField: 'code',    
				        textField: 'name',    
				        url: '${ctx }/auth/role/listData',
				        method: 'get',
				        onLoadSuccess: function(){
				        	$('#roleCodeComboBox').combobox('setValue', '${searchParam.paramMap.roleCode }');
				        }   
				        " />  
				</td>
				<td></td>
			</tr>
			<tr>
				<td colspan="7"><br />
					<button type="button" class="easyui-linkbutton main-btn" onclick="easyui_tabs_update('listUserForm_${searchParam.paramMap.roleId }','layout_center_tabs');">
						<i class="fa fa-search"></i> 查询
					</button> 
					<button type="button" class="easyui-linkbutton" onclick="addUser()">
						<i class="fa fa-plus-square-o"></i> 新增
					</button>
					<button type="button" class="easyui-linkbutton" onclick="editUser()">
						<i class="fa fa-edit"></i> 修改
					</button>
					<button type="button" class="easyui-linkbutton delete-btn" onclick="deleteUser()">
						<i class="fa fa-trash-o"></i> 删除
					</button>
					<button type="button" class="easyui-linkbutton" onclick="editUserRole()">
						<i class="fa fa-user"></i> 角色授权
					</button>
					<button type="button" class="easyui-linkbutton" onclick="updateAccountState('2')">
						<i class="fa fa-lock"></i> 账户锁定
					</button>
					<button type="button" class="easyui-linkbutton" onclick="updateAccountState('1')">
						<i class="fa fa-unlock"></i> 账户解锁
					</button>
					<button type="button" class="easyui-linkbutton" onclick="exportUser()">
						<i class="fa fa-reply-all"></i> 导出
					</button>
					<button type="button" class="easyui-linkbutton" onclick="resetPassword()">
						<i class="fa fa-user"></i> 重置密码
					</button>
				</td>
			</tr>
		</table>
	</div>
	<table id="listUserTable_${searchParam.paramMap.roleId }" class="" pagination="true" rownumbers="true" fitColumns="true" singleSelect="false" checkOnSelect="true" selectOnCheck="true">
		<thead>
			<tr>
				<th width="10" data-options="field:'id',checkbox:true"></th>
				<th data-options="field:'accountId', hidden:true"></th>
				<th width="20" data-options="field:'userName'">用户名</th>
				<th width="20" data-options="field:'roleCode'">角色</th>
				<th width="20" data-options="field:'realName'">姓名</th>
				<th width="20" data-options="field:'deptName'">所在单位</th>
				<th width="20" data-options="field:'sex'">性别</th>
				<th width="20" data-options="field:'phone'">联系电话</th>
				<th width="20" data-options="field:'email'">邮箱</th>
				<th width="20" data-options="field:'state'">状态</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty users}">
				<c:forEach items="${users}" var="user" >
					<tr>
						<td>${user.id}</td>
						<td>${user.account.id}</td>
						<td>${user.account.userName}</td>
						<td>${user.authRole.name}</td>
						<td>${user.realName}</td>
						<td>${user.department.deptName}</td>
						<td>${dict:getEntryName('SEX', user.sex) }</td> 
						<td>${user.phone}</td>
						<td>${user.email}</td>
						<td>${dict:getEntryName('ACCOUNT_STATE', user.account.state) }</td> 
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/include/pagination_table.jsp">
		<jsp:param name="pageForm" value="listUserForm_${searchParam.paramMap.roleId }" />
	    <jsp:param name="tableId" value="listUserTable_${searchParam.paramMap.roleId }"/>
		<jsp:param name="type" value="easyui" />
		<jsp:param name="tabId" value="layout_center_tabs"/>
		<jsp:param name="paginatorName" value="usersPaginator"  />
	</jsp:include>
</form>
<script>
	function addUser() {
		var url = '${ctx}/user/create';
		easyui_modal_open('editUserDiv', '新增教师', 800, 500, url, true);
	}

	function editUser() {
		var row = $('#listUserForm_${searchParam.paramMap.roleId }').find('#listUserTable_${searchParam.paramMap.roleId }').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else {
			var id = row[0].id;
			easyui_modal_open('editUserDiv', '修改教师信息', 800, 500, '${ctx}/user/'+id+'/edit', true);
		}
	}
	
	function editUserRole() {
		var row = $('#listUserForm_${searchParam.paramMap.roleId }').find('#listUserTable_${searchParam.paramMap.roleId }').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else {
			var id = row[0].id;
			easyui_modal_open('editUserRoleDiv', '角色授权', 500, 300, '${ctx}/user/'+id+'/editUserRole', true);
		}
	}
	
	function deleteUser(){
		var row = $('#listUserForm_${searchParam.paramMap.roleId }').find('#listUserTable_${searchParam.paramMap.roleId }').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确认要删除选中的用户吗？',function(r){    
			    if (r){    
					$.ajaxDelete('${ctx}/user', $('#listUserForm_${searchParam.paramMap.roleId }').serialize(), function(){
						easyui_tabs_update('listUserForm_${searchParam.paramMap.roleId }', 'layout_center_tabs');
					});
			    }    
			}); 
		}
	}
	
	function updateAccountState(state){
		var row = $('#listUserForm_${searchParam.paramMap.roleId }').find('#listUserTable_${searchParam.paramMap.roleId }').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			var msg = "确定要锁定选中的账户吗?";
			if(state == '1'){
				msg = "确定要解锁选中的账户吗?";
			}
			$.messager.confirm('确认',msg,function(r){    
			    if (r){    
			    	var data = 'state='+state;
			    	$(row).each(function(){
			    		data += '&id='+this.accountId;
					});
					$.put('${ctx}/account', data, function(){
						easyui_tabs_update('listUserForm_${searchParam.paramMap.roleId }', 'layout_center_tabs');
					});
			    }    
			}); 
		}
	}
	
	function exportUser(){
		window.open('${ctx}/user/exportUser?'+$('#listUserForm_${searchParam.paramMap.roleId }').serialize());
	}
	
	function resetPassword(){
		var row = $('#listUserForm_${searchParam.paramMap.roleId }').find('#listUserTable_${searchParam.paramMap.roleId }').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确认要从重置选中的账号密码吗？',function(r){    
			    if (r){    
					$.post('${ctx}/user/resetPassword', $('#listUserForm_${searchParam.paramMap.roleId }').serialize(), function(){
						alert('重置成功');
						easyui_tabs_update('listUserForm_${searchParam.paramMap.roleId }', 'layout_center_tabs');
					});
			    }    
			}); 
		}
	}
</script>