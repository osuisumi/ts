<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<shiro:hasRole name="schoolAdmin">
	<c:set var="hasSchoolAdmin" value="true" />
</shiro:hasRole>
<!-- 设置查询按钮点击时更新window还是tab，设置分页跟新的tab -->
<c:choose>
	<c:when test="${searchParam.paramMap.relationType eq 'competition'}">
		<c:set var="isWindow" value="Y"></c:set>
		<c:set value="listCompetitionAnnouncementDiv" var="tabId"></c:set>
		<c:set value="/WEB-INF/views/include/pagination_window.jsp" var="page"></c:set>
	</c:when>
	<c:otherwise>
		<c:set var="isWindow" value="N"></c:set>
		<c:set value="layout_center_tabs" var="tabId"></c:set>
		<c:set value="/WEB-INF/views/include/pagination_table.jsp" var="page"></c:set>
	</c:otherwise>
</c:choose>
<form id="listAnnouncementForm_${searchParam.paramMap.type }" action="${ctx}/announcement">
	<input type="hidden" name="paramMap[type]" value="${searchParam.paramMap.type}" /> 
	<input type="hidden" name="paramMap[relationId]" value="${searchParam.paramMap.relationId}" /> 
	<input type="hidden" name="orders" value="${orders}" />
	<div>
		<table cellpadding="5px;" cellspacing="0" width="100%"
			style="padding: 10px;">
			<tr>
				<td width="5%">标题：</td>
				<td width="10%"><input type="text" class="easyui-textbox" name="paramMap[title]" value="${searchParam.paramMap.title}"></td>
				<c:choose>
					<c:when test="${searchParam.paramMap.type eq '1' }">
						<td width="5%">类型：</td>
						<td width="10%">
							<input id="relationTypeSelect" name="paramMap[relationType]" class="easyui-combobox" editable="false" style="width: 158px;" data-options="
						        valueField: 'value',
								textField: 'text',
						        data: [{
						        	value:'',
						        	text:'全部'
						        },{	
						        	value:'cms',
						        	text:'通知公告'
						        },{	
						        	value:'bms',
						        	text:'站内通知'
						        }],
						        onLoadSuccess: function(){
						        	if('${searchParam.paramMap.relationType }' != ''){
						       			$('#relationTypeSelect').combobox('select', '${searchParam.paramMap.relationType }');
						       		}else{
						       			$('#relationTypeSelect').combobox('select', '');
						       		}
						        }   
							">
						</td>
					</c:when>
					<c:otherwise>
						<input type="hidden" name="paramMap[relationType]" value="${searchParam.paramMap.relationType}">
					</c:otherwise>
				</c:choose>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td colspan="6"><br />
					<c:choose>
						<c:when test="${isWindow eq 'Y' }">
							<button type="button" class="easyui-linkbutton main-btn" onclick="easyui_window_update('listAnnouncementForm_${searchParam.paramMap.type }','listCompetitionAnnouncementDiv')">
						</c:when>
						<c:otherwise>
							<button type="button" class="easyui-linkbutton main-btn" onclick="easyui_tabs_update('listAnnouncementForm_${searchParam.paramMap.type }','layout_center_tabs');">
						</c:otherwise>
					</c:choose>
						<i class="fa fa-search"></i> 查询
					</button>
					<button type="button" class="easyui-linkbutton"
						onclick="addAnnouncement('${searchParam.paramMap.type }','${searchParam.paramMap.relationId}','${searchParam.paramMap.relationType}')">
						<i class="fa fa-plus"></i> 新增
					</button>
					<button type="button" class="easyui-linkbutton"
						onclick="editAnnouncement('${searchParam.paramMap.type }')">
						<i class="fa fa-pencil"></i> 修改
					</button>
					<button type="button" class="easyui-linkbutton delete-btn"
						onclick="deleteAnnouncement('${searchParam.paramMap.type }')">
						<i class="fa fa-minus"></i> 删除
					</button></td>
			</tr>
		</table>
	</div>
	<table id="listAnnouncementTable_${searchParam.paramMap.type }"
		class="" pagination="true" rownumbers="true" fitColumns="true"
		singleSelect="false" checkOnSelect="true" selectOnCheck="true">
		<thead>
			<tr>
				<th width="10" data-options="field:'id',checkbox:true"></th>
				<th width="20" data-options="field:'title'">标题</th>
				<th width="20" data-options="field:'type'">类型</th>
				<th width="20" data-options="field:'publishedTime'">发布时间</th>
				<th width="20" data-options="field:'isPublished'">发布</th>
				<!-- <th width="20" data-options="field:'isTop'">置顶</th>  -->
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty announcements}">
				<c:forEach items="${announcements}" var="announcement">
					<tr>
						<td>${announcement.id}</td>
						<%-- <td><a onclick="viewAnnouncement('${announcement.id}')">${announcement.title}</a></td>--%>
						<td>${announcement.title}</td>
						<td>
							<c:choose>
								<c:when test="${searchParam.paramMap.type eq '1' }">
									<c:choose>
										<c:when test="${announcement.announcementRelations[0].relation.type eq 'cms' }">
											通知公告
										</c:when>
										<c:otherwise>
											站内通知
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${announcement.announcementRelations[0].relation.type eq 'system' }">
											教育快讯
										</c:when>
										<c:when test="${announcement.announcementRelations[0].relation.type eq 'school' }">
											学校资讯
										</c:when>
										<c:otherwise>
											活动公告
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</td>
						<td><fmt:formatDate value="${announcement.publishTime}"
								pattern="yyyy-MM-dd" /></td>
						<td>${dict:getEntryName('EDIT_STATE',announcement.state)}</td>
						<%--<td>${announcement.isTop}</td>--%>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
		<jsp:include page="${page }">
				<jsp:param name="pageForm"
					value="listAnnouncementForm_${searchParam.paramMap.type }" />
				<jsp:param name="tableId"
					value="listAnnouncementTable_${searchParam.paramMap.type }" />
				<jsp:param name="type" value="easyui" />
				<jsp:param name="tabId" value="${tabId }" />
				<jsp:param name="paginatorName" value="announcementsPaginator" />
		</jsp:include>
</form>
<script>
	function addAnnouncement(type,relationId, relationType) {
		var url = '${ctx}/announcement/create?announcementRelations[0].relation.id=' + relationId+'&type='+type+'&announcementRelations[0].relation.type='+relationType;
		easyui_modal_open('editAnnouncementDiv', '发布通知', 800, 680, url, true);
	}

/* 	function viewAnnouncement(announcementId) {
		var url = '${ctx}/announcement/' + announcementId + '/view';
		easyui_modal_open('viewAnnouncementDiv', '查看通知', 750, 470, url, true);
	} */

	function editAnnouncement(type) {
		var row = $('#listAnnouncementForm_' + type).find('#listAnnouncementTable_' + type).datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		} else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		} else {
			var id = row[0].id;
			easyui_modal_open('editAnnouncementDiv', '编辑通知', 800, 680, '${ctx}/announcement/' + id + '/edit', true);
		}
	}

	function deleteAnnouncement(type) {
		var row = $('#listAnnouncementForm_' + type).find('#listAnnouncementTable_' + type).datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		} else {
			$.messager.confirm('确认', '确认要删除选中记录吗？', function(r) {
				if (r) {
					$.ajaxDelete('${ctx}/announcement', $('#listAnnouncementForm_' + type).serialize(), function() {
						var isWindow = '${isWindow}';
						if(isWindow == 'Y'){
							easyui_window_update('listAnnouncementForm_'+ type,'listCompetitionAnnouncementDiv')
						}else{
							easyui_tabs_update('listAnnouncementForm_' + type, 'layout_center_tabs');
						}
						
						easyui_tabs_update('listAnnouncementForm_' + type, 'layout_center_tabs');
					});
				}
			});
		}
	}
</script>