<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<tag:mainLayout>
	<span id="discussionForm">
		<input id="discussionId" type="hidden" value="${discussion.id}">
		<input id="relationId" type="hidden" value="${discussion.discussionRelations[0].relation.id}">
		<input id="relationType" type="hidden" value="${discussion.discussionRelations[0].relation.type}">
		<input id="relation_Id" type="hidden" value="${discussion.discussionRelations[0].id}">
		<input id="targetId" type="hidden" value="${targetId[0]}">
	</span>
	<div id="g-bd">
		<div class="f-auto">
			<div class="g-circle-wp">
				<div class="m-crm">
					<span class="txt">您当前的位置： </span><a onclick="home()" title="首页" class="u-goto-index"> <i class="u-sHome-ico"></i>
					</a> <span class="trg">&gt;</span> <a href="${retUrl}">社区</a> <span class="trg">&gt;</span> <em>讨论详情</em>
				</div>
				<div class="g-mn-mod">
					<div class="g-circle-detail w_discuss_con">
<!-- 						<div class="hd_dis">
							<div class="m-jump-page1">
								<a href="javascript:void(0);" class="return-lst">返回列表</a> <a href="javascript:void(0);" class="prev" title="上一页">上一页</a> <a href="javascript:void(0);" class="z-crt">1</a> <a class="cur" href="javascript:void(0);">2</a> <a href="javascript:void(0);">3</a> <a href="javascript:void(0);">4</a> <a href="javascript:void(0);">5</a> <a href="javascript:void(0);">6</a> <a href="javascript:void(0);">...9</a> <a href="javascript:void(0);" class="next" title="下一页">下一页</a>
							</div>
							<div class="btn_dis">
								<a href="javascript:void(0);" class="u-btn-com u-publish">回复</a>
							</div>
						</div> -->
						<div class="mod">
							<div class="hd_tit">
								<h2 class="tit">${discussion.title}</h2>
								<p class="cz">[${discussion.discussionRelations[0].replyNum}回复 / ${discussion.discussionRelations[0].browseNum}阅读]</p>
							</div>
							<div class="bd_tit">
								<p class="txt1">
									<span class="u-time">发表于：${sipc:prettyTime(discussion.createTime)}</span> <span class="u-floor">楼主</span>
								</p>
								${sipc:split(discussion.content,discussion.id,0)}
								<div class="operate">
									<div class="btn attitude_num">
										<a class="reply" href="javascript:void(0);">回复（${discussion.discussionRelations[0].replyNum}）</a> <a class="agree z-crt" onclick="attitude_support('${discussion.id}','discussion',this)">赞同(<span id="sup_num" class="sup_num">${discussion.discussionRelations[0].supportNum}</span>)</a>
									</div>
								</div>
							</div>
						</div>
						<div id="discussionPostDiv"></div>
						
<!-- 						<div class="page_tu">
							<div class="m-jump-page1">
								<a href="javascript:void(0);" class="return-lst">返回列表</a> <a href="javascript:void(0);" class="prev" title="上一页">上一页</a> <a href="javascript:void(0);" class="z-crt">1</a> <a class="cur" href="javascript:void(0);">2</a> <a href="javascript:void(0);">3</a> <a href="javascript:void(0);">4</a> <a href="javascript:void(0);">5</a> <a href="javascript:void(0);">6</a> <a href="javascript:void(0);">...9</a> <a href="javascript:void(0);" class="next" title="下一页">下一页</a>
							</div>
						</div> -->
						<div class="mod huifu">
							<c:choose>
								<c:when test="${empty sessionScope.loginer }">
									<div class="m-sd-dt">
										<div class="u-user-logn">
											<p>
												您需要登录后方可评论，请<a onclick="goLoginForDiscussionPost('${discussion.id}')">登录</a>
											</p>
										</div>
									</div>
								</c:when>
								<c:otherwise>
									<div class="col_l">
										<a class="pic" href="#"><tag:avatar userId="${sessionScope.loginer.id}" avatar="${sessionScope.loginer.avatar }"></tag:avatar></a> <a class="name" href="#">${sessionScope.loginer.realName }</a>
									</div>
									<div class="col_r clearfix">
										<div class="editor">
											<script id="editor" type="text/plain" style="width:743px;height:148px;"></script>
										</div>
										<div class="m-pb-btnline" style="padding-bottom: 30px; text-align: right;">
											<input onclick="saveDiscussionPost()" type="submit" class="u-confirm-btn" value="提交">
										</div>
										<script type="text/javascript">
											var ue;
											$(function(){
												UE.delEditor('editor');
												ue = UE.getEditor('editor',{
													toolbars: [
													           [
													               'bold', //加粗
													               'italic', //斜体
													               'underline', //下划线
													               'strikethrough', //删除线
													               'fontborder', //字符边框
													               'horizontal', //分隔线
													               'fontfamily', //字体
													               'fontsize', //字号
													               'justifyleft', //居左对齐
													               'justifyright', //居右对齐
													               'justifycenter', //居中对齐
													               'justifyjustify', //两端对齐
													               'forecolor', //字体颜色
													               'backcolor', //背景色
													               'lineheight', //行间距
													           ]
													       ],
													scaleEnabled: true,
												});
												ue.ready(function() {
												    ue.execCommand('serverparam', {
												        'relations': '${sessionScope.loginer.id}',
												    });
												});
											});
										</script>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</tag:mainLayout>
<script>

	//UE.delEditor('editor');
	//var ue = UE.getEditor('editor');
	$(function(){
		changeTab('board');
		
		loadDiscussionPost();
	})
	
	//加载回复
	function loadDiscussionPost(){
		var targetId = $('#targetId').val();
		if(targetId!=''||targetId!='undefined'){
			$('#discussionPostDiv').load("${ctx}/board/discussion/post?orders=CREATE_TIME&paramMap[discussionRelationId]=${discussion.discussionRelations[0].id}&page="+Math.ceil(targetId/10)+"&paramMap[relationId]=${discussion.discussionRelations[0].relation.id}");
		}else{
			$('#discussionPostDiv').load("${ctx}/board/discussion/post?orders=CREATE_TIME&paramMap[discussionRelationId]=${discussion.discussionRelations[0].id}&paramMap[relationId]=${discussion.discussionRelations[0].relation.id}");
		}
	}
	
	function saveDiscussionPost(){
		var content=ue.getContent();
		var targetId = parseInt($('#totalPage').val())+1;
		$.post("${ctx}/board/discussion/post/save",{
			"discussionUser.discussionRelation.discussion.id":"${discussion.id}",
			"discussionUser.discussionRelation.relation.id":"${discussion.discussionRelations[0].relation.id}",
			"discussionUser.discussionRelation.relation.type":"${discussion.discussionRelations[0].relation.type}",
			"discussionUser.discussionRelation.id":"${discussion.discussionRelations[0].id}",
			"content":content,
			"targetId":targetId
		},function(response){
			if(response.responseCode == '00'){
				ue.setContent('');
				alert('操作成功');
				loadDiscussionPost();
			}
		});
	}	
	
	function goLoginForDiscussionPost(){
		goLogin(function(){
			window.location.href = "${ctx}/board/discussion/"+$('#discussionId').val()+"/view";
			//$('#content').load("${ctx}/board/discussion/"+$('#discussionId').val()+"/view");
		});
	}
	
</script>
