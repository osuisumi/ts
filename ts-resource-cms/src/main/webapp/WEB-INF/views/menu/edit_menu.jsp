<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="saveMenuForm" action="${ctx}/menu" method="post">
<c:if test="${not empty menu.id }">
<input id="id" type="hidden" name="id" value="${menu.id }">
</c:if>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="alter-table-v">
		<tbody>
			<tr>
				<td width="15%">菜单名称:</td>
				<td width="35%" style="text-align: left;"><input type="text" name="name" class="easyui-textbox" required value="${menu.name}" style="width: 95%" /></td>
			</tr>
			<c:choose>
				<c:when test="${empty menu.id }">
				<tr>
					<td width="15%">唯一标识:</td>
					<td width="35%" style="text-align: left;"><input type="text" name="id" class="easyui-textbox" required style="width: 95%;" /></td>
				</tr>
				</c:when>
				<c:otherwise>
				<tr>
					<td width="15%">排序:</td>
					<td width="35%" style="text-align: left;"><input type="text" name="orderNo" value="${menu.orderNo }" class="easyui-textbox"  style="width: 95%;" /></td>
				</tr>
				</c:otherwise>
			</c:choose>
			<tr>
				<td width="15%">父菜单:</td>
				<td width="35%" style="text-align: left;">
					<select id="parentSelect"  name="parent.id" class="easyui-combobox" style="width: 95%" >
						<option value="">请选择</option>
						<c:forEach items="${parentMenus}" var="parentMenu">
							<option value="${parentMenu.id }">${parentMenu.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td width="15%">访问地址:</td>
				<td width="35%" style="text-align: left; height: 120px;"><input type="text" name="permission.actionURI" class="easyui-textbox" value="${menu.permission.actionURI}" style="width: 95%;" data-options="multiline:true, height:100" /></td>
			</tr>
		</tbody>
	</table>
	<br>
	<div style="text-align: center">
		<button type="button" onclick="saveMenu()" class="easyui-linkbutton">
			<i class="fa fa-floppy-o"></i> 保 存
		</button>
	</div>
</form>
<script type="text/javascript">
	function saveMenu() {
		var id = $('#id').val();
		if(id){
			$('#saveMenuForm').attr('action','${ctx}/menu/update');
		}
		if(!$('#saveMenuForm').form('validate')){
			return false;
		}
		var data = $.ajaxSubmit('saveMenuForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listMenuForm', 'layout_center_tabs');
				easyui_modal_close('editMenuDiv');
			});
		}else{
			alert("唯一标识不可重复");
		}
	}
	
	$(function(){
		//初始化编辑时，父菜单下拉框
		var parentId = "${menu.parent.id}";
		if(parentId){
			$('#parentSelect option[value='+parentId+']').attr('selected',true);
		}
	})
</script>