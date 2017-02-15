<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="paginator" value="${requestScope['competitionsPaginator']}" />
<form id="hotCompetitionForm" action="${ctx}/competition/list/hot">
<input type="hidden" id="page" class="page" name="page" value="<c:out value="${paginator.page }"/>">
<input type="hidden" id="totalPage" class="totalPages" value="<c:out value="${paginator.totalPages}"/>">
<input type="hidden" value="${limit}" name="limit">
<input type="hidden" name="orders" value="${orders}">
<input type="hidden" name="paramMap[resourceNum]" value="searchParam.paramMap.resourceNum">
	<div class="g-sd-mod">
		<div class="m-new-resource">
			<div class="m-sd-tt">
				<h3 class="tt">热点活动</h3>
			</div>
			<div class="m-active-silde" id="activeSilde">
				<ul class="lst">
					<c:forEach items="${competitions}" var="competition">
						<li>
							<a onclick="viewCompetition('${competition.id}')" class="img"><img src="${file:getFileUrl(competition.imageUrl) }" width="250" height="158" alt=""></a>
							<span class="shadow"></span> 
							<a onclick="viewCompetition('${competition.id}')" class="txt">${competition.title }</a>
						</li>
					</c:forEach>
				</ul>
				<div class="focus">
					<c:forEach items="${competitions}" var="competition">
						<a href="javascript:void(0);"></a> 
					</c:forEach>
				</div>
			</div>
			<div class="m-active-news">
				<div class="u-change">
					<a onclick="trunPage()"><i></i>换一批</a>
				</div>
				<ul class="active-news-ul">
					<c:forEach items="${competitions}" var="competition">
						<li>
							<i></i> 
							<a class="news-txt" onclick="viewCompetition('${competition.id}')">${competition.title }</a>
							<p>${sipc:formatDate(competition.createTime,'yyyy/MM/dd') }</p>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</form>
<script type="text/javascript">
    $(function(){
    $('#g-bn').dsTab({
        itemEl        : '.m-bn li',
        btnElName     : 'm-bn-focus',
        btnItem       : 'a',
        currentClass  : 'z-crt',
        maxSize       : 5,
        changeType    : 'fade',
        change        : true,
        changeTime    : 3000,
        autoCreateTab : false
    });
    //news silde
    $('#activeSilde').dsTab({
        itemEl        : '.lst li',
        btnElName     : 'focus',
        btnItem       : 'a',
        currentClass  : 'z-crt',
        maxSize       : 5,
        changeType    : 'fade',
        change        : true,
        changeTime    : 4000,
        autoCreateTab : false
    });

})

	function trunPage(){
    	var nowPage = $('#page').val();
    	var totalPage = $('#totalPage').val();
    	if(parseInt(nowPage) >= parseInt(totalPage)){
    		$('#page').val(1);
    	}else{
    		$('#page').val(parseInt(nowPage)+1);
    	}
    	$.ajaxQuery('hotCompetitionForm','hotCompetitionDiv');
    }
</script>