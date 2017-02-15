<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="g-sd-mod">
	<div class="m-sd-rank">
		<div class="m-sd-tt">
			<h3 class="tt">本周话题排行</h3>
		</div>
		<div class="m-sd-dt">
			<ul class="m-arr-lst tab" style="display: block;">
				<c:forEach items="${discussions}" var="discussion" varStatus="index">
					<c:choose>
						<c:when test="${index.index eq 0 }">
							<li class="m-arr-block first"><strong class="rank">1</strong>
								<h4 class="tt">
									<a onclick="viewBoardDiscussion('${discussion.id }')">${discussion.title }</a>
								</h4>
							</li>
						</c:when>
						<c:when test="${index.index eq 1 }">
							<li class="m-arr-block second"><strong class="rank">2</strong>
								<h4 class="tt">
									<a onclick="viewBoardDiscussion('${discussion.id }')">${discussion.title }</a>
								</h4>
							</li>
						</c:when>
						<c:when test="${index.index eq 2 }">
							<li class="m-arr-block thirdly"><strong class="rank">3</strong>
								<h4 class="tt">
									<a onclick="viewBoardDiscussion('${discussion.id }')">${discussion.title }</a>
								</h4>
							</li>
						</c:when>
						<c:otherwise>
							<li class="m-arr-block"><strong class="rank">${index.index+1 }</strong>
								<h4 class="tt">
									<a onclick="viewBoardDiscussion('${discussion.id }')">${discussion.title }</a>
								</h4>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
		</div>
	</div>
</div>