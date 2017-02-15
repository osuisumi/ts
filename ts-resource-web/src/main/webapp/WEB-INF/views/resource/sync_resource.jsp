<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="m-resource-box">
	<div class="m-mn-tt">
		<h2 class="tt">同步资源</h2>
		<div class="m-tabli" id="subjectDiv">
			<script>
				$(function(){
					$.get('${ctx}/textBook/getEntryList', 'textBookTypeCode=SUBJECT', function(data){
						$('#subjectDiv').empty();
						$(data).each(function(i){
							if(i < 8){
								$('#subjectDiv').append('<a href="###" value="'+this.textBookValue+'">'+this.textBookName+'</a>');
								if(i != $(data).length - 1){
									$('#subjectDiv').append('<span>|</span>');
								}
							}
						});
						$('#subjectDiv a').click(function(){
							$('#subjectDiv a').removeClass('z-crt');
							$(this).addClass('z-crt'); 
							$('#listSyncResourceForm input[name="paramMap[subject]"]').val($(this).attr('value'));
							$.ajaxQuery('listSyncResourceForm', 'listSyncResourceDiv');
						});
						$('#subjectDiv a:first').trigger('click');
					});	
				});
			</script>
		</div>
	</div>
	<form id="listSyncResourceForm" action="${ctx }/resource/listResource">
		<input type="hidden" name="limit" value="4">
		<input type="hidden" name="paramMap[subject]">
		<input type="hidden" name="orders" value="BROWSE_NUM.DESC">
		<div id="listSyncResourceDiv">
		
		</div>
	</form>
</div>