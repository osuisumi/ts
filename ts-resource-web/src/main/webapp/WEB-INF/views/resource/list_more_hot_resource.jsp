<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<shiro:hasRole name="${searchParam.paramMap.relationId}_master">
	<c:set var="hasMasterRole" value="true"  />
</shiro:hasRole>
<shiro:hasRole name="${searchParam.paramMap.relationId}_member">
	<c:set var="hasMember" value="true"  />
</shiro:hasRole>
<form id="listMoreResourceForm" action="${ctx}/resource/listMoreHotResource">
	<input type="hidden" name="paramMap[relationId]" value="${searchParam.paramMap.relationId}" /> 
	<input type="hidden" name="orders" value="${orders }">
	<div class="m-crm" style="height:20px;padding-left:0px;margin-top:5px">
      <span class="txt">您当前的位置： </span><a href="../../index.html" title="首页" class="u-goto-index">
          <i class="u-sHome-ico"></i>
      </a>
      <span class="trg">&gt;</span>
      <a onclick="workshopIndex()">工作室</a>
      <span class="trg">&gt;</span>
      <a onclick="viewWorkshop('${searchParam.paramMap.relationId}')"  class="backName"></a>
      <span class="trg">&gt;</span>
      <em>热门资源</em>
    </div>
	<script>
		$('.backName').text($('#backName').val());
	</script>
	<div id="st-resource-listing" class="space-content-page">
		<div class="page-same-mod cmnt-mod">
			<div class="cmnt-detail">
				<c:choose>
					<c:when test="${empty resources }">
						<tag:noContent msg="暂未上传资源" />
					</c:when>
					<c:otherwise>
						<ul class="same-resource-list">
							<c:forEach items="${resources }" var="resource">
								<li class="block clearfix">
									<i class="file-word-ico cmnt-ico type"></i> <%-- <a href="###" class="title" onclick="downloadFile('${ipanthercore:getJsonMapValue(resource.attachment,'id') }','${ipanthercore:getJsonMapValue(resource.attachment,'fileName') }')">${resource.name }</a> --%> 
									<a href="###" class="title" onclick="viewResource('${resource.id}')">${resource.title }</a> 
									<span class="time"> 
										<i class="time-ico cmnt-ico" style="margin-right: 5px;"></i> 
										${sipc:prettyTime(resource.createTime)}
									</span> 
									<!-- <span class="u">培训管理员</span> --> <%-- <div class="cmnt-opa">
									<a href="###" class="title" onclick="downloadFile('${ipanthercore:getJsonMapValue(resource.attachment,'id') }','${ipanthercore:getJsonMapValue(resource.attachment,'fileName') }')">
										<i class="download-ico cmnt-ico"></i>
										下载
									</a>
								</div> --%>
								</li>
							</c:forEach>
						</ul>
						<jsp:include page="/WEB-INF/views/include/pagination.jsp">
							<jsp:param value="listMoreResourceForm" name="pageForm" />
							<jsp:param value="ajax" name="type" />
							<jsp:param value="content" name="divId" />
							<jsp:param value="resourcesPaginator" name="paginatorName" />
						</jsp:include>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</form>
<script>
	function searchResourceByName() {
		$('.currentPage').val('1');
		$.ajaxQuery('listResourceMoreFrm', 'content');
	}

	function showResourceDetail(id, relationType) {
		var relationType = '${searchParam.paramMap.relationType}';
		$('#content').load('${ctx}/resource/yxResource/showDetail.do', 'id=' + id + '&relationType=' + relationType);
	}
</script>