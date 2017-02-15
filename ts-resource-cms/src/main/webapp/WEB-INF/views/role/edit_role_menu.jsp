<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="saveRoleMenuForm" action="${ctx}/auth/role/updateRoleMenu" method="put">
	<input type="hidden" name="id" value="${authRole.id }">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="alter-table-v">
		<tbody>
			<tr>
				<td width="15%">权限配置:</td>
				<td width="35%" style="text-align: left;">
					<ul id="menuTree" style="height: 350px; padding: 10px; overflow: auto;" data-options="checkbox:true">
						<c:forEach items="${menuTree }" var="menu">
							<li id="${menu.id }">
								<span>${menu.name }</span>   
								<c:if test="${not empty menu.children }">
									<ul>   
										<c:forEach items="${menu.children }" var="child">
											<li id="${child.id }" class="child">   
						                        <span><a href="###">${child.name }</a></span>   
						                    </li>  
										</c:forEach>
									</ul>
								</c:if>
							</li>
						</c:forEach>
					</ul>  
				</td>
			</tr>
		</tbody>
	</table>
	<br>
	<div style="text-align: center">
		<button type="button" onclick="saveRoleMenu()" class="easyui-linkbutton">
			<i class="fa fa-floppy-o"></i> 保 存
		</button>
	</div>
</form>
<script type="text/javascript">
	$(function(){
		var menu = '${menus}';
		$('#menuTree li.child').each(function(){
			if(menu.indexOf($(this).attr('id')) >= 0){
				$(this).attr('checked', 'true');
			}
		});
		
		$('#menuTree').tree();
	});

	function saveRoleMenu() {
		var nodes = $('#menuTree').tree('getChecked',['indeterminate','checked']);
		$('#saveRoleMenuForm .menuParam').empty();
		$(nodes).each(function(i){
			$('#saveRoleMenuForm').append('<input type="hidden" name="menus['+i+'].id" value="'+this.id+'">');
		});
		var data = $.ajaxSubmit('saveRoleMenuForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_modal_close('editRoleDiv');
			});
		}
	}
</script>