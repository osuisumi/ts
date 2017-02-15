<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:choose>
	<c:when test="${not empty  subUsers}">
		<div class="u-mod-tit">
			<div class="title">
				<span class="lb"></span>
				<h3>订阅信息</h3>
			</div>
			<a onclick="nextPage()" href="javascript:void(0);" class="more"> 更多<i class="more-ico user-ico"></i>
			</a>
		</div>
		<input id="totalCount" type="hidden" value="${paginator.totalCount }">
		<input id="nowPage" type="hidden" value="${paginator.page }">
		<input id="limit" type="hidden" value="${paginator.limit}">
		<div class="detail">
			<form id="subscribeUsersForm" action="${ctx}/zone/personal/listSubscribeUser">
				<input type="hidden" value="${userId }" name="userId"> <input type="hidden" value="${limit}" name="limit"> <input id="nextPage" type="hidden" value="page" name="page">
				<ul class="user-listing">
					<c:forEach items="${subUsers}" var="user">
						<li class="block">
							<div class="user-list-mod img-mod">
								<a href="javascript:void(0);" class="img"> <tag:avatar avatar="${user.avatar }" userId="${user.id }"></tag:avatar>
								</a>
								<div class="infor">
									<div class="name">
										<a href="javascript:void(0);">${user.realName }</a>
									</div>
									<p class="site">${user.department.deptName }</p>
								</div>
								<div class="opa-block subscribe" id="${user.id }"></div>
							</div>
						</li>
					</c:forEach>
				</ul>
			</form>
		</div>
	</c:when>

</c:choose>
<script>
	$(function() {
		loadSubscribeStat();
	})

	function loadSubscribeStat() {
		//订阅用户列表
		var subDivs;
		var userId = '${userId}';
		var loginer = '${sessionScope.loginer.id}';
		if (userId == loginer) {
			subDivs = $('.user-listing .subscribe');
		} else {
			subDivs = $('#user-panel .subscribe');
		}
		var ids = '';
		$.each(subDivs, function(i, subDiv) {
			if (ids == '') {
				ids = $(subDiv).attr('id');
			} else {
				ids = ids + ',' + $(subDiv).attr('id');
			}
		});
		$.get('${ctx}/follows/isFollow', {
			'userId' : '${sessionScope.loginer.id}',
			'relationIds' : ids,
			'type' : 'subscribe_user'
		}, function(response) {
			$.each(response, function(key, value) {
				var subDiv = $('#' + key);
				if (value == true) {
					addUnfollowBtn(subDiv);
				} else {
					addFollowBtn(subDiv);
				}
			})
		})
	}

	function addFollowBtn(subDiv) {
		if ($(subDiv).find('a').size() < 1) {
			$(subDiv).append('<a onclick="sub(this)" href="javascript:void(0);" class="u-btn-dy">订阅</a>');
		}
	}

	function addUnfollowBtn(subDiv) {
		if ($(subDiv).find('a').size() < 1) {
			$(subDiv).append('<a onclick="unSub(this)" href="javascript:void(0);" class="u-btn-dy">取消订阅</a>');
		}
	}

	function sub(a) {
		var subDiv = a.closest('div');
		goLogin(function() {
			$.post('${ctx}/follows', {
				'followEntity.id' : $(subDiv).attr('id'),
				'followEntity.type' : 'subscribe_user'
			}, function(response) {
				if (response.responseCode == '00') {
					$(a).remove();
					addUnfollowBtn(subDiv);
				}
			});
		});
	}

	function unSub(a) {
		var subDiv = a.closest('div');
		goLogin(function() {
			$.ajaxDelete('${ctx}/follows/deleteByUserAndFollowEntity', "followEntity.id=" + $(subDiv).attr('id') + "&followEntity.type=subscribe_user&creator.id=${sessionScope.loginer.id}", function(response) {
				if (response.responseCode == '00') {
					$(a).remove();
					addFollowBtn(subDiv);
				}
			});
		});
	}

	function nextPage() {
		var nowPage = $('#nowPage').val();
		var total = $('#totalCount').val();
		var limit = $('#limit').val();
		if (parseInt(limit) * parseInt(nowPage) >= total) {
			alert("没有更多了");
			return;
		}
		$('#nextPage').val(parseInt(nowPage) + 1);
		$.ajaxQuery('subscribeUsersForm', 'subscribeUserDiv');
	}
</script>