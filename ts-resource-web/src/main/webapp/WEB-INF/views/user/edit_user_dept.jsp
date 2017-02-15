<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="m-log-box">
	<div class="m-tab-cont f-cb">
		<div class="m-login-tit">
			<h2 class="u-tit">修改单位</h2>
			 <i style="display: none;" class="u-close-btn">×</i>
		</div>
		<div class="m-log-block">
			<form id="editUserDeptForm" action="${ctx }/user/updateUserDept" method="post">
				<input type="hidden" name="id" value="${user.id }">
				<input type="hidden" name="userDept.id" value="${user.userDept.id }">
				<input type="hidden" name="account.id" value="${user.account.id }">
				<input type="hidden" name="department.deptName" id="deptNameParam">
				<input type="hidden" name="userDept.deptId" id="deptIdParam">
				<p style="color: red;">您的所在单位可能不正确, 请选择您的所在单位</p>
				<div class="m-bslt-mod" >
                    <a href="javascript:void(0);" class="show-txt">
                        <span class="txt">请选择</span>
                        <i></i>
                    </a>
                    <div class="txt-lst" id="txt-lst" style="height: 250px; overflow: auto">
                    	<c:forEach items="${departments }" var="dept">
                    		<a href="javascript:void(0);" value="${dept.id }" style="height: 30px; line-height: 30px;">${dept.deptName }</a>
                    	</c:forEach>
                    </div>
                    <script>
                    	$(function(){
                    		$('#txt-lst a').click(function(){
                    			$('#deptIdParam').val($(this).attr('value'));
                    			$('#deptNameParam').val($(this).text());
                    		});
                    	});
                    </script>
                </div>
				<br>
				<div class="m-btn-row">
					<a onclick="updateUserDept()" id="loginBtn" target="_parent" class="u-login-btn main-btn1 btn">修改</a>
				</div>
			</form>
		</div>
	</div>
</div>
<script>
	function updateUserDept(){
		if($('#deptIdParam').val().length == 0){
			alert('请选择单位');
			return false;
		}
		var data = $.ajaxSubmit('editUserDeptForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			$('.u-close-btn').trigger('click');
			home();
		}
	}

	$(function(){
		var $parents = $(".m-bslt-mod"),
		$showBlcok = $parents.children(".show-txt"),
		$txtList = $parents.children(".txt-lst");
		$showText = $showBlcok.children(".txt");
		$sltText = $txtList.children("a");
		$showBlcok.on("click",function(e){
			e.stopPropagation();
			var _this = $(this);
			if(_this.hasClass("z-crt")){
				_this.removeClass("z-crt");
				$txtList.hide();
			}else{
				_this.addClass("z-crt");
				$txtList.show();
			}
			$sltText.on("click",function(){
				$sltText.removeClass("z-crt");
				$(this).addClass("z-crt");
				$showText.text($(this).text());
				$showBlcok.removeClass("z-crt");
				$txtList.hide();
			})
			$(document).one("click",function(e){
				var target = $(e.target);
				if(target.closest($txtList).length == 0){
					$txtList.hide();
					$showBlcok.removeClass("z-crt");
				}
			})
		})
	});
</script>