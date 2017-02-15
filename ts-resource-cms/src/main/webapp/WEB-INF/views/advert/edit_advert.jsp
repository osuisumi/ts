<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="saveAdvertForm" action="${ctx}/advert/save" method="post">
	<input type="hidden" id="advertId" name="id" value="${advert.id }" />
	<table width="100%" border="0" cellpadding="0" cellspacing="0"
		class="alter-table-v">
		<tbody>
			<tr>
				<td width="13%">标题:</td>
				<td width="87%" style="text-align: left;"><input type="text"
					name="title" class="easyui-textbox" required
					value="${advert.title}" style="width: 90%" /></td>
			</tr>
			<tr>
				<td width="13%">序号:</td>
				<td width="87%" style="text-align: left;"><input type="text"
					name="sortNo" class="easyui-textbox" required
					value="${advert.sortNo}" style="width: 50%" /></td>
			</tr>			
			<tr>
				<td width="13%">位置:</td>
				<td width="87%" style="text-align: left;">
					<input id="locationsInput" type="hidden" name="location">
					<select id="advertLocationCombobox"  class="easyui-combobox" style="width: 158px;" editable="false" value="${advert.location}"
						data-options='
						onSelect:function(recode){
						var optionVlaue = $("#advertLocationCombobox").combobox("getValue");
						var optionText = $("#advertLocationCombobox").combobox("getText");
						appendLocation(optionVlaue,optionText);
						$("#advertLocationCombobox").combobox("clear");
					}'
					>
							<option>请选择</option>
							${dict:getEntryOptionsSelected('ADVERT_LOCATION',advert.location)}
					</select>
					<span id="locationsSpan">
						<c:forTokens items="${advert.location}" delims="," var="l">
								<label style='margin-right:15px'>${dict:getEntryName('ADVERT_LOCATION',l)}<a style='margin-left:5px' href='###' value='${l}' onclick='deleteLocation(this)'>x</a></label>
							</c:forTokens>
					</span>
				</td>
			</tr>
			<tr>
				<td width="13%">状态:</td>
				<td width="87%" style="text-align: left;">
					<select name="state" class="easyui-combobox" style="width: 158px;" editable="false" required value="${advert.state}">
						${dict:getEntryOptionsSelected('ADVERT_STATE',advert.state)}
				</select></td>
			</tr>			
			<tr>
				<td>图片:</td>
				<td colspan="3" style="text-align: left; height: 200px;">
					<div id="imagePreviewDiv" style="height:150px;">
						<c:choose>
							<c:when test="${not empty advert.imageUrl }">
								<img id="imagePreView"
									src="${file:getFileUrl(advert.imageUrl) }" width="200"
									height="150">
							</c:when>
							<c:when test="${empty advert.imageUrl }">
								<img id="imagePreView" width="200" height="150">
							</c:when>
						</c:choose>
					</div> 
					<a class="l-btn" id="picker"><span>上传图片</span></a> 
					<p class="help-block">仅支持JPG、JPEG、PNG格式（2M以下）,  建议图片尺寸: 1920 x 400</p>
					<ul id="fileList"></ul>
				</td>
			</tr>
			<tr>
				<td width="13%">链接地址:</td>
				<td width="100%" style="text-align: left;height:200px">
					<span>
						<input type="text" id="imageLinkInput" name="imageLink"   class="easyui-textbox" value="${advert.imageLink}" style="width: " 
							data-options='
								onChange:function(newValue,oldValue){
									if(newValue){
										$("#imageLinkImg").attr("src",newValue);
									}
								},
								multiline:"true",
								height:"150px",
								width:"200px"
							'
						/>
						<img id="imageLinkImg" src="${advert.imageLink }" height="150px" width="200px" style="float:right"></img>
					</span>
					<p >既上传图片，又填写链接地址，优先显示上传的图片</p>
				</td>
			</tr>	
		</tbody>
	</table>
	<br>
	<div style="text-align: center">
		<button type="button" onclick="saveAdvert()" class="easyui-linkbutton">
			<i class="fa fa-floppy-o"></i> 保 存
		</button>
	</div>
</form>
<script type="text/javascript">
	$(function() {
		initImageUploader($('#advertId').val(), 'advert');
		initLocation();
	});

	function saveAdvert() {
		if (!$('#saveAdvertForm').form('validate')) {
			return false;
		}
		var imageLink = $('#imageLinkInput').textbox('getText').trim();
		if($('#imagePreView').attr('src') == null && imageLink==''){
			alert('请上传图片或填写链接地址');
			return false;
		}
		if($("#locationsSpan a").size()<1){
			alert('请至少选择一个位置');
			return;
		}
		var data = $.ajaxSubmit('saveAdvertForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listAdvertForm', 'layout_center_tabs');
				easyui_modal_close('editAdvertDiv');
			});
		}
	}
	
	function appendLocation(value,text){
		if(!isExist(value)){
			$("#locationsSpan").append("<label style='margin-right:15px'>"+text+"<a style='margin-left:5px' value='"+value+"' href='###' onclick='deleteLocation(this)'>x</a></label>");
			initLocation();
		}else{
			alert('已经添加该位置');
		}
	}
	
	function isExist(value){
		var locations = $("#locationsSpan a");
		var flag = false;
		for(var i=0;i<locations.size();i++){
			if(locations.eq(i).attr('value') == value){
				flag = true;
				break;
			}
		}
		return flag;
	}
	
	function deleteLocation(a){
		$(a).closest('label').remove();
		initLocation();
	}
	
	function initLocation(){
		var locations = $("#locationsSpan a");
		$('#locationsInput').val('');
		var locationsInputValue = '';
		$.each($(locations),function(i,location){
			if(locationsInputValue == ''){
				locationsInputValue = $(location).attr('value');
			}else{
				locationsInputValue = locationsInputValue + ',' + $(location).attr('value');
			}
		});
		$('#locationsInput').val(locationsInputValue);
	}
</script>