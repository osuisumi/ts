<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sipc" uri="/WEB-INF/tld/sip-core-tag.tld" %>
<%@ attribute name="timePeriod" type="com.haoyu.sip.core.entity.TimePeriod" required="true" %>
<%@ attribute name="label" type="java.lang.String" required="true" %>
<c:choose>
	<c:when test="${not empty timePeriod}">
		<c:choose>
			<c:when test="${sipc:hasBegun(timePeriod.startTime)}">
				<c:choose>
					<c:when test="${not empty timePeriod.endTime and sipc:hasEnded(timePeriod.endTime)==false}">
						<div class="am-count-down in">
							<span class="txt">离${label}结束还剩：</span>
							<div class="t-time">${sipc:prettyEndTime(timePeriod.endTime)}</div>
						</div>
					</c:when>
					<c:when test="${not empty timePeriod.endTime and sipc:hasEnded(timePeriod.endTime) }">
						<div class="am-count-down end">
								<p class="h-txt">${label}已结束</p>
						</div>
					</c:when>
					<c:otherwise>
						<div class="am-count-down in">
							<p class="h-txt">${label}进行中</p>
						</div>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:when test="${not empty timePeriod.startTime and sipc:hasBegun(timePeriod.startTime)==false}">
				<div class="am-count-down">
						<span class="txt">离${label}开始还有：</span>
						<div class="t-time">${sipc:prettyStartTime(timePeriod.startTime)}</div>
				</div>
			</c:when>
			<c:otherwise>				
				<div class="am-count-down in">
					<p class="h-txt">${label}进行中</p>
				</div>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		<div class="am-count-down in">
				<p class="h-txt">${label}进行中</p>
		</div>
	</c:otherwise>
</c:choose>
