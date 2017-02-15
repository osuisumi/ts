<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!-- 修改了样式和显示方法 	by shisibo start -->
<c:choose>
	<c:when test="${not empty adverts }">
		<ul class="m-bn bn-index">
			<c:forEach items="${adverts}" var="advert">
				<li>
					<c:choose>
						<c:when test="${not empty advert.imageUrl }">
							<img src="${file:getFileUrl(advert.imageUrl) }" alt="">
						</c:when>
						<c:otherwise>
							<img src="${advert.imageLink}" alt="">
						</c:otherwise>
					</c:choose>
				</li>
			</c:forEach>
		</ul>
		<div class="m-bn-focus">
			<c:forEach items="${adverts}" var="advert" varStatus="vs">
				<a href="javascript:void(0);" class="<c:if test='${vs.count == 1 }'>z-crt</c:if>"</a>
			</c:forEach>
		</div>
	</c:when>
	<c:otherwise>
		<ul class="m-bn bn-index">
			<li><img src="css/images/banner-img1.jpg" alt=""></li>
			<li><img src="css/images/banner-img2.jpg" alt=""></li>
		</ul>
		<div class="m-bn-focus">
			<a href="javascript:void(0);" class="z-crt"></a> 
			<a href="javascript:void(0);"></a>
		</div>
	</c:otherwise>
</c:choose>
<!-- 修改了样式和显示方法 	by shisibo end -->

<script type="text/javascript">
	$(function() {
		$('#g-bn').dsTab({
			itemEl : '.m-bn li',
			btnElName : 'm-bn-focus',
			btnItem : 'a',
			currentClass : 'z-crt',
			maxSize : 5,
			changeType : 'fade',
			change : true,
			changeTime : 3000,
			autoCreateTab : false
		});
	})
</script>