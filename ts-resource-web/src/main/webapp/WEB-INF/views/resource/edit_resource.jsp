<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<tag:mainLayout>
	<div id="g-bd">
		<div class="f-auto">
			<div class="g-layout-mod">
				<div class="g-mn-mod">
					<div class="m-upload-box">
						<form id="saveResourceForm" action="${ctx }/resource/saveResource">
							<input type="hidden" name="id" value="${resource.id }"> 
							<c:choose>
								<c:when test="${!(resource.resourceRelations[0].relation.id eq 'default')}">
									<input type="hidden" name="resourceRelations[0].relation.id" value="${resource.resourceRelations[0].relation.id}">
									<input type="hidden" name="resourceRelations[0].relation.type" value="${resource.resourceRelations[0].relation.type }">
								</c:when>
								<c:otherwise>
									<input type="hidden" name="resourceRelations[0].relation.id" value="${sessionScope.loginer.deptId}">
								</c:otherwise>
							</c:choose>		
							<input id="fileIdParam" type="hidden" name="fileInfos[0].id" value="${resource.fileInfos[0].id }">
							<input id="urlParam" type="hidden" name="fileInfos[0].url" value="${resource.fileInfos[0].url }">
							<input id="fileNameParam" type="hidden" name="fileInfos[0].fileName" value="${resource.fileInfos[0].fileName }">
							<input id="extendTypeParam" type="hidden" name="resourceExtend.type" value="${resource.resourceExtend.type }">
							<input type="hidden" name="state" value="3">
							<input id="backPage" type="hidden" value="${backPage[0]}">
							<div class="m-mn-tt">
								<h2 class="tt spe">上传资源</h2>
								<span class="ex" style="top: 6px;"><img src="${ctx }/css/images/tt-ex-img1.png" alt="为教学提供新灵感"></span>
							</div>
							<c:choose>
								<c:when test="${empty resource.id }">
									<div id="upload_befort_div" class="m-mn-dt">	
										<div id="picker" style="position: relative; left: 50%; margin-left: -110px; width: 220px; ">
											<a href="javascript:void(0);" class="upload-btn" >
												<p>点击上传文件</p> 
											</a>
										</div>
										<p class="tel-txt">允许上传的文件类型: doc, docx, pdf, ppt, pptx, mp4, flv, mp3, flash, rar</p>
									</div>
									<div id="upload_ing_div" class="m-rate-bar" style="display: none;">
				                        <div id="pg_bar" class="now-rate">
				                        	<p class="now-rate-num">已完成：<span id="pg_percent">20%</span></p>
				                        </div>
				                        <div class="file-info">
				                            <div id="fileIcon" class="m-bRsc-block">
				                                <a href="javascript:void(0);"><i class="type-ico"></i></a>
				                                <h4 class="tt"><a href="javascript:void(0);" id="fileName"></a></h4>
				                            </div>
				                        </div>
				                        <div class="u-ope" style="width: 80px; padding: 0px;">
			                                <a href="javascript:void(0);" id="picker1"><i></i>重新上传</a>
			                            </div>
				                    </div>
								</c:when>
								<c:otherwise>
									<div id="upload_ing_div" class="m-rate-bar">
				                        <div id="pg_bar" class="now-rate" style="width: 100%">
				                        	<p class="now-rate-num">已完成：<span id="pg_percent">100%</span></p>
				                        </div>
				                        <div class="file-info">
				                            <div id="fileIcon" class="m-bRsc-block">
				                                <a href="javascript:void(0);"><i class="type-ico"></i></a>
				                                <h4 class="tt"><a href="javascript:void(0);" id="fileName">${resource.fileInfos[0].fileName  }</a></h4>
				                            </div>
				                        </div>
				                        <div class="u-ope" style="width: 80px; padding: 0px;">
			                                <a href="javascript:void(0);" id="picker"><i></i>重新上传</a>
			                            </div>
				                    </div>
								</c:otherwise>
							</c:choose>
							<div class="m-mn-dt">
								<div class="g-userMod-dt">
									<div class="g-pb-lst">
										<div class="m-pb-row">
											<div class="pb-mn">
												<div class="m-pb-mod">
													<div class="pb-txt">
														<span>资源描述：</span>
													</div>
													<div class="m-ipt-mod">
														<textarea placeholder="填写资源的描述信息" class="u-textarea required" name="summary">${resource.summary }</textarea>
													</div>
												</div>
											</div>
										</div>
										<!-- <div class="m-pb-row">
											<div class="pb-mn">
												<div class="m-pb-mod">
													<div class="pb-txt">
														<span>来源：</span>
													</div>
													<div class="m-choose-mod">
														<label class="u-choose"> 
															<input type="radio" name="resourceExtend.isOriginal" checked="checked" value="Y"> <span>原创</span>
														</label> 
														<label class="u-choose"> 
															<input type="radio" name="resourceExtend.isOriginal" value="N"> <span>转载</span>
														</label>
													</div>
													<script>
														$(function(){
															$('#saveResourceForm input[name="resourceExtend.isOriginal"]').each(function(){
																if($(this).attr('value') == '${resource.resourceExtend.isOriginal}'){
																	$(this).trigger('click');
																}
															});
														});
													</script>
												</div>
											</div>
										</div> -->
										<div class="m-pb-row">
											<div class="pb-mn">
												<div class="m-pb-mod">
													<div class="pb-txt">
														<span>选择资源类型：</span>
													</div>
													<div class="m-choose-mod">
														<label class="u-choose"> 
															<input name="type" value="sync" type="radio" checked="checked" id="radio-tb"> <span>同步资源</span>
														</label> 
														<label class="u-choose"> 
															<input name="type" value="classify" type="radio" id="radio-fl"> <span>分类资源</span>
														</label>
													</div>
													<script>
														$(function(){
															$('#saveResourceForm input[name="type"]').each(function(){
																if($(this).attr('value') == '${resource.type}'){
																	$(this).trigger('click');
																}
															});
														});
													</script>
												</div>
											</div>
										</div>
										<c:if test="${resource.resourceRelations[0].relation.type eq 'workshop' }">
											<div class="m-pb-row">
												<div class="pb-mn">
													<div class="m-pb-mod">
														<div class="pb-txt">
															<span>访问权限：</span>
														</div>
														<div class="m-choose-mod">
															<label class="u-choose"> 
																<input name="resourceExtend.isHidden" value="N" type="radio" checked="checked"> <span>公开</span>
															</label> 
															<label class="u-choose"> 
																<input name="resourceExtend.isHidden" value="Y" type="radio"> <span>工作室成员可见</span>
															</label>
														</div>
														<script>
															$(function(){
																$('#saveResourceForm input[name="resourceExtend.isHidden"]').each(function(){
																	if($(this).attr('value') == '${resource.resourceExtend.isHidden}'){
																		$(this).trigger('click');
																	}
																});
															});
														</script>
													</div>
												</div>
											</div>
										</c:if>
										<div class="m-resource-type">
											<div class="type-tb" id="syncDiv">
												<div class="m-pb-row">
													<div class="pb-mn">
														<div class="m-pb-mod">
															<div class="pb-txt">
																<span>资源分类：</span>
															</div>
															<div class="m-linkage-choose">
																<div class="m-slt-block1 mid">
																	<a href="javascript:void(0);" class="show-txt" title=""> <span class="txt">请选择系统分类</span> <i class="trg"></i>
																	</a>
																	<dl id="extendTypeDl" class="lst">
																		<script>
																			setEntryList_dl('extendTypeDl', 'RESOURCE_SYNC_TYPE', 'extendTypeParam');
		                                                            	</script>
																	</dl>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div class="m-pb-row">
													<div class="pb-mn">
														<div class="m-pb-mod">
															<div class="pb-txt">
																<span>学段/学科/年级：</span>
															</div>
															<div class="m-linkage-choose">
																<div class="m-slt-block1 mid">
																	<a href="javascript:void(0);" class="show-txt" title=""> <span class="txt">请选择学段</span> <i class="trg"></i>
																	</a>
																	<input id="stageParam" type="hidden" name="resourceExtend.stage" value="${resource.resourceExtend.stage }">
																	<dl id="stageSelect" class="lst">
																	</dl>
																</div>
																<div class="m-slt-block1 mid">
																	<a href="javascript:void(0);" class="show-txt" title=""> <span class="txt">请选择学科</span> <i class="trg"></i>
																	</a>
																	<input id="subjectParam" type="hidden" name="resourceExtend.subject" value="${resource.resourceExtend.subject }">
																	<dl id="subjectSelect" class="lst">
																	</dl>
																</div>
																<div class="m-slt-block1 mid">
																	<a href="javascript:void(0);" class="show-txt" title=""> <span class="txt">请选择年级</span> <i class="trg"></i>
																	</a>
																	<input id="gradeParam" type="hidden" name="resourceExtend.grade" value="${resource.resourceExtend.grade }">
																	<dl id="gradeSelect" class="lst">
																	</dl>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div class="m-pb-row">
													<div class="pb-mn">
														<div class="m-pb-mod">
															<div class="pb-txt">
																<span>选择教材：</span>
															</div>
															<div class="m-linkage-choose">
																<div class="m-slt-block1 mid">
																	<a href="javascript:void(0);" class="show-txt" title=""> 
																		<span class="txt">请选择教材</span> <i class="trg"></i>
																	</a>
																	<input id="tbVersionParam" type="hidden" name="resourceExtend.tbVersion" value="${resource.resourceExtend.tbVersion }">
																	<dl id="tbVersionSelect" class="lst">
																	</dl>
																</div>
																<div class="m-slt-block1 mid" style="width: 412px;">
																	<a href="javascript:void(0);" class="show-txt" title=""> <span class="txt">请选择章节</span> <i class="trg"></i>
																	</a>
																	<input id="sectionParam" type="hidden" name="resourceExtend.section" value="${resource.resourceExtend.section }">
																	<dl id="sectionSelect" class="lst">
																	</dl>
																</div>
																<Br><Br>
																<div id="chapterDiv" style="display: none; width: 90%" class="m-slt-block1 mid">
																	<a href="javascript:void(0);" class="show-txt" title=""> <span class="txt">请选择章节</span> <i class="trg"></i></a>
																	<input id="chapterParam" type="hidden" name="resourceExtend.chapter" value="${resource.resourceExtend.chapter }">
																	<dl id="chapterSelect" class="lst">
																		
																	</dl>
																	<div id="chapterListDiv" style="display: none;">
																	
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
											<div class="type-fl" id="classifyDiv">
		                                        <div class="m-pb-row">
		                                            <div class="pb-mn">
		                                                <div class="m-pb-mod">
		                                                    <div class="pb-txt">
		                                                        <span>适用岗位：</span>
		                                                    </div>
		                                                    <div class="m-linkage-choose">
		                                                        <div class="m-slt-block1 mid">
		                                                            <a href="javascript:void(0);" class="show-txt" title="">
		                                                                <span class="txt">请选择岗位</span>
		                                                                <i class="trg"></i>
		                                                            </a>
		                                                            <dl id="postDl" class="lst">
		                                                            	<script>
		                                                            		setEntryList_dl('postDl', 'POST', 'postParam');
		                                                            	</script>
		                                                            </dl>
		                                                            <input id="postParam" type="hidden" name="resourceExtend.post" value="${resource.resourceExtend.post}">
		                                                        </div>
		                                                    </div>
		                                                </div>
		                                            </div>
		                                        </div>
		                                        <div class="m-pb-row">
		                                            <div class="pb-mn">
		                                                <div class="m-pb-mod">
		                                                    <div class="pb-txt">
		                                                        <span>资源分类：</span>
		                                                    </div>
		                                                    <div class="m-linkage-choose">
		                                                        <div class="m-slt-block1 mid">
		                                                            <a href="javascript:void(0);" class="show-txt" title="">
		                                                                <span class="txt">请选择系统分类</span>
		                                                                <i class="trg"></i>
		                                                            </a>
		                                                            <dl id="typeDl" class="lst">
		                                                            	<script>
		                                                            		setEntryList_dl('typeDl', 'RESOURCE_CLASSIFY_TYPE', 'extendTypeParam');
		                                                            	</script>
		                                                            </dl>
		                                                        </div>
		                                                    </div>
		                                                </div>
		                                            </div>
		                                        </div>
		                                    </div>
										</div>
										<div class="m-pb-row btn-box">
											<a id="saveResourceBtn" onclick="saveResource()" class="u-btn-com u-download large">发布</a> 
											<a onclick="cancel()" class="u-btn-com u-cancel">取消发布</a>
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="cloneElementDiv" style="display: none;">
		<dl class="chapterSelect" class="lst"></dl>
		<dd class="cloneOption"><a></a></dd>
	</div>
</tag:mainLayout>
<script>
$(function(){
    resTab();

    $(".u-person-lst li").click(function(){
        $(this).addClass("z-crt").siblings().removeClass("z-crt");;
    });

    function resTab(){
        var rad1 = $("#radio-tb");
        var rad2 = $("#radio-fl");

        rad1.click(function(){
             $(".type-tb").css("display","block");
             $(".type-fl").css("display","none");
        });
        rad2.click(function(){
             $(".type-tb").css("display","none");
             $(".type-fl").css("display","block");

        });
    }
});
$(function(){
	changeTab('resource');
	initUpload('picker');
	initTextBookEntry('z-crt', 'select');
});

function initUpload(picker){
	var uploader = WebUploader.create({
		swf : $('#ctx').val() + '/js/webuploader/Uploader.swf',
		server : $('#ctx').val() + '/file/uploadTemp.do',
		pick : '#'+picker,
		resize : true,
		accept : {
		    extensions: 'doc,docx,pdf,ppt,pptx,mp4,flv,mp3,flash,rar'
		}
	});
	uploader.on('fileQueued', function(file) {
		var fileName = file.name;
		$('#upload_befort_div').hide();
		$('#upload_ing_div').show();
		$('#upload_ing_div').find('#fileName').text(fileName);
		setFileIcon(fileName);
		uploader.upload();
		initUpload('picker1');
	});
	uploader.on('uploadProgress', function(file, percentage) {
		var progress = Math.round(percentage * 100);
		$('#upload_ing_div').find('#pg_bar').css('width', progress + '%');
		$('#upload_ing_div').find('#pg_percent').text(progress + '%');
	});
	uploader.on('uploadSuccess', function(file, response) {
		if (response != null && response.responseCode == '00') {
			$('#upload_ing_div').find('#state').text('上传成功');
			var fileInfo = response.responseData;
			$('#urlParam').val(fileInfo.url);
			$('#fileNameParam').val(fileInfo.fileName);
			$('#fileIdParam').val('${sipc:uuid() }');
		}
	});
	uploader.on('uploadError', function(file) {
		$('#upload_ing_div').find('#state').text('上传出错');
	});
	uploader.on('error', function(type) {
		if (type == 'Q_TYPE_DENIED') {
			alert('不支持该类型的文件');
		}
	});
}

function saveResource(){
	if($('#saveResourceForm').find('#fileNameParam').val().length == 0){
		alert('请先上传文件');
		return false;
	}
	if (!$('#saveResourceForm').validate().form()) {
		return false;
	}
	var type = $('#saveResourceForm input[name="type"]:checked').attr('value');
	if(type == 'sync'){
		$('#classifyDiv :hidden').val('')
	}else{
		$('#syncDiv :hidden').val('')
	}
	$('#saveResourceBtn').removeAttr('onclick');
	var data = $.ajaxSubmit('saveResourceForm');
	var json = $.parseJSON(data);
	if (json.responseCode == '00') {
		alert('操作成功', function(){
			window.location.href = '${retUrl}';
		});
	}
}

function cancel(){
	window.location.href = '${retUrl}';
}

function setFileIcon(fileName){
	var strings = fileName.split(".");
    var s_length = strings.length;
    var suffix = strings[s_length -1];
    $('#fileIcon').removeClass();
    if(suffix == "doc" || suffix == "docx"){
    	$('#fileIcon').addClass('doc').addClass('m-bRsc-block');
    }else if(suffix == "xls" || suffix == "xlsx"){
    	$('#fileIcon').addClass('xls').addClass('m-bRsc-block');
    }else if(suffix == "ppt" || suffix == "pptx"){
    	$('#fileIcon').addClass('ppt').addClass('m-bRsc-block');
    }else if(suffix == "pdf"){
    	$('#fileIcon').addClass('pdf').addClass('m-bRsc-block');
    }else if(suffix == "txt"){
    	$('#fileIcon').addClass('txt').addClass('m-bRsc-block');
    }else if(suffix == "zip" || suffix == "rar"){
    	$('#fileIcon').addClass('zip').addClass('m-bRsc-block');
    }else if(suffix == "jpg" || suffix == "jpeg" || suffix == "png" || suffix == "gif"){
    	
    }else if(
        suffix == "mp4" || 
        suffix == "avi" || 
        suffix == "rmvb" || 
        suffix == "rm" || 
        suffix == "asf" || 
        suffix == "divx" || 
        suffix == "mpg" || 
        suffix == "mpeg" || 
        suffix == "mpe" || 
        suffix == "wmv" || 
        suffix == "mkv" || 
        suffix == "vob" || 
        suffix == "3gp"
        ){
    	$('#fileIcon').addClass('video').addClass('m-bRsc-block');
    }else {
    	$('#fileIcon').addClass('other').addClass('m-bRsc-block');
    }
}
</script>