<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:if test="${not empty resources }">
	<div class="g-sd-mod">
		<div class="m-sd-tt">
			<h3 class="tt">猜你喜欢的</h3>
		</div>
		<div class="m-sd-dt">
			<ul class="m-arr-lst m-like-lst work-show">
				<c:forEach items="${resources }" var="resource">
					<li class="m-arr-block"><i class="type-ico"></i>
						<h4 class="tt">
							<a onclick="viewResource('${resource.id}')">${resource.title }</a>
						</h4>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
</c:if>
<script type="text/javascript">
changeFileType($('.m-like-lst'),"li"," ","li",0,"a",0);
</script>

