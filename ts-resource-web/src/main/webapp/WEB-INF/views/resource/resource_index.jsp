<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<tag:mainLayout>
	<div id="g-bd">
		<div class="f-auto">
			<c:if test="${not empty relationId }">
				<div class="g-layout-mod">
	                <div class="m-crm">
	                    <span class="txt">您当前的位置： </span>
	                    <a onclick="home()" href="###" title="首页" class="u-goto-index">
	                        <i class="u-sHome-ico"></i>
	                    </a>
	                    <span class="trg">&gt;</span>
	                    <a onclick="viewDept('${dept.id}')" href="###">${dept.deptName }</a>
	                    <span class="trg">&gt;</span>
	                    <em>资源</em>
	                </div>
					<div class="m-logo-box">
						<div class="logo-lt">
							<a class="u-logo"> 
								<c:choose>
									<c:when test="${empty dept.imageUrl }">
										<img src="${ctx}/images/no-logo.png" width="91" height="91">
									</c:when>
									<c:otherwise>
										<img src="${file:getFileUrl(dept.imageUrl) }" width="91" height="91">
									</c:otherwise>
								</c:choose>
								<h1>${dept.deptName}校本资源平台</h1>
								<p>育人为本，自主发展，追求卓越</p>
							</a>
						</div>
						<div class="logo-rt">
							<p>资源总量：${resourceNum } 个</p>
							<p>本月新增：${newResourceNum }个</p>
						</div>
						<div class="u-light-line"></div>
	                    <a onclick="goSchool('${dept.website }')"  class="u-rt-btn">前往学校</a>
					</div>
	            </div>
			</c:if>
			<div class="g-res-bd">
				<div class="m-head-btn">
					<div class="u-tb-btn">
						<a onclick="moreResource('sync')" class="btn-tb act"><i></i>同步资源库<span></span></a>
					</div>
					<div class="u-fl-btn">
						<a onclick="moreResource('classify')" class="btn-tb btn-fl"><i></i>分类资源<span></span></a>
					</div>
					<c:if test="${empty relationId }">
						<div class="u-upload-btn">
							<p>已有 ${numMap.teacherNum } 名教师，贡献 ${numMap.resourceNum } 套资源</p>
							<a onclick="goLoginForAddResource()" class="u-cont-btn btn-upload"><i class="u-upload-ico"></i>上传我的资源</a>
						</div>
					</c:if>
				</div>
				<div id="resourceContent">
				
				</div>
			</div>
		</div>
	</div>
</tag:mainLayout>
<script>
$(function(){
	moreResource('sync');
	changeTab('resource');
});

function moreResource(type){
	$('#resourceContent').load('${ctx}/resource/moreResource', 'paramMap[type]='+type+'&paramMap[relationId]=${relationId[0]}'+'&paramMap[creator]=${creator[0]}');
}

function listMoreResource(){
	$.ajaxQuery('listMoreResourceForm', 'listMoreResourceDiv');
}
</script>
			
