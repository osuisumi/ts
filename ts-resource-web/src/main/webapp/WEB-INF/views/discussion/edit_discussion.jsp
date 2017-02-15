<%@ page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<fmt:formatDate value="<%=new Date()%>" type="both" pattern="yyyy-MM-dd" var="nowDate" />
<input type="hidden" name="id" value="${discussion.id }">
<input type="hidden" name="discussionRelations[0].id" value="${discussion.discussionRelations[0].id }" />
<div class="am-pb-mod">
	<div class="c-txt">
		<em>*</em><span>活动名称：</span>
	</div>
	<div class="c-center">
		<div class="am-ipt-mod">
			<input type="text" name="title" class="au-ipt {required:true}" placeholder="请输入活动名称(必填)" value="${discussion.title }">
		</div>
	</div>
</div>
<div class="am-pb-mod">
    <div class="c-txt">
        <span>活动描述：</span>
    </div>
    <div class="c-center">
        <div class="am-ipt-mod">
            <textarea name="content" class="au-textarea" placeholder="请输入活动描述">${discussion.content }</textarea>
        </div>
    </div>
</div>
<div class="am-pb-mod">
	<div class="c-txt">
		<span>附件：</span>
	</div>
	<div class="c-center">
		<tag:fileUpload relationId="${discussion.id }" />
	</div>
</div>
<div class="am-pb-mod">
	<div class="c-txt">
		<em>*</em><span>起止时间：</span>
	</div>
	<div class="c-center">
		<div class="am-time-mod f-cb">
			<div class="am-slt-time">
				<input type="text" name="startTime" value='<fmt:formatDate value="${discussion.discussionRelations[0].timePeriod.startTime }" pattern="yyyy-MM-dd"  />' id="startTimeParam" class="au-ipt" placeholder="${nowDate}" onclick="WdatePicker({minDate:'${nowDate}',dateFmt:'yyyy-MM-dd'})"> <a class="au-calendar-ico"></a>
			</div>
			<span class="au-time-txt">至</span>
			<div class="am-slt-time">
				<input type="text" name="endTime" value='<fmt:formatDate value="${discussion.discussionRelations[0].timePeriod.endTime }" pattern="yyyy-MM-dd"  />' id="endTimeParam" class="au-ipt {gtAndEqStartTime:'startTimeParam'}" placeholder="${nowDate }" onclick="WdatePicker({minDate:'${nowDate}',dateFmt:'yyyy-MM-dd'})"> <a class="au-calendar-ico"></a>
			</div>
		</div>
	</div>
</div>
<tag:editTag relationId="${discussion.id }" />
<script>
	$(function() {
		$('#saveActivityForm').attr('action', '${ctx}/discussion/save');
	});
	
	$(function(){
		$('.au-ipt').attr('style','height:30px');
	})
</script>