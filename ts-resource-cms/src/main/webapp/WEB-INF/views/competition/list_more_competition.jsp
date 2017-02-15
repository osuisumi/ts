<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="listCompetitionForm_${searchParam.paramMap.operation}" action="${ctx}/competition/list/more">
	<input type="hidden" name="orders" value="${orders }">
	<input type="hidden" name="paramMap[operation]" value="${searchParam.paramMap.operation }">
	<div>
		<table cellpadding="0" cellspacing="0" width="100%" style="padding: 10px;">
			<tr>
				<td width="50px">标题：</td>
				<td width="200px"><input id="titleTextbox" name="paramMap[title]" class="easyui-textbox" value="${searchParam.paramMap.title }" style="width: 200px;" /></td>
				<td width="30px"></td>
				<td width="70px">发布时间：</td>
				<td width="200px"><input class="easyui-datebox" name="minCreateTime" value="${minCreateTime }" data-options="editable:false,buttons:buttons"> 至</td>
				<td width="110px"><input class="easyui-datebox" name="maxCreateTime" value="${maxCreateTime }" data-options="editable:false,buttons:buttons"> </td>
				<td width="30px"></td>
			</tr>
			<tr>
				<td colspan="7"><br />
					<button type="button" class="easyui-linkbutton main-btn" onclick="easyui_tabs_update('listCompetitionForm_${searchParam.paramMap.operation}','layout_center_tabs');">
						<i class="fa fa-search"></i> 查询
					</button>
					<c:if test="${searchParam.paramMap.operation eq 'competition'}">
					<button type="button" class="easyui-linkbutton" onclick="addCompetition()">
						<i class="fa fa-plus"></i> 新增
					</button>
					<button type="button" class="easyui-linkbutton" onclick="editCompetition()">
						<i class="fa fa-pencil"></i> 修改
					</button>
					<button type="button" class="easyui-linkbutton delete-btn" onclick="deleteCompetition()">
						<i class="fa fa-trash-o"></i> 删除
					</button>
					</c:if>
					</td>
			</tr>
		</table>
	</div>
	<c:choose>
		<c:when test="${searchParam.paramMap.operation eq 'competition'}">
			<table id="listCompetitionTable_${searchParam.paramMap.operation}" class="" pagination="true" rownumbers="true" fitColumns="true" singleSelect="false" checkOnSelect="true" selectOnCheck="true">
		</c:when>
		<c:otherwise>
			<table id="listCompetitionTable_${searchParam.paramMap.operation}" class="" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true" checkOnSelect="true" selectOnCheck="true">
		</c:otherwise>
	</c:choose>
		<thead>
			<tr>
				<c:if test="${searchParam.paramMap.operation eq 'competition'}">
					<th width="10" data-options="field:'id',checkbox:true"></th>
				</c:if>
				<th data-options="field:'creator', hidden:true"></th>
				<th width="20" data-options="field:'title'">主题</th>
				<th width="20" data-options="field:'faceGroup'">面向人群</th>
				<th width="20" data-options="field:'createTime'">发布时间</th>
				<th width="20" data-options="field:'competitionStartTime'">开始时间</th>
				<th width="20" data-options="field:'competitionEndTime'">结束时间</th>
				<th width="20" data-options="field:'state'">主办单位</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty competitions}">
				<c:forEach items="${competitions}" var="competition">
					<tr>
					<c:if test="${searchParam.paramMap.operation eq 'competition'}">
						<td>${competition.id}</td>
					</c:if>
						<td>${competition.creator.id }</td>
						<td>
						<c:choose>
							<c:when test="${searchParam.paramMap.operation eq 'competition'}">
								${competition.title}
							</c:when>
							<c:otherwise>
							<a href="###" onclick="operation('${competition.id}')" style="color: blue">
								${competition.title}
							</a>
							</c:otherwise>
						</c:choose>
						</td>
						<td>${competition.faceGroup}</td>
						<td>${sipc:formatDate(competition.createTime,'yyyy-MM-dd') }</td>
						<td><fmt:formatDate value="${competition.competitionTimePeriod.startTime}"  pattern="yyyy-MM-dd"/></td>
						<td><fmt:formatDate value="${competition.competitionTimePeriod.endTime }"  pattern="yyyy-MM-dd"/></td>
						<td>${competition.mainOrganization}</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/include/pagination_table.jsp">
		<jsp:param name="pageForm" value="listCompetitionForm_${searchParam.paramMap.operation}" />
		<jsp:param name="tableId" value="listCompetitionTable_${searchParam.paramMap.operation}" />
		<jsp:param name="type" value="easyui" />
		<jsp:param name="tabId" value="layout_center_tabs" />
		<jsp:param name="paginatorName" value="competitionsPaginator" />
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
	function addCompetition() {
		var url = '${ctx}/competition/create';
		easyui_modal_open('editCompetitionDiv', '新增活动', 800, 500, url, true);
	}
	
	function deleteCompetition(id){
		var rows = $('#listCompetitionTable_${searchParam.paramMap.operation}').datagrid('getSelections');
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
					$.post('${ctx}/competition/delete/deleteByIds', {
						"id":ids
					}, function() {
						easyui_tabs_update('listCompetitionForm_${searchParam.paramMap.operation}', 'layout_center_tabs');
					});
				}
			});
		}
	}
	
	function editCompetition() {
		var row = $('#listCompetitionTable_${searchParam.paramMap.operation}').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		} else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		} else {
			/*var creator = row[0].creator;
			if(creator != '${sessionScope.loginer.id}'){
				alert('只能编辑自己发布的资源');
				return false;
			}*/
			var id = row[0].id;
			easyui_modal_open('editCompetitionDiv', '编辑通知', 800, 500, '${ctx}/competition/' + id + '/edit', true);
		}
	}
	
	function operation(id){
		var operationName = '${searchParam.paramMap.operation}';
		if(operationName == 'announcement'){
			var url = '${ctx}/announcement?paramMap[relationId]='+id+'&paramMap[relationType]=competition&paramMap[type]=2';
			easyui_modal_open('listCompetitionAnnouncementDiv', '活动公告', 900, 550, url, true);
		}else if(operationName == 'resource'){
			var url = '${ctx}/competition/resource?orders=VOTE_NUM.DESC&paramMap[relationId]='+id;
			easyui_modal_open('listCompetitionResourceDiv', '作品管理', 900,550, url, true);
		}

	}
</script>