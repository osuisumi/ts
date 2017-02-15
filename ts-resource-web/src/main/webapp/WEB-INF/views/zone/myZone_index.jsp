<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="m-zone-mn">
	<div class="m-con-head">
		<div class="con-head-lt">
			<a href="javascript:void(0);"> <strong class="myzone_myResourceNum"></strong>
				<p>
					<i class="u-ico u-res"></i>资源
				</p>
			</a>
			<a href="javascript:void(0);"> <strong class="myzone_myCompetitionNum"></strong>
				<p>
					<i class="u-ico u-act"></i>活动
				</p>
			</a>
			<a href="javascript:void(0);" class="u-last"> <strong class="myzone_myDiscoveryNum"></strong>
				<p>
					<i class="u-ico u-find"></i>发现
				</p>
			</a>
		</div>
		<div class="con-head-rt">
			<a onclick="addResource('zone')" class="u-btn-type u-upload"><i></i>上传资源</a> <a onclick="addDiscovery('zone')" class="u-btn-type u-share"><i></i>分享发现</a>
		</div>
	</div>
	<div class="m-zone-ad">
		<div id="zoneAdvert">
			<script>
				$(function(){
					$('#zoneAdvert').load('${ctx}/advert/list/zone', "orders=CREATE_TIME.DESC&paramMap[state]=1&paramMap[location]=3");
				})
			</script> 
		</div> 
		<!-- <a href="javascript:void(0);" class="u-close"><i></i></a> -->
	</div>
	<!-- 订阅列表 -->
	<div class="g-mn-mod" style="padding-bottom: 20px;">
		<div id="subscribeContent" class="m-mn-tt">
			<script type="text/javascript">
				$(function(){
					$('#subscribeContent').load('${ctx}/zone/myZone/subscribe');
				})
			</script>
		</div>
		<div id="subscribeResourceContent" class="g-res-con">
			<tag:noContent msg="请添加订阅"></tag:noContent>
		</div>
	</div>
</div>
<script>
	$(function() {
		$('.myzone_myResourceNum').text($('#myResourceNum').val());
		$('.myzone_myDiscoveryNum').text($('#myDiscoveryNum').val());
		$('.myzone_myCompetitionNum').text($('#myCompetitionNum').val());
	})
	
</script>
