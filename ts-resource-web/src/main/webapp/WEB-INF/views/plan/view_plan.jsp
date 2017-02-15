<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<shiro:hasRole name="${plan.planRelations[0].relation.id}_master">
	<c:set var="hasMasterRole" value="true"  />
</shiro:hasRole>

<div id="g-bd" class="f-auto">
	<div class="innerPage">
		<div class="g-crm">
			<div class="m-crm">
				<a class="go-home" href="${ctx }/index.do"><i class="u-home"></i>首页</a> 
				<span>&gt;</span>
				<a onclick="viewWorkshop('${plan.planRelations[0].relation.id}')" class="backName"></a>
				<span>&gt;</span>
				<a onclick="listMorePlan('${plan.planRelations[0].relation.id}')">研修计划</a> 
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
									<span class="aa-type-txt">【研修计划】</span>
									<span class="txt">${plan.title }</span>
								</h2>
							</div>
							<div class="am-title-info f-cb">
		                        <div class="c-infor">
									<span class="txt">发起人：${plan.creator.realName }</span> 
									<span class="line">|</span> 
									<span class="txt">起始时间：${sipc:formatDate(plan.planRelations[0].timePeriod.startTime.getTime(),'yyyy-MM-dd') }</span>至 
									${sipc:formatDate(plan.planRelations[0].timePeriod.endTime.getTime(),'yyyy-MM-dd') }
								</div>
							</div>
							<div class="am-main-r">
			                    <div class="am-opa1">
			                    	<c:if test="${hasMasterRole}">
			                    		<a onclick="editPlan('${plan.id}')" class="au-edit">
				                    		<i class="au-edit-ico"></i>编辑
				                    	</a>
				                    	<a class="au-dlt" onclick="deletePlan('${plan.id}','${plan.planRelations[0].relation.id}')"> 
				                    		<i class="au-dlt-ico"></i>删除
				                    	</a>
			                    	</c:if>
								</div>
							</div>
							<div class="ag-detail-txt ag-detail-txt1">
								<p class="cont-txt">${plan.content }</p>
							</div>
						</div>
						<c:if test="${not empty plan.fileInfos }">
							<div class="ag-adjunct-cont">
			                	<div class="am-mod-tt">
			                		<h3 class="t1">附件</h3>
			                	</div>
								<div class="ag-adjunct-dt">
	                				<ul id="fileUl" class="am-file-lst f-cb">
										<c:forEach items="${plan.fileInfos }" var="file">
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
														<a class="download" onclick="downloadFile('${file.id}','${file.fileName }','plan','${plan.id }')">下载</a> 
														<c:if test="${hasMasterRole}">
															<!-- <a class="rename">重命名</a>  -->
															<a class="delete" onclick="deleteFile(this, '${file.id}')">删除</a>
														</c:if>
													</div>
													<input type="hidden" class="fileId" value="${file.id }">
												</div>
											</li>
										</c:forEach>
									</ul>
								</div>
							</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="editPlanDiv" class="new-plan-layer layer"></div>
<script>
$(function() {
	initFileResourceMng($('#fileUl'));
});

function deleteFile(obj,fileId){
	confirm('确认要删除该附件吗?',function(){
		$(obj).parents('.fileLi').remove();
		deleteFileRelation(fileId,'${resource.id}');
	});
}

</script>