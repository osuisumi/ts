<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="sipc" uri="http://sip.haoyu.com/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="followEntityId" type="java.lang.String" required="true"%>
<%@ attribute name="followEntityType" type="java.lang.String" required="true"%>
<%@ attribute name="backPage" type="java.lang.String" %>
<%@ attribute name="item" type="java.lang.String" %>
<c:set var="data" value="${sessionScope.loginer.id}${followEntityId }${followEntityType}" />
<form id="followForm" style="float:left">
	<input id="followEntityId${followEntityId}" type="hidden" name="followEntity.id" value="${followEntityId }"/>
	<input id="followEntityType" type="hidden" name="followEntity.type" value="${followEntityType }"/>
</form>
<script>
	$(function(){
		var followId = '${sipc:md5(data)}';
		$.get('${ctx}/follows/'+followId,'',function(data) {
			if(data.id == null || data.id == ''){
				$('#cancelFollowBtn${followEntityId}').hide();
			}else{
				$('#followBtn${followEntityId}').hide();
			} 
		});
	})
	
	$('#followBtn${followEntityId}').click(function(){
		goLogin(function(){
			$.post('${ctx}/follows',{
				"followEntity.id":$('#followEntityId${followEntityId}').val(),
				"followEntity.type":$('#followEntityType').val()
			},function(data){
				if(data.responseCode=='00'){
					$('#followBtn${followEntityId}').toggle();
					$('#cancelFollowBtn${followEntityId}').toggle();
					$('.followNum').text(parseInt($('.followNum:first').text())+1);
					alert("收藏成功");
					var backPage = "${backPage}";
					if(backPage == 'zone'){
						zoneIndex('${item}');
					}
				}else{
					if(data.responseMsg == "duplicate create follow!"){
						$('#cancelFollowBtn${followEntityId}').show();
						$('#followBtn${followEntityId}').hide();
					}else{
						alert("收藏失败");
					}
				}
			});
		},function(){
			var followEntityType = "${followEntityType}";
			var followEntityId = "${followEntityId}";
			var backPage = "${backPage}";
			if(followEntityType == 'resource'){
				viewResource(followEntityId);
			}else if(followEntityType == 'discovery'){
				if(backPage == 'zone'){
					zoneIndex('${item}');
				}else{
					viewDiscovery(followEntityId);
				}
			}
		});
	});
	$('#cancelFollowBtn${followEntityId}').click(function(){
		var followId = '${sipc:md5(data)}';
		$.ajaxDelete('${ctx}/follows/'+followId, {
			"followEntity.id":$('#followEntityId${followEntityId}').val(),
			"followEntity.type":$('#followEntityType').val()
		}, function(response){
			if(response.responseCode=='00'){
				$('#followBtn${followEntityId}').toggle();
				$('#cancelFollowBtn${followEntityId}').toggle();
				$('.followNum').text(parseInt($('.followNum:first').text())-1);
				alert("取消成功");
				var backPage = "${backPage}";
				if(backPage == 'zone'){
					zoneIndex('${item}');
				}
			}else{
				alert("取消失败");
			}
	   });
	});
</script>
