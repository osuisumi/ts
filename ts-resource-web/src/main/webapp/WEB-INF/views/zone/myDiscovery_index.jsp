<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="g-mn-mod">
	<div class="m-cloud-box">
		<div class="m-mn-tt" style="padding-bottom: 10px;">
			<a onclick="addDiscovery('zone')" class="u-btn-type u-share" style="margin-left: 0;"><i></i>分享发现</a>
		</div>
		<div class="m-mn-dt">
			<div class="m-sel-wrap">
				<div class="sel-lt">
					<a onclick="changeTab('all')" class="c-zrt">全部<span class="myDiscoveryNum"></span></a><span>|</span> <a onclick="changeTab('upload')">上传<span class="myUploadDiscoveryNum"></span></a><span>|</span> <a onclick="changeTab('follow')">收藏<span class="myFollowDiscoveryNum"></span></a>
				</div>
				<!-- <div class="sel-rt">
					<div class="m-slt-block1">
						<a href="javascript:void(0);" class="show-txt" title=""> <span class="txt">按分类筛选</span> <i class="trg"></i>
						</a>
						<dl class="lst">
							<dd>
								<a href="javascript:void(0);" class="z-crt">请选择教材版本请选择教材版本</a>
							</dd>
							<dd>
								<a href="javascript:void(0);">人教版</a>
							</dd>
							<dd>
								<a href="javascript:void(0);">苏教版</a>
							</dd>
							<dd>
								<a href="javascript:void(0);">北师大版</a>
							</dd>
							<dd>
								<a href="javascript:void(0);">湘教版</a>
							</dd>
						</dl>
					</div>
				</div> -->
			</div>
			<form id="listDiscoveryForm" action="${ctx}/zone/myDiscovery/list">
				<input type="hidden" name="orders" value="CREATE_TIME.DESC"/>
				<input type="hidden" name="limit" value="10"/>
				<input id="creatorOrFollowCreator" type="hidden" name="paramMap[creatorOrFollowCreator]" value="${searchParam.paramMap.creatorOrFollowCreator}">
				<input id="creator" type="hidden" name="paramMap[creator]" value="${searchParam.paramMap.creator}">
				<input id="followCreator" type="hidden" name="paramMap[followCreator]" value="${searchParam.paramMap.followCreator }">
				<input type="hidden" name="paramMap[type]" value="discovery">
				<div id="myDiscoveryDiv" class="m-find-wrap">
	
				</div>
			</form>
		</div>
	</div>
</div>
<script>
	$(function(){
		$('.sel-lt a').eq(0).click();
	})
	$(function(){
		$('.sel-lt a').on('click',function(){
			$('.sel-lt a').attr('class','');
			$(this).attr('class','c-zrt');
		})
	})
	
	function listMyDiscovery(){
		$('#myDiscoveryDiv').load('${ctx}/zone/myDiscovery/list?'+$('#listDiscoveryForm').serialize());
	}
	
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
		$('#listDiscoveryForm input[name=page]').val('1');
		listMyDiscovery();

	}
	
	$(function(){
		$('.myDiscoveryNum').text("("+$('#myDiscoveryNum').val()+")");
		$('.myUploadDiscoveryNum').text("("+$('#myUploadDiscoveryNum').val()+")");
		$('.myFollowDiscoveryNum').text("("+$('#myFollowDiscoveryNum').val()+")");
	})
</script>
