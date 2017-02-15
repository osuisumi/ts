<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="competitionForm" action="${ctx}/competition">
	<input id="competitionId" type="hidden" name="id" value="${competition.id}">
	<input type="hidden" id="relation" name="competitionRelations[0].relation.id" value="${sessionScope.loginer.deptId}">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="alter-table-v">
		<tbody>
			<tr style="height: 100px">
				<td>宣传图片:</td>
				<td>
					<div>
						<c:choose>
							<c:when test="${not empty competition.imageUrl }">
								<img id="imagePreView" src="${file:getFileUrl(competition.imageUrl) }" width="200" height="150">
							</c:when>
							<c:otherwise>
								<img id="imagePreView" src="" width="200" height="150">
							</c:otherwise>
						</c:choose>
					</div> 
					<a class="l-btn" id="picker"><span>上传图片</span></a> 
					<span class="help-block">图片建议尺寸：2000*400像素,仅支持JPG、JPEG、PNG格式（2M以下）</span>
					<ul id="fileList"></ul>
				</td>
			</tr>
			<tr>
				<td width="10%">活动标题:</td>
				<td width="90%" style="text-align: left;" colspan="3">
				<input value="${competition.title}" type="text" class="easyui-textbox" required style="width: 200px" name="title" placeholder="请输入发现标题" aria-describedby="basic-addon1">
				</td>
			</tr>
			<tr>
				<td width="10%">活动标题:</td>
				<td width="35%" style="text-align: left;">
					<input id="competitionTypeParam" name="type" class="easyui-combobox" value="${competition.type }" style="width:200px;"
					data-options="
						valueField: 'dictValue',    
				        textField: 'dictName',  
				        onLoadSuccess: function(){
				        	if('${competition.type }' != ''){
				       			$('#competitionTypeParam').combobox('select', '${competition.type }');
				       		}else{
				       			$('#competitionTypeParam').combobox('select', '');
				       		}
				        }   
				        " /> 
				    <script>
				    	$(function(){
				    		$.get('${ctx }/dict/getEntryList','dictTypeCode=COMPETITION_TYPE',function(data){
				    			data.unshift({"dictName":"请选择","dictValue":""});
				    			$('#competitionTypeParam').combobox('loadData', data);
				    		});
				    	});
				    </script>
				</td>
			</tr>
			<tr>
				<td width="10%">活动说明:</td>
				<td width="40%" style="text-align: left;"><input value="${competition.summary}" type="text" class="easyui-textbox" required name="summary" multiline="true" style="width: 478px; height: 100px"></td>
			</tr>
			<tr>
				<td width="10%">面向群体:</td>
				<td width="40%" style="text-align: left;"><input value="${competition.faceGroup}" type="text" class="easyui-textbox" required name="faceGroup" placeholder="请输入发现标题" aria-describedby="basic-addon1"></td>
			</tr>
			<tr>
				<td width="10%">活动时间:</td>
				<td style="text-align: left;"><input id="csd"  class="easyui-datebox" data-options="editable:false,onSelect:onSelectCompetition"  required name="competitionTimePeriod.startTime" value='<fmt:formatDate value="${competition.competitionTimePeriod.startTime}" pattern="yyyy-MM-dd"/>'/>至<input id="ced" name="competitionTimePeriod.endTime" data-options="editable:false,onSelect:onSelectCompetition"  value='<fmt:formatDate value="${competition.competitionTimePeriod.endTime}" pattern="yyyy-MM-dd"/>' class="easyui-datebox" required/></td>
			</tr>
			<tr>
				<td>投票时间:</td>
				<td style="text-align: left;"><input id="vsd" class="easyui-datebox" data-options="editable:false,onSelect:onSelectVote"  required name="attitudeTimePeriod.startTime" value='<fmt:formatDate value="${competition.attitudeTimePeriod.startTime}" pattern="yyyy-MM-dd"/>'/>至<input id="ved" class="easyui-datebox" data-options="editable:false,onSelect:onSelectVote"  required name="attitudeTimePeriod.endTime" value='<fmt:formatDate value="${competition.attitudeTimePeriod.endTime}" pattern="yyyy-MM-dd"/>'/></td>
			</tr>
			<tr>
				<td>主办机构:</td>
				<td style="text-align: left;"><input class="easyui-textbox" name="mainOrganization" value="${competition.mainOrganization }" required/></td>
			</tr>
			<tr>
				<td>协办单位:</td>
				<td style="text-align: left;"><input class="easyui-textbox" name="assistOrganization" value="${competition.assistOrganization }" /></td>
			</tr>
			<tr>
				<td>承办单位:</td>
				<td style="text-align: left;"><input class="easyui-textbox" name="undertakeOrganization" value="${competition.undertakeOrganization }" /></td>
			</tr>
			<tr>
				<td>咨询电话:</td>
				<td style="text-align:left"><input class="easyui-textbox" name="phone" value="${competition.phone}" /></td>
			</tr>
		</tbody>
	</table>
	<br>
	<div style="text-align: center">
		<button type="button" onclick="saveCompetition()" class="easyui-linkbutton">
			<i class="fa fa-floppy-o"></i> 保 存
		</button>
	</div>
</form>

<script>
	$(function(){
		initImageUploader($('#competitionId').val(), 'competition');
		var competitionId = $('#competitionId').val();
		if(competitionId){
			$('#competitionForm').attr('action','${ctx}/competition/'+competitionId+'/update');
		}
	})
	function saveCompetition(){
		var img = $('#imagePreView').attr('src');
		if(img.length<=0){
			alert('请上传宣传图片');
			return false;
		}
		if (!$('#competitionForm').form('validate')) {
			return false;
		}
		data = $.ajaxSubmit('competitionForm');
		data = $.parseJSON(data);
		if (data.responseCode == '00') {
			$.messager.alert('提示信息', '操作成功');
			easyui_tabs_update('listCompetitionForm_competition', 'layout_center_tabs');
			easyui_modal_close('editCompetitionDiv');
		}
	}
	
	function onSelectCompetition(d){
		var issd = this.id == 'csd', sd = issd ? d : new Date($('#csd').datebox('getValue')), ed = issd ? new Date($('#ced').datebox('getValue')) : d;
        if (ed <= sd) {
        	$.messager.alert('提示信息', '结束日期小于开始日期');
            $('#ced').datebox('setValue', '');
        }
	}
	function onSelectVote(d){
		var issd = this.id == 'vsd', sd = issd ? d : new Date($('#vsd').datebox('getValue')), ed = issd ? new Date($('#ved').datebox('getValue')) : d;
        if (ed <= sd) {
        	$.messager.alert('提示信息', '结束日期小于开始日期');
            $('#ved').datebox('setValue', '');
        }
	}
</script>
