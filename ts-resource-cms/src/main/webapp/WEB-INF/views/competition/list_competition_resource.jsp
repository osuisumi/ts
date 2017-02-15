<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<form id="listCompetitionResourceForm" action="${ctx}/competition/resource">
	<input type="hidden" name="paramMap[type]" value="${searchParam.paramMap.type }">
	<input type="hidden" name="orders" value="${orders }">
	<input type="hidden" name="paramMap[relationId]" value="${searchParam.paramMap.relationId }">
		<div>
		<table cellpadding="0" cellspacing="0" width="100%" style="padding: 10px;">
			<tr>
				<td width="50px">标题：</td>
				<td width="200px"><input id="titleTextbox" name="paramMap[title]" class="easyui-textbox" value="${searchParam.paramMap.title }" style="width: 200px;" /></td>
			</tr>
			<tr>
				<td colspan="7"><br />
					<button type="button" class="easyui-linkbutton main-btn" onclick="easyui_window_update('listCompetitionResourceForm','listCompetitionResourceDiv');">
						<i class="fa fa-search"></i> 查询
					</button>
					<button type="button" class="easyui-linkbutton prize-btn" onclick="prize()">
						<i class=""></i> 颁奖
					</button>
					</td>
			</tr>
		</table>
	</div>
	<table id="listCompetitionResourceTable"  pagination="true" rownumbers="true" fitColumns="true" singleSelect="false" checkOnSelect="true" selectOnCheck="true">
		<thead>
			<tr>
				<th width="10" data-options="field:'id',checkbox:true"></th>
				<th data-options="field:'creator', hidden:true"></th>
				<th width="20" data-options="field:'title'">标题</th>
				<th width="20" data-options="field:'stage'">学段</th>
				<th width="20" data-options="field:'grade'">年级</th>
				<th width="20" data-options="field:'subject'">学科</th>
				<th width="20" data-options="field:'tbVersion'">教材</th>
				<th width="20" data-options="field:'extendType'">分类</th>
				<th width="20" data-options="field:'creatorName'">上传者</th>
				<th width="20" data-options="field:'createTime'">发布时间</th>
				<th width="20" data-options="field:'prize'">奖项</th>
				<th width="20" data-options="field:'voteNum'">得票数</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty resources}">
				<c:forEach items="${resources}" var="resource" >
					<tr>
						<td>${resource.id}</td>
						<td>${resource.creator.id }</td>
						<td><a href="###" onclick="viewResource('${resource.id}')" style="color: blue">${resource.title}</a></td>
						<td>${tb:getEntryName('STAGE',resource.resourceExtend.stage) }</td>
						<td>${tb:getEntryName('GRADE',resource.resourceExtend.grade) }</td>
						<td>${tb:getEntryName('SUBJECT',resource.resourceExtend.subject) }</td>
						<td>${tb:getEntryName('VERSION',resource.resourceExtend.tbVersion) }</td> 
						<td>${dict:getEntryName('RESOURCE_SYNC_TYPE',resource.resourceExtend.type) }</td>
						<td>${resource.creator.realName}</td>
						<td>${sipc:formatDate(resource.createTime,'yyyy-MM-dd') }</td>
						<td>
							${dict:getEntryName('RESOURCE_PRIZE', resource.resourceExtend.prize) }</span>
						</td>
						<td>${resource.resourceRelations[0].voteNum }</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/include/pagination_window.jsp">
		<jsp:param name="pageForm" value="listCompetitionResourceForm" />
	    <jsp:param name="tableId" value="listCompetitionResourceTable"/>
		<jsp:param name="type" value="easyui" />
		<jsp:param name="tabId" value="listCompetitionResourceDiv"/>
		<jsp:param name="paginatorName" value="resourcesPaginator"/>
	</jsp:include>
</form>
<script>
	function prize(){
		var rows = $('#listCompetitionResourceTable').datagrid('getSelections');
		if (rows.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}
		var ids = '';
		$.each($(rows),function(i,row){
			ids = ids + row.id + ',';
		});
		ids = ids.substr(0,ids.length-1);
		easyui_modal_open('prizeDiv', '颁奖', 300	,200, '${ctx}/competition/prize/edit?paramMap[ids]='+ids, true);
	}
</script>