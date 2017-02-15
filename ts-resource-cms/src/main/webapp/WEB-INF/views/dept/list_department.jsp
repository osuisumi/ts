<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<shiro:hasRole name="schoolAdmin">
	<c:set var="hasSchoolAdminRole" value="true" />
</shiro:hasRole>
<shiro:hasRole name="superAdmin">
	<c:set var="superAdmin" value="true" />
</shiro:hasRole>
<form id="listDepartmentForm" action="${ctx}/dept">
	<input type="hidden" name="orders" value="${orders }">
	<div>
		<table cellpadding="0" cellspacing="0" width="100%" style="padding: 10px;">
			<tr>
				<td width="5%">标题：</td>
				<td width="10%"><input type="text" class="easyui-textbox" name="paramMap[deptName]" value="${searchParam.paramMap.deptName}"></td>
				<td></td>
			</tr>
			<tr>
				<td colspan="6"><br />
					<button type="button" class="easyui-linkbutton main-btn" onclick="easyui_tabs_update('listDepartmentForm','layout_center_tabs');">
						<i class="fa fa-search"></i> 查询
					</button> 
					<c:if test="${superAdmin }">
						<button type="button" class="easyui-linkbutton" onclick="addDepartment()">
							<i class="fa fa-plus"></i> 新增
						</button>
					</c:if>
					<button type="button" class="easyui-linkbutton" onclick="editDepartment()">
						<i class="fa fa-pencil"></i> 修改
					</button>
					<c:if test="${superAdmin }">
						<button type="button" class="easyui-linkbutton delete-btn" onclick="deleteDepartment()">
							<i class="fa fa-minus"></i> 删除
						</button>
					</c:if>
				</td>
			</tr>
		</table>
	</div>
	<table id="listDepartmentTable" class="" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false" checkOnSelect="true" selectOnCheck="true">
		<thead>
			<tr>
				<th width="10" data-options="field:'id',checkbox:true"></th>
				<th width="20" data-options="field:'deptName'">机构名称</th>
				<th width="20" data-options="field:'deptCode'">组织机构代码</th>
				<th width="20" data-options="field:'deptType'">机构类型</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty departments}">
				<c:forEach items="${departments}" var="department" >
					<tr>
						<td>${department.id}</td>
						<td>${department.deptName}</td>
						<td>${department.deptCode}</td>
						<td>${dict:getEntryName('DEPT_TYPE', department.deptType) }</td> 
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/include/pagination_table.jsp">
		<jsp:param name="pageForm" value="listDepartmentForm" />
	    <jsp:param name="tableId" value="listDepartmentTable"/>
		<jsp:param name="type" value="easyui" />
		<jsp:param name="tabId" value="layout_center_tabs"/>
		<jsp:param name="paginatorName" value="departmentsPaginator"  />
	</jsp:include>
</form>
<script>
	$(function(){
		if('${hasSchoolAdminRole}' == 'true'){
			$('#listDepartmentTable').datagrid({
				pagination: false
			});	
		}
	});

	function addDepartment() {
		var url = '${ctx}/dept/create';
		easyui_modal_open('editDepartmentDiv', '新增机构', 800, 500, url, true);
	}

	function editDepartment() {
		var row = $('#listDepartmentForm').find('#listDepartmentTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else {
			var id = row[0].id;
			easyui_modal_open('editDepartmentDiv', '修改机构', 800, 500, '${ctx}/dept/'+id+'/edit', true);
		}
	}
	
	function deleteDepartment(){
		var row = $('#listDepartmentForm').find('#listDepartmentTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确认要删除选中的机构吗？',function(r){    
			    if (r){    
					$.ajaxDelete('${ctx}/dept', $('#listDepartmentForm').serialize(), function(){
						easyui_tabs_update('listDepartmentForm', 'layout_center_tabs');
					});
			    }    
			}); 
		}
	}
</script>