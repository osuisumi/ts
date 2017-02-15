<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<jsp:useBean id="nowTime" class="java.util.Date" />
<%-- <div id="header-wrap" style="background: rgba(0, 0, 0, 0) url('${ctx}/images/header_bg_right.jpg') no-repeat; background-size: 100% 100%;">
	<div class="hd-wrap-l" style="padding-right: 100px; background: none">
		<div id="logoDiv" style="margin-top: 10px; background-image: none; line-height: 30px;">
			<h2>${ipanthercore:getProperty('app.name')}</h2>
			<img src="${ctx}/images/logo.png" width="600">
		</div>
		<div class="u-infor">
			<span class="u-txt"> <strong>当前用户</strong>：${sessionScope.loginer.realName }</span>
			<!-- <span class="u-line">/</span> -->
			<span class="u-txt"> <strong>机构</strong>：${sessionScope.loginer.deptName} </span>
		</div>
	</div>
	<div id="menu-wrap">
		<a href="${ctx }/logout.do" class="menu-base menu-quit"> <i class="menu-tab5 menu-ico"></i></a>
	</div>
</div>
 --%>
<div id="g-hd">
	<div class="g-hd-inner">
		<h1 class="m-logo">
			<a href="###"> <img src="${ctx }/css/images/logo.png" alt="台山市教育资源公共服务平台">
			</a>
		</h1>
		<!--end logo -->
		<ul class="m-top-menu">
			<li><a onclick="logout()" href="###" class="top-menu-ico ico1"> <span class="icons"></span></a></li>
			<li>
				<a href="javascript:void(0);" class="user"> 
					<tag:avatar avatar="${sessionScope.loginer.avatar }" />
					<span>${sessionScope.loginer.realName }</span>
				</a>
			</li>
			<li>
				<a href="javascript:void(0);" class="user"> 
					<span>${sessionScope.loginer.deptName }</span>
				</a>
			</li>
		</ul>
	</div>
	<!--end header inner -->
</div>
<script>
function logout(){
	confirm('确定要退出登录吗?', function(){
		window.location.href = '${sipc:getProperty("cms.http.domain")}/logout';
	});
}
</script>