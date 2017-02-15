<%@ page import="com.haoyu.sip.file.utils.FileUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<spring:url value="/images" var="imageUrl" />
<form id="userForm" action="${ctx}/zone/user/update">
	<input type="hidden" name="id" value="${user.id}">
	<input id="oldUserName" type="hidden" value="${user.account.userName}">
	<input type="hidden" name="account.id" value="${user.account.id}">
	<div class="g-frame-mn w-710 fr">
		<div class="g-mn-mod">
			<div class="m-cloud-box">
				<div class="m-mn-tt">
					<h3 class="tt small">账号设置</h3>
				</div>
				<div class="m-mn-dt">
					<div class="g-userMod-dt">
						<div class="g-pb-lst">
							<div class="m-pb-row">
								<div class="pb-mn">
									<div class="m-pb-mod">
										<div class="m-upload-pic headimg">
											<div class="img">
												<c:choose>
													<c:when test="${not empty user.avatar}">
														<img id="imagePreView" src="<%=FileUtils.getHttpHost() %>${user.avatar}" alt="">
													</c:when>
													<c:otherwise>
														<img id="imagePreView" src="${imageUrl}/defaultAvatar.png" alt="">
													</c:otherwise>
												</c:choose>
											</div>
											<div class="opa">
												<div class="m-ful-btn">
													<a class="u-file-show-btn" id="picker"> <i class="u-upload-ico ico1"></i> 上传图片
													</a>
												</div>
												<p class="ex">仅支持JPG、JPEG、PNG格式（2M以下）</p>
											</div>
											<ul id="fileList">

											</ul>
										</div>
									</div>
								</div>
							</div>
							<div class="m-pb-row">
								<div class="pb-mn">
									<div class="m-pb-mod">
										<div class="pb-txt">
											<span>用户名：</span>
										</div>
										<div class="m-ipt-mod">
											<input id="account_userName" type="text" name="account.userName" value="${user.account.userName}" placeholder=""  class="u-ipt">
										</div>
									</div>
								</div>
							</div>
							<div class="m-pb-row">
								<div class="pb-mn">
									<div class="m-pb-mod">
										<div class="pb-txt">
											<span>联系邮箱：</span>
										</div>
										<div class="m-ipt-mod">
											<input type="text" name="email" placeholder="" value="${user.email}" class="u-ipt important {email:true}">
										</div>
									</div>
								</div>
							</div>
							<div class="m-pb-row">
								<div class="pb-mn">
									<div class="m-pb-mod">
										<div class="pb-txt">
											<span>联系电话：</span>
										</div>
										<div class="m-ipt-mod">
											<input type="text" name="phone" placeholder="" value="${user.phone }" class="u-ipt {digits:true}">
										</div>
									</div>
								</div>
							</div>
							<div class="m-pb-row">
								<div class="pb-mn">
									<div class="m-pb-mod">
										<div class="pb-txt">
											<span>自我介绍：</span>
										</div>
										<div class="m-ipt-mod">
											<textarea placeholder="让乐高迷们认识你，请用一句话介绍自己。" name="summary" class="u-textarea">${user.summary}</textarea>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="g-userMod-dt">
						<div class="u-line-tit">
							<h4>教师信息</h4>
						</div>
						<div class="g-pb-lst">
							<div class="m-pb-row">
								<div class="pb-mn">
									<div class="m-pb-mod">
										<div class="pb-txt">
											<span>真实姓名：</span>
										</div>
										<div class="m-ipt-mod">
											<input type="text" name="realName" placeholder="" value="${user.realName }" class="u-ipt {required:true}">
										</div>
									</div>
								</div>
							</div>
							<!--end .m-pb-row -->
							<div class="m-pb-row">
								<div class="pb-mn">
									<div class="m-pb-mod">
										<div class="pb-txt">
											<span>身份证号：</span>
										</div>
										<div class="m-ipt-mod">
											<input type="text" readonly="readonly" name="paperworkNo" placeholder="" value="${user.paperworkNo }" class="u-ipt">
										</div>
									</div>
								</div>
							</div>
							<div class="m-pb-row">
								<div class="pb-mn">
									<div class="m-pb-mod">
										<div class="pb-txt">
											<span>出生年月：</span>
										</div>
										<div class="m-ipt-mod">
											<input id="bornDate" type="text" name="birthday" class="u-ipt" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd', minDate: '', maxDate: '' })" value="<fmt:formatDate value="${user.bornDate}" pattern="yyyy-MM-dd"  />"> <a href="javascript:void(0);" class="au-calendar-ico"></a>
										</div>
									</div>
								</div>
							</div>
							<div class="m-pb-row">
								<div class="pb-mn">
									<div class="m-pb-mod">
										<div class="pb-txt">
											<span>性别：</span>
										</div>
										<div class="m-choose-mod">
											<label class="u-choose"> <input id="male" type="radio" name="sex" checked="checked" value="${dict:getEntryValue('SEX','男') }"> <span>男</span></label> <label class="u-choose"> <input id="female" type="radio" name="sex" value="${dict:getEntryValue('SEX','女') }"> <span>女</span></label>
											<script type="text/javascript">
											var sex = "${user.sex}";
											var male = "${dict:getEntryValue('SEX','男')}";
											var female = "${dict:getEntryValue('SEX','女')}"
											if(sex == female){
												$('#female').get(0).checked = true;
												$('#male').get(0).checked = false;
											}else{
												$('#male').get(0).checked = true;
												$('#female').get(0).checked = false;
											}
										</script>
										</div>
									</div>
								</div>
							</div>
							<div class="m-pb-row">
								<div class="pb-mn">
									<div class="m-pb-mod">
										<div class="pb-txt">
											<span>学段学科：</span>
										</div>
										<div class="m-ipt-mod">
											<!-- <div class="m-slt-block1"> -->
											<select class="u-ipt" style="width: 40%" name="stage">
												<!-- <option>请选择学段</option> --> ${tb:getEntryOptionsSelected('STAGE',user.stage)}
											</select> <select class="u-ipt" style="width: 40%" name="subject">
												<!-- <option>请选择学科</option> --> ${tb:getEntryOptionsSelected("SUBJECT",user.subject) }
											</select>
										</div>
									</div>
								</div>
							</div>
							<div class="m-pb-row">
								<div class="pb-mn">
									<div class="m-pb-mod">
										<div class="pb-txt">
											<span>工作单位：</span>
										</div>
										<div class="m-ipt-mod">
											<input type="text" name="" placeholder="" readonly="readonly" value="${user.department.deptName}" class="u-ipt">
										</div>
									</div>
								</div>
							</div>
							<div class="m-pb-row">
								<div class="pb-mn">
									<div class="m-pb-mod">
										<div class="pb-txt">
											<span>工作岗位：</span>
										</div>
										<div class="m-ipt-mod">
											<select class="u-ipt" style="width: 40%" name="post">
												<option>请选择岗位</option> ${dict:getEntryOptionsSelected('POST',user.post)}
											</select>
											<!-- 		<div class="m-slt-block1 large">
											<a href="javascript:void(0);" class="show-txt" title=""> <span class="txt">请选择岗位</span> <i class="trg"></i>
											</a>
										</div> -->
										</div>
									</div>
								</div>
							</div>
							<div class="m-pb-row btn-box">
								<a onclick="saveUser()" class="u-btn-com u-download">保存</a> <a onclick="cancel()" class="u-btn-com u-cancel">取消</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
<script type="text/javascript">
	$(function(){
	    $(".u-person-lst li").click(function(){
	        $(this).addClass("z-crt").siblings().removeClass("z-crt");;
	    });
	})
	
	function saveUser(){
		if (!$('#userForm').validate().form()) {
			return false;
		}
		var data = $.ajaxSubmit('userForm');
		data = $.parseJSON(data);
		if(data.responseCode == '00'){
			alert("保存成功");
			//window.location.href="${ctx }/logout.do";
		}else{
			alert('保存失败');
		}
	}
	
	$(function(){
		initImageUploader('${user.id}', 'avatar');
	})
	
	
	$(function(){
		$('#userForm').validate({
			 rules:{
				 'account.userName':{
					 required: true,
					 remote:{
						 url : "${ctx}/user/count",
						 type : "post",
						 cache:false,
						 dataType : "json",
						 data:{
						       'paramMap[userName]': function() {
						       return $("#account_userName").val();
						  	}
						 },
						 dataFilter:function(data,type){
							 if(data >= 1){
								var newUserName = $("#account_userName").val();
								var oldUserName = $("#oldUserName").val();
								if(newUserName == oldUserName){
									return true;
								}else{
									return false;
								}
							 }else{
								 return true;
							 }
						 }
					 }
				 }
			 },
			 messages:{
				 'account.userName':{
					 remote: "该姓名已经存在"
				 }
			 }
		});
	});
	
	function cancel(){
		zoneIndex('account');
	}
	
</script>
