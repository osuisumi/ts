<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="listRoleForm" action="${ctx}/auth/role">
	<div>
		<table cellpadding="0" cellspacing="0" width="100%" style="padding: 10px;">
			<tr>
				<td width="5%">角色名称：</td>
				<td width="10%"><input type="text" class="easyui-textbox" name="paramMap[name]" value="${searchParam.paramMap.name}"></td>
				<td></td>
			</tr>
			<tr>
				<td colspan="6"><br />
					<button type="button" class="easyui-linkbutton main-btn" onclick="easyui_tabs_update('listRoleForm','layout_center_tabs');">
						<i class="fa fa-search"></i> 查询
					</button> 
					<button type="button" class="easyui-linkbutton" onclick="addRole()">
						<i class="fa fa-plus"></i> 新增
					</button>
					<button type="button" class="easyui-linkbutton" onclick="editRole()">
						<i class="fa fa-pencil"></i> 修改
					</button>
					<button type="button" class="easyui-linkbutton delete-btn" onclick="deleteRole()">
						<i class="fa fa-minus"></i> 删除
					</button>
					<button type="button" class="easyui-linkbutton delete-btn" onclick="editRoleMenu()">
						<i class="fa fa-user"></i> 权限配置
					</button>
					<button type="button" class="easyui-linkbutton delete-btn" onclick="goImportTextBook()">
						导入教材
					</button>
				</td>
			</tr>
		</table>
	</div>
	<table id="listRoleTable" class="" pagination="true" rownumbers="true" fitColumns="true" singleSelect="false" checkOnSelect="true" selectOnCheck="true">
		<thead>
			<tr>
				<th width="10" data-options="field:'id',checkbox:true"></th>
				<th width="20" data-options="field:'name'">角色名称</th>
				<th width="20" data-options="field:'summary'">描述</th>
				<th width="20" data-options="field:'code'">角色标识</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty roles}">
				<c:forEach items="${roles}" var="role" >
					<tr>
						<td>${role.id}</td>
						<td>${role.name}</td>
						<td>${role.summary}</td>
						<td>${role.code}</td> 
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/include/pagination_table.jsp">
		<jsp:param name="pageForm" value="listRoleForm" />
	    <jsp:param name="tableId" value="listRoleTable"/>
		<jsp:param name="type" value="easyui" />
		<jsp:param name="tabId" value="layout_center_tabs"/>
		<jsp:param name="paginatorName" value="rolesPaginator"  />
	</jsp:include>
</form>
<script>
	function addRole() {
		var url = '${ctx}/auth/role/create';
		easyui_modal_open('editRoleDiv', '新增机构', 800, 500, url, true);
	}

	function editRole() {
		var row = $('#listRoleForm').find('#listRoleTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else {
			var id = row[0].id;
			if(id == '1' || id == '2' || id == '3' || id == '4' || id == '-1'){
				alert('此角色不能编辑');
				return false;
			}
			easyui_modal_open('editRoleDiv', '修改机构', 800, 500, '${ctx}/auth/role/'+id+'/edit', true);
		}
	}
	
	function deleteRole(){
		var row = $('#listRoleForm').find('#listRoleTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确认要删除选中的机构吗？',function(r){    
			    if (r){    
			    	var isReturn = false;
			    	$(row).each(function(){
			    		var id = this.id;
			    		if(id == '1' || id == '2' || id == '3' || id == '4' || id == '-1'){
							alert('存在不能删除的角色,请重新选择');
							isReturn = true;
							return false;
						}
					});
			    	if(isReturn){
			    		return false;
			    	}
			    	$.ajaxDelete('${ctx}/auth/role', $('#listRoleForm').serialize(), function(){
						easyui_tabs_update('listRoleForm', 'layout_center_tabs');
					});
			    }    
			}); 
		}
	}
	
	function editRoleMenu(){
		var row = $('#listRoleForm').find('#listRoleTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时对多个角色进行权限配置', 'warning');
			return false;
		}else {
			var id = row[0].id;
			easyui_modal_open('editRoleDiv', '权限配置', 800, 500, '${ctx}/auth/role/'+id+'/editRoleMenu', true);
		}
	}
	
	function goImportTextBook(){
		var url = '${ctx}/textBook/goImport';
		easyui_modal_open('importTextbookDiv', '导入教材', 400, 200, url, true);
	}
</script>