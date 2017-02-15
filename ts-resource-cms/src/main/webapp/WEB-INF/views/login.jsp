<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<title>广州昊誉信息科技有限公司</title>
<meta name="Keywords" content="教育,网络,数字校园,教育信息化,科技,网站开发,软件开发,远程教育">
<meta name="description" content="广州昊誉信息科技有限公司成立于2012年，公司以计算机软件技术为基础，立足于教育信息化行业，为客户提供教育信息化相关软件开发及技术支持的服务 ，旨在成为专业的教育信息化建设解决方案提供商。">
<meta content="广州昊誉信息科技有限公司" name="author" />
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript" src="${ctx }/js/jquery.js"></script>
<script type="text/javascript" src="${ctx }/js/jquery.dsTab.js"></script>
<script type="text/javascript" src="${ctx }/js/login.js"></script>
<link type="text/css" rel="stylesheet" href="${ctx}/css/reset.css">
<link type="text/css" rel="stylesheet" href="${ctx}/css/login.css">
</head>
<div id="g-logWrap">
	<!--start #g-tp 顶部-->
	<!--  class="g-fx-tp" -->
	<div id="g-logTp">
		<div class="g-tpc f-cb">
			<!--start #g-logo 标志-->
			<h1 class="g-logo">
				<br>
				<a href="index.html" class="logo"><img src="images/logo2.png" alt=""></a><span class="txt">台山市教育资源公共服务平台</span>
			</h1>
			<!--end #g-logo 标志-->
		</div>
	</div>
	<!--end #g-tp 顶部-->
	<!--start .g-log-bn-->
	<div id="g-log-bn">
		<ul class="m-slide-lst">
			<li><img src="images/login-banner1.jpg" alt=""></li>
			<li><img src="images/login-banner2.jpg" alt=""></li>
		</ul>
		<a href="javascript:void(0);" class="u-bn-prev"></a> <a href="javascript:void(0);" class="u-bn-next"></a>
	</div>
	<!--end .g-log-bn-->
	<!--start #g-logBox 登录框-->
	<div id="g-logBox">
		<!-- <div class="m-hint">
			<span class="c-txt">来试试更安全便捷的登录方式</span> <span class="u-trg1"></span>
		</div> -->
		<div class="m-log-box">
			<div class="m-tab-li f-cb">
				<a href="javascript:void(0);" class="item1 z-crt"><span>账号登录</span></a> 
				<!-- <a href="javascript:void(0);" class="item2"><span><i class="u-tdc"></i>二维码登录</span></a> -->
			</div>
			<div class="m-tab-cont f-cb">
				<div class="m-log-block">
					<form id="loginForm" name="loginForm" action="${ctx }/login.do" method="post">
						<label class="m-ipt-mod m-ipt-password"> 
							<input type="text" class="u-ipt" name="userName" id="userName" placeholder="账号" />
							<div id="usernameError" class="login-popup-hint">
								<i></i> 
								<span class="txt">请输入正确的帐号！</span>
							</div> 
							<b class="icon-war-error ico"></b>
							<!-- <div class="m-slt-mod">
								<a href="javascript:void(0);" class="show-text"> 
									<span class="txt">账号</span><i class="u-trg2"></i>
								</a>
								<div class="txt-lst">
									<a href="#" class="z-crt">账号</a> 
									<a href="#">手机号</a>
								</div>
							</div> -->
						</label> 
						<br>
						<label class="m-ipt-mod m-ipt-password"> 
							<input type="password" class="u-ipt" name="password" id="password" placeholder="密码" />
							<div id="passwordError" class="login-popup-hint">
								<i></i> 
								<span class="txt">你的密码不正确，请重新输入！</span>
							</div> 
							<b class="icon-war-error ico"></b>
						</label>
						<!-- <div class="m-row f-cb">
							<label for="" class="m-diy-checkbox" onselectstart="return false"> <i class="u-checkbox z-slt"></i> <span>5天内免登录</span>
							</label> <a href="#" class="fg-pw">找回密码</a>
						</div> -->
						<br><br>
						<div class="m-btn-row">
							<button onClick="login()" type="button" class="main-btn1 btn">
								<em>登录</em>
								<span><i class="u-trg3"></i></span>
							</button>
						</div>
						<!-- <div class="link-reg">
							<span>还没有昊誉账号？<a href="#">免费注册</a></span>
						</div> -->
					</form>
				</div>
				<!--end .m-log-block 帐号密码登录-->
				<div class="m-tdc-block">
					<h4>安全登录，防止被盗</h4>
					<div class="m-tdc-img">
						<img src="images/tdc.jpg" alt="二维码">
					</div>
					<span class="c-ex">请使用昊誉手机版扫描二维码</span>
				</div>
				<!--end .m-log-block 二维码登录-->
			</div>
		</div>
	</div>
	<!--end #g-logBox 登录框-->
	<!--start #g-logft 登录页面底部-->
	<div id="g-logft">
		<div class="g-ftc">
			<!-- <div class="m-ft-nav">
				<a href="#">联系我们</a> <span class="line">|</span> <a href="#">软件产品</a> <span class="line">|</span> <a href="#">解决方案</a> <span class="line">|</span> <a href="#">隐私保护</a> <span class="line">|</span> <a href="#">招贤纳士</a> <span class="line">|</span> <a href="#">意见反馈</a>
			</div> -->
			<p>Copyright&nbsp;&nbsp;&nbsp;2012-2015&nbsp;&nbsp;&nbsp;台山市教育局&nbsp; 版权所有</p>
		</div>
	</div>
	<!--end #g-logft 登录页面底部-->
</div>
<!-- <div id="login-footer">
			<div class="login-footer-auto login-auto">
				<p>项目工程办：广东省中小学信息技术应用能力提升工程 办公室联系电话：020-34113588 020-34224200(FAX)</p>
			</div>
		</div> -->
</div>
<script type="text/javascript">
	$(function() {
		$('#g-log-bn').dsTab({
			itemEl : '.m-slide-lst li',
			btnElName : 'm-fouse',
			btnItem : 'a',
			maxSize : 5,
			currentClass : 'z-crt', //按钮当前样式
			autoCreateTab : false,
			prev : '.u-bn-prev',
			next : '.u-bn-next',
			changeType : 'fade',
			change : true,
			changeTime : 5000,
			overStop : false,
		});
		
		if('${requestScope.errorMsg}' != ''){
			$('#passwordError .txt').text('账号或密码不正确, 请重新输入');
			$('#passwordError').show();
		}
	});

	function login() {
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
		$("#loginForm").submit();
		return true;
	}
</script>
</body>
</html>