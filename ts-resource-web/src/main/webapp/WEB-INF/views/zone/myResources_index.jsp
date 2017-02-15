<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="g-mn-mod">
	<div class="m-cloud-box">
		<div class="m-mn-tt" style="padding-bottom: 10px;">
			<a onclick="addResource('zone')" class="u-btn-type u-upload"><i></i>上传资源</a>
		</div>
		<div class="m-mn-dt">
			<div class="m-sel-wrap">
				<div class="sel-lt">
					<a onclick="changeTab('all')" class="c-zrt">全部<span class="myResourceNum"></span></a><span>|</span> <a onclick="changeTab('upload')">上传<span class="myUploadResourceNum"></span></a><span>|</span> <a onclick="changeTab('follow')">收藏<span class="myFollowResourceNum"></span></a>
				</div>
			</div>
			<form id="listMyResourceForm" action="${ctx }/zone/myResources/list">
				<input type="hidden" name="paramMap[typeNotEquils]" value="discovery">
				<input id="creatorOrFollowCreator" type="hidden" name="paramMap[creatorOrFollowCreator]" value="${searchParam.paramMap.creatorOrFollowCreator}">
				<input id="creator" type="hidden" name="paramMap[creator]" value="${searchParam.paramMap.creator}">
				<input id="followCreator" type="hidden" name="paramMap[followCreator]" value="${searchParam.paramMap.followCreator }">
				<input type="hidden" name="orders" value="CREATE_TIME.DESC">
				<input type="hidden" name="limit" value="12">
			<div id="myResourcesDiv" class="m-res-wrap">
				
			</div>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
	$(function(){
		$('.sel-lt a').eq(0).click();
	})
	$(function(){
		$('.sel-lt a').on('click',function(){
			$('.sel-lt a').attr('class','');
			$(this).attr('class','c-zrt');
		})
	})
	
	$(function(){
		$('.myResourceNum').text("("+$('#myResourceNum').val()+")");
		$('.myUploadResourceNum').text("("+$('#myUploadResourceNum').val()+")");
		$('.myFollowResourceNum').text("("+$('#myFollowResourceNum').val()+")");
	})
	
	function changeTab(type){
		var creator = "${sessionScope.loginer.id}"
		if(type=='all'){
			$('#creator').val('');
			$('#followCreator').val('');
			$('#creatorOrFollowCreator').val(creator);
		}else if(type == 'upload'){
			$('#creator').val(creator);
			$('#followCreator').val('');
			$('#creatorOrFollowCreator').val('');
		}else if(type == 'follow'){
			$('#creator').val('');
			$('#followCreator').val(creator);
			$('#creatorOrFollowCreator').val('');
		}
		//每次变换tab重置分页信息
		$('#listMyResourceForm input[name=page]').val('1');
		listMyResources();
	}
	
	function listMyResources(){
		$('#myResourcesDiv').load('${ctx}/zone/myResources/list?'+$('#listMyResourceForm').serialize());
	}
</script>
