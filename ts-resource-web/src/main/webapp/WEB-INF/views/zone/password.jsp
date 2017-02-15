<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="modifyPasswordForm" action="">
<div class="g-frame-mn w-710 fr">
	<div class="g-mn-mod">
		<div class="m-cloud-box">
			<div class="m-mn-tt">
				<h3 class="tt small">修改密码</h3>
			</div>
			<div class="m-mn-dt">
				<div class="g-userMod-dt">
					<div class="g-pb-lst">
						<div class="m-pb-row">
							<div class="pb-mn">
								<div class="m-pb-mod">
									<div class="pb-txt">
										<span>原密码：</span>
									</div>
									<div class="m-ipt-mod">
										<input type="password" style="display:none">
										<input id="oldPsw" type="password" name="oldPassword" class="u-ipt {required:true}" autocomplete="off">
									</div>
								</div>
							</div>
						</div>
						<div class="m-pb-row">
							<div class="pb-mn">
								<div class="m-pb-mod">
									<div class="pb-txt">
										<span>新密码：</span>
									</div>
									<div class="m-ipt-mod">
										<input type="password" style="display:none">
										<input id="newPsw" type="password" name="newPassword" class="u-ipt important {required:true}">
									</div>
								</div>
							</div>
						</div>
						<div class="m-pb-row">
							<div class="pb-mn">
								<div class="m-pb-mod">
									<div class="pb-txt">
										<span>确认密码：</span>
									</div>
									<div class="m-ipt-mod">
										<input type="password" style="display:none">
										<input id="repetPsw" type="password" name="repetPassword" class="u-ipt {required:true,equalTo:'#newPsw'}">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="g-userMod-dt">
					<div class="g-pb-lst">
						<div class="m-pb-row btn-box">
							<a onclick="saveModifyPassword()" class="u-btn-com u-download">保存</a> <a onclick="cancel()" class="u-btn-com u-cancel">取消</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</form>
<script>
function saveModifyPassword(){
	if (!$('#modifyPasswordForm').validate().form()) {
		return false;
	}
	$.post('${ctx}/zone/password/modify',{
		"oldPassword":$('#oldPsw').val(),
		"account.password":$('#newPsw').val(),
		"id":"${sessionScope.loginer.id}"
	},function(response){
		if(response.responseCode == '00'){
			alert("修改成功，请重新登录");
			window.location.href="${ctx }/logout.do";
		}else{
			alert("密码错误");
		}
	})
}

</script>
