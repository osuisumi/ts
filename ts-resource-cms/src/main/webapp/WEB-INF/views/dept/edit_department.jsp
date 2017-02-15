<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="saveDepartmentForm" action="${ctx}/dept" method="post">
	<c:choose>
		<c:when test="${empty department.id }">
			<input id="departmentId" type="hidden" name="id" value="${sipc:uuid() }">
		</c:when>
		<c:otherwise>
			<input id="departmentId" type="hidden" name="id" value="${department.id }">
			<script>
				$('#saveDepartmentForm').attr('action', '${ctx}/dept/${department.id }');
				$('#saveDepartmentForm').attr('method', 'PUT');
			</script>
		</c:otherwise>
	</c:choose>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="alter-table-v">
		<tbody>
			<tr>
				<td width="15%">机构名称:</td>
				<td width="35%" style="text-align: left;"><input type="text" name="deptName" class="easyui-textbox" value="${department.deptName}" data-options="required:true,validType:'deptName[\'${department.deptName }\']'" style="width: 95%" /></td>
			</tr>
			<tr>
				<td width="15%">机构类型:</td>
				<td width="35%" style="text-align: left;">
					<input id="deptTypeParam" name="deptType" class="easyui-combobox" value="${department.deptType }" style="width:200px;"
					data-options="
						valueField: 'dictValue',    
				        textField: 'dictName',  
				        onSelect: function(record){
				        	if(record.dictValue == '2'){
				        		$('#stageTr').show();
				        	}else{
				        		$('#stageTr').hide();
				        		$('#stageParam').combobox('select', '');
				        	}
				        },
				        onLoadSuccess: function(){
				        	if('${department.deptType }' != ''){
				       			$('#deptTypeParam').combobox('select', '${department.deptType }');
				       			if('${department.deptType }' == '2'){
				        			$('#stageTr').show();
				        		}
				       		}else{
				       			$('#deptTypeParam').combobox('select', '');
				       		}
				        }   
				        " /> 
				    <script>
				    	$(function(){
				    		$.get('${ctx }/dict/getEntryList','dictTypeCode=DEPT_TYPE',function(data){
				    			data.unshift({"dictName":"请选择","dictValue":""});
				    			$('#deptTypeParam').combobox('loadData', data);
				    		});
				    	});
				    </script>
				</td>
			</tr>
			<tr>
				<td width="15%">机构代码:</td>
				<td width="35%" style="text-align: left;"><input type="text" name="deptCode" class="easyui-textbox"  value="${department.deptCode}" style="width: 95%" /></td>
			</tr> 
			<tr>
				<td width="15%">机构网站链接:</td>
				<td width="35%" style="text-align: left;"><input id="websiteParam" type="text" name="website" class="easyui-textbox"  value="${department.website}" style="width: 95%" /></td>
			</tr> 
			<tr id="stageTr" style="display: none;">
				<td width="15%">学段</td>
				<td width="35%" style="text-align: left;">
					<input id="stageParam" class="easyui-combobox" name="stage" value="${department.stage }" style="width:200px;"
					data-options="
						valueField: 'textBookValue',    
				        textField: 'textBookName',  
				        onLoadSuccess: function(){
				        	if('${department.stage }' != ''){
				       			$('#stageParam').combobox('select', '${department.stage }');
				       		}else{
				       			$('#stageParam').combobox('select', '');
				       		}
				        }   
				        " /> 
				    <script>
				    	$(function(){
				    		$.get('${ctx }/textBook/getEntryList','textBookTypeCode=STAGE',function(data){
				    			data.unshift({"textBookName":"请选择","textBookValue":""});
				    			$('#stageParam').combobox('loadData', data);
				    		});
				    	});
				    </script>
				</td>
			</tr>
			<tr>
				<td>封面图片:</td>
				<td colspan="3" style="text-align: left; height: 200px;">
					<div>
						<c:choose>
							<c:when test="${not empty department.imageUrl }">
								<img id="imagePreView" src="${file:getFileUrl(department.imageUrl) }" width="200" height="150">
							</c:when>
							<c:otherwise>
								<img id="imagePreView" src="${ctx }/images/defaultDepartmentImg.png" width="200" height="150">
							</c:otherwise>
						</c:choose>
					</div> 
					<a class="l-btn" id="picker"><span>上传图片</span></a> 
					<span class="help-block">仅支持JPG、JPEG、PNG格式（2M以下）</span>
					<ul id="fileList"></ul>
				</td>
			</tr>
		</tbody>
	</table>
	<br>
	<div style="text-align: center">
		<button type="button" onclick="saveDepartment()" class="easyui-linkbutton">
			<i class="fa fa-floppy-o"></i> 保 存
		</button>
	</div>
</form>
<script type="text/javascript">
	$(function() {
		initImageUploader($('#departmentId').val(), 'department');
	});

	function saveDepartment() {
		if(!$('#saveDepartmentForm').form('validate')){
			return false;
		}
		var website = $('#websiteParam').val();
		if(website.trim().length > 0 && website.indexOf('http') == -1){
			$('#websiteParam').textbox('setValue', 'http://'+website);
		}
		var data = $.ajaxSubmit('saveDepartmentForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listDepartmentForm', 'layout_center_tabs');
				easyui_modal_close('editDepartmentDiv');
			});
		} 
	}
</script>