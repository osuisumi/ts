<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="m-resource-box">
	<div class="m-mn-tt">
		<h2 class="tt">分类资源</h2>
		<div class="m-tabli" id="postDiv">
			<script>
				$(function(){
					$.get('${ctx}/dict/getEntryList', 'dictTypeCode=POST', function(data){
						$('#postDiv').empty();
						$(data).each(function(i){
							if(i < 8){
								$('#postDiv').append('<a href="###" value="'+this.dictValue+'">'+this.dictName+'</a>');
								if(i != $(data).length - 1){
									$('#postDiv').append('<span>|</span>');
								}
							}
						});
						$('#postDiv a').click(function(){
							$('#postDiv a').removeClass('z-crt');
							$(this).addClass('z-crt'); 
							$('#listClassifyResourceForm input[name="paramMap[post]"]').val($(this).attr('value'));
							$.ajaxQuery('listClassifyResourceForm', 'listClassifyResourceDiv');
						});
						$('#postDiv a:first').trigger('click');
					});	
				});
			</script>
		</div>
	</div>
	<form id="listClassifyResourceForm" action="${ctx }/resource/listResource">
		<input type="hidden" name="limit" value="4">
		<input type="hidden" name="paramMap[post]">
		<input type="hidden" name="orders" value="BROWSE_NUM.DESC">
		<div id="listClassifyResourceDiv">
		
		</div>
	</form>
</div>