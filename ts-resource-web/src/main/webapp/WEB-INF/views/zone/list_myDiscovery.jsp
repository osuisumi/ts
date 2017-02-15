<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
	<table cellpadding="0" cellspacing="0" border="0" class="g-stat-table">
		<thead>
			<tr>
				<th width="300">资源名称</th>
				<th width="110">资源类别</th>
				<th width="80">状态</th>
				<th width="200" style="border: 0">操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${myDiscoverys}" var="discovery">
				<tr>
					<td><a onclick="viewDiscovery('${discovery.id}')">${discovery.title }</a></td>
					<td>${dict:getEntryName('RESOURCE_DISCOVERY_TYPE',discovery.resourceExtend.type)}</td>
					<td>${dict:getEntryName('EDIT_STATE',discovery.state)}</td>
					<td style="border: 0"><span class="u-time">${sipc:prettyTime(discovery.createTime) }</span>
					<span class="u-handle">
						<c:if test="${discovery.creator.id eq sessionScope.loginer.id }">
							<a onclick="editDiscovery('${discovery.id}','zone')">编辑</a>
							<a onclick="deleteDiscovery('${discovery.id}','zone')">删除</a>
						</c:if>
						<a id="followBtn${discovery.id}">收藏</a> <a id="cancelFollowBtn${discovery.id}">取消收藏</a>
						<tag:collect followEntityId="${discovery.id }" followEntityType="discovery" backPage="zone" item="discovery" />
					</span>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
		<div class="am-pageturn">
			<jsp:include page="/WEB-INF/views/include/pagination.jsp">
				<jsp:param value="listDiscoveryForm" name="pageForm" />
				<jsp:param value="myDiscoverysPaginator" name="paginatorName" />
				<jsp:param value="myDiscoveryDiv" name="divId" />
				<jsp:param value="ajax" name="type" />
			</jsp:include>
		</div>

<script>
	function cancelFollow(followId){
		$.ajaxDelete('${ctx}/follows/'+followId, null, function(response){
			alert("取消成功");
		})
	}
</script>
