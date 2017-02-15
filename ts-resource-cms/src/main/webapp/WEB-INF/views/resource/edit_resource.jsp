<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="saveResourceForm" action="${ctx}/resource/saveResource" method="post">
	<input type="hidden" name="id" value="${resource.id }"> 
	<input type="hidden" name="resourceRelations[0].relation.id" value="${sessionScope.loginer.deptId}">
	<input id="fileIdParam" type="hidden" name="fileInfos[0].id" value="${resource.fileInfos[0].id }" class="fileParam">
	<input id="urlParam" type="hidden" name="fileInfos[0].url" value="${resource.fileInfos[0].url }" class="fileParam">
	<input id="fileNameParam" type="hidden" name="fileInfos[0].fileName" value="${resource.fileInfos[0].fileName }" class="fileParam"> 
	<input id="extendTypeParam" type="hidden" name="resourceExtend.type" value="${resource.resourceExtend.type }">
	<input type="hidden" name="state" value="4">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="alter-table-v">
		<tbody>
			<tr>
				<td>上传资源:</td>
				<td colspan="3" style="text-align: left; height: 120px;">
					<div class="am-file-upload">
						<div class="am-ful-btn">
							<a href="javascript:void(0);" class="au-file-show-btn l-btn" id="picker"> 
								<i class="au-link-ico"></i><span id="btnTitle">上传资源</span>
							</a> 
							<a style="display: none;" href="javascript:void(0);" class="au-file-show-btn l-btn" id="picker1"> 
								<i class="au-link-ico"></i><span id="btnTitle">重新上传</span>
							</a> 
						</div>
						<ul id="fileList" class="am-ful-lst">
						</ul>
					</div>
					<span class="help-block">允许上传的文件类型: doc, docx, pdf, ppt, pptx, mp4, flv, mp3, flash, rar</span>
					<ul id="fileList">
					
					</ul>
					<c:if test="${not empty resource.id}">
						<script>
							$.get('/file','relationId=${resource.id}',function(data) {
								if (data != null) {
									var $tag_lst = $("#fileList");
									$.each(data,function(i, tag) {
										$tag_lst.append('<li class="fileLi success" fileId="'+this.id+'">'+
															'<a class="txt">'+this.fileName+'</a>'+
															'<a class="dlt" title="删除附件" onclick="removeFileParam()">×</a>'+
														'</li>'
										);
									});
								}
							});
						</script>
					</c:if>
				</td>
			</tr>
			<tr>
				<td width="15%">资源描述:</td>
				<td width="35%" style="text-align: left;"><input type="text" name="summary" class="easyui-textbox" required value="${resource.summary}" style="width: 95%;" data-options="multiline:true, height:100" /></td>
			</tr>
			<tr>
				<td width="15%">资源类型:</td>
				<td width="35%" style="text-align: left;">
					<input id="typeComboBox" name="type" class="easyui-combobox" value="${resource.type }" style="width:200px;"
					data-options="
						valueField: 'value',    
				        textField: 'text',  
				        data:  [{
							text: '同步资源',
							value: 'sync'
						},{ 
							text: '分类资源',
							value: 'classify'
						}],
				        onSelect: function(record){
				        	if(record.value == 'sync'){
				        		$('.syncTr').show();
				        		$('.classifyTr').hide();	
				        	}else{
				        		$('.syncTr').hide();
				        		$('.classifyTr').show();	
				        	}
				        	$('#extendTypeParam').val('');
				        },
				        onLoadSuccess: function(){
				        	if('${resource.type }' != ''){
				       			$('#typeComboBox').combobox('select', '${resource.type }');
				       		}else{
				       			$('#typeComboBox').combobox('select', 'sync');
				       		}
				       		if('${resource.type }' == 'sync'){
				        		$('.syncTr').show();
				        		$('.classifyTr').hide();	
				        	}else{
				        		$('.syncTr').hide();
				        		$('.classifyTr').show();	
				        	}
				        }   
				        " />  
				</td>
			</tr>
			<tr class="syncTr">
				<td width="15%">系统分类:</td>
				<td width="35%" style="text-align: left;">
					<input id="syncTypeParam" class="easyui-combobox" value="${resource.resourceExtend.type }" style="width:200px;"
					data-options="
						valueField: 'dictValue',    
				        textField: 'dictName',  
				        onSelect: function(record){
				        	$('#extendTypeParam').val(record.dictValue);
				        },
				        onLoadSuccess: function(){
				        	if('${resource.resourceExtend.type }' != ''){
				       			$('#syncTypeParam').combobox('select', '${resource.resourceExtend.type }');
				       		}else{
				       			$('#syncTypeParam').combobox('select', '');
				       		}
				        }   
				        " /> 
				    <script>
				    	$(function(){
				    		$.get('${ctx }/dict/getEntryList','dictTypeCode=RESOURCE_SYNC_TYPE',function(data){
				    			data.unshift({"dictName":"请选择","dictValue":""});
				    			$('#syncTypeParam').combobox('loadData', data);
				    		});
				    	});
				    </script>
				</td>
			</tr>
			<tr class="syncTr">
				<td width="15%">学段:</td>
				<td width="35%" style="text-align: left;">
					<input id="stageParam" name="resourceExtend.stage" class="easyui-combobox" value="${resource.resourceExtend.stage }" style="width:200px;"
					data-options="
						valueField: 'textBookValue',    
				        textField: 'textBookName',    
				        method: 'get',
				        onSelect: function(record){
				        	var data = 'textBookTypeCode=SUBJECT&stage='+record.textBookValue;
				        	$.get('${ctx }/textBook/getEntryListByEntity',data,function(data){
				    			data.unshift({'textBookName':'请选择','textBookValue':''});
				    			$('#subjectParam').combobox('loadData', data);
				    		});
				        },
				        onLoadSuccess: function(data){
				       		if('${resource.resourceExtend.stage }' != ''){
				       			$('#stageParam').combobox('select', '${resource.resourceExtend.stage }');
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
			<tr class="syncTr">
				<td width="15%">学科:</td>
				<td width="35%" style="text-align: left;">
					<input id="subjectParam" name="resourceExtend.subject" class="easyui-combobox" value="${resource.resourceExtend.subject }" style="width:200px;"
					data-options="
						valueField: 'textBookValue',    
				        textField: 'textBookName',    
				        method: 'get',
				        onSelect: function(record){
				        	changeGrade();
				        },
				        onLoadSuccess: function(){
				        	var value = $('#subjectParam').combobox('getValue');
				        	if(value != null && value != ''){
				        		var data = $('#subjectParam').combobox('getData');
				        		var hasValue = false;
				        		$(data).each(function(){
				        			if(this.textBookValue == value){
				        				hasValue = true;
				        				return false;
				        			}
				        		});
				        		if(hasValue){
				        			$('#subjectParam').combobox('select', value);
				        			changeGrade();
				        		}else{
				        			$('#subjectParam').combobox('select', '');
				        		}
				        	}else{
				        		$('#subjectParam').combobox('select', '');
				        	}
				        }   
				        " />  
				     <script>
				    	$(function(){
				    		$.get('${ctx }/textBook/getEntryList','textBookTypeCode=SUBJECT',function(data){
				    			data.unshift({"textBookName":"请选择","textBookValue":""});
				    			$('#subjectParam').combobox('loadData', data);
				    		});
				    	});
				    	
				    	function changeGrade(){
				     		var stage = $('#stageParam').combobox('getValue');
				        	var subject = $('#subjectParam').combobox('getValue');
				        	if(stage != '' && subject != ''){
				        		var data = 'textBookTypeCode=GRADE&subject='+subject+'&stage='+stage;
					        	$.get('${ctx }/textBook/getEntryListByEntity',data,function(data){
					        		data.unshift({'textBookName':'请选择','textBookValue':''});
					    			$('#gradeParam').combobox('loadData', data);
					    		});
				        	}
				     	}
				    </script>
				</td>
			</tr>
			<tr class="syncTr">
				<td width="15%">教材版本:</td>
				<td width="35%" style="text-align: left;">
					<input id="tbVersionParam" name="resourceExtend.tbVersion" class="easyui-combobox" value="${resource.resourceExtend.tbVersion }" style="width:200px;"
					data-options="
						valueField: 'textBookValue',    
				        textField: 'textBookName',    
				        method: 'get',
				        onSelect: function(){
				        	changeSection();
				        },
				        onLoadSuccess: function(){
				        	if('${resource.resourceExtend.tbVersion }' != ''){
				       			$('#tbVersionParam').combobox('select', '${resource.resourceExtend.tbVersion }');
				       			changeSection();
				       		}else{
				       			$('#tbVersionParam').combobox('select', '');
				       		}
				        }   
				        " />  
				    <script>
				    	$(function(){
				    		$.get('${ctx }/textBook/getEntryList','textBookTypeCode=VERSION',function(data){
				    			data.unshift({"textBookName":"请选择","textBookValue":""});
				    			$('#tbVersionParam').combobox('loadData', data);
				    		});
				    	});
				    </script>
				</td>
			</tr>
			<tr class="syncTr">
				<td width="15%">年级:</td>
				<td width="35%" style="text-align: left;">
					<input id="gradeParam" name="resourceExtend.grade" class="easyui-combobox" value="${resource.resourceExtend.grade }" style="width:200px;"
					data-options="
						valueField: 'textBookValue',    
				        textField: 'textBookName',    
				        method: 'get',
				        onSelect: function(record){
				     		changeSection();
				        },
				        onLoadSuccess: function(data){
				        	var value = $('#gradeParam').combobox('getValue');
				        	if(value != null && value != ''){
				        		var data = $('#gradeParam').combobox('getData');
				        		var hasValue = false;
				        		$(data).each(function(){
				        			if(this.textBookValue == value){
				        				hasValue = true;
				        				return false;
				        			}
				        		});
				        		if(hasValue){
				        			$('#gradeParam').combobox('select', value);
				        			changeSection();
				        		}else{
				        			$('#gradeParam').combobox('select', '');
				        		}
				        	}else{
				        		$('#gradeParam').combobox('select', '');
				        	}
				        }   
				        " />  
					<script>
						function changeSection(){
							var stage = $('#stageParam').combobox('getValue');
				        	var subject = $('#subjectParam').combobox('getValue');
				        	var tbVersion = $('#tbVersionParam').combobox('getValue');
				        	var grade = $('#gradeParam').combobox('getValue');
				        	if(stage != '' && subject != '' && tbVersion != '' && grade != ''){
				        		var data = 'textBookTypeCode=SECTION&subject='+subject+'&stage='+stage+'&version='+tbVersion+'&grade='+grade;
					        	$.get('${ctx }/textBook/getEntryListByEntity',data,function(data){
					        		data.unshift({'textBookName':'请选择','textBookValue':''});
					    			$('#sectionParam').combobox('loadData', data);
					    		});
				        	}
				     	}
				    </script>
				</td>
			</tr>
			<tr class="syncTr">
				<td width="15%">章:</td>
				<td width="35%" style="text-align: left;">
					<input id="sectionParam" name="resourceExtend.section" class="easyui-combobox" value="${resource.resourceExtend.section }" style="width:200px;"
					data-options="
						valueField: 'textBookValue',    
				        textField: 'textBookName',    
				        method: 'get',
				        onSelect: function(record){
				        	changeChapter();
				        },
				        onLoadSuccess: function(data){
				        	var value = $('#sectionParam').combobox('getValue');
				        	if(value != null && value != ''){
				        		var data = $('#sectionParam').combobox('getData');
				        		var hasValue = false;
				        		$(data).each(function(){
				        			if(this.textBookValue == value){
				        				hasValue = true;
				        				return false;
				        			}
				        		});
				        		if(hasValue){
				        			$('#sectionParam').combobox('select', value);
				        			changeChapter();
				        		}else{
				        			$('#sectionParam').combobox('select', '');
				        		}
				        	}else{
				        		$('#sectionParam').combobox('select', '');
				        	}
				        }   
				        " />  
					<script>
						function changeChapter(){
							var stage = $('#stageParam').combobox('getValue');
				        	var subject = $('#subjectParam').combobox('getValue');
				        	var tbVersion = $('#tbVersionParam').combobox('getValue');
				        	var grade = $('#gradeParam').combobox('getValue');
				        	var section = $('#sectionParam').combobox('getValue');
				        	if(stage != '' && subject != '' && tbVersion != '' && grade != '' && section != ''){
				        		var data = 'textBookTypeCode=SECTION&subject='+subject+'&stage='+stage+'&version='+tbVersion+'&grade='+grade+'&section='+section;
					        	$.get('${ctx }/textBook/getEntryListByEntity',data,function(data){
					        		data.unshift({'textBookName':'请选择','textBookValue':''});
					    			$('#chapterParam').combobox('loadData', data);
					    		});
				        	}else{
				        		$('#chapterParam').combobox('select', '');
				        		$('#chapterParam').combobox('loadData', '[]');
				        	}
				     	}
				    </script>
				</td>
			</tr>
			<tr class="syncTr">
				<td width="15%">节:</td>
				<td width="35%" style="text-align: left;">
					<input id="chapterParam" name="resourceExtend.chapter" class="easyui-combobox" value="${resource.resourceExtend.chapter }" style="width:200px;"
					data-options="
						valueField: 'textBookValue',    
				        textField: 'textBookName',    
				        method: 'get',
				        onLoadSuccess: function(data){
				        	var value = $('#chapterParam').combobox('getValue');
				        	if(value != null && value != ''){
				        		var data = $('#chapterParam').combobox('getData');
				        		var hasValue = false;
				        		$(data).each(function(){
				        			if(this.textBookValue == value){
				        				hasValue = true;
				        				return false;
				        			}
				        		});
				        		if(hasValue){
				        			$('#chapterParam').combobox('select', value);
				        		}else{
				        			$('#chapterParam').combobox('select', '');
				        		}
				        	}else{
				        		$('#chapterParam').combobox('select', '');
				        	}
				        }   
				        " />  
				</td>
			</tr> 
			<tr class="classifyTr" style="display: none;">
				<td width="15%">岗位:</td>
				<td width="35%" style="text-align: left;">
					<input id="postParam" name="resourceExtend.post" class="easyui-combobox" value="${resource.resourceExtend.post }" style="width:200px;"
					data-options="
						valueField: 'dictValue',    
				        textField: 'dictName',
				        onLoadSuccess: function(){
				        	if('${resource.resourceExtend.post }' != ''){
				       			$('#postParam').combobox('select', '${resource.resourceExtend.post }');
				       		}else{
				       			$('#postParam').combobox('select', '');
				       		}
				        }   
				        " /> 
				    <script>
				    	$(function(){
				    		$.get('${ctx }/dict/getEntryList','dictTypeCode=POST',function(data){
				    			data.unshift({"dictName":"请选择","dictValue":""});
				    			$('#postParam').combobox('loadData', data);
				    		});
				    	});
				    </script>
				</td>
			</tr>
			<tr class="classifyTr" style="display: none;">
				<td width="15%">系统分类:</td>
				<td width="35%" style="text-align: left;">
					<input id="classifyTypeParam" class="easyui-combobox" value="${resource.resourceExtend.type }" style="width:200px;"
					data-options="
						valueField: 'dictValue',    
				        textField: 'dictName',  
				        onSelect: function(record){
				        	$('#extendTypeParam').val(record.dictValue);
				        },
				        onLoadSuccess: function(){
				        	if('${resource.resourceExtend.type }' != ''){
				       			$('#classifyTypeParam').combobox('select', '${resource.resourceExtend.type }');
				       		}else{
				       			$('#classifyTypeParam').combobox('select', '');
				       		}
				        }   
				        " /> 
				    <script>
				    	$(function(){
				    		$.get('${ctx }/dict/getEntryList','dictTypeCode=RESOURCE_CLASSIFY_TYPE',function(data){
				    			data.unshift({"dictName":"请选择","dictValue":""});
				    			$('#classifyTypeParam').combobox('loadData', data);
				    		});
				    	});
				    </script>
				</td>
			</tr>
		</tbody>
	</table>
	<br>
	<div style="text-align: center">
		<button type="button" onclick="saveResource()" class="easyui-linkbutton">
			<i class="fa fa-floppy-o"></i> 保 存
		</button>
	</div>
</form>
<script type="text/javascript">
	$(function(){
		if('${resource.id}' != ''){
			$('#picker').hide();
			$('#picker1').show();
			initUpload('picker1');
		}else{
			initUpload('picker');
		}
	});

	function initUpload(picker){
		var uploader = WebUploader.create({
			swf : $('#ctx').val() + '/js/webuploader/Uploader.swf',
			server : '${ctx}/file/uploadTemp.do',
			pick : '#'+picker,
			resize : true
		});
		// 当有文件被添加进队列的时候
		uploader.on('fileQueued', function(file) {
			$list = $('#fileList');
			$list.html('<li id="' + file.id + '" class="fileLi fileItem item">' + '<a href="#" class="txt">' + file.name + '</a>' + '<div class="state">' + '<span class="status">等待上传...</span>' + '</div>' + '</li>');
			uploader.upload();
			if($('#picker1').css('display') == 'none'){
				$('#picker').hide();
				$('#picker1').show();
				initUpload('picker1');
			}
		});
		// 文件上传过程中创建进度条实时显示。
		uploader.on('uploadProgress', function(file, percentage) {
			var $li = $('#' + file.id), $percent = $li.find('.sche');
			// 避免重复创建
			if (!$percent.length) {
				$li.find('.state').html('<div class="sche">' + '<div class="bl">' + '<div class="bs" role="progressbar" style="width: 0%"></div>' + '</div>' + '<span class="num">' + '0%' + '</span>' + '<span class="status"></span>' + '</div>');
				$percent = $li.find('.sche');
			}
			var progress = Math.round(percentage * 100);
			$percent.find('.bs').css('width', progress + '%');
			$percent.find('.num').text(progress + '%');
			$percent.find('.status').text('上传中');
		});
		uploader.on('uploadSuccess', function(file, response) {
			if (response != null && response.responseCode == '00') {
				$('#' + file.id).find('.state .status').text('已上传');
				var fileInfo = response.responseData;
				$('#fileNameParam').val(fileInfo.fileName);
				$('#fileIdParam').val(fileInfo.id);
				$('#urlParam').val(fileInfo.url);
				$('#' + file.id).addClass('success');
			}
		});
		uploader.on('uploadError', function(file) {
			$('#' + file.id).find('.state .status').text('上传出错');
		});
		uploader.on('uploadComplete', function(file) {
			$('#' + file.id).find('.progress').fadeOut();
		});
//		$('#uploadBtn').click(function() {
//			uploader.upload();
//		});
		$('#fileList').on('click', '.dlt', function() {
			var _this = $(this);
			confirm('是否确定删除该附件?',function(){
				if ($(this).parents('.fileLi').hasClass('fileItem')) {
					uploader.removeFile($(this).parents('.fileLi').attr('id'));
				}
				_this.parents('.fileLi').remove();
				initFileParam();
			});
		});
		uploader.on('error', function(type) {
			if (type == 'Q_EXCEED_NUM_LIMIT') {
				alert('只允许上传' + fileNumLimit + '个附件');
			}
		});
	}
	
	function saveResource() {
		if($('#saveResourceForm').find('#fileNameParam').val().length == 0){
			alert('请先上传文件');
			return false;
		}
		if(!$('#saveResourceForm').form('validate')){
			return false;
		}
		var type = $('#typeComboBox').combobox('getValue');
		if(type == 'sync'){
			$('.classifyTr :hidden').val('')
		}else{
			$('.syncTr :hidden').val('')
		}
		var data = $.ajaxSubmit('saveResourceForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listSyncResourceForm', 'layout_center_tabs');
				easyui_modal_close('editResourceDiv');
			});
		}
	}
</script>