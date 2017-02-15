<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!-- 设置是窗口还是tab页 -->
<c:choose>
	<c:when test="${announcement.announcementRelations[0].relation.type eq 'competition'}">
		<c:set var="isWindow" value="Y"></c:set>
	</c:when>
	<c:otherwise>
		<c:set var="isWindow" value="N"></c:set>
	</c:otherwise>
</c:choose>
<form id="saveAnnouncementForm" action="${ctx}/announcement/save" method="post">
	<input id="id" type="hidden" name="id" value="${announcement.id }" /> 
	<input type="hidden" name="type" value="${announcement.type}" />
	<input id="uuid" name="uuid" type="hidden" value="${sipc:uuid()}">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="alter-table-v">
		<tbody>
			<tr>
				<td width="10%">标题:</td>
				<td width="90%" style="text-align: left;" colspan="3">
					<input type="text" name="title" class="easyui-textbox" required value="${announcement.title}" style="width: 95%" />
				</td>
			</tr>
			<tr>
				<td width="10%">内容:</td>
				<td width="90%" style="text-align: left; height: 380px;" colspan="3">
					<!-- <input type="text" name="content" class="easyui-textbox" required value="${announcement.content}" style="width: 95%;" data-options="multiline:true, height:170" /> -->
					<script id="editor" type="text/plain" style="width:100%;height:370px;"></script>
					<input id="announcementContent" name="content" type="hidden">
				</td>
			</tr>
			<tr>
				<td width="10%">类型:</td>
				<td width="40%" style="text-align: left;">
					<c:choose>
						<c:when test="${announcement.type eq '1' }">
							<input type="hidden" name="announcementRelations[0].relation.id" value="system" /> 
							<c:choose>
								<c:when test="${empty announcement.announcementRelations[0].relation.type}">
									<input id="relationTypeParam" name="announcementRelations[0].relation.type" class="easyui-combobox" style="width: 158px;" required editable="false" data-options="
								        valueField: 'value',
										textField: 'text',
								        data: [{	
								        	value:'cms',
								        	text:'通知公告'
								        },{	
								        	value:'bms',
								        	text:'站内通知'
								        }] 
									">
								</c:when>
								<c:otherwise>
									<input type="hidden" name="announcementRelations[0].relation.type" value="${announcement.announcementRelations[0].relation.type }">
									<c:choose>
										<c:when test="${announcement.announcementRelations[0].relation.type eq 'cms' }">
											<span>通知公告</span>
										</c:when>
										<c:otherwise>
											<span>站内通知</span>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<input type="hidden" name="announcementRelations[0].relation.id" value="${announcement.announcementRelations[0].relation.id}" /> 
							<input type="hidden" name="announcementRelations[0].relation.type" value="${announcement.announcementRelations[0].relation.type }">
							<c:choose>
								<c:when test="${announcement.announcementRelations[0].relation.type eq 'school' }">
									<span>学校资讯</span>
								</c:when>
								<c:when test="${announcement.announcementRelations[0].relation.type eq 'system' }">
									<span>教育快讯</span>
								</c:when>
								<c:otherwise>
									<span>活动公告</span>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</td>
				<td width="10%">状态:</td>
				<td width="40%" style="text-align: left;">
					<select id="stateSelect" name="state" class="easyui-combobox" style="width: 158px;" editable="false" required value="${announcement.state}">
						<option></option>
						${dict:getEntryOptionsSelected('EDIT_STATE',announcement.state) }
					</select>
				</td>
			</tr>
			<tr>
				<td width="10%">附件:</td>
				<td width="90%" colspan="3" style="text-align: left; padding-top: 10px;">
				<tag:fileUpload relationId="${announcement.id }" /></td>
			</tr>
		</tbody>
	</table>
	<br>
	<div style="text-align: center">
		<button type="button" onclick="saveAnnouncement()" class="easyui-linkbutton">
			<i class="fa fa-floppy-o"></i> 保 存
		</button>
	</div>
</form>
<script type="text/javascript">
	var ue;
	$(function(){
		UE.delEditor('editor');
		ue = UE.getEditor('editor',{
			toolbars: [
			           [
			               'bold', //加粗
			               'italic', //斜体
			               'underline', //下划线
			               'strikethrough', //删除线
			               'fontborder', //字符边框
			               'horizontal', //分隔线
			               'fontfamily', //字体
			               'fontsize', //字号
			               'justifyleft', //居左对齐
			               'justifyright', //居右对齐
			               'justifycenter', //居中对齐
			               'justifyjustify', //两端对齐
			               'forecolor', //字体颜色
			               'backcolor', //背景色
			               'lineheight', //行间距
			               'imagenone',
			               'imageleft',
			               'imageright',
			               'imagecenter',
			               'simpleupload',
			               'insertimage' 
			           ]
			       ],
			scaleEnabled: true,
		});
		ue.ready(function() {
		    ue.execCommand('serverparam', {
		        'relations': '${sessionScope.loginer.id}',
		    });
		});
		
		ue.addListener("ready", function () {
			var content = '${sipc:split(announcement.content,announcement.id,0) }';
			ue.setContent(content);
		});
	});
	
	$(function() {
		if ('${announcement.announcementRelations[0].relation.id}' == "system") {
			$("select[name=type]>option[value=3]").remove();
		}
	});

	function saveAnnouncement() {
		var id = $('#id').val();
		if(!id){
			$('#saveAnnouncementForm').attr('action','${ctx}/announcement/saveAnnouncement')
		}
		if (!$('#saveAnnouncementForm').form('validate')) {
			return false;
		}
		var content = ue.getContent();
		var contentText = ue.getContentTxt();
		if(contentText.length == 0){
			$.messager.alert("提示信息","发表内容不能为空");
			return;
		}
		var id = $('#id').val();
		var uuid = $('#uuid').val();
		var contentId = '';
		if(id){
			contentId = id;
		}else{
			contentId = uuid;
		}
		$('#announcementContent').val(content+contentId+contentText);
		var data = $.ajaxSubmit('saveAnnouncementForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				var isWindow = '${isWindow}';
				if(isWindow == 'Y'){
					easyui_window_update('listAnnouncementForm_${announcement.type}','listCompetitionAnnouncementDiv')
				}else{
					easyui_tabs_update('listAnnouncementForm_${announcement.type}', 'layout_center_tabs');
				}
				easyui_modal_close('editAnnouncementDiv');
			});
		}
	}
	
	$(function(){
		var except = ['3','4','5'];
		var options = $('#stateSelect option');
		$.each($(options),function(i,option){
			var optionValue = $(option).attr('value');
			for(var i=0;i<except.length;i++){
				if(optionValue == except[i]){
					$(option).remove();
					break;
				}
			}
		});
	})
	
</script>