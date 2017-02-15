<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="listWorkshopForm" action="${ctx}/workshop">
<input type="hidden" name="orders" value="${orders }">
	<div>
		<table cellpadding="0" cellspacing="0" width="100%" style="padding: 10px;">
			<tr>
				<td width="5%">工作室名称：</td>
				<td width="10%"><input type="text" class="easyui-textbox" name="paramMap[name]" value="${searchParam.paramMap.name}"></td>
				<td></td>
			</tr>
			<tr>
				<td colspan="6"><br />
					<button type="button" class="easyui-linkbutton main-btn" onclick="easyui_tabs_update('listWorkshopForm','layout_center_tabs');">
						<i class="fa fa-search"></i> 查询
					</button> 
					<button type="button" class="easyui-linkbutton" onclick="addWorkshop()">
						<i class="fa fa-plus"></i> 新增
					</button>
					<button type="button" class="easyui-linkbutton" onclick="editWorkshop()">
						<i class="fa fa-pencil"></i> 修改
					</button>
					<button type="button" class="easyui-linkbutton delete-btn" onclick="deleteWorkshop()">
						<i class="fa fa-minus"></i> 删除
					</button>
				</td>
			</tr>
		</table>
	</div>
	<table id="listWorkshopTable" class="" pagination="true" rownumbers="true" fitColumns="true" singleSelect="false" checkOnSelect="true" selectOnCheck="true">
		<thead>
			<tr>
				<th width="10" data-options="field:'id',checkbox:true"></th>
				<th width="20" data-options="field:'name'">工作室名称</th>
				<th width="20" data-options="field:'summary'">描述</th>
				<!-- <th width="20" data-options="field:'imageUrl'">封面图片</th> -->
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty workshops}">
				<c:forEach items="${workshops}" var="workshop" >
					<tr>
						<td>${workshop.id}</td>
						<td>${workshop.name}</td>
						<td>${workshop.summary}</td>
						<%-- <td>${workshop.imageUrl}</td>  --%>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/include/pagination_table.jsp">
		<jsp:param name="pageForm" value="listWorkshopForm" />
	    <jsp:param name="tableId" value="listWorkshopTable"/>
		<jsp:param name="type" value="easyui" />
		<jsp:param name="tabId" value="layout_center_tabs"/>
		<jsp:param name="paginatorName" value="workshopsPaginator"  />
	</jsp:include>
</form>
<script>
	function addWorkshop() {
		var url = '${ctx}/workshop/create';
		easyui_modal_open('editWorkshopDiv', '新增机构', 800, 500, url, true);
	}

	function editWorkshop() {
		var row = $('#listWorkshopForm').find('#listWorkshopTable').datagrid('getSelections');
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
			easyui_modal_open('editWorkshopDiv', '修改机构', 800, 500, '${ctx}/bizWorkshop/'+id+'/edit', true);
		}
	}
	
	function deleteWorkshop(){
		var row = $('#listWorkshopForm').find('#listWorkshopTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确认要删除选中的工作室吗？',function(r){    
			    if (r){    
			    	$.ajaxDelete('${ctx}/workshop', $('#listWorkshopForm').serialize(), function(){
						easyui_tabs_update('listWorkshopForm', 'layout_center_tabs');
					});
			    }    
			}); 
		}
	}
	
</script>