<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<tag:mainLayout>
	<div id="g-bd">
		<div class="f-auto">
			<div class="g-search-wp">
				<div class="g-mn-mod">
					<form id="searchForm" action="${ctx }/search" method="get"> 
						<input id="typeParam" type="hidden" name="paramMap[type]" value="${searchParam.paramMap.type }">
						<input type="hidden" name="orders" value="${orders}">
						<input type="hidden" name="paramMap[stage]" value="${searchParam.paramMap.stage}" class="resourceParam"> 
						<input type="hidden" name="paramMap[subject]" value="${searchParam.paramMap.subject}" class="resourceParam">
						<input type="hidden" name="paramMap[grade]" value="${searchParam.paramMap.grade}" class="resourceParam">
						<div class="m-search-box">
							<div class="search-tit">
								<div class="m-linkage-choose">
									<div class="m-slt-block1">
										<a href="javascript:void(0);" class="show-txt" title=""> 
											<span id="typeTxt" class="txt">请选择资源类型</span> <i class="trg"></i>
										</a>
										<dl id="typeDl" class="lst">
											<dd>
												<a href="javascript:void(0);" value="" class="z-crt">全部</a>
											</dd>
											<dd>
												<a href="javascript:void(0);" value="announcement">资讯</a>
											</dd>
											<dd>
												<a href="javascript:void(0);" value="resource">资源</a>
											</dd>
											<dd>
												<a href="javascript:void(0);" value="discovery">发现</a>
											</dd>
											<dd>
												<a href="javascript:void(0);" value="discussion">社区</a>
											</dd>
											<dd>
												<a href="javascript:void(0);" value="competition">活动</a>
											</dd>
										</dl>
										<script>
											$(function(){
												$('#typeDl a').click(function(){
													$('#typeParam').val($(this).attr('value'));
												});
												$('#typeDl a').removeClass('z-crt');
												$('#typeDl a[value="${searchParam.paramMap.type}"]').addClass('z-crt');
												$('#typeTxt').text($('#typeDl a.z-crt').text());
											});
										</script>
									</div>
								</div>
								<div class="input-box">
									<input id="keywords" type="text" class="u-txt" name="paramMap[keywords]" value="${searchParam.paramMap.keywords }" placeholder="请输入关键字" style="height: 30px;"> 
									<input type="button" class="u-sch" value="搜索" onclick="submitSearchForm()">
								</div>
							</div>
							<div class="search-con"></div>
						</div>
						<div class="m-search-result">
							<c:choose>
								<c:when test="${not empty searchParam.paramMap.keywords }">
									<h3 class="u-srh-rst">
										<i class="u-sch-ico"></i>搜索结果
									</h3>
									<c:choose>
										<c:when test="${not empty searchResult }">
											<ul id="searchResultUl" class="m-slt-option">
												<c:forEach items="${searchResult }" var="searchResult">
													<c:choose>
														<c:when test="${searchResult.type eq 'announcement' }">
															<li class="u-news"><i class="u-ltl-ico">资讯</i>
															<a onclick="viewAnnouncement('${searchResult.id}')" class="txt">
																${searchResult.title }
															</a> 
														</c:when>
														<c:when test="${searchResult.type eq 'resource' }">
															<li class="u-res"><i class="u-ltl-ico">资源</i>
															<a onclick="viewResource('${searchResult.id}')" class="txt">
																${searchResult.title }
															</a> 
														</c:when>
														<c:when test="${searchResult.type eq 'discovery' }">
															<li class="u-find"><i class="u-ltl-ico">发现</i>
															<a onclick="viewDiscovery('${searchResult.id}')" class="txt">
																${searchResult.title }
															</a> 
														</c:when>
														<c:when test="${searchResult.type eq 'discussion' }">
															<li class="u-community"><i class="u-ltl-ico">社区</i>
															<a onclick="viewBoardDiscussion('${searchResult.id}')" class="txt">
																${searchResult.title }
															</a> 
														</c:when>
														<c:when test="${searchResult.type eq 'competition' }">
															<li class="u-community"><i class="u-ltl-ico">活动</i>
															<a onclick="viewCompetition('${searchResult.id}')" class="txt">
																${searchResult.title }
															</a> 
														</c:when>
													</c:choose>
														<span class="u-time">创建于 ${searchResult.createTime }</span>
													</li>
												</c:forEach>
											</ul>
										</c:when>
										<c:otherwise>
											<tag:noContent msg="没有匹配的结果" />
										</c:otherwise>	
									</c:choose>
									<p class="res-num">
										找到
										<c:if test="${not empty searchParam.paramMap.keywords }">
											与<em>”${searchParam.paramMap.keywords }“</em>
										</c:if>
										相关的资源有<em>${paginator.totalCount }</em>条记录
									</p>
									<div class="am-pageturn">
										<jsp:include page="/WEB-INF/views/include/pagination.jsp">
											<jsp:param value="searchForm" name="pageForm" />
											<jsp:param value="paginator" name="paginatorName" />
											<jsp:param value="content" name="divId" />
											<jsp:param value="post" name="type" />
										</jsp:include>
									</div>
								</c:when>
								<c:otherwise>
									<tag:noContent msg="请输入关键字后再搜索" />
								</c:otherwise>
							</c:choose>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</tag:mainLayout>
<script>
$(function(){
	changeTab();
});

function submitSearchForm(){
	if($('#keywords').val().length == 0){
		alert('请输入关键字再搜索');
		return false;
	}
	$('#searchForm .page').val(1); 
	$('.resourceParam').val(''); 
	searchIndex('searchForm')
}
</script>