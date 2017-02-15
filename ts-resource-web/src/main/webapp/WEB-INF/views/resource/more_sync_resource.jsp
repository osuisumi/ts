<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="m-sel-box">
	<div class="reson-box">
		<p>学段：</p>
		<div class="reson-lst-box">
			<ul id="stageSelect" class="reson-lst">
			</ul>
		</div>
		<a href="javascript:void(0);" class="u-updown">展开全部<i></i></a>
	</div>
	<div class="reson-box">
		<p>学科：</p>
		<div class="reson-lst-box">
			<ul id="subjectSelect" class="reson-lst">
				<li><a href="javascript:void(0);" class="act">全部</a></li>
			</ul>
		</div>
		<a href="javascript:void(0);" class="u-updown">展开全部<i></i></a>
	</div>
	<div class="reson-box">
		<p>年级：</p>
		<div class="reson-lst-box">
			<ul id="gradeSelect" class="reson-lst">
				<li><a href="javascript:void(0);" class="act">全部</a></li>
			</ul>
		</div>
		<a href="javascript:void(0);" class="u-updown">展开全部<i></i></a>
	</div>
	<div class="reson-box">
		<p>版本：</p>
		<div class="reson-lst-box">
			<ul id="tbVersionSelect" class="reson-lst">
			</ul>
		</div>
		<a href="javascript:void(0);" class="u-updown">展开全部<i></i></a>
	</div>
</div>
<div class="m-res-mn">
	<div class="mn-lt">
		<div class="m-mn-tt">
			<h2 class="tt">教材目录</h2>
		</div>
		<div class="m-sd-dt m-mu-dt">
			<ul class="fir-ul" id="sectionSelect">
			</ul>
		</div>
	</div>
	<div class="mn-rt">
		<div class="m-mn-tt">
			<div id="syncTypeDiv" class="m-tabli">
				<script>
					$.get('${ctx}/dict/getEntryList','dictTypeCode=RESOURCE_SYNC_TYPE',function(data){
						$('#syncTypeDiv').empty();
						$('#syncTypeDiv').append('<a href="javascript:void(0);" class="z-crt">全部</a>');
						$(data).each(function(){
							$('#syncTypeDiv').append('<span>|</span> ').append('<a value="'+this.dictValue+'">'+this.dictName+'</a> ');
							$('#syncTypeDiv a').click(function(){
								$('#extendTypeParam').val($(this).attr('value'));
								listMoreResource();
							});
						});
					});
				</script>
			</div>
		</div>
		<form id="listMoreResourceForm" action="${ctx }/resource/listMoreResource">
			<input type="hidden" name="paramMap[type]" value="${searchParam.paramMap.type }">
			<input type="hidden" name="paramMap[relationId]" value="${searchParam.paramMap.relationId }">
			<input type="hidden" id="orderParam" name="orders" value="CREATE_TIME.DESC">
			<input type="hidden" id="subjectParam" name="paramMap[subject]">
			<input type="hidden" id="gradeParam" name="paramMap[grade]">
			<input type="hidden" id="stageParam" name="paramMap[stage]">
			<input type="hidden" id="tbVersionParam" name="paramMap[tbVersion]">
			<input type="hidden" id="sectionParam" name="paramMap[section]">
			<input type="hidden" id="chapterParam" name="paramMap[chapter]">
			<input type="hidden" id="extendTypeParam" name="paramMap[extendType]">
			<input type="hidden" name="paramMap[creator]" value="${searchParam.paramMap.creator }">
			<div id="orderParamDiv" class="m-sort-box">
				<a href="javascript:void(0);" class="first act" orders="CREATE_TIME.DESC">时间</a> 
				<a href="javascript:void(0);" orders="DOWNLOAD_NUM.DESC">下载</a> 
				<a href="javascript:void(0);" orders="BROWSE_NUM.DESC">浏览</a> 
				<a href="javascript:void(0);" orders="EVALUATE_RESULT.DESC">评分</a>
				<script>
					$('#orderParamDiv a').click(function(){
						$('#orderParam').val($(this).attr('orders'));
						listMoreResource();
					});
				</script>
			</div>
			<div class="g-res-con">
				<div id="listMoreResourceDiv">
					
				</div>
			</div>
		</form>
	</div>
</div>
<div id="cloneElementDiv" style="display: none;">
	<ul class="chapterSelect sec-ul"></ul>
	<li class="cloneOption"><i></i><a></a></li>
</div>
<script>
	$(function(){
		initTextBookEntry('act', 'radio'); 
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

		$('#sectionSelect').on('click', 'li a' ,function() {
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
		
		$(".m-sort-box").on('click', 'a', function(){
	        $(this).addClass("act").siblings().removeClass("act");
	    });

		$(".btn-tb").click(function() {
			$(this).addClass("act").parent().siblings().children(".btn-tb").removeClass("act");
		});

	});
</script>