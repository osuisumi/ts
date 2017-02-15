<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="listMenuForm">
	<div>
		<table cellpadding="0" cellspacing="0" width="100%" style="padding: 10px;">
			<tr>
				<td width="5%">菜单名称：</td>
				<td width="10%"><input type="text" id="paramMap_name" class="easyui-textbox" name="paramMap[name]" value="${searchParam.paramMap.name}"></td>
				<td></td>
			</tr>
			<tr>
				<td colspan="6"><br />
					<button type="button" class="easyui-linkbutton main-btn" onclick="doSearch()">
						<i class="fa fa-search"></i> 查询
					</button> 
					<button type="button" class="easyui-linkbutton" onclick="addMenu()">
						<i class="fa fa-plus"></i> 新增
					</button>
					<button type="button" class="easyui-linkbutton" onclick="editMenu()">
						<i class="fa fa-pencil"></i> 修改
					</button>
					<button type="button" class="easyui-linkbutton delete-btn" onclick="deleteMenu()">
						<i class="fa fa-minus"></i> 删除
					</button>
				</td>
			</tr>
		</table>
	</div>
	<table  id="listMenuTable" >
	 	<thead>
			<tr>
				<th width="10" data-options="field:'id',checkbox:true"></th>
				<th width="30%" data-options="field:'name'">菜单名称</th>
				<th width="65%" data-options="field:'url'">访问地址</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${menus }" var="menu">
				<tr>
					<td>${menu.id }</td>
					<td>${menu.name }</td>
					<td>${menu.permission.actionURI }</td>
				</tr>
			</c:forEach>
		</tbody> 
	</table>
</form>
<script>
	function addMenu() {
		var url = '${ctx}/menu/create';
		easyui_modal_open('editMenuDiv', '新增菜单', 800, 500, url, true);
	}

	function editMenu() {
		var row = $('#listMenuTable').treegrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else {
			var id = row[0].id;
			easyui_modal_open('editMenuDiv', '修改菜单', 800, 500, '${ctx}/menu/'+id+'/edit', true);
		}
	}
	
	function deleteMenu(){
		var row = $('#listMenuTable').treegrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确认要删除选中的菜单吗？',function(r){    
			    if (r){    
			    	var hasParent = false;
			    	$(row).each(function(){
			    		var parentname = this.parentname;
			    		if(parentname == ''){
			    			hasParent = true;
			    			return false;
			    		}
					});
			    	if(hasParent){
			    		$.messager.confirm('确认','选中的菜单中包含一级菜单，删除该菜单将一并删除其所有的子菜单',function(r){
			    			if(r){
			    				$.ajaxDelete('${ctx}/menu/delete', $('#listMenuForm').serialize(), function(){
									easyui_tabs_update('listRoleForm', 'layout_center_tabs');
								});
			    			}
			    		});
			    	}else{
			    		$.ajaxDelete('${ctx}/menu/delete', $('#listMenuForm').serialize(), function(){
							easyui_tabs_update('listRoleForm', 'layout_center_tabs');
						});
			    	}
			    }    
			}); 
		}
	}
	
	function doSearch(){
		$('#listMenuTable').treegrid('load',{
			'paramMap[name]': $('#paramMap_name').val()
		});
	}
	
	$('#listMenuTable').treegrid({
		idField:'id',
		treeField:'name',
		singleSelect:false,
		checkOnSelect:true,
		selectOnCheck:true,
		pagination:'true',
		onBeforeLoad:function(row,param){
			if(row){
				$(this).treegrid('options').url='${ctx}/menu/node?parentId='+row.id;
			}
		}
	})
</script>