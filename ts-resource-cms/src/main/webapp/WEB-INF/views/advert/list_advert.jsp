<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="listAdvertForm" action="${ctx}/advert">
	<input type="hidden" name="orders" value="${orders}" />
	<div>
		<table cellpadding="5px;" cellspacing="0" width="100%"
			style="padding: 10px;">
			<tr>
				<td width="5%">名称：</td>
				<td width="10%">
					<input type="text" class="easyui-textbox" 	name="paramMap[title]" value="${searchParam.paramMap.title}">
				</td>
				<td width="5%">位置：</td>
				<td width="10%">
					<select name="paramMap[location]" class="easyui-combobox" style="width: 158px;" editable="false" value="${searchParam.paramMap.location}">
							<option value=""></option>
							${dict:getEntryOptionsSelected('ADVERT_LOCATION',searchParam.paramMap.location)}
					</select>
				</td>
				<td width="5%">类型：</td>
				<td width="10%">
					<select name="paramMap[state]" class="easyui-combobox" style="width: 158px;" editable="false" value="${searchParam.paramMap.state}">
							<option value=""></option>
							${dict:getEntryOptionsSelected('ADVERT_STATE',searchParam.paramMap.state)}
					</select>
				</td>
				<td colspan="4"></td>
			</tr>
			<tr>
				<td colspan="6"><br />
					<button type="button" class="easyui-linkbutton main-btn"
						onclick="easyui_tabs_update('listAdvertForm','layout_center_tabs');">
						<i class="fa fa-search"></i> 查询
					</button>
					<button type="button" class="easyui-linkbutton"
						onclick="addAdvert()">
						<i class="fa fa-plus"></i> 新增
					</button>
					<button type="button" class="easyui-linkbutton"
						onclick="editAdvert()">
						<i class="fa fa-pencil"></i> 修改
					</button>
					<button type="button" class="easyui-linkbutton delete-btn"
						onclick="deleteAdvert()">
						<i class="fa fa-minus"></i> 删除
					</button>
					<button type="button" class="easyui-linkbutton"
						onclick="updateAdvert(1)">
						<i class="fa fa-pencil"></i> 展示
					</button>
					<button type="button" class="easyui-linkbutton"
						onclick="updateAdvert(2)">
						<i class="fa fa-pencil"></i> 下架
					</button>
					</td>
			</tr>
		</table>
	</div>
	<table id="listAdvertTable" class="" pagination="true" rownumbers="true"
		fitColumns="true" singleSelect="false" checkOnSelect="true"
		selectOnCheck="true">
		<thead>
			<tr>
				<th width="10" data-options="field:'id',checkbox:true"></th>
				<th width="10" data-options="field:'location'">位置</th>
				<th width="10" data-options="field:'sortNo'">排序</th>
				<th width="20" data-options="field:'title'">标题</th>
				<th width="20" data-options="field:'imageUrl'">图片链接地址</th>
				<th width="10" data-options="field:'state'">状态</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty adverts}">
				<c:forEach items="${adverts}" var="advert">
					<tr>
						<td>${advert.id}</td>
						<td>
							<c:forTokens items="${advert.location}" delims="," var="l">
								${dict:getEntryName('ADVERT_LOCATION',l)}
							</c:forTokens>
						</td>
						<td>${advert.sortNo}</td>
						<td>${advert.title}</td>
						<td>
							<c:choose>
								<c:when test="${not empty advert.imageUrl}">
									${advert.imageUrl}
								</c:when>
								<c:otherwise>
									${advert.imageLink}
								</c:otherwise>
							</c:choose>
						</td>
						<td>${dict:getEntryName('ADVERT_STATE',advert.state)}</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/include/pagination_table.jsp">
		<jsp:param name="pageForm" value="listAdvertForm" />
		<jsp:param name="tableId" value="listAdvertTable" />
		<jsp:param name="type" value="easyui" />
		<jsp:param name="tabId" value="layout_center_tabs" />
		<jsp:param name="paginatorName" value="advertsPaginator" />
	</jsp:include>
</form>
<script>
	function addAdvert() {
		var url = '${ctx}/advert/create';
		easyui_modal_open('editAdvertDiv', '添加广告图片', 800, 600, url, true);
	}

	function editAdvert() {
		var row = $('#listAdvertForm').find('#listAdvertTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		} else if (row.length > 1) {
			$.messager.alert('提示', '不能同时编辑多条数据', 'warning');
			return false;
		} else {
			var id = row[0].id;
			easyui_modal_open('editAdvertDiv', '编辑广告图片', 700, 470, '${ctx}/advert/' + id + '/edit', true);
		}
	}
	function updateAdvert(state) {
		var row = $('#listAdvertForm').find('#listAdvertTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择数据进行操作！', 'warning');
			return false;			
		}else {		

			$.messager.confirm('确认', '确认要更新选中记录吗？', function(r) {
				if (r) {
					$.ajax({
						  url: '${ctx}/advert/update?state='+state,
						  data: $('#listAdvertForm').serialize(),
						  success: function() {
								easyui_tabs_update('listAdvertForm', 'layout_center_tabs');
							},
						});
				}
			});
		}
	}
	
	function deleteAdvert() {
		var row = $('#listAdvertForm').find('#listAdvertTable').datagrid('getSelections');
		if (row.length == 0) {
			$.messager.alert('提示', '请选择数据进行操作！', 'warning');
			return false;			
		}else {					
			$.messager.confirm('确认', '确认要删除选中记录吗？', function(r) {
				if (r) {
					$.ajaxDelete('${ctx}/advert', $('#listAdvertForm').serialize(), function() {
						easyui_tabs_update('listAdvertForm', 'layout_center_tabs');
					});
				}
			});
		}
	}
</script>