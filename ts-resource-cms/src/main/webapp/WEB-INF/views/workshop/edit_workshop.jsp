<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="saveWorkshopForm" action="${ctx }/workshop/" method="post">
<input type="hidden" name="workshopRelations[0].relation.id" value="SYSTEM">
	<c:choose>
		<c:when test="${not empty workshop.id }">
			<input type="hidden" name="id" value="${workshop.id }">
			<input type="hidden" name="workshopRelations[0].id" value="${workshop.workshopRelations[0].id }">
			<script type="text/javascript">
				$(function(){
					$('#saveWorkshopForm').attr('action','${ctx}/bizWorkshop/${workshop.id}/update');
					$('#saveWorkshopForm').attr('method','put');
				})
			</script>
		</c:when>
		<c:otherwise>
			<input type="hidden" name="id" value="${sipc:uuid()}">
		</c:otherwise>
	</c:choose>

	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="alter-table-v">
		<tbody>
			<tr>
				<td width="15%">封面图片:</td>
				<td>
					<div>
						<c:choose>
							<c:when test="${not empty workshop.imageUrl }">
								<img id="imagePreView" src="${file:getFileUrl(workshop.imageUrl) }" width="200" height="150">
							</c:when>
							<c:otherwise>
								<img id="imagePreView" src="${ctx }/images/defaultWorkshopImg.png" width="200" height="150">
							</c:otherwise>
						</c:choose>
					</div> 
					<a class="l-btn" id="picker"><span>上传图片</span></a> 
					<span class="help-block">仅支持JPG、JPEG、PNG格式（2M以下）</span>
					<ul id="fileList"></ul>
				</td>
			</tr>
			<tr>
				<td width="15%">工作室名称:</td>
				<td width="35%" style="text-align: left;"><input type="text" name="name" class="easyui-textbox" required value="${workshop.name}" style="width: 95%" /></td>
			</tr>
			<tr>
				<td width="15%">简介:</td>
				<td width="35%" style="text-align: left;"><input type="text" name="summary" class="easyui-textbox"  value="${workshop.summary}" multiline="true" style="width: 478px; height: 100px" /></td>
			</tr>
			<tr>
				<td width="10%">主持人:</td>
				<td width="40%" style="text-align: left;"><select
					id="mastersCombobox" class="easyui-combobox" style="width: 100px;"
					editable="true"
					data-options='url:"${ctx}/user/userInfos",valueField:"id",textField:"realName",
					onLoadSuccess : function() {
						
					},
					onSelect:function(recode){
						var optionVlaue = $("#mastersCombobox").combobox("getValue");
						var optionText = $("#mastersCombobox").combobox("getText");
						appendUser(optionVlaue,optionText);
						$("#mastersCombobox").combobox("clear");
					}
				'>
				</select>
				<span id="names">
						<c:if test="${not empty workshop.masters}">
							<c:forEach items="${workshop.masters}" var="master">
								<label style='margin-right:15px'>${master.realName}<a style='margin-left:5px' href='###' value='${master.id}' onclick='deleteUser(this)'>x</a></label>
							</c:forEach>
						</c:if>
				</span>
				</td>
			</tr>
		</tbody>
	</table>
	<br>
	<div style="text-align: center">
		<a type="button" onclick="saveWorkshop()" class="easyui-linkbutton">
			<i class="fa fa-floppy-o"></i> 保 存
		</a>
	</div>
</form>
<script>
	$(function(){
		initImageUploader($('#competitionId').val(), 'competition');	
	})
	
	function saveWorkshop(){
		if (!$('#saveWorkshopForm').form('validate')) {
			return false;
		}
		var users = $("#names a");
		if(users.size()<=0){
			alert('请至少选择一个版主');
			return false;
		}
		var data = $.ajaxSubmit('saveWorkshopForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listWorkshopForm', 'layout_center_tabs');
				easyui_modal_close('editWorkshopDiv');
			});
		}
	}
	
	function deleteUser(a){
		$(a).closest('label').remove();
		initUser();
	}
	
	function appendUser(value,text){
		if(!isExist(value)){
			$("#names").append("<label style='margin-right:15px'>"+text+"<a style='margin-left:5px' value='"+value+"' href='###' onclick='deleteUser(this)'>x</a></label>");
			initUser();
		}else{
			alert('该用户已经是主持人');
		}

	}
	
	function initUser(){
		var users = $("#names a");
		$('.mastersParam').remove();
		$.each($(users),function(i,user){
			$("#saveWorkshopForm").append("<input class='mastersParam' type='hidden'  name='masters["+i+"].id'  value='"+$(user).attr('value')+"'/>");
		});
	}
	
	function isExist(value){
		var users = $("#names a");
		var flag = false;
		for(var i=0;i<users.size();i++){
			if(users.eq(i).attr('value') == value){
				flag = true;
				break;
			}
		}
		return flag;
	}
</script>