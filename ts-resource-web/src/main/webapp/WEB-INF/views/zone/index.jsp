<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<tag:mainLayout>
<input type="hidden" id="item" value="${item[0]}">
<input type="hidden" id="myResourceNum">
<input type="hidden" id="myUploadResourceNum">
<input type="hidden" id="myFollowResourceNum">

<input type="hidden" id="myDiscoveryNum">
<input type="hidden" id="myUploadDiscoveryNum">
<input type="hidden" id="myFollowDiscoveryNum">
<input type="hidden" id="myCompetitionNum">
<input type="hidden" id="myDiscussionNum">

<input type="hidden" id="myActivityNum">



	<div id="g-bd">
		<div class="f-auto">
			<div class="g-res-bd">
				<div class="m-crm">
					<span class="txt">您当前的位置： </span><a href="../index.html" title="首页" class="u-goto-index"> <i class="u-sHome-ico"></i>
					</a> <span class="trg">&gt;</span> <a href="index.html">个人空间</a> <span class="trg">&gt;</span> <em>首页</em>
				</div>
				<div class="g-frame-sd w-240 fl">
					<div class="m-zone-sd">
						<div class="u-sd-head">
							<a href="javascript:void(0);" class="head-img">
								<tag:avatar userId="${sessionScope.loginer.id}" avatar="${sessionScope.loginer.avatar}"></tag:avatar>
							</a>
							<div class="user-info">
								<a href="javascript:void(0);" class="u-name">${sessionScope.loginer.realName}</a>
								<!-- <p class="u-txt">积分：86</p> -->
							</div>
							<!-- <a href="javascript:void(0);" class="u-email"><i>2</i></a> -->
						</div>
						<div class="u-sd-bd">
							<ul class="u-person-lst">
								<li class='z-crt'><a id="myZone" onclick="myZone()"><i class="u-ico u-zone"></i>个人空间</a></li>
								<li><a id="resource" onclick="myResources()"><i class="u-ico u-res"></i>云资源库<span class="myResourceNum"></span></a></li>
								<li><a id="competition" onclick="myCompetition()" ><i class="u-ico u-act"></i>教研活动<span class="myCompetitionNum"></span></a></li>
								<li><a id="discovery" onclick="myDiscovery()"><i class="u-ico u-find"></i>我的发现<span class="myDiscoveryNum"></span></a></li>
								<li><a id="discussion" onclick="myDiscussion()"><i class="u-ico u-talk"></i>我的讨论<span class="myDiscussionNum"></span></a></li>
								<li><a id="myHomePage" onclick="myHomePage()"><i class="u-ico u-zy"></i>我的主页</a></li>
								<li><a id="account" onclick="myAccount()"><i class="u-ico u-set"></i>账号设置</a></li>
								<li><a id="password" onclick="modifyPassword()"><i class="u-ico u-psw"></i>修改密码</a></li>
								<li><a id="logout" href="${ctx }/logout.do"><i class="u-ico u-exit"></i>退出</a></li>
							</ul>
						</div>
					</div>
				</div>
				<div id="zoneContend" class="g-frame-mn w-710 fr">
				
				</div>
			</div>
		</div>
	</div>
</tag:mainLayout>
<script type="text/javascript">
	$(function(){
		changeTab();			
		
		$('.u-person-lst a').on('click',function(){
			$('.u-person-lst li').attr('class','');
			$(this).parent('li').attr('class','z-crt');
		});
	})

	function myResources(){
		$('#zoneContend').load("${ctx}/zone/myResources/index");
	}
	
	
	function myDiscovery(){
		$('#zoneContend').load("${ctx}/zone/myDiscovery/index");
	}
	
	function myZone(){
		$('#zoneContend').load("${ctx}/zone/myZone/index");
	}
	
	function myAccount(){
		$('#zoneContend').load("${ctx}/zone/user?id=${sessionScope.loginer.id}");
	}
	
	function myCompetition(){
		$('#zoneContend').load("${ctx}/zone/myCompetition/index");
	}
	
	function modifyPassword(){
		$('#zoneContend').load("${ctx}/zone/password");
	}
	
	function myHomePage(){
		window.location.href = "${ctx}/zone/personal/homepage?userId=${sessionScope.loginer.id}";
	}
	
	function myDiscussion(){
		$('#zoneContend').load("${ctx}/zone/myDiscussion/list","paramMap[creator]=${sessionScope.loginer.id}&paramMap[relationType]=board");
	}
	
	
	$(function(){
		$.post("${ctx}/zone/listData/zoneInfo",{
			"paramMap[creator]":"${sessionScope.loginer.id}",
			"paramMap[creatorOrFollowCreator]":"${sessionScope.loginer.id}",
			"paramMap[followCreator]":"${sessionScope.loginer.id}"
		},function(response){
			$('#myResourceNum').val(response.resourceNum);
			$('#myUploadResourceNum').val(response.myUploadResourceNum);
			$('#myFollowResourceNum').val(response.myFollowResourceNum);
			$('#myDiscoveryNum').val(response.discoveryNum);
			$('#myUploadDiscoveryNum').val(response.myUploadDiscoveryNum);
			$('#myFollowDiscoveryNum').val(response.myFollowDiscoveryNum);
			$('#myCompetitionNum').val(response.myCompetitionNum);
			$('#myDiscussionNum').val(response.myDiscussionNum);
			$('.myDiscussionNum').text("("+$('#myDiscussionNum').val()+")");
			$('.myResourceNum').text("("+$('#myResourceNum').val()+")");
			$('.myDiscoveryNum').text("("+$('#myDiscoveryNum').val()+")");
			$('.myCompetitionNum').text("("+$('#myCompetitionNum').val()+")");
			
			goItem();
		});
	})
	
	function goItem(){
		var item = $('#item').val();
		if(item == 'myZone'){
			$('#myZone').click();
		}else if(item == 'resource'){
			$('#resource').click();
		}
		else if(item == 'activity'){
			$('#activity').click();
		}
		else if(item == 'discovery'){
			$('#discovery').click();
		}
		else if(item == 'account'){
			$('#account').click();
		}
		else if(item == 'password'){
			$('#password').click();
		}
		else{
			$('.u-person-lst a').eq(0).click();
		}
	}
	
	
	
</script>
