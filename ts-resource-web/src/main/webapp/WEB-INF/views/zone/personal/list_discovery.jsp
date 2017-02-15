<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="g-mn-mod" style="padding-bottom: 20px;">
	<div class="m-mn-tt tea">
		<span class="lb"></span>
		<h2 class="tt small-size">精彩发现</h2>
		<c:if test="${sessionScope.loginer.id eq searchParam.paramMap.creator}">
			<a style="float:right" onclick="addDiscovery()">+分享发现</a>
		</c:if>
	</div>
	<div class="m-mn-dt">
	<form id="listDiscoveryForm" action="${ctx}/zone/personal/discovery">
		<input type="hidden" name="orders" value="${orders }"/>
		<input type="hidden" name="limit" value="${limit}"/>
		<input id="creatorOrFollowCreator" type="hidden" name="paramMap[creatorOrFollowCreator]" value="${searchParam.paramMap.creatorOrFollowCreator}">
		<input id="creator" type="hidden" name="paramMap[creator]" value="${searchParam.paramMap.creator}">
		<input id="followCreator" type="hidden" name="paramMap[followCreator]" value="${searchParam.paramMap.followCreator }">
		<input type="hidden" name="paramMap[type]" value="discovery">
		<div class="m-find-wrap">
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
					<jsp:param value="personalContent" name="divId" />
					<jsp:param value="ajax" name="type" />
				</jsp:include>
			</div>
		</div>
	</form>
	</div>
</div>