<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
    <div class="g-hd" id="g-hd-inner">
        <div class="f-auto">
            <h1 id="logo">
				<a class="img"><img id="logoImg" src="${ctx }/css/images/logo.png" alt=""></a>
           		<a class="txt">${sipc:getProperty('app.name')}</a>
			</h1>
			<div class="m-menu">
                <a item="home" onclick="home()" title="首页" class="z-crt">
                    <i class="u-home-ico"></i>
                </a>
                <a item="announcement" onclick="announcementIndex()">资讯</a>
                <a item="competition" onclick="competitionIndex()">活动</a>
                <a item="resource" onclick="resourceIndex()">资源</a>
                <a item="discovery" onclick="discoveryIndex()">发现</a>
                <a item="board" onclick="boardIndex()">社区</a>
            	<a item="school" onclick="schoolIndex()">学校</a>
            	<a item="workshop" onclick="workshopIndex()" class="last">工作室</a>
            </div>
            <c:choose>
            	<c:when test="${empty sessionScope.loginer }">
            		<div id="loginDiv" class="m-lr-btn">
		                <i class="u-user-ico"></i>
		                <a onclick="goLogin();">登录</a>
		               <!--  <span>/</span>
		                <a href="register.html">注册</a> -->
		            </div>
            	</c:when>
            	<c:otherwise>
            		<div id="loginSeccessDiv" class="m-rt-con">
		                <a class="u-headImg">
		                	<tag:avatar userId="${sessionScope.loginer.id}" avatar="${sessionScope.loginer.avatar}" />
		                	<span>${sessionScope.loginer.realName }</span>
		                </a>
		                <div class="m-user-opa">
		                    <span class="u-bor bor1"></span>
		                    <span class="u-bor bor2"></span>
		                    <a onclick="zoneIndex()" class="u-ico u-zone"><i></i>个人空间</a>
		                    <shiro:hasRole name="bms_manager">
		                    	<a onclick="$('#bmsLoginSSOForm').submit()" class="u-ico u-manage"><i></i>管理中心</a>
		                    	<form id="bmsLoginSSOForm" action="${sipc:getProperty('bms.http.domain') }/loginSSO" method="post">
		                    		<input type="hidden" name="userName" value=${sessionScope.loginer.userName }>
		                    		<input type="hidden" name="password" value=${sessionScope.loginer.password }>
		                    	</form>
		                    </shiro:hasRole>
		                    <!-- <a href="javascript:void(0);" class="u-ico u-news"><i></i>我的消息</a> -->
		                    <a href="${ctx }/logout" class="u-ico u-exit"><i></i>退出登录</a>
		                </div>
		            </div>
            	</c:otherwise>
            </c:choose>
            <%-- <div class="m-tSearch" onclick="searchIndex('searchForm2');">
            	<form id="searchForm2" action="${ctx }/search">
            		<a class="u-sSrh"><i class="u-sSrh-ico"></i>搜索</a>
	                <input type="text" placeholder="输入搜索内容" class="ipt">
	                <a href="###" class="submit"><i class="u-sSrh-ico"></i></a>
            	</form>
            </div> --%>
            <div class="m-top-srh">
            	<form id="searchForm2" action="${ctx }/search">
	                <input name="paramMap[keywords]" type="text" class="ipt" placeholder="请输入关键字" />
	                <a onclick="searchIndex('searchForm2');" href="javascript:void(0);" class="submit"><i class="u-sSrh-ico"></i></a>
	            </form>
            </div>
        </div>
    </div>
<!-- 登录框 -->
<div class="g-layer g-login-box">
    <div id="g-logBox" class="g-logBox" style="border: 1px solid #e7dac9">
        <div class="m-log-box">
            <div class="m-tab-cont f-cb">
                <div class="m-login-tit">
                    <h2 class="u-tit">用户登录</h2>
                    <i class="u-close-btn">×</i>
                </div>
                <div class="m-log-block">
                    <form id="loginForm" name="loginForm" action="${ctx }/login.do" method="post">
                    	<br>
                        <label class="m-ipt-mod m-ipt-account">
                            <input type="text" placeholder="请输入账号" class="u-input" name="userName" id="userName" style="height: 46px; padding: 0">
                        	<div id="usernameError" class="login-popup-hint">
                                <i></i>
                                <span class="txt">请输入正确的帐号！</span>
                            </div>
                            <b class="icon-war-error ico"></b>
                        </label>
                        <label class="m-ipt-mod m-ipt-password">
                            <input type="password" placeholder="请输入密码" class="u-input" name="password" id="password" style="height: 46px; padding: 0">
                        	<div id="passwordError" class="login-popup-hint">
                                <i></i>
                                <span class="txt">请输入密码！</span>
                            </div>
                            <b class="icon-war-error ico"></b>
                        </label>
                        <br>
                        <div class="m-btn-row">
                            <a onclick="submitLogin()" id="loginBtn"  target="_parent" class="u-login-btn main-btn1 btn">登录</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
$(function(){
	if('${sessionScope.loginer.state}' == '3'){
		$('#g-logBox').load('${ctx}/user/goEditUserDept');
		commonJs.fn.aJumpLayer($(".g-layer"));
	}
	
	$('.m-menu').find('a').click(function(){
		$('.m-menu a').removeClass('z-crt');
		$(this).addClass('z-crt');
		changeTop();
	});
	
	if('${index}' != ''){
		$('.m-menu a').removeClass('z-crt');
		$('.m-menu a').eq('${index}').addClass('z-crt');
		changeTop('${index}');
	} 
});

function changeTop(index){
	if(index == null || index == ''){
		index = $('.m-menu a').index($('.m-menu a.z-crt'));
	}
	if(index == 0){
		$('#wrap').find('.g-hd').attr('id','g-hd-index');
		$('#logoImg').attr('src','${ctx }/css/images/logo1.png');
	}else{
		$('#wrap').find('.g-hd').attr('id','g-hd-inner');
		$('#logoImg').attr('src','${ctx }/css/images/logo.png');
	}
}

function changeTab(item){
	$('.m-menu').find('a').removeClass('z-crt');
	$('.m-menu').find('a[item="'+item+'"]').addClass('z-crt');
	var	index = $('.m-menu a').index($('.m-menu a.z-crt'));
	if(index == 0){
		$('#wrap').find('.g-hd').attr('id','g-hd-index');
		$('#logoImg').attr('src','${ctx }/css/images/logo1.png');
	}else{
		$('#wrap').find('.g-hd').attr('id','g-hd-inner');
		$('#logoImg').attr('src','${ctx }/css/images/logo.png');
	}
}
 
function listResource(){
	$('#content').load('${ctx}/resource/listResource');
}

var callback;

function goLogin(callbackFn, loginedFn){
	if('${empty loginer}' == 'true'){
		if(loginedFn != null){
			callback = loginedFn;
		}else{
			callback = callbackFn;
		}
		commonJs.fn.aJumpLayer($(".g-layer"));
	}else{
		callback = callbackFn;
	}
	if('${empty loginer}' == 'true'){
		commonJs.fn.aJumpLayer($(".g-layer"));
	}else{
		if(callback!=undefined){
			var $callback = callback;
			if (! $.isFunction($callback)) $callback = eval('(' + callback + ')');
			$callback();
		}else{
			home();
		}
	}
}

function submitLogin() {
	$('#usernameError').hide();
	$('#passwordError').hide();
	if ($('#userName').val() == '') {
		$('#usernameError').show();
		$('#userName').focus();
		return false;
	}
	if ($('#password').val() == '') {
		$('#passwordError').show();
		$('#password').focus();
		return false;
	}
	var data = $.ajaxSubmit('loginForm');
	var json = $.parseJSON(data);
	if(json.responseCode == '00'){
		if(callback!=undefined){
			var $callback = callback;
			if (! $.isFunction($callback)) $callback = eval('(' + callback + ')');
			$callback();
		}
		$('.u-close-btn').trigger('click');
		reloadLoginer();
	}else{
		$('#passwordError').find('span').text('用户名或密码错误!');
		$('#passwordError').show();
		return false;
	}
}

function reloadLoginer(){
	window.location.reload();
	//$('#top').load('${ctx}/top?index='+$('.m-menu a').index($('.m-menu a.z-crt')));
}
</script>