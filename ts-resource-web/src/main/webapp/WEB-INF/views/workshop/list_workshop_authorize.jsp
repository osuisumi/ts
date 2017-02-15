<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="hasMasterRole" value="${sipc:getBooleanFromRequest(pageContext.request, 'hasMasterRole') }" />
<c:set var="hasMemberRole" value="${sipc:getBooleanFromRequest(pageContext.request, 'hasMemberRole') }" />
<c:set var="inCurrentDate" value="${sipc:getBooleanFromRequest(pageContext.request, 'inCurrentDate') }" />
<c:forEach items="${resultList}" var="member" end="5">
	<div class="u-img-lis img-lis1">
		<a class="u-pto pto1" href="javascript:void(0);"> 
		<tag:avatar userId="${menber.id}" avatar="${menber.avatar }"></tag:avatar>
		</a>
		<div class="wrap-info-lis">
			<div class="info-lis">
				<span class="u-bor1"></span> <span class="u-bor2"></span> <span class="u-bor3"><a href="javascript:void(0);"><i></i></a></span>
				<div class="info-con">
					<a class="u-info-img" href="javascript:void(0);"><img src="${ctx }/images/headImg1.jpg" alt=""></a>
					<div class="info-txt">
						<div class="txt-top">
							<p class="u-tea">
								<a href="#">${member.realName }</a>（工作坊成员）
							</p>
							<p class="u-tt">${deptName }</p>
						</div>
						<div class="txt-btm">
							<p>
								已参与<a href="#">${member.activityNum }</a>个研修活动
							</p>
							<p>
								已上传<a href="#">${member.resourceNum }</a>个资源
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="zj1-box"></div>
		</div>
		<div class="m-show-zj1">
			<span class="u-bor4"></span> <span class="u-bor5"></span>
		</div>
	</div>
</c:forEach>

