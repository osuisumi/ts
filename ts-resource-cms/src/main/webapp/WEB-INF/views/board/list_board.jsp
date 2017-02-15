<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="listBoardForm" action="${ctx}/board">
	<input type="hidden" name="orders" value="${orders}" />
	<div>
		<table cellpadding="5px;" cellspacing="0" width="100%"
			style="padding: 10px;">
			<tr>
				<td width="5%">名称：</td>
				<td width="10%"><input type="text" class="easyui-textbox"
					name="paramMap[name]" value="${searchParam.paramMap.name}"></td>
				<td colspan="4"></td>
			</tr>
			<tr>
				<td colspan="6"><br />
					<button type="button" class="easyui-linkbutton main-btn"
						onclick="easyui_tabs_update('listBoardForm','layout_center_tabs');">
						<i class="fa fa-search"></i> 查询
					</button>
					<button type="button" class="easyui-linkbutton"
						onclick="addBoard()">
						<i class="fa fa-plus"></i> 新增
					</button>
					<button type="button" class="easyui-linkbutton"
						onclick="editBoard()">
						<i class="fa fa-pencil"></i> 修改
					</button>
					<button type="button" class="easyui-linkbutton delete-btn"
						onclick="deleteBoard()">
						<i class="fa fa-minus"></i> 删除
					</button></td>
			</tr>
		</table>
	</div>
	<table id="listBoardTable" class="" pagination="true" rownumbers="true"
		fitColumns="true" singleSelect="false" checkOnSelect="true"
		selectOnCheck="true">
		<thead>
			<tr>
				<th width="10" data-options="field:'id',checkbox:true"></th>
				<th width="20" data-options="field:'name'">名称</th>
				<th width="20" data-options="field:'sortNo'">序号</th>
				<th width="20" data-options="field:'master'">版主</th>
				<th width="20" data-options="field:'summary'">简介</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty boards}">
				<c:forEach items="${boards}" var="board">
					<tr>
						<td>${board.id}</td>
						<td>${board.name}</td>
						<td>${board.sortNo}</td>
						<td>
							<c:if test="${not empty board.boardAuthorizes }">
								<c:forEach items="${ board.boardAuthorizes}"
									var="boardAuthorize" varStatus="status">
									<c:if test="${status.last}">${boardAuthorize.user.realName}</c:if>
									<c:if test="${!status.last}">${boardAuthorize.user.realName},</c:if>
								</c:forEach>
							</c:if>
						</td>
						<td>${board.summary}</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/include/pagination_table.jsp">
		<jsp:param name="pageForm" value="listBoardForm" />
		<jsp:param name="tableId" value="listBoardTable" />
		<jsp:param name="type" value="easyui" />
		<jsp:param name="tabId" value="layout_center_tabs" />
		<jsp:param name="paginatorName" value="boardsPaginator" />
	</jsp:include>
</form>
<script>
	function addBoard() {
		var url = '${ctx}/board/create';
		easyui_modal_open('editBoardDiv', '添加版块', 750, 600, url, true);
	}

	function editBoard() {
		var row = $('#listBoardForm').find('#listBoardTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		} else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		} else {
			var id = row[0].id;
			easyui_modal_open('editBoardDiv', '编辑版块', 750, 600, '${ctx}/board/' + id + '/edit', true);
		}
	}

	function deleteBoard() {
		var row = $('#listBoardForm').find('#listBoardTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择数据进行操作！', 'warning');
			return false;			
		}else {		
			$.messager.confirm('确认', '确认要删除选中记录吗？', function(r) {
				if (r) {
					$.ajaxDelete('${ctx}/board', $('#listBoardForm').serialize(), function() {
						easyui_tabs_update('listBoardForm', 'layout_center_tabs');
					});
				}
			});
		}
	}
</script>