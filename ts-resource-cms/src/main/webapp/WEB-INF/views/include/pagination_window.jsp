<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="paginator" value="${requestScope[param.paginatorName]}" />
<c:set var="tableId" value="#${param.tabId} #${param.tableId}" />
<c:set var="formId" value="#${param.tabId} #${param.pageForm}" />
<input id="page" type="hidden" name="page" value="${paginator.page }" />
<input id="limit" type="hidden" name="limit" value="${paginator.limit }" />
<script>
	$(function() {
		$('${tableId}').datagrid({
			pageSize : parseInt('${paginator.limit}'),
			pageNumber : parseInt('${paginator.page}'),
			pageList : [ 10, 20 ]
		});
		var pagination = $('${tableId}').datagrid('getPager');
		$(pagination).pagination({
			total : parseInt('${paginator.totalCount}'),
			pageSize : parseInt('${paginator.limit}'),
			pageNumber : parseInt('${paginator.page}'),
			onSelectPage : function(pageNumber, pageSize) {
				$('${formId} #page').val(pageNumber);
				$('${formId} #limit').val(pageSize);
				if ('${param.type}' != null && '${param.type}' == 'ajax') {
					$.ajaxQuery('${formId}', '${param.tabId}');
				} else if ('${param.type}' != null && '${param.type}' == 'easyui') {
					var window = $('#${param.tabId}');
					window.panel('options').queryParams= $('${formId}').serializeObject();
					window.window('refresh', $('${formId}').attr('action'));  
				} else {
					document.getElementById('${formId}').submit();
				}
			}
		});
	});
</script>

