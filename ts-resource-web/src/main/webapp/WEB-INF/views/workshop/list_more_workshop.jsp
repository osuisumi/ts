<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<tag:mainLayout>
	<div id="g-bd">
		<div class="f-auto">
			<div class="g-inner-bd">
				<div class="g-frame">
					<div class="g-school-lst">
						<div class="g-mn-mod">
							<div class="m-mn-tt">
								<h2 class="tt">名师工作室</h2>
							</div>
							<form id="listWorkshopForm" action="${ctx }/workshop/more">
								<input type="hidden" name="orders" value="CREATE_TIME.DESC">
								<div id="listWorkshopDiv" class="m-mn-dt" style="padding: 20px 0;">
									<ul class="m-figure-lst2 worksop-lst">
										<c:forEach items="${workshops}" var="workshop">
											<li>
												<div class="m-figure-block2">
													<a onclick="viewWorkshop('${workshop.id}')" class="head-box">
														<c:choose>
															<c:when test="${not empty workshop.imageUrl }">
																<img class="u-head-img" src="${file:getFileUrl(workshop.imageUrl) }">
															</c:when>
															<c:otherwise>
																<img class="u-head-img" src="${ctx }/images/defaultWorkshopImg.png">
															</c:otherwise>
														</c:choose>	
													</a>
													<h4 class="u-tit">
														<a onclick="viewWorkshop('${workshop.id}')" >${workshop.name }</a>
													</h4>
													<p class="u-info">
														<span>
															主持人：
															<c:forEach items="${workshop.masters }" var="master">
																${master.realName}&nbsp
															</c:forEach>
														</span>
													</p>
													<p class="u-info">
														<span>成员：${workshop.workshopRelations[0].memberNum }</span>
														<span>研修活动：${workshop.workshopRelations[0].activityNum }</span>
														<span>资源：${workshop.workshopRelations[0].resourceNum }</span>
														<span>最新动态：无</span>
													</p>
													<p class="u-info">${workshop.summary }</p>
													<div class="btnDiv">
														<a onclick="viewWorkshop('${workshop.id }')" class="minor-btn">进入工作室</a>
													</div>
												</div>
											</li>
										</c:forEach>
									</ul>
									<div class="am-pageturn">
										<jsp:include page="/WEB-INF/views/include/pagination.jsp">
											<jsp:param value="listWorkshopForm" name="pageForm" />
											<jsp:param value="workshopsPaginator" name="paginatorName" />
											<jsp:param value="post" name="type" />
										</jsp:include>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</tag:mainLayout>
<script>
$(function(){
	changeTab('workshop');
});
</script>