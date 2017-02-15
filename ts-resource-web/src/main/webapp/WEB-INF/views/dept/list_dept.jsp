<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="deptForm" action="${ctx}/dept/more">
	<input type="hidden" name="paramMap[deptType]" value="2">
	<input type="hidden" name="orders" value="CREATE_TIME.DESC" />
	<input type="hidden" id="stage" name="paramMap[stage]" value="${searchParam.paramMap.stage}" />
	<input type="hidden" id="selected" name="paramMap[selected]" value="${searchParam.paramMap.selected}" />
	<div id="g-bd">
		<div class="f-auto">
			<div class="g-inner-bd">
				<div class="g-frame">
					<div class="g-school-lst">
						<div class="g-mn-mod">
							<div class="m-mn-tt">
								<h2 class="tt">台山市学校一览</h2>
								<div class="m-tabli">
									<a onclick="javascript:changeStage();" i="0" class="z-crt">全部</a> <span>|</span>
									<a i='4' href="javascript:changebyRank();">按排名</a> <span>|</span> <a i='3'
										onclick="javascript:changeStage(3);">小学</a> <span>|</span> <a i='1'
										onclick="javascript:changeStage(1);">初中</a> <span>|</span> <a i='2'
										onclick="javascript:changeStage(2);">高中</a>
								</div>
							</div>
							<div class="m-mn-dt" style="padding-bottom: 20px;">
								<div class="school-lst-box">
									<c:choose>
										<c:when test="${not empty depts }">
											<ul id="schoolContent" class="school-lst-ul">
												<!--  24个就好  -->
												<c:forEach items="${depts}" var="dept">
													<li class="logo-lst">
														<a title="${dept.deptName }" onclick="viewDept('${dept.id}')"><i>
															<c:if test="${empty dept.imageUrl }">
																<img id="imagePreView" src="${ctx}/images/no-logo.png" width="91" height="91">
															</c:if>
															<c:if test="${not empty dept.imageUrl }">
																<img id="imagePreView" src="${file:getFileUrl(dept.imageUrl) }" width="91" height="91"></c:if>														
															</i>
															<p>${dept.deptName }</p>
														</a>
													</li>
												</c:forEach>
											</ul>
											<!-- 这里插入pagination.jsp -->
											<div class="m-jump-page">
												<jsp:include page="/WEB-INF/views/include/pagination.jsp">
													<jsp:param value="deptForm" name="pageForm" />
													<jsp:param value="deptsPaginator" name="paginatorName" />
													<jsp:param value="content" name="divId" />
													<jsp:param value="ajax" name="type" />
												</jsp:include>
											</div>
										</c:when>
										<c:otherwise>
											<tag:noContent msg="没有相关资源" />
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
						<!--end g-mn-mod-->
					</div>
					<!--end g-school-lst-->
				</div>
				<!--end layout frame -->
			</div>
			<!--end inner page body -->
		</div>
	</div>
</form>
<!--end content body -->

<script type="text/javascript">
/* 待页面返回，设定所属的分类 */
$(function(){
	$(".m-tabli a.z-crt").removeClass("z-crt");
	var selected = $("#selected").val();
	var t;
	if(selected == null||selected ===""){
		t = "a[i=0]";
	}else{
		t = "a[i="+selected+"]";
	}
	$(t).addClass("z-crt");	
});

	function changeStage(stage){		
		$("#stage").val(stage);	
		$("#selected").val(stage);
		$.ajaxQuery('deptForm', 'content');	
	}
	function changebyRank(){
		$("#stage").val('');	
		$("#selected").val('4');
		$("input[name=orders]").val("UPLOAD_NUM.DESC");
		$.ajaxQuery('deptForm', 'content');
	}
</script>