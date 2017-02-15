<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="hasMasterRole" value="${sipc:getBooleanFromRequest(pageContext.request, 'hasMasterRole') }" /> 
<c:set var="hasMemberRole" value="${sipc:getBooleanFromRequest(pageContext.request, 'hasMemberRole') }" /> 
<c:set var="inCurrentDate" value="${sipc:getBooleanFromRequest(pageContext.request, 'inCurrentDate') }" /> 
<form id="updateAuthorizeForm">
	<input type="hidden" name="workshopRelation.id" value="${searchParam.paramMap.workshopRelationId}">
	<input type="hidden" name="state">
	<input type="hidden" name="role">
</form>
<div id="g-bd">
	<div class="f-auto">
		<div class="g-inner-bd">
			<div class="g-frame">
				<div class="m-crm">
					<span class="txt">您当前的位置： </span>
					<a onclick="home()" title="首页" class="u-goto-index"> <i class="u-sHome-ico"></i></a> 
					<span class="trg">&gt;</span> 
					<a href="###">工作室</a> <span class="trg">&gt;</span>
					<a href="${retUrl }">工作室详情</a> <span class="trg">&gt;</span> <em>成员列表</em>
				</div>
				<div class="g-member-lst">
					<div class="g-mn-mod">
						<div class="m-mn-tt">
							<h2 class="tt b-tt">管理成员</h2>
							<div class="m-classif-box" id="m-classif-box">
								<a onclick="searchAuthorize('',this)" type="all" class="u-btn z-crt">全部</a> <span class="u-line">|</span> 
								<a onclick="searchAuthorize('apply',this)" type="pass" class="u-btn">未审核</a>
							</div>
						</div>
						<div class="g-member-wrap" id="g-member-wrap">
							<div class="g-member-tablst z-crt">
								<div class="g-tablst-top">
									<label class="m-choose"> 
										<input type="checkbox" name="checkAll" value="" onclick="checkAllBox('listAuthorizeForm', this)"> <span>全选</span>
									</label>
									<a onclick="updateAuthorizes('pass','');" class="u-btn-tp u-pass">申请通过</a> 
									<a onclick="updateAuthorizes('nopass','');" class="u-btn-tp u-decline">拒绝申请</a>
								</div>
							</div>
							<form id="listAuthorizeForm" action="${ctx}/workshop/authorize/more">
								<input type="hidden" name="paramMap[workshopId]" value="${searchParam.paramMap.workshopId}"> 
								<input type="hidden" name="paramMap[state]" value="${searchParam.paramMap.state}"> 
								<input type="hidden" name="paramMap[workshopRelationId]" value="${searchParam.paramMap.workshopRelationId}"> 
								<input type="hidden" name="orders" value="${orders[0] }"/>
								<input type="hidden" name="hasMasterRole" value="${hasMasterRole }"/>
								<input type="hidden" name="hasMemberRole" value="${hasMemberRole }"/>
								<input type="hidden" name="limit" value="10">
								<div id="listAuthorizeDiv">
								<script>
									$(function(){
										$.ajaxQuery('listAuthorizeForm','listAuthorizeDiv');
									})
								</script>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="m-blackbg"></div>
<!-- start 拒绝申请提示框-->
<div class="g-layer-box decline-join-layer">
	<div class="m-layer">
		<h3 class="u-tt">
			拒绝申请加入工作坊<i class="u-close-btn">×</i>
		</h3>
		<div class="u-content">
			<textarea class="u-textarea" style="height: 150px;"></textarea>
		</div>
		<a href="javascript:void(0);" class="u-btn u-cancel-btn">取消</a> <a href="javascript:void(0);" class="u-btn u-conf-btn">确定</a>
	</div>
</div>

<script>
function searchAuthorize(state,a){
	$(a).addClass('z-crt').siblings('a').removeClass('z-crt');
	$('#listAuthorizeForm input[name="paramMap[state]"]').val(state);
	$.ajaxQuery('listAuthorizeForm','listAuthorizeDiv');
}

function updateAuthorize(id, state, role){
	$('#updateAuthorizeForm input[name="role"]').val(role);
	$('#updateAuthorizeForm input[name="state"]').val(state);
	$.put('${ctx}/workshop/authorize/'+id, $('#updateAuthorizeForm').serialize(), function(data){
		if(data.responseCode == '00'){
			alert('提交成功');
			$.ajaxQuery('listAuthorizeForm','listAuthorizeDiv');
		}
	});
}

function updateAuthorizes(state, role){
	if($('#listAuthorizeForm').find('input:checked').length == 0){
		alert('请选择成员');
		return false;
	}
	$('#updateAuthorizeForm input[name="role"]').val(role);
	$('#updateAuthorizeForm input[name="state"]').val(state);
	$.put('${ctx}/workshop/authorize', $('#updateAuthorizeForm').serialize()+'&'+$('#listAuthorizeForm').serialize(), function(data){
		if(data.responseCode == '00'){
			alert('提交成功');
			$.ajaxQuery('listAuthorizeForm','listAuthorizeDiv');
		}
	});
}

function deleteAuthorize(id, userId){
	confirm('确定要删除该成员吗?', function(){
		$.ajaxDelete('${ctx}/workshop/authorize/'+id,'workshopRelation.id=${searchParam.paramMap.workshopRelationId}&user.id='+userId,function(data){
			if(data.responseCode == '00'){
				alert('删除成功');
				$.ajaxQuery('listAuthorizeForm','listAuthorizeDiv');
			}
		})
	});
}

function addAuthorize(){
	$('#addAuthorizeDiv').load('${ctx}/workshop/authorize/create'
			,'workshop.id=${searchParam.paramMap.workshopId}&workshopRelation.id=${searchParam.paramMap.workshopRelationId}'
			,function(){
				researchJs.fn.aJumpLayer($(".add-member-layer"));
			}
	);
}
</script>
