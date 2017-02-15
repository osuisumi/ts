<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="page clearfix">
	<div class="page_l">
		<p class="gray6">共有 <c:out value="${requestParam.pagination.rowCount}"/>条记录，当前第<c:out value="${requestParam.pagination.currentPage }"/> 页，共 <c:out value="${requestParam.pagination.pageCount }"/> 页</p>
	</div>
	<div class="page_r">
		<p class="gray6">
			<input type="hidden" id="requestParam.pagination.currentPage" name="requestParam.pagination.currentPage" value="<c:out value="${requestParam.pagination.currentPage }"/>">
			<a href="#" onclick="indexPage">首页</a> <a href="#" onclick="previous()">上一页</a> <a href="#" onclick="next()">下一页</a> <a
				href="#" onclick="lastPage()">尾页</a> 跳转到第&nbsp;<input type="text" id="goPage" class="" size="2">&nbsp;页
			<button class="btn_gray left5">GO</button>
		</p>
	</div>
</div>
<script>
	function indexPage(){
		document.getElementById("requestParam.pagination.currentPage").value=1;
		submitPage.submit();
	}
	
	function lastPage(){
		document.getElementById("requestParam.pagination.currentPage").value='${requestParam.pagination.pageCount }';
		submitPage.submit();
	}
	
	function previous(){
		var currentPage = document.getElementById("requestParam.pagination.currentPage");
		if(currentPage.value>1){
			currentPage.value = parseInt(currentPage.value)-1;
			submitPage.submit();
		}else{
			alert("已经是第一页");
		}
	}
	
	function next(){
		var currentPage = document.getElementById("requestParam.pagination.currentPage");
		if(currentPage.value<parseInt('${requestParam.pagination.pageCount}')){			
			currentPage.value = parseInt(currentPage.value)+1;
			submitPage();
		}else{
			alert("已经是最后一页");
		}
	}
	
	function goPage(){
		var goPage = document.getElementById("goPage");
		if(goPage.value<=parseInt('${requestParam.pagination.pageCount}')||goPage>=1){
			currentPage.value = goPage;
			submitPage();
		}else{
			alert("输入的跳转页不在页面范围内");
		}
	}
	
	function submitPage(){
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
		document.getElementById("${param.pageForm}").submit();
		</c:otherwise>
		</c:choose>
	}
</script>