<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<tag:mainLayout>
<input type="hidden" id="announcementRelationId" value="${competition.id }">
<input id="isCompetitionBegun" type="hidden" value="${sipc:hasBegun(competition.competitionTimePeriod.startTime) }">
<input id="isCompetitionEnded" type="hidden" value="${sipc:hasEnded(competition.competitionTimePeriod.endTime) }">
<input id="isAttitudeBegun" type="hidden" value="${sipc:hasBegun(competition.attitudeTimePeriod.startTime) }">
<input id="isAttitudeEnded" type="hidden" value="${sipc:hasEnded(competition.attitudeTimePeriod.endTime) }">
	
	<c:if test="${not empty  competition.imageUrl}">
		<div id="g-small-bn">
			<ul class="m-bn bn-activity">
				<li>
					<a href="javascript:void(0);" target="_blank">
						<img src="${file:getFileUrl(competition.imageUrl)} " alt="">
					</a>
				</li>
			</ul>
			<div class="m-bn-focus">
			</div>
		</div>
	</c:if>
	<div id="g-bd">
		<div class="f-auto">
			<div class="g-frame">
				<div class="g-frame-mn">
					<div id="hdggDiv" class="g-mn-mod">
						<!-- 活动公告 -->
						<script>
							$(function(){
								$('#hdggDiv').load('${ctx}/announcement/list?orders=CREATE_TIME.DESC&limit=5&paramMap[relationId]=${competition.id}&paramMap[state]=1');	
							})
						</script>
					</div>
					<div class="g-mn-mod pd-bt">
						<div class="m-mn-tt pa-bt">
							<h2 class="tt small">作品展示</h2>
							<div class="m-tabli">
								<a id="createTimeRank" onclick="createTimeRank()" class="">最新上传</a> <span>|</span> 
								<a id="voteRank" onclick="voteRank()">得票数</a>
							</div>
						</div>
						<div id="listCompetitionResourceDiv" class="g-res-con">
							<!-- 作品展示 -->
							<script type="text/javascript">
								$(function(){
									$('#listCompetitionResourceDiv').load('${ctx}/competition/resource?paramMap[relationId]=${competition.id}');
								})
							</script>
						</div>
					</div>
				</div>
				<div class="g-frame-sd">
					<div class="g-btn-mod">
						<a onclick="uploadCompetitionResource()" class="u-bSrh-btn u-cont-btn u-upload-btn"> <strong> <i class="u-upload-bg-ico"></i>上传我的作品
						</strong>
							<p>已有${numMap.teacherNum }人 ，上传${numMap.resourceNum }个作品</p>
						</a>
					</div>
					<div class="g-sd-mod">
						<div class="m-match-seek">
							<div class="m-sd-tt">
								<h3 class="tt">赛事咨询</h3>
							</div>
							<div class="m-sd-dt">
								<p>主&nbsp;办&nbsp;方：${competition.mainOrganization }</p>
								<p>活动时间：<fmt:formatDate value="${competition.competitionTimePeriod.startTime }" pattern="yyyy-MM-dd"></fmt:formatDate>至<fmt:formatDate value="${competition.competitionTimePeriod.endTime }" pattern="yyyy-MM-dd"></fmt:formatDate></p>
								<p>投票时间：<fmt:formatDate value="${competition.attitudeTimePeriod.startTime }" pattern="yyyy-MM-dd"></fmt:formatDate>至<fmt:formatDate value="${competition.attitudeTimePeriod.endTime }" pattern="yyyy-MM-dd"></fmt:formatDate></p>
								<c:if test="${not empty competition.undertakeOrganization}">
									<p>承&nbsp;办&nbsp;方：${competition.undertakeOrganization }</p>
								</c:if>
								<c:if test="${not empty competition.phone }">
									<p>客服电话：${competition.phone }</p>
								</c:if>
							</div>
						</div>
					</div>
					<div id="rankDepartmentDiv" class="g-sd-mod">
						<!-- 作品数量 -->
						<script type="text/javascript">
							$(function(){
								$('#rankDepartmentDiv').load('${ctx}/competition/resource/rankDepartment?paramMap[competitionId]=${competition.id}&orders=UPLOAD_NUM.DESC');
							})
						</script>
					</div>
					<div id="rankCompetitionResource" class="g-sd-mod">
						<!-- 人气排名 -->
						<script type="text/javascript">
							$(function(){
								$('#rankCompetitionResource').load('${ctx}/competition/resource/rankResource?paramMap[relationId]=${competition.id}&limit=5&orders=DOWNLOAD_NUM.DESC');	
							})
						</script>
					</div>
				</div>
			</div>
		</div>
	</div>
<script>
	function voteRank(){
		$('#voteRank').addClass('z-crt').siblings().removeClass('z-crt');
		$('#listCompetitionResourceDiv').load('${ctx}/competition/resource?paramMap[relationId]=${competition.id}&orders=VOTE_NUM.DESC');
	}
	
	function createTimeRank(){
		$('#createTimeRank').addClass('z-crt').siblings().removeClass('z-crt');
		$('#listCompetitionResourceDiv').load('${ctx}/competition/resource?paramMap[relationId]=${competition.id}&orders=CREATE_TIME.DESC');
	}
	
	function uploadCompetitionResource(){
		var isCompetitionBegun = $('#isCompetitionBegun').val();
		var isCompetitionEnded = $('#isCompetitionEnded').val();
		if(isCompetitionBegun == 'false'){
			alert('活动尚未开始');
			return false;
		}else if(isCompetitionEnded == 'true'){
			alert('活动已结束');
			return false;
		}
		goLoginForAddResource('competition','${competition.id}');
	}
</script>
</tag:mainLayout>

