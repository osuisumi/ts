<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<tag:mainLayout>
	<div id="g-bd">
		<div class="f-auto">
			<div class="g-inner-bd">
				<div class="g-inside-frame f-cb">
					<div class="g-inside-sd">
						<ul id="announcementTabUl" class="m-inside-nav">
							<li type="1" onclick="listMoreAnnouncement('1','cms')" class="item1 z-crt"><a href="###">通知公告</a></li>
							<li type="2" onclick="listMoreAnnouncement('2','system')" class="item2"><a href="###">教育快讯</a></li>
						</ul>
						<script>
							$(function(){
								$('#announcementTabUl li').click(function(){
									$(this).addClass('z-crt').siblings().removeClass('z-crt');
								});
							});
						</script>
					</div>
					<form id="announcementForm" action="${ctx}/announcement/more/indexTab">
						<input id="stateParam" type="hidden" name="paramMap[state]" value="1">
						<input id="typeParam" type="hidden" name="paramMap[type]" value="1">
						<input type="hidden" name="paramMap[relationId]" value="system">
						<input type="hidden" name="paramMap[relationType]" value="cms">
						<div id="listMoreAnnouncementDiv" class="g-inside-mn">
					
						</div>
					</form>
					<script>
						$(function(){
							$.ajaxQuery('announcementForm', 'listMoreAnnouncementDiv');
						});
					</script>
				</div>
			</div>
		</div>
	</div>
</tag:mainLayout>
<script type="text/javascript">
	$(function(){
		changeTab('announcement');
	});

	$(function(){
		if($('#discoveryType').val() == 'JXKX'){
			$('#jyzx').attr('class','item2 z-crt');
		}else{
			$('#tzgg').attr('class','item1 z-crt');
		}
	})
	
	function listMoreAnnouncement(type, relationType) {
		$('#announcementForm input[name="paramMap[type]"]').val(type);
		$('#announcementForm input[name="paramMap[relationType]"]').val(relationType);
		$.ajaxQuery('announcementForm', 'listMoreAnnouncementDiv');
	}

</script>
