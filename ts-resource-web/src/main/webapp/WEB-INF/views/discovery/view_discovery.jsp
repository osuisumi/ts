<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<tag:mainLayout>
	<div id="wrap">
		<div id="g-bd">
			<div class="f-auto">
				<div class="g-res-bd">
					<div class="m-crm">
						<span class="txt">您当前的位置： </span><a onclick="home()" title="首页" class="u-goto-index"> <i class="u-sHome-ico"></i>
						</a> <span class="trg">&gt;</span> <a href="${retUrl}">发现</a> <span class="trg">&gt;</span> <em>${discovery.title}</em>
					</div>
					<div class="g-frame-mn">
						<div class="g-mn-mod">
							<div class="m-find-detail">
								<div class="m-mn-tt m-detail-tt">
									<h2 class="tt">${discovery.title }</h2>
									<div class="u-find-lst">
										<a id="tagId" class="u-lst">${type}</a>
										<tag:viewTag relationId="${discovery.id}" />
									</div>
									<p class="u-time">${sipc:prettyTime(discovery.createTime)}</p>
								</div>
								<div class="m-mn-dt">
									<p class="u-book-intro">
										<a href="javascript:void(0);" class="user-head-img"><tag:avatar userId="${discovery.creator.id}" avatar="${discovery.creator.avatar }"></tag:avatar><span>${discovery.creator.realName }</span></a>：${discovery.summary}
									</p>
									<div class="u-book-img">
										<a hef="javascript:void(0);"> <c:forEach items="${discovery.fileInfos}" var="fileInfo">
												<img src="${file:getFileUrl(fileInfo.url)}" title="${discovery.fileInfos[0].fileName}">
											</c:forEach>
										</a>
									</div>
									<p class="u-res-url">
										<span>资源网址：</span> <a href="javascirpt:void(0);">${discovery.resourceExtend.previewUrl }</a>
									</p>
									<div class="am-opa1">
										<c:if test="${discovery.creator.id eq sessionScope.loginer.id }">
											<a onclick="editDiscovery('${discovery.id}')" class="au-edit"><i class="au-edit-ico"></i>编辑</a>
	                                    	<a onclick="deleteDiscovery('${discovery.id}')" class="au-delete"><i class="au-delete-ico"></i>删除</a>
										</c:if>
									</div>
								</div>
							</div>
							<div class="g-share-mod">
								<div class="m-mn-tt m-detail-tt">
									<div class="u-share-box">
										<div class="share-box-lt">
											<p>
												<span>分享到：</span>
											<div class="share-wrap">
												<div class="bdsharebuttonbox share-con">
													<a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a>
												</div>
											</div>
											</p>
										</div>
										<div class="share-box-rt attitude_num">
											<!-- 										<a href="javascript:void(0);">收藏</a> <a href="javascript:void(0);" class="u-sup" id="u-sup"> <i class="u-ding"></i> <span id="sup-num">6</span> <span class="u-point">来点个赞吧，这个发现更多人知道。<i></i></span> <span class="addNum">+1</span>
											</a> -->
											<a id="followBtn${discovery.id}">收藏</a> <a id="cancelFollowBtn${discovery.id}">取消收藏</a>
											<tag:collect followEntityId="${discovery.id }" followEntityType="discovery" />
											<a onclick="attitude_support('${discovery.id}','discovery',this)" class="u-sup agree" id="u-sup"> <i class="u-ding"></i> <span id="sup-num" class="sup_num">${discovery.resourceRelations[0].supportNum}</span> <span class="u-point">来点个赞吧，这个发现更多人知道。<i></i></span> <span class="addNum">+1</span>
											</a>
										</div>
									</div>
								</div>
							</div>
							<jsp:include page="/WEB-INF/views/comment/comment.jsp">
								<jsp:param name="relationId" value="${discovery.id }" />
								<jsp:param name="relationType" value="discovery" />
								<jsp:param name="isEvaluate" value="false" />
							</jsp:include>
						</div>
					</div>
					<div class="g-frame-sd">
						<div class="g-btn-mod small">
							<a onclick="loginAddDiscovery()" class="u-bSrh-btn u-cont-btn u-share-big-btn"> <strong> <i class="u-share-ico"></i>分享发现
							</strong>
								<p>
									已有<span id="memberNum">${numMap.teacherNum }</span>人 ，分享<span id="discoveryNum">${numMap.resourceNum }</span>个发现
								</p>
							</a>
						</div>
						<c:if test="${not empty relativeDisCoverys }">
							<div id="relativeDiscoveryDiv" class="g-sd-mod">
								<div class="m-new-find">
									<div class="m-sd-tt">
										<h3 class="tt">你可能感兴趣的</h3>
									</div>
									<div class="m-sd-dt">
										<ul class="m-news-lst">
											<c:forEach items="${relativeDisCoverys}" var="relativeDiscovery">
												<li><a onclick="viewDiscovery('${relativeDiscovery.id}')">${relativeDiscovery.title}</a></li>
											</c:forEach>
										</ul>
									</div>
								</div>
							</div>
						</c:if>
						<c:if test="${not empty  creatorOtherDiscoverys}">
							<div id="creatorOtherDiscoveryDiv" class="g-sd-mod">
								<div class="m-new-find">
									<div class="m-sd-tt">
										<h3 class="tt">作者的其他发现</h3>
									</div>
									<div class="m-sd-dt">
										<ul class="m-news-lst">
											<c:forEach items="${creatorOtherDiscoverys}" var="creatorOtherDiscovery">
												<li><a onclick="viewDiscovery('${creatorOtherDiscovery.id}')">${creatorOtherDiscovery.title}</a></li>
											</c:forEach>
										</ul>
									</div>
								</div>
							</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
</tag:mainLayout>
<script>
	$(function(){
		changeTab('discovery');
	});
	
	function loginAddDiscovery() {
		goLogin(function() {
			addDiscovery();
		});
	}
</script>