<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<shiro:hasRole name="schoolAdmin">
	<c:set var="hasSchoolAdminRole" value="true" />				
</shiro:hasRole>
<form id="listUserForm_${searchParam.paramMap.roleId }" action="${ctx}/user">
	<input type="hidden" name="paramMap[roleId]" value="${searchParam.paramMap.roleId }">
	<input type="hidden" name="paramMap[deptId]" value="${searchParam.paramMap.deptId }">
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
				<td></td>
			</tr>
			<tr>
				<td colspan="9"><br />
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
					<button type="button" class="easyui-linkbutton" onclick="goImport()">
						<i class="fa fa-share-alt"></i> 导入
					</button>
					<button type="button" class="easyui-linkbutton" onclick="exportTeacher()">
						<i class="fa fa-reply-all"></i> 导出
					</button>
					<button type="button" class="easyui-linkbutton" onclick="resetPassword()">
						<i class="fa fa-user"></i> 重置密码
					</button>
					<c:if test="${hasSchoolAdminRole }">
						<button type="button" class="easyui-linkbutton" onclick="updateAccountState('3')">
							<i class="fa fa-user"></i> 标志单位错误
						</button>
						<button type="button" class="easyui-linkbutton" onclick="updateAccountState('1')">
							<i class="fa fa-user"></i> 取消单位错误标志
						</button>
					</c:if>
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
				<th width="20" data-options="field:'realName'">姓名</th>
				<th width="20" data-options="field:'deptName'">所在单位</th>
				<th width="20" data-options="field:'sex'">性别</th>
				<th width="20" data-options="field:'post'">岗位信息</th>
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
						<td>${user.realName}</td>
						<td>${user.department.deptName}</td>
						<td>${dict:getEntryName('SEX', user.sex) }</td> 
						<td>${dict:getEntryName('POST', user.post) }</td>
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
		var url = '${ctx}/user/create?authRole.id=${searchParam.paramMap.roleId }';
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
			easyui_modal_open('editUserDiv', '修改教师信息', 800, 500, '${ctx}/user/'+id+'/edit?authRole.id=${searchParam.paramMap.roleId }', true);
		}
	}
	
	function deleteUser(){
		var row = $('#listUserForm_${searchParam.paramMap.roleId }').find('#listUserTable_${searchParam.paramMap.roleId }').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确认要删除选中的教师吗？',function(r){    
			    if (r){    
					$.ajaxDelete('${ctx}/user', $('#listUserForm_${searchParam.paramMap.roleId }').serialize(), function(){
						easyui_tabs_update('listUserForm_${searchParam.paramMap.roleId }', 'layout_center_tabs');
					});
			    }    
			}); 
		}
	}
	
	function goImport() {
		var url = '${ctx}/user/goImport';
		easyui_modal_open('importUserDiv', '导入教师', 500, 250, url, true);
	}
	
	function exportTeacher(){
		window.open('${ctx}/user/exportTeacher?'+$('#listUserForm_${searchParam.paramMap.roleId }').serialize());
	}
	
	function updateAccountState(state){
		var row = $('#listUserForm_${searchParam.paramMap.roleId }').find('#listUserTable_${searchParam.paramMap.roleId }').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			var msg = "确定要取消单位错误标志吗?";
			if(state == '3'){
				msg = "请确认所选中的账户是否存在单位错误?";
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