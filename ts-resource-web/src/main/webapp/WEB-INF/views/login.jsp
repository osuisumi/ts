<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>	
<script type="text/javascript">
	$(function(){
		login();
	});
	
	function login(){
        var btn = $("#loginBtn");

        btn.click(function(){
            var urlVal = $("#txt-lst a.z-crt").attr("data-link");
            $(this).attr("href",urlVal);        
        });
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
			parent.window.location.href = '${ctx}/index';
		}else{
			$('#passwordError').find('span').text('用户名或密码错误!');
			$('#passwordError').show();
			return false;
		}
	}
</script>
