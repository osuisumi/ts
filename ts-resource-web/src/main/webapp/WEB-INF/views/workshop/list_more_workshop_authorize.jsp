<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
	<ul class="g-member-ul">
		<c:forEach items="${workshopAuthorizes}" var="workshopAuthorize">
			<li>
			<c:if test="${not(workshopAuthorize.role eq 'master')}">
				<label class="m-choose">
					 <input type="checkbox" name="id" style="top:23px" value="${workshopAuthorize.id }">
				</label> 
			</c:if>
				<span class="m-user-img">
					 <tag:avatar userId="${workshopAuthorize.user.id}" avatar="${workshopAuthorize.user.avatar}"></tag:avatar> <span class="name">${workshopAuthorize.user.realName }</span>
				</span>
				<div class="u-rt">
					<c:choose>
						<c:when test="${workshopAuthorize.role eq 'master' }">
							<span>坊主</span>
						</c:when>
						<c:when test="${workshopAuthorize.state eq 'apply' }">
							<div class="u-rt">
								<div class="u-ope">
									<a onclick="updateAuthorize('${workshopAuthorize.id}','pass','');" class="u-allow">审核通过</a> <span class="u-line">|</span> <a onclick="updateAuthorize('${workshopAuthorize.id}','nopass','');" class="u-decline">拒绝申请</a>
								</div>
							</div>
						</c:when>
						<c:when test="${workshopAuthorize.state eq 'nopass'}">
							<p class="u-state">
								<i class="u-ico"></i> <span>已拒绝申请</span>
							</p>
						</c:when>
						<c:when test="${(workshopAuthorize.role eq 'member') and (workshopAuthorize.state eq 'pass') }">
							<span>成员</span>
						</c:when>
					</c:choose>
				</div> 
				<a onclick="deleteAuthorize('${workshopAuthorize.id}','${authorize.user.id }')" class="u-del" title="删除该成员">×</a>
			</li>
		</c:forEach>
	</ul>
	<div class="am-pageturn">
		<jsp:include page="/WEB-INF/views/include/pagination.jsp">
			<jsp:param value="listAuthorizeForm" name="pageForm" />
			<jsp:param value="workshopAuthorizesPaginator" name="paginatorName" />
			<jsp:param value="listAuthorizeDiv" name="divId" />
			<jsp:param value="ajax" name="type" />
		</jsp:include>
	</div>