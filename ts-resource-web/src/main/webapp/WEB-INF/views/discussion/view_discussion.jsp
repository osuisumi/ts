<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="hasMasterRole" value="${sipc:getBooleanFromRequest(pageContext.request, 'hasMasterRole') }" />
<c:set var="hasMemberRole" value="${sipc:getBooleanFromRequest(pageContext.request, 'hasMemberRole') }" /> 
<c:set var="inCurrentDate" value="${sipc:getBooleanFromRequest(pageContext.request, 'inCurrentDate') }" />
<%-- <c:set var="relationEntity" value="${discussion.discussionRelations[0]}" />
<c:set var="relationId" value="${discussion.discussionRelations[0].relation.id}" /> --%>
<div id="g-bd" class="f-auto">
	<div class="innerPage">
		<div class="g-crm">
			<div class="m-crm">
				<a class="go-home" href="${ctx }/index.do"><i class="u-home"></i>首页</a>
				<span>&gt;</span>
				<a onclick="viewWorkshop('${discussion.discussionRelations[0].relation.id}')" class="backName"></a>
				<span>&gt;</span>
				<strong>教学研讨</strong>
			</div>
			<script>
				$('.backName').text($('#backName').val());
			</script>
		</div>			
		<div class="g-innerPage-dt">
			<div class="ag-activity">
				<div class="ag-activity-bd">
					<div class="ag-cMain">
		            	<div class="ag-main-hd">
		                    <div class="am-title">
								<h2>
									<span class="aa-type-txt">【教学研讨】</span> 
									<span class="txt">${discussion.title }</span>
								</h2>
							</div>
							<div class="am-title-info f-cb">
								<div class="c-infor">
									<span class="txt">发起人：${discussion.creator.realName }</span> 
									<span class="line">|</span>
									<span class="txt">参与人数：${discussion.discussionRelations[0].participateNum }</span> 
									<span class="line">|</span> 
									<span class="txt">被阅读数：${discussion.discussionRelations[0].browseNum }</span>
								</div>
								<div class="am-mnTag-lst">
		                            <span class="au-tag-type type1">
										<i class="au-bulb-ico"></i>活动
									</span>
									<span id="tagId" class="au-tt-type"></span>
									<tag:viewTag relationId="${discussion.id }" />
		                        </div>
							</div>
							<div class="am-main-r">
		                    	<tag:timePeriod timePeriod="${discussion.discussionRelations[0].timePeriod}" label="活动"/>
			                    <div class="am-opa1">
			                    	<!-- <a href="javascript:void(0);" class="au-top">
			                    		<i class="au-top-ico"></i>置顶
			                    	</a>
			                    	<a href="javascript:void(0);" class="au-delete">
			                    		<i class="au-delete-ico"></i>删除
			                    	</a> -->
			                    	<c:if test="${hasMasterRole or ((discussion.creator.id eq sessionScope.loginer.id) and discussion != 'published' )}">
										<a onclick="editActivity($('#aid').val())" class="ua-edit"> <i class="au-edit-ico"></i>编辑</a>
										<a onclick="deleteDiscussion('${discussion.id}')" class="au-delete"> <i class="au-delete-ico"></i>删除</a>
									</c:if>
			                    </div>
		                    </div>
							<div class="ag-detail-txt ag-detail-txt1">
								<p class="ag-detail-txt1">${discussion.content }</p>
							</div>
						</div>
						<c:if test="${not empty discussion.fileInfos }">
							 <div class="ag-adjunct-cont">
			                	<div class="am-mod-tt">
			                		<h3 class="t1">附件</h3>
			                	</div>
								<div class="ag-adjunct-dt">
	                				<ul id="fileUl" class="am-file-lst f-cb">
										<c:forEach items="${discussion.fileInfos }" var="file">
											<li class="fileBlock fileLi">
												<div class="am-file-block am-file-word">
													<div class="file-view fileIcon">
														<div class="au-file-word" url="${file:getFileUrl(file.url) }" ></div>
													</div>
													<b class="f-name fileName"><span>${file.fileName }</span></b>
													<div class="f-info">
														<span class="u-name">${file.creator.realName }</span> 
														<span class="time">${sipc:formatDate(file.createTime,"yyyy/MM/dd")}</span>
													</div>
													<div class="f-opa">
														<c:if test="${hasMasterRole  or hasMemberRole or (discussion.creator.id eq sessionScope.loginer.id) }">
															<a class="download" onclick="downloadFile('${file.id}','${file.fileName }')">下载</a> 
														</c:if>
														<c:if test="${hasMasterRole }">
															<!-- <a class="rename">重命名</a>  -->
															<a class="delete" onclick="deleteFile(this, '${file.id}')">删除</a>
														</c:if>
													</div>
													<input type="hidden" class="fileId" value="${file.id }">
													<%-- <div class="rename-box">
														<input type="text" class="rename-ipt" id="fileNameText_${file.id }">
														<div>
															<a class="confirm" onclick="updateFile('${file.id}',$('#fileNameText_${file.id }').val())">确定</a> 
															<a class="cancel">取消</a>
														</div>
													</div> --%>
												</div>
											</li>
										</c:forEach>
									</ul>
								</div>
							</div>
						</c:if>
						<div id="listDiscussionPostDiv">

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	$(function(){
		initFileResourceUploader();
		listDiscussionPost();
		
		initFileResourceMng($('#fileUl'));
	});	
	
	function deleteDiscussion(id) {
		confirm('确认要删除该附件吗?',function(){
			$.ajaxDelete('${ctx}/discussion/'+id,null,function(response){
				if(response.responseCode == '00'){
					viewWorkshop('${discussion.discussionRelations[0].relation.id }');
				}
			});
		})
	}
		
	function listDiscussionPost(){
		$('#listDiscussionPostDiv').load('${ctx}/discussion/post'
				,'orders=CREATE_TIME.DESC&paramMap[discussionRelationId]=${discussion.discussionRelations[0].id}&paramMap[discussionId]=${discussion.id}&paramMap[relationId]=${discussion.discussionRelations[0].relation.id}&'+$('#roleForm').serialize());
	}

	function deleteFile(obj, fileId) {
		confirm('确认要删除该附件吗?',function(){
			$(obj).parents('.fileLi').remove();
			deleteFileRelation(fileId, '${discussion.id}');
		});
	}
	
	function updateFileResource(fileId, fileName){
		updateFile(fileId,fileName);
	}
</script> 