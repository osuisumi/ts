<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<shiro:hasRole name="editor">
	<c:set var="hasEditorRole" value="true" />
</shiro:hasRole>
<form id="listClassifyResourceForm" action="${ctx}/resource/listResource">
	<input type="hidden" name="paramMap[type]" value="${searchParam.paramMap.type }">
	<input type="hidden" name="orders" value="${orders }">
	<div>
		<table cellpadding="0" cellspacing="0" width="100%" style="padding: 10px;">
			<tr>
				<td width="50px">分类：</td>
				<td width="200px">
					<input id="classifyTypeComboBox" name="paramMap[extendType]" class="easyui-combobox" value="${searchParam.paramMap.extendType }" style="width:200px;"
					data-options="
						valueField: 'dictValue',    
				        textField: 'dictName',    
				        method: 'get',
				        onLoadSuccess: function(data){
				       		if('${searchParam.paramMap.extendType }' != ''){
				       			$('#classifyTypeComboBox').combobox('select', '${searchParam.paramMap.extendType }');
				       		}else{
				       			$('#classifyTypeComboBox').combobox('select', '');
				       		}
				        }   
				        " />  
				    <script>
				    	$(function(){
				    		$.get('${ctx }/dict/getEntryList','dictTypeCode=RESOURCE_CLASSIFY_TYPE',function(data){
				    			data.unshift({"dictName":"请选择","dictValue":""});
				    			$('#classifyTypeComboBox').combobox('loadData', data);
				    		});
				    	});
				    </script>
				</td>
				<td width="30px"></td>
				<td width="50px">岗位：</td>
				<td width="200px">
					<input id="postComboBox" name="paramMap[post]" class="easyui-combobox" value="${searchParam.paramMap.post }" style="width:200px;"
					data-options="
						valueField: 'dictValue',    
				        textField: 'dictName',    
				        method: 'get',
				        onLoadSuccess: function(data){
				       		if('${searchParam.paramMap.post }' != ''){
				       			$('#postComboBox').combobox('select', '${searchParam.paramMap.post }');
				       		}else{
				       			$('#postComboBox').combobox('select', '');
				       		}
				        }   
				        " />  
				    <script>
				    	$(function(){
				    		$.get('${ctx }/dict/getEntryList','dictTypeCode=POST',function(data){
				    			data.unshift({"dictName":"请选择","dictValue":""});
				    			$('#postComboBox').combobox('loadData', data);
				    		});
				    	});
				    </script>
				</td>
				<td width="30px"></td>
				<td width="50px">关键字：</td>
				<td width="200px"><input type="text" class="easyui-textbox" name="paramMap[title]" value="${searchParam.paramMap.title}"></td>
				<td width="40%"></td>
			</tr>
			<tr>
				<td colspan="7"><br />
					<button type="button" class="easyui-linkbutton main-btn" onclick="easyui_tabs_update('listClassifyResourceForm','layout_center_tabs');">
						<i class="fa fa-search"></i> 查询
					</button> 
					<button type="button" class="easyui-linkbutton" onclick="addResource()">
						<i class="fa fa-plus"></i> 新增
					</button>
					<button type="button" class="easyui-linkbutton" onclick="editResource()">
						<i class="fa fa-pencil"></i> 修改
					</button>
					<button type="button" class="easyui-linkbutton delete-btn" onclick="deleteResource()">
						<i class="fa fa-trash-o"></i> 删除
					</button>
					<button type="button" class="easyui-linkbutton delete-btn" onclick="goImport()">
						<i class="fa fa-share-alt"></i> 导入资源
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
	<table id="listClassifyResourceTable" class="" pagination="true" rownumbers="true" fitColumns="true" singleSelect="false" checkOnSelect="true" selectOnCheck="true">
		<thead>
			<tr>
				<th width="10" data-options="field:'id',checkbox:true"></th>
				<th data-options="field:'creator', hidden:true"></th>
				<th width="20" data-options="field:'title'">标题</th>
				<th width="20" data-options="field:'post'">适用岗位</th>
				<th width="20" data-options="field:'extendType'">分类</th>
				<th width="20" data-options="field:'creatorName'">上传者</th>
				<th width="20" data-options="field:'createTime'">发布时间</th>
				<th width="20" data-options="field:'state'">审核情况</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty resources}">
				<c:forEach items="${resources}" var="resource" >
					<tr>
						<td>${resource.id}</td>
						<td>${resource.creator.id }</td>
						<td><a href="###" onclick="viewResource('${resource.id}')" style="color: blue">${resource.title}</a></td>
						<td>${dict:getEntryName('POST',resource.resourceExtend.post) }</td>
						<td>${dict:getEntryName('RESOURCE_CLASSIFY_TYPE',resource.resourceExtend.type) }</td>
						<td>${resource.creator.realName}</td>
						<td>${sipc:formatDate(resource.createTime,'yyyy-MM-dd') }</td>
						<td>
							<c:choose>
								<c:when test="${resource.state eq '3' }">
									<span style="color: #19A2E9">
								</c:when>
								<c:when test="${resource.state eq '5' }">
									<span style="color: #F00">
								</c:when>
							</c:choose>
							${dict:getEntryName('EDIT_STATE', resource.state) }</span>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/include/pagination_table.jsp">
		<jsp:param name="pageForm" value="listClassifyResourceForm" />
	    <jsp:param name="tableId" value="listClassifyResourceTable"/>
		<jsp:param name="type" value="easyui" />
		<jsp:param name="tabId" value="layout_center_tabs"/>
		<jsp:param name="paginatorName" value="resourcesPaginator"  />
	</jsp:include>
</form>
<script>
	function addResource() {
		var url = '${ctx}/resource/addResource?type=classify';
		easyui_modal_open('editResourceDiv', '新增资源', 800, 650, url, true);
	}

	function editResource() {
		var row = $('#listClassifyResourceForm').find('#listClassifyResourceTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		}else {
			var creator = row[0].creator;
			if(creator != '${sessionScope.loginer.id}' && '${hasEditorRole}' != 'true'){
				alert('只能编辑自己发布的资源');
				return false;
			}
			var id = row[0].id;
			easyui_modal_open('editResourceDiv', '修改资源', 800, 650, '${ctx}/resource/editResource?id='+id, true);
		}
	}
	
	function deleteResource(){
		var row = $('#listClassifyResourceForm').find('#listClassifyResourceTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else {
			$.messager.confirm('确认','确认要删除选中的资源吗？',function(r){    
			    if (r){    
					$.ajaxDelete('${ctx}/resource/deleteResource', $('#listClassifyResourceForm').serialize(), function(){
						easyui_tabs_update('listClassifyResourceForm', 'layout_center_tabs');
					});
			    }    
			}); 
		}
	}
	
	function goImport(){
		var url = '${ctx}/resource/goImport';
		easyui_modal_open('importResourceDiv', '导入资源', 400, 200, url, true);
	}
	
	function updateResource(state){
		var row = $('#listClassifyResourceForm').find('#listClassifyResourceTable').datagrid('getSelections');
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
					$.ajaxDelete('${ctx}/resource/updateResource', 'state='+state+'&'+$('#listClassifyResourceForm').serialize(), function(){
						easyui_tabs_update('listClassifyResourceForm', 'layout_center_tabs');
					});
			    }    
			}); 
		}
	}
</script>