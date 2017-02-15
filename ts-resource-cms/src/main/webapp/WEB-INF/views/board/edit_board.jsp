<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="saveBoardForm" action="${ctx}/board/save" method="post">
	<input type="hidden" id="boardId" name="id" value="${board.id }" /> 
	<table width="100%" border="0" cellpadding="0" cellspacing="0"
		class="alter-table-v">
		<tbody>
			<tr>
				<td>版块图片:</td>
				<td colspan="3" style="text-align: left; height: 200px;">
					<div>
						<c:choose>
							<c:when test="${not empty board.imageUrl }">
								<img id="imagePreView" src="${file:getFileUrl(board.imageUrl) }"
									width="200" height="150">
							</c:when>
							<c:otherwise>
								<img id="imagePreView" src="${ctx }/images/defaultBoardImg.jpg"
									width="200" height="150">
							</c:otherwise>
						</c:choose>
					</div> <a class="l-btn" id="picker"><span>上传图片</span></a> <span
					class="help-block">仅支持JPG、JPEG、PNG格式（2M以下）</span>
					<ul id="fileList"></ul>
				</td>
			</tr>
			<tr>
				<td width="10%">名称:</td>
				<td width="90%" style="text-align: left;"><input type="text"
					name="name" class="easyui-textbox" required value="${board.name}"
					style="width: 80%" /></td>
			</tr>
			<tr>
				<td width="10%">序号:</td>
				<td width="90%" style="text-align: left;"><input type="text"
					name="sortNo" class="easyui-textbox" required
					value="${board.sortNo}" style="width: 60%" /></td>
			</tr>
			<c:set var="userIdList" value="" />
			<c:if test="${not empty board.boardAuthorizes }">
			<c:forEach items="${board.boardAuthorizes }" var="ba">
				<c:set var="userIdList" value="${userIdList},${ba.user.id }" />
			</c:forEach>
			</c:if>
			<tr>
				<td width="10%">版主:</td>
				<td width="40%" style="text-align: left;"><select
					id="boardAuthorizeCombobox" class="easyui-combobox" style="width: 100px;"
					editable="true"
					data-options='url:"${ctx}/user/userInfos",valueField:"id",textField:"realName",
					onLoadSuccess : function() {
						
					},
					onSelect:function(recode){
						var optionVlaue = $("#boardAuthorizeCombobox").combobox("getValue");
						var optionText = $("#boardAuthorizeCombobox").combobox("getText");
						appendUser(optionVlaue,optionText);
						$("#boardAuthorizeCombobox").combobox("clear");
					}
				'>
				</select>
				<span id="names">
					<c:forEach items="${board.boardAuthorizes}" var="master">
						<c:if test="${not empty master.user.realName}">
							<label style='margin-right:15px'>${master.user.realName}<a style='margin-left:5px' href='###' value='${master.user.id}' onclick='deleteUser(this)'>x</a></label>
						</c:if>
					</c:forEach>
				</span>
				</td>
			</tr>
			<tr>
				<td width="10%">简介:</td>
				<td width="90%" style="text-align: left; height: 180px;" colspan="3"><input
					type="text" name="summary" class="easyui-textbox" required
					value="${board.summary}" style="width: 95%;"
					data-options="multiline:true, height:170" /></td>
			</tr>
		</tbody>
	</table>
	<br>
	<div style="text-align: center">
		<button type="button" onclick="saveBoard()" class="easyui-linkbutton">
			<i class="fa fa-floppy-o"></i> 保 存
		</button>
	</div>
</form>
<script type="text/javascript">
	$(function() {
		initImageUploader($('#boardId').val(), 'board');
	});

	function saveBoard() {
		if (!$('#saveBoardForm').form('validate')) {
			return false;
		}
		var users = $("#names a");
		if(users.size()<=0){
			alert('请至少选择一个版主');
			return false;
		}
		/* var arr = $("#boardAuthorizes").combobox("getValues");
		for (var i = 0; i < arr.length; i++) {
			$("#saveBoardForm").append("<input  type='hidden' name='boardAuthorizes["+i+"].user.id' value='"+arr[i]+"'/>");
		} */
		var data = $.ajaxSubmit('saveBoardForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listBoardForm', 'layout_center_tabs');
				easyui_modal_close('editBoardDiv');
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
			alert('该用户已经是版主');
		}

	}
	
	function initUser(){
		var users = $("#names a");
		$('.boardAuthorzeParam').remove();
		$.each($(users),function(i,user){
			$("#saveBoardForm").append("<input class='boardAuthorzeParam' type='hidden'  name='boardAuthorizes["+i+"].user.id'  value='"+$(user).attr('value')+"'/>");
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