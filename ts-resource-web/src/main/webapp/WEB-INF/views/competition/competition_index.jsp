<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<tag:mainLayout>
	<div id="g-bd">
		<div class="f-auto">
			<div class="g-inner-bd">
				<div class="g-frame">
					<div class="g-frame-mn">
						<div class="g-mn-mod">
							<div class="m-activity-box">
								<div class="m-mn-tt">
									<h2 class="tt">活动</h2>
									<div class="m-tabli">
										<a type="all" class="z-crt" onclick="loadCompetitionList('all')">全部</a> <span>|</span> 
										<a type="begin" onclick="loadCompetitionList('begin')">正在进行</a> <span>|</span> 
										<a type="before" onclick="loadCompetitionList('before')">即将开始</a> <span>|</span> 
										<a type="end" onclick="loadCompetitionList('end')">历史活动</a>
									</div>
								</div>
								<div id="listCompetitionDiv" class="g-mn-dt2">
									<script type="text/javascript">
										$(function(){
											loadCompetitionList('all');
										})
									</script>
								</div>
							</div>
						</div>
					</div>
					<div id="hotCompetitionDiv" class="g-frame-sd">
						<script>
							$(function(){
								$('#hotCompetitionDiv').load('${ctx}/competition/list/hot?paramMap[resourceNum]=true&orders=RESOURCE_NUM.DESC&limit=5');
							})
						</script>
					</div>
				</div>
			</div>
		</div>
	</div>
</tag:mainLayout>
<script>
	$(function(){
		changeTab('competition');
	})
	function loadCompetitionList(type){
		$('.m-tabli a[type="'+type+'"]').addClass('z-crt').siblings().removeClass('z-crt');
		$('#listCompetitionDiv').load('${ctx}/competition/list/more?orders=CREATE_TIME.DESC&limit=10&paramMap[timeState]='+type);
	}
</script>