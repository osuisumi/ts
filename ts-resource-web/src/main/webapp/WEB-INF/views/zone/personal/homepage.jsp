<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<tag:mainLayout>
<div id="g-bd">
	<div class="f-auto">
		<div class="g-res-bd">
			<div class="m-crm">
				<span class="txt">您当前的位置： </span>
				<a href="../index.html" title="首页" class="u-goto-index">
					<i class="u-sHome-ico"></i>
				</a> 
				<span class="trg">&gt;</span> <em>${user.realName }的主页</em>
			</div>
			<div class="g-layout-mod">
				<div id="user-panel">
					<div class="infor clearfix">
						<a class="u-img"> 
							<tag:avatar avatar="${user.avatar }" userId="${user.id }"></tag:avatar>
						</a>
						<div class="u">
							<span class="name">${user.realName }</span><i class="sex-ico woman user-ico"></i>
						</div>
						<div class="site">
							<p>${user.department.deptName }</p>
						</div>
							<div class="opa clearfix subscribe" id="${user.id }">
								<c:if test="${sessionScope.loginer.id eq user.id }">
									<span style="cursor: pointer" onclick="zoneIndex('account')" href="javascript:void(0);" class="u-btn-dy" >编辑资料</span>
								</c:if>
							</div>
					</div>
				</div>
			</div>
			<div class="g-frame-sd w-240 fl">
				<div class="space-menu">
					<a onclick="loadPersonalContent('resource',this)" class="menu-t2"> <i class="menus-ico"></i> <span class="txt">教育资源</span> <em>(${personalInfo.myUploadResourceNum })</em>
					</a> <a onclick="loadPersonalContent('discovery',this)" class="menu-t3"> <i class="menus-ico"></i> <span class="txt">精彩发现</span> <em>(${personalInfo.myUploadDiscoveryNum })</em>
					</a> <a onclick="loadPersonalContent('competition',this)" class="menu-t4"> <i class="menus-ico"></i> <span class="txt">参与的活动</span> <em>(${personalInfo.myCompetitionNum })</em>
					</a> <a onclick="loadPersonalContent('discussion',this)"  class="menu-t5"> <i class="menus-ico"></i> <span class="txt">发表的讨论</span> <em>(${personalInfo.myDiscussionNum })</em>
					</a>
				</div>
				<div class="side-teacher-space" id="subscribeUserDiv">

				</div>
			</div>
			<div class="g-frame-mn w-710 fr">
				<div class="m-zone-mn">
					<!-- ajax列表 -->
					<div id="personalContent">
					
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</tag:mainLayout>
<script>
	$(function() {
		$(".u-person-lst li").click(function() {
			$(this).addClass("z-crt").siblings().removeClass("z-crt");
			;
		});

	})
</script>
<script>
	scroll();

	//订阅内容左右滚动
	function scroll() {
		var toLt = $("#toLt"); //获取左按钮
		var toRt = $("#toRt"); //获取右按钮
		var par = $("#u-scroll"); //获取要滚动的元素
		var len = par.children('.u-lst').length;
		var offsetW = 96; //设置每次滚动的偏移量                 
		toRt.on('click', function() {
			//获取滚动元素当前的left值
			var lt = parseInt(par.css("left"));
			//如果滚动到最后一个子元素，设置向右按钮为不可用状态
			if (lt > ((len - 1) * (-offsetW))) {
				if (!par.is(":animated")) {
					par.animate({
						'left' : "-=" + offsetW + "px"
					}, 300);
				}
			} else {
				toRt.attr("disabled", "true");
			}
		});
		toLt.on('click', function() {
			//获取滚动元素当前的left值
			var lt = parseInt(par.css("left"));
			//如果滚动到第一个子元素，设置向左按钮为不可用状态
			if (lt < 0) {
				if (!par.is(":animated")) {
					par.animate({
						'left' : "+=" + offsetW + "px"
					}, 300);
				}
			} else {
				toLt.attr("disabled", "true");
			}
		});
	}

	$("#open-layer").on('click', function() {
		//alert("test");
		layer.open({
			type : 2,
			title : [ '订阅设置', 'font-size:18px;color:#1a1d29;' ],
			maxmin : false,
			shadeClose : false, //点击遮罩关闭层
			area : [ '640px', '520px' ],
			closeBtn : 1,
			content : '../layer-Frame.html'
		});
		//layer.tips('Hello tips!','#open-layer');
	});
	//}();

	function loadPersonalContent(type, a) {
		$(a).closest('div').find('a').removeClass('z-crt');
		$(a).addClass('z-crt');
		if (type == 'resource') {
			$('#personalContent').load('${ctx}/zone/personal/resource', 'paramMap[typeNotEquils]=discovery&paramMap[creator]=${user.id}&limit=12&orders=CREATE_TIME.DESC');
		} else if (type == 'competition') {
			$('#personalContent').load('${ctx}/zone/personal/competition', 'limit=10&orders=CREATE_TIME.DESC&paramMap[creator]=${user.id}');
		} else if (type == 'discovery') {
			$('#personalContent').load('${ctx}/zone/personal/discovery', 'limit=10&orders=CREATE_TIME.DESC&paramMap[creator]=${user.id}&paramMap[type]=discovery');
		}else if(type=='discussion'){
			$('#personalContent').load('${ctx}/zone/personal/discussion', 'limit=10&orders=CREATE_TIME.DESC&paramMap[creator]=${user.id}&paramMap[relationType]=board');
		}
	}

	$(function() {
		$('.space-menu a').eq(0).click();
	})
	
	//订阅用户
	$(function() {
		$('#subscribeUserDiv').load('${ctx}/zone/personal/listSubscribeUser','userId=${user.id}&limit=5');
	})

</script>
