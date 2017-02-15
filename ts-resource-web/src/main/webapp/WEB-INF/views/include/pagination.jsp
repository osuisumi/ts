<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<fmt:setBundle basename="message" var="message" />
<c:set var="paginator" value="${requestScope[param.paginatorName]}" />
<div class="m-jump-page">
	<c:if test="${paginator.totalPages > 1}">
		<c:choose>
			<c:when test="${paginator.page == 1}">
				<a href="###" class="noClick prev" title="上一页">&lt;</a>
			</c:when>
			<c:otherwise>
				<a href="###" onclick="previous('${param.pageForm}','${param.type}','${param.divId }' )" class="prev" title="上一页">&lt;</a>
			</c:otherwise>
		</c:choose>
	
		<c:if test="${paginator.page != 1}">
			<a name="pageNo_1" href="###" onclick="indexPage('${param.pageForm}','${param.type}','${param.divId }')">1</a>
		</c:if>
		<c:if test="${paginator.page > 3}">
			<a name="pageNo_${paginator.page-2}" href="###" onclick="goPage('${param.pageForm}','${param.type}','${param.divId }','${paginator.page-2}')">${paginator.page-2}</a>
		</c:if>
		<c:if test="${paginator.page > 2}">
			<a name="pageNo_${paginator.page-1}" href="###" onclick="goPage('${param.pageForm}','${param.type}','${param.divId }','${paginator.page-1}')">${paginator.page-1}</a>
		</c:if>
	
		<a name="pageNo_${paginator.page}" class="z-crt">${paginator.page}</a>
	
		<c:if test="${paginator.page + 1 < paginator.totalPages}">
			<a name="pageNo_${paginator.page+1}" href="###" onclick="goPage('${param.pageForm}','${param.type}','${param.divId }','${paginator.page+1}')">${paginator.page+1}</a>
		</c:if>
		<c:if test="${paginator.page + 2 < paginator.totalPages}">
			<a name="pageNo_${paginator.page+2}" href="###" onclick="goPage('${param.pageForm}','${param.type}','${param.divId }','${paginator.page+2}')">${paginator.page+2}</a>
		</c:if>
		<c:if test="${paginator.page != paginator.totalPages}">
			<a name="pageNo_${paginator.totalPages}" href="###" onclick="goPage('${param.pageForm}','${param.type}','${param.divId }','${paginator.totalPages}')">${paginator.totalPages}</a>
		</c:if>
	
		<c:choose>
			<c:when test="${paginator.page == paginator.totalPages}">
				<a href="###" class="noClick next">&gt;</a>
			</c:when>
			<c:otherwise>
				<a href="###" onclick="next('${param.pageForm}','${param.type}','${param.divId }')"  class="next" title="下一页">&gt;</a>
			</c:otherwise>
		</c:choose>
	</c:if>
</div>
<input type="hidden" class="page" name="page" value="<c:out value="${paginator.page }"/>">
<input type="hidden" class="totalPages" value="<c:out value="${paginator.totalPages}"/>">
<script>
	function indexPage(formId,type,divId){
		$("#"+formId+" .page").val(1);
		submitPage(formId,type,divId);
	}
	
	function lastPage(formId,type,divId){
		var totalPages = $("#"+formId+" .totalPages");
		$("#"+formId+" .page").val(totalPages.val());
		submitPage(formId,type,divId);
	}
	
	function previous(formId,type,divId){
		var page = $("#"+formId+" .page");
		if(parseInt($(page).val())>1){
			$(page).val(parseInt($(page).val())-1);
			submitPage(formId,type,divId);
		}else{
			alert('已经是第一页');
		}
	}
	
	function next(formId,type,divId){
		var page = $("#"+formId+" .page"); 
		var totalPages = $("#"+formId+" .totalPages");
		if(parseInt($(page).val())<parseInt(totalPages.val())){	
			$(page).val(parseInt($(page).val())+1);
			submitPage(formId,type,divId);
		}else{
			alert('已经是最后一页');
		}
	}
	
	function skipPage(formId,type,divId){
		var goPage = $("#"+formId+" .page");
		var totalPages = $("#"+formId+" .totalPages");
		if(parseInt($(goPage).val()) <= parseInt(totalPages.val())&&parseInt($(goPage).val())>=1){
			$("#"+formId+" .page").val($(goPage).val());
			submitPage(formId,type,divId);
		}else{
			alert('输入的跳转页不在页面范围内');
		}
	}
	
	function goPage(formId,type,divId,pageNo){
		$("#"+formId+" .page").val(pageNo);
		submitPage(formId,type,divId);
	}
	
	function submitPage(formId,type,divId){
		<c:choose>
		<c:when test="${not empty param.callback}">
		var fn = ${param.callback};
		var args= ${param.args};
		if(args==null){
			args=[''];
		}
		fn.apply(this,args);  
		</c:when>
		<c:otherwise>
			if(type != null && type == 'ajax'){
				$.ajaxQuery(formId, divId);
			}else{
				$('#'+formId).submit();
			}
		</c:otherwise>
		</c:choose> 
	}
</script> 