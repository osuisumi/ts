<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<tag:mainLayout>
	<div id="g-bd">
		<div class="f-auto">
			<div class="g-res-bd">
				<div class="m-crm">
					<span class="txt">您当前的位置： </span>
					<a onclick="home()" title="首页" class="u-goto-index"> <i class="u-sHome-ico"></i></a> 
					<span class="trg">&gt;</span> 
					<a href="${retUrl}">资源</a> 
					<span class="trg">&gt;</span> 
					<em>${resource.title }</em> 
				</div>
				<div class="g-frame-mn one-spc">
					<div class="m-res-detail">
						<div id="viewTitle" class="m-res-name">
							<h2 class="res-tit tit" style="width: 600px;">
								<i class="u-ico"></i>${resource.title }
							</h2>
							<div class="u-res-info">
								<div class="u-small-stars">
									<c:forEach begin="1" end="${resource.resourceExtend.evaluateResult }" >
										<i class="u-full"></i> 
									</c:forEach>
									<c:if test="${resource.resourceExtend.evaluateResult % 1 > 0 }">
										<i class="u-half"></i> 
									</c:if>
									<c:forEach begin="1" end="${5 - resource.resourceExtend.evaluateResult }" >
										<i class="u-null"></i>
									</c:forEach>
								</div>
								<p>
									(评价数: ${resource.resourceRelations[0].replyNum }) <span>|</span> 
									浏览数: ${resource.resourceRelations[0].browseNum } <span>|</span> 
									下载数: ${resource.resourceRelations[0].downloadNum }
								</p>
							</div>
							<c:if test="${resource.resourceRelations[0].relation.type eq 'competition' }">
							<div class="u-tp-info attitude_num">
                                <p class="u-num">得票数：<span class="sup_num">${resource.resourceRelations[0].voteNum }</span></p>
                                <p class="u-tp"><a onclick="vote('${resource.id}','${resource.resourceRelations[0].relation.id}',this)"><i></i>投一票</a></p>
                            </div>
                            </c:if>
						</div>
						<div class="am-opa1">
							<c:if test="${resource.creator.id eq sessionScope.loginer.id }">
								<a onclick="editResource('${resource.id}')" class="au-edit"><i class="au-edit-ico"></i>编辑</a>
	                        	<a onclick="deleteResource('${resource.id}', '${retUrl}')" class="au-delete"><i class="au-delete-ico"></i>删除</a>
							</c:if>
	                    </div>
						<div class="m-res-con">
							<tag:previewFile url="${resource.fileInfos[0].url }" />
						</div>
						<div class="m-res-do">
							<div class="res-do-lt">
								<a onclick="downloadFile('${resource.fileInfos[0].id}','${resource.fileInfos[0].fileName}','resources','${resource.id }')" class="u-btn-com u-download"><i></i>下载文档</a>
								<!-- <a href="javascript:void(0);" class="u-btn-com u-collect"><i></i>收藏</a> -->
							</div>
						</div>
						<div class="g-mn-mod" style="margin-bottom: 0;">
							<div class="g-share-mod">
								<div class="m-mn-tt m-detail-tt">
									<div class="u-share-box">
										<!-- <div class="share-box-lt">
											<p>
												<span>分享到：</span>
											<div class="share-wrap">
												<div class="bdsharebuttonbox share-con">
													<a href="#" class="bds_more" data-cmd="more"></a>
													<a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
													<a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a>
													<a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a>
													<a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a>
													<a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a>
												</div>
											</div>
											</p>
										</div> -->
										<div class="share-box-rt attitude_num">
	<!-- 										<a href="javascript:void(0);">收藏</a> <a href="javascript:void(0);" class="u-sup" id="u-sup"> <i class="u-ding"></i> <span id="sup-num">6</span> <span class="u-point">来点个赞吧，这个发现更多人知道。<i></i></span> <span class="addNum">+1</span>
											</a> -->
											<a id="followBtn${resource.id}">收藏</a>
											<a id="cancelFollowBtn${resource.id}">取消收藏</a>
											<tag:collect followEntityId="${resource.id }" followEntityType="resource"  />
											<a onclick="attitude_support('${resource.id}','resource',this)" class="u-sup agree" id="u-sup"> <i class="u-ding"></i> <span id="sup-num" class="sup_num">${resource.resourceRelations[0].supportNum}</span> <span class="u-point">来点个赞吧，这个发现更多人知道。<i></i></span> <span class="addNum">+1</span>
											</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<jsp:include page="/WEB-INF/views/comment/comment.jsp">
						<jsp:param name="relationId" value="${resource.id }" />
						<jsp:param name="relationType" value="resources"/>
						<jsp:param name="isEvaluate" value="true"/>
					</jsp:include>
				</div>
				<!--end g-frame-mn-->
				<div class="g-frame-sd one-spc">
					<div class="g-btn-mod">
						<a onclick="goLoginForAddResource()" class="u-bSrh-btn u-cont-btn u-upl-btn"> <strong> <i class="u-upload-bg-ico"></i>上传我的资源
						</strong>
							<p>已有 ${numMap.teacherNum } 名教师，贡献 ${numMap.resourceNum } 套资源</p>
						</a>
					</div>
					<div class="g-sd-mod">
						<div class="m-match-seek">
							<div class="m-people-intro">
								<div class="u-head-img">
									<a href="javascript:void(0);">
										<tag:avatar userId="${resource.creator.id }" avatar="${resource.creator.avatar }" />
									</a>
								</div>
								<div class="u-pp-txt">
									<a href="javascript:void(0);">${resource.creator.realName }</a>
									<p>贡献于：${sipc:formatDate(resource.createTime, 'yyyy/MM/dd HH:mm') }</p>
								</div>
								<p class="more-intro">${resource.summary }</p>
							</div>
							<div class="m-sd-dt m-intro-con">
								<c:choose>
									<c:when test="${resource.type eq 'sync' }">
										<c:if test="${not empty resource.resourceExtend.type }">
											<p>类别：${dict:getEntryName('RESOURCE_SYNC_TYPE', resource.resourceExtend.type) }</p>
										</c:if>
										<c:if test="${not empty resource.resourceExtend.stage }">
											<p>学段：${tb:getEntryName('STAGE', resource.resourceExtend.stage) }</p>
										</c:if>
										<c:if test="${not empty resource.resourceExtend.subject }">
											<p>学科：${tb:getEntryName('SUBJECT', resource.resourceExtend.subject) }</p>
										</c:if>
										<c:if test="${not empty resource.resourceExtend.grade }">
											<p>学段：${tb:getEntryName('GRADE', resource.resourceExtend.grade) }</p>
										</c:if>
										<c:if test="${not empty resource.resourceExtend.tbVersion }">
											<p>版本：${tb:getEntryName('VERSION', resource.resourceExtend.tbVersion) }</p>
										</c:if>
										<c:if test="${not empty resource.resourceExtend.section }">
											<p>章节：${tb:getEntryName('SECTION', resource.resourceExtend.section) }</p>
										</c:if>
									</c:when>
									<c:otherwise>	
										<c:if test="${not empty resource.resourceExtend.type }">
											<p>类别：${dict:getEntryName('RESOURCE_CLASSIFY_TYPE', resource.resourceExtend.type) }</p>
										</c:if>
										<c:if test="${not empty resource.resourceExtend.post }">
											<p>岗位：${dict:getEntryName('POST', resource.resourceExtend.post) }</p>
										</c:if>
									</c:otherwise>
								</c:choose>
								<c:if test="${not empty resource.resourceExtend.prize}">
									<c:choose>
										<c:when test="${dict:getEntryName('RESOURCE_PRIZE',resource.resourceExtend.prize) eq '一等奖'}">
											<p class="u-praise u-first">奖项：<i></i>${dict:getEntryName('RESOURCE_PRIZE',resource.resourceExtend.prize) }</p>
										</c:when>
										<c:when test="${dict:getEntryName('RESOURCE_PRIZE',resource.resourceExtend.prize) eq '二等奖'}">
											<p class="u-praise u-second">奖项：<i></i>${dict:getEntryName('RESOURCE_PRIZE',resource.resourceExtend.prize) }</p>
										</c:when>
										<c:when test="${dict:getEntryName('RESOURCE_PRIZE',resource.resourceExtend.prize) eq '三等奖'}">
											<p class="u-praise u-third">奖项：<i></i>${dict:getEntryName('RESOURCE_PRIZE',resource.resourceExtend.prize) }</p>
										</c:when>
									</c:choose>
								</c:if>
							</div>
						</div>
					</div>
					<div id="sameResourceDiv">
						<script>
							$(function(){
								if('${resource.type}' == 'sync'){
									$('#sameResourceDiv').load('${ctx}/resource/listSame'
											,'limit=5&paramMap[stage]=${resource.resourceExtend.stage}&paramMap[subject]=${resource.resourceExtend.subject}&paramMap[grade]=${resource.resourceExtend.grade}&paramMap[idNotEquils]=${resource.id}');
								}else{
									$('#sameResourceDiv').load('${ctx}/resource/listSame'
											,'limit=5&paramMap[extendType]=${resource.resourceExtend.type}&paramMap[post]=${resource.resourceExtend.post}&paramMap[idNotEquils]=${resource.id}');
								}
							});
						</script>
					</div>
				</div>
			</div>
		</div>
	</div> 
</tag:mainLayout>
<script>
$(function(){
	commonJs.fn.init();
	changeTab('resource');
});

$(function(){
	changeFileType($('#viewTitle'),'h2','-','h2',0,'h2',0);
})
</script>