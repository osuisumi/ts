<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="m-sel-box">
	<div class="reson-box">
		<p>工作岗位：</p>
		<div class="reson-lst-box">
			<ul id="postUl" class="reson-lst">
				<script>
					setEntryList_ul('postUl', 'POST', 'postParam');	
					$('#postUl').on('click', 'a', function(){
						listMoreResource();
					});
				</script>
			</ul>
		</div>
		<a href="javascript:void(0);" class="u-updown">展开全部<i></i></a>
	</div>
	<div class="reson-box">
		<p>相关资源：</p>
		<div class="reson-lst-box">
			<ul id="typeUl" class="reson-lst">
				<script>
					setEntryList_ul('typeUl', 'RESOURCE_CLASSIFY_TYPE', 'extendTypeParam');	
					$('#typeUl').on('click', 'a', function(){
						listMoreResource();
					});
				</script>
			</ul>
		</div>
		<a href="javascript:void(0);" class="u-updown">展开全部<i></i></a>
	</div>
</div>
<div class="g-mn-mod" style="padding-bottom: 30px;">
	<div class="m-mn-tt">
		<h2 class="tt">资源</h2>
		<div id="orderParamDiv" class="m-tabli">
			<a href="javascript:void(0);" class="z-crt" orders="CREATE_TIME.DESC">时间</a><span>|</span> 
			<a href="javascript:void(0);" orders="DOWNLOAD_NUM.DESC">下载</a><span>|</span> 
			<a href="javascript:void(0);" orders="BROWSE_NUM.DESC">浏览</a><span>|</span>  
			<a href="javascript:void(0);" orders="EVALUATE_RESULT.DESC">评分</a>
			<script>
				$('#orderParamDiv a').click(function(){
					$('#orderParam').val($(this).attr('orders'));
					listMoreResource();
				});
			</script>
		</div>
	</div>
	<div class="g-res-con">
		<form id="listMoreResourceForm" action="${ctx }/resource/listMoreResource">
			<input type="hidden" name="paramMap[relationId]" value="${searchParam.paramMap.relationId }">
			<input type="hidden" name="orders" value="CREATE_TIME.DESC" id="orderParam">
			<input type="hidden" name="paramMap[type]" value="${searchParam.paramMap.type }">
			<input type="hidden" name="paramMap[post]" value="${searchParam.paramMap.post }" id="postParam">
			<input type="hidden" name="paramMap[extendType]" value="${searchParam.paramMap.extendType }" id="extendTypeParam">
			<input type="hidden" name="paramMap[creator]" value="${searchParam.paramMap.creator }">
			<div id="listMoreResourceDiv">
					
			</div>
		</form>
	</div>
</div>
<script>
	$(function(){
		listMoreResource();
	});

	$(document).ready(function() {
		showall();

		$(".reson-lst a").click(function() { //高亮显示列表项
			$(this).addClass("act").parent().siblings().children().removeClass("act");
		});

		function showall() {
			$(".reson-lst").each(function() { //判断列表的高度来显示或隐藏按钮
				var status = $(this).height();
				// alert(status);
				if (parseInt(status) <= 35) {
					$(this).parent().next().css("display", "none");
				}
			});

			$(".u-updown").click(function() { //点击按钮显示全部列表
				var childH = $(this).prev().children().height();
				var parentH = $(this).prev().height();
				if (childH > 35) {
					if (parentH == 35) {
						$(this).prev().height("inherit");
					} else {
						$(this).prev().height("35px");
					}
				}
			});
		}

		$(".fir-ul li a").click(function() {
			if ($(this).hasClass("act")) {
				$(this).removeClass("act");
			} else {
				$(this).addClass("act").parent().siblings().children("a").removeClass("act");
			}
			$(this).next().slideToggle().parent().siblings().children(".sec-ul").slideUp();

		});
		
		$(".m-tabli").on('click', 'a', function(){
	        $(this).addClass("z-crt").siblings().removeClass("z-crt");
	    });

		$(".btn-tb").click(function() {
			$(this).addClass("act").parent().siblings().children(".btn-tb").removeClass("act");
		});
	});
</script>