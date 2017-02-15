<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="listDiscoveryForm" action="${ctx}/discovery">
	<input type="hidden" name="paramMap[type]" value="${searchParam.paramMap.type }">
	<input type="hidden" name="orders" value="${orders }">
	<div>
		<table cellpadding="0" cellspacing="0" width="100%" style="padding: 10px;">
			<tr>
				<td width="50px">标题：</td>
				<td width="200px">
					<input id="titleTextbox" name="paramMap[title]" class="easyui-textbox" value="${searchParam.paramMap.title }" style="width:200px;"
					/>  
				</td>
				<td width="30px"></td>
				<td width="70px">发布时间：</td>
				<td width="200px"><input class="easyui-datebox" name="minCreateTime" value="${minCreateTime }" data-options="editable:false,buttons:buttons"> 至</td>
				<td width="110px"><input class="easyui-datebox" name="maxCreateTime" value="${maxCreateTime }" data-options="editable:false,buttons:buttons"> </td>
				<td width="30px"></td>
				<td width="50px">状态：</td>
				<td width="200px">
					<select id="stateComboBox" name="paramMap[state]" class="easyui-combobox" value="${searchParam.paramMap.state }" style="width:200px;">  
						<option value=''>请选择</option>
						${dict:getEntryOptionsSelected('EDIT_STATE',searchParam.paramMap.state)}
					</select>
				</td>
				<td></td>
			</tr>
			<tr>
				<td colspan="7"><br />
					<button type="button" class="easyui-linkbutton main-btn" onclick="easyui_tabs_update('listDiscoveryForm','layout_center_tabs');">
						<i class="fa fa-search"></i> 查询
					</button> 
					<button type="button" class="easyui-linkbutton" onclick="addDiscovery()">
						<i class="fa fa-plus"></i> 新增
					</button>
					<button type="button" class="easyui-linkbutton" onclick="editDiscovery()">
						<i class="fa fa-pencil"></i> 修改
					</button>
					<button type="button" class="easyui-linkbutton delete-btn" onclick="deleteDiscovery()">
						<i class="fa fa-trash-o"></i> 删除
					</button>
					<button type="button" class="easyui-linkbutton" onclick="updateResource('4')">
						<i class="fa fa fa-check"></i> 审核通过
					</button>
					<button type="button" class="easyui-linkbutton" onclick="updateResource('5')">
						<i class="fa fa-times"></i> 审核不通过
					</button>
				</td>
			</tr>
		</table>
	</div>
	<table id="listDiscoveryTable" class="" pagination="true" rownumbers="true" fitColumns="true" singleSelect="false" checkOnSelect="true" selectOnCheck="true">
		<thead>
			<tr>
				<th width="10" data-options="field:'id',checkbox:true"></th>
				<th data-options="field:'creator', hidden:true"></th>
				<th width="20" data-options="field:'title'">标题</th>
				<th width="20" data-options="field:'extendType'">分类</th>
				<th width="20" data-options="field:'createTime'">发布时间</th>
				<th width="20" data-options="field:'state'">审核情况</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty discoverys}">
				<c:forEach items="${discoverys}" var="discovery" >
					<tr>
						<td>${discovery.id}</td>
						<td>${discovery.creator.id }</td>
						<td><a href="###" onclick="viewDiscovery('${discovery.id}')" style="color: blue">${discovery.title}</a></td>
						<td>${dict:getEntryName('RESOURCE_DISCOVERY_TYPE',discovery.resourceExtend.type)}</td>
						<td>${sipc:formatDate(discovery.createTime,'yyyy-MM-dd') }</td>
						<td>
							<c:choose>
								<c:when test="${discovery.state eq '3' }">
									<span style="color: #19A2E9">
								</c:when>
								<c:when test="${discovery.state eq '5' }">
									<span style="color: #F00">
								</c:when>
							</c:choose>
							${dict:getEntryName('EDIT_STATE', discovery.state) }</span>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/include/pagination_table.jsp">
		<jsp:param name="pageForm" value="listDiscoveryForm" />
	    <jsp:param name="tableId" value="listDiscoveryTable"/>
		<jsp:param name="type" value="easyui" />
		<jsp:param name="tabId" value="layout_center_tabs"/>
		<jsp:param name="paginatorName" value="discoverysPaginator"  />
	</jsp:include>
</form>
<script>
	var buttons = $.extend([], $.fn.datebox.defaults.buttons);
	buttons.splice(1, 0, {
		text: '清空',
		handler: function(target){
			$(target).datebox('setValue','');
		}
	});
	function updateResource(state){
		var row = $('#listDiscoveryForm').find('#listDiscoveryTable').datagrid('getSelections');
		var msg = '确定要通过所选资源的审核吗?';
		if(state == '5'){
			msg = '确定不通过所选资源的审核吗?'
		}
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认',msg,function(r){    
			    if (r){    
					$.ajaxDelete('${ctx}/resource/updateResource', 'state='+state+'&'+$('#listDiscoveryForm').serialize(), function(){
						easyui_tabs_update('listDiscoveryForm', 'layout_center_tabs');
					});
			    }    
			}); 
		}
	}
	
	function addDiscovery(){
		var url = '${ctx}/discovery/create';
		easyui_modal_open('editDiscoveryDiv', '新增资源', 800, 500, url, true);
	}
	
	function editDiscovery() {
		var row = $('#listDiscoveryTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		} else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		} else {
			var creator = row[0].creator;
			if(creator != '${sessionScope.loginer.id}'){
				alert('只能编辑自己发布的资源');
				return false;
			}
			var id = row[0].id;
			easyui_modal_open('editDiscoveryDiv', '编辑通知', 800, 500, '${ctx}/discovery/' + id + '/edit', true);
		}
	}
	
	function deleteDiscovery(){
		var rows = $('#listDiscoveryTable').datagrid('getSelections');
		if (rows.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		} else {
			$.messager.confirm('确认', '确认要删除选中记录吗？', function(r) {
				if (r) {
					var ids = '';
					$.each($(rows),function(i,row){
						ids = ids + row.id + ',';
					});
					ids = ids.substr(0,ids.length-1);
					$.post('${ctx}/discovery/delete/deleteByIds', {
						"ids":ids
					}, function() {
						easyui_tabs_update('listDiscoveryForm', 'layout_center_tabs');
					});
				}
			});
		}
	}
	
	$(function(){
		var except = ['1','2'];
		var options = $('#stateComboBox option');
		$.each($(options),function(i,option){
			var optionValue = $(option).attr('value');
			for(var i=0;i<except.length;i++){
				if(optionValue == except[i]){
					$(option).remove();
					break;
				}
			}
		});
	})
	
	function viewDiscovery(id){
		var url = '${ctx}/discovery/'+id+'/view';
		easyui_modal_open('viewDiscoveryDiv', '发现详情', 800, 500, url, true);
	}
	
</script>