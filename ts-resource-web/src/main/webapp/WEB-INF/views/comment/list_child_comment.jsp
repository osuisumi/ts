<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="g-is-comment" style="display: block;">
	<i class="au-comment-trg"></i>
	<ul class="ag-cmt-lst">
		<c:forEach items="${comments }" var="comment">
			<li class="am-cmt-block">
				<div class="c-info">
					<div class="u-user-img">
						<a href="javascript:void(0);"> 
							<tag:avatar userId="${comment.creator.id}" avatar="${comment.creator.avatar}"/>
						</a>
					</div>
					<div class="u-user-info">
						<p class="u-user-name">
							<a href="javascript:void(0);">${comment.creator.realName}</a> <span>${sipc:prettyTime(comment.createTime)}</span>
						</p>
						<div class="u-user-txt">
							<p class="u-pl-txt">${comment.content }</p>
						</div>
					</div>
				</div>
			</li>
		</c:forEach>
	</ul>
	<!-- <a href="javascript:void(0);" class="m-more">加载更多<i></i></a> -->
	<div class="m-comment-box">
		<textarea name="content" class="commentTextarea" placeholder="说一句吧~"></textarea>
		<div class="b">
			<!-- <span class="user"> 
				<img src="../images/headImg5.jpg"> 
				<span>崔圆圆</span>
			</span>  -->
			<a onclick="saveChildComment(this)" class="u-btn-com u-publish-btn">提交</a>
		</div>
	</div>
</div>