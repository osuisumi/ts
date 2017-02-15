<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="g-mn-mod">
	<div class="m-cloud-box">
		<div class="m-mn-tt">
			<h3 class="tt small">教研活动</h3>
			<a onclick="competitionIndex()" class="more" style="float: right;">查看全部活动&gt;&gt;</a>
		</div>
		<div id="listMyCompetitionDiv">
			<script type="text/javascript">
				$(function(){
					$('#listMyCompetitionDiv').load('${ctx}/zone/myCompetition/list','limit=10&orders=CREATE_TIME.DESC&paramMap[creator]=${sessionScope.loginer.id}');
				})
			</script>
		</div>
	</div>
</div>

<script>
function myResource(competitionId){
	window.location.href ="${ctx}/resource/resourceIndex?relationId="+competitionId+"&creator=${sessionScope.loginer.id}"
}
</script>
