<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="sipc" uri="http://sip.haoyu.com/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="followEntityId" type="java.lang.String" required="true"%>
<%@ attribute name="followEntityType" type="java.lang.String" required="true"%>
<c:set var="data" value="${sessionScope.loginer.id}${followEntityId }${followEntityType}" />
<form id="followForm">
	<input type="hidden" name="followEntity.id" value="${followEntityId }"/>
	<input type="hidden" name="followEntity.type" value="${followEntityType }"/>
</form>
<script>
	var followId = '${sipc:md5(data)}';
	$.get('${ctx}/follows/'+followId,'',function(data) {
		if(data.id == null || data.id == ''){
			$('#cancelFollowBtn').hide();
		}else{
			$('#followBtn').hide();
		} 
	});
	
	$('#followBtn').click(function(){
		$.post('${ctx}/follows',$('#followForm').serialize(),function(data){
			if(data.responseCode=='00'){
				$('#followBtn').toggle();
				$('#cancelFollowBtn').toggle();
				$('.followNum').text(parseInt($('.followNum:first').text())+1);
				alert("关注成功");
			}else{
				alert("关注失败");
			}
		});
	});
	$('#cancelFollowBtn').click(function(){
		$.ajaxDelete('${ctx}/follows/'+followId, $('#followForm').serialize(), function(response){
			if(response.responseCode=='00'){
				$('#followBtn').toggle();
				$('#cancelFollowBtn').toggle();
				$('.followNum').text(parseInt($('.followNum:first').text())-1);
				alert("取消成功");
			}else{
				alert("取消失败");
			}
	   });
	});
</script>
