<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="g-mn-mod">
	<div class="m-find-box">
		<div class="m-mn-tt">
			<h2 class="tt">精彩发现</h2>
			<span class="ex" style="top: 6px;"><img src="css/images/tt-ex-img1.png" alt="为教学提供新灵感"></span>
		</div>
		<div class="g-mn-dt1">
			<c:choose>
				<c:when test="${not empty discoverys }">
					<ul class="m-figure-lst">
						<c:forEach items="${discoverys }" var="discovery">
							<li>
								<div class="m-figure-block">
									<a onclick="viewDiscovery('${discovery.id}')" class="figure">
										<img src="${file:getFileUrl(discovery.fileInfos[0].url)}" alt="">
									</a>
									<h4 class="tt">
										<a onclick="viewDiscovery('${discovery.id}')">${discovery.title }</a>
									</h4>
									<p class="ex">${discovery.summary }</p>
									<div class="info">
										<a href="javascript:void(0);" class="user"> 
										<tag:avatar userId="${discovery.creator.id}" avatar="${discovery.creator.avatar }"></tag:avatar> <span>${discovery.creator.realName }</span>
										</a> 
										<span class="time">${sipc:prettyTime(discovery.createTime) }</span>
									</div>
								</div>
							</li>
						</c:forEach>
					</ul>
				</c:when>
				<c:otherwise>
					<tag:noContent msg="暂时没有发现"></tag:noContent>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
