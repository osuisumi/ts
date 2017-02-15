<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<form id="discoveryForm" action="${ctx}/discovery/save">
<input type="hidden" name="type" value="discovery">
<input type="hidden" id="relation" name="resourceRelations[0].relation.id" value="${sessionScope.loginer.deptId}">
<input type="hidden" name="state" value="${dict:getEntryValue('EDIT_STATE','待审核')}">
<input type="hidden" name="id" value="${discovery.id}">
<input id="backPage" type="hidden" value="${backPage[0]}">
<ul id="fileResult"></ul>
	<div id="g-bd">
		<div class="f-auto">
			<div class="g-layout-mod">
				<div class="g-mn-mod">
					<div class="m-find-box">
						<div class="m-mn-tt">
							<h2 class="tt spe">分享发现</h2>
							<span class="ex" style="top: 6px;"><img src="${ctx }/css/images/tt-ex-img1.png" alt="为教学提供新灵感"></span>
						</div>
						<div class="m-mn-dt">
							<div class="g-userMod-dt1">
								<div class="g-pb-lst">
									<div class="m-pb-row">
										<div class="pb-mn">
											<div class="m-pb-mod">
												<div class="pb-txt">
													<span>有图有真相：</span>
												</div>
												<div class="m-ipt-mod">
													<div id="filePicker" style="position: relative; left: 50%; margin-left: -110px; width: 200px; ">
														<a class="img-upload-box">
															<p>最多可上传9张图片</p>
														</a>
													</div>
												</div>
												<!-- <a id="filePicker">上传</a> -->
												<ul id="fileList" class="m-upload-lst">
													<c:forEach items="${discovery.fileInfos}" var="fileInfo">
														<li id="${fileInfo.id}" fileId="${fileInfo.id}" url="${fileInfo.url}" fileName="fileInfo.fileName" class="upload-state-done">
											    		<img src="${file:getFileUrl(fileInfo.url)}">
											    		<a onclick="deleteImage(this)" class="close" title="删除图片">×</a>
											    		</li>
													</c:forEach>
												</ul>
												<div id="fileForm">
													<c:forEach items="${discovery.fileInfos}" var="fileInfo" varStatus="index">
														<input class="fileParam ${fileInfo.id}" name="fileInfos[${index.index}].id" value="${fileInfo.id}" type="hidden"/>
														<input class="fileParam ${fileInfo.id}" name="fileInfos[${index.index}].fileName" value="${fileInfo.fileName}" type="hidden"/>
														<input class="fileParam ${fileInfo.id}" name="fileInfos[${index.index}].url" value="${fileInfo.url}" type="hidden"/>
													</c:forEach>
												</div>
											</div>
										</div>
									</div>
									<div class="m-pb-row">
										<div class="pb-mn">
											<div class="m-pb-mod">
												<div class="pb-txt">
													<span>发现什么：</span>
												</div>
												<div class="m-ipt-mod">
													<input type="text" name="title" placeholder="用一句话描述你的发现" value="${discovery.title}" class="u-ipt {required:true}">
												</div>
											</div>
										</div>
									</div>
									<div class="m-pb-row">
										<div class="pb-mn">
											<div class="m-pb-mod">
												<div class="pb-txt">
													<span>有啥亮点：</span>
												</div>
												<div class="m-ipt-mod">
													<textarea id="summary" placeholder="这个发现对你教学启发是什么？建议不超过500字" name="summary" class="u-textarea"></textarea>
												</div>
											</div>
										</div>
									</div>
									<div class="m-pb-row">
										<div class="pb-mn">
											<div class="m-pb-mod">
												<div class="pb-txt">
													<span>资源网址：</span>
												</div>
												<div class="m-ipt-mod">
													<input type="text" name="resourceExtend.previewUrl" placeholder="请填写完整网址，将有助于内容审核" class="u-ipt" value="${discovery.resourceExtend.previewUrl}">
												</div>
											</div>
										</div>
									</div>
									<div class="m-pb-row">
										<div class="pb-mn">
											<div class="m-pb-mod">
												<!-- <div class="pb-txt">
													<span>属于：</span>
												</div> -->
												<tag:editTag relationId="${discovery.id }" />
												<script type="text/javascript">
													$(function(){
														$('.au-ipt').css('width','228px').css('height','32px');
													})
												</script>
											</div>
										</div>
									</div>
									<div class="m-pb-row btn-box">
										<a onclick="saveDiscovery()" class="u-btn-com u-download">发布</a> <a onclick="cancel()" class="u-btn-com u-cancel">取消发布</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
<script type="text/javascript">
	$(function(){
		$('.u-find-lst').on('click','a',function(){
			var classAttr = $(this).attr('class');
			if(classAttr.indexOf('z-crt')>0){
				//包含，去掉z-crt
				$(this).attr('class','u-lst');
			}else{
				$('.u-find-lst a').attr('class','u-lst');
				$(this).attr('class','u-lst z-crt');
			}
			$('#discoveryType').val($(this).attr('value'));
		});
	})

	$(function(){
		//初始化编辑
		if("${discovery.summary}"){
			$('#summary').val("${discovery.summary}");
		}
		var discoveryType = "${discovery.resourceExtend.type}";
		if(discoveryType){
			$('#'+discoveryType).click();
		}
	})

	$(function(){
		initImagesUploader('${discovery.id}','discovery');
	})
	
	function cancel(){
		var type=$('#backPage').val();
		if(type == "zone"){
			zoneIndex();
		}else{
			discoveryIndex();	
		}
	}

	function saveDiscovery(){
		var imgCount = $('#fileList img').size();
		if(imgCount>9){
			alert('请不要上传大于九张图片');
			return false;
		}
		if(imgCount<=0){
			alert('请至少上传一张图片');
			return false;
		}
		if($('#discoveryType').val() == ''){
			alert('请选择发现的类别');
			return false;
		}
		if (!$('#discoveryForm').validate().form()) {
			return false;
		}
		data = $.ajaxSubmit('discoveryForm');
		data = $.parseJSON(data);
		if(data.responseCode == '00'){
			alert("操作成功");
			cancel();
		}
	}
	
</script>

