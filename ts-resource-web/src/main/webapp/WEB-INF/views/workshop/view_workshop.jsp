<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<tag:mainLayout_yx>
<shiro:hasRole name="${workshop.id }_master">
	<c:set var="hasMasterRole" value="true" />
</shiro:hasRole>
<shiro:hasRole name="${workshop.id }_assist">
	<c:set var="hasAssistRole" value="true" />
</shiro:hasRole>
<shiro:hasRole name="${workshop.id }_member">
	<c:set var="hasMemberRole" value="true" />
</shiro:hasRole>
<!-- workshoprelation的id属性，跟新menbernum用 -->
<input id="relationId" type="hidden" value="${workshop.workshopRelations[0].id}" />
<div id="hot-workshop-listing" class="space-content-page">
	<div class="g-crm">
		<div class="m-crm">
			<a class="go-home" onclick="home()"><i class="u-home"></i>首页</a> 
			<span>&gt;</span> 
			<a onclick="" id="${workShop.id }_master">工作室</a>
		</div>
	</div>
	<div class="g-dt-bd">
		<div class="m-per-info">
			<div class="per-top">
				<div class="top-lf">
					<div class="u-per-img">
						<c:choose>
							<c:when test="${not empty workshop.imageUrl }">
								<img src="${file:getFileUrl(workshop.imageUrl) }" alt="">
							</c:when>
							<c:otherwise>
								<img src="${ctx}/images/img/defaultWorkshopImg.png" alt="">
							</c:otherwise>
						</c:choose>
					</div>
					<div class="u-per-info">
						<h3>
							${workshop.name }
							<c:if test="${hasMasterRole }">
								<a onclick="editWorkshop('${workshop.id}')"><i></i>编辑</a>
							</c:if>
						</h3>
						<p class="u-fz">
							坊主： <a class="u-tc"> 
								<c:forEach items="${workshop.masters }" var="user">
									${user.realName }&nbsp;&nbsp;
								</c:forEach>
							</a>
						</p>
						<p id="detail-intro" limit="60">
							${workshop.summary }
						</p>
						<div class="detail-intro-wrap">
                            <div class="detail-intro-more">
                                <span class="u-bor1 deta-bor1"></span>
                                <span class="u-bor2 deta-bor2"></span>
                                <p></p>
                            </div>
                        </div>
					</div>
				</div>
				<div class="top-rt">
					<div class="u-cir">
						<strong id="u-mun1" value="">${workshop.workshopRelations[0].planNum }</strong> <span>研修计划</span>
					</div>
					<div class="u-cir">
						<strong id="u-mun2" value="">${workshop.workshopRelations[0].resourceNum }</strong> <span>资源</span>
					</div>
					<div class="u-cir">
						<strong id="u-mun3" value="">${workshop.workshopRelations[0].activityNum }</strong> <span>活动</span>
					</div>
				</div>
			</div>
			<div class="per-bottom">
				<div class="btm-lt">
					<div class="u-head-img">
						<div id="listWorkshopAuthorizeDiv">
					
						</div>
					</div>
					<c:choose>
						<c:when test="${hasMasterRole}">
							<a onclick="authorizeIndex('${workshop.id}')" class="u-cy-num">共有${workshop.workshopRelations[0].memberNum }位成员参与 &gt;</a>
						</c:when>
						<c:otherwise>
							<a  class="u-cy-num">共有${workshop.workshopRelations[0].memberNum }位成员参与 &gt;</a>
						</c:otherwise>
					</c:choose>
					<%-- <span class="u-cy-num">共有<span id="memberNum"></span>${workshop.workshopRelations[0].memberNum }位成员参与 &gt; </span> --%>
				</div>
				<div class="btm-rt">
					<ul>
						<c:choose>
							<%-- <c:when test="${hasMasterRole}">
								<li  class="li-sq"><a onclick="authorizeIndex('${workshop.id}')"><i class="u-sq"></i>成员管理</a></li>
							</c:when> --%>
							<c:when test="${workshop.workshopAuthorize.role eq 'master' }">
							</c:when>
							<c:when test="${workshop.workshopAuthorize.state eq 'apply'  }">
								<li class="li-sq"><a href="#"><i class="u-sq"></i>申请中...</a></li>
							</c:when>
							<c:when test="${workshop.workshopAuthorize.state eq 'pass' }">
								<li id="quit" class="li-tc"><a onclick="quitWorkshop('${workshop.workshopAuthorize.id}','${sessionScope.loginer.id }')"><i class="u-tc"></i>退出工作坊</a></li>
							</c:when>
							<c:when test="${workshop.workshopAuthorize.state eq 'nopass' }">
								<li  class="li-jr"><a ><i class="u-jr"></i>申请失败</a></li>
							</c:when>
							<c:when test="${(empty  workshop.workshopAuthorize.state)}">
								<li id="apply" class="li-jr"><a onclick="addAuthorize('${workshop.id}','apply','member')"><i class="u-jr"></i>申请加入</a></li>
							</c:when>
						</c:choose>
						<!-- end申请加入 -->
						<tag:follow followEntityId="${workshop.id }" followEntityType="workshop"  />
						<%-- <li id="followBtn" class="li-gz followBtns"><a><i class="u-gz"></i>关注(<strong class="followNum">${workshop.workshopRelations[0].followNum }</strong>)</a></li>
						<li id="cancelFollowBtn" class="li-ngz followBtns"><a><i class="u-ngz"></i>取消关注(<strong class="followNum">${workshop.workshopRelations[0].followNum }</strong>)</a></li>
						<li class="li-zj"><a href="#"><i class="u-zj"></i>我的足迹</a> --%>
							<div class="m-show-zj">
								<!--<span class="u-bor1"></span> <span class="u-bor2"></span>
								<div class="zj-tit">
									<h4>张雯老师的足迹</h4>
								</div>
								<div class="zj-con">
									<div class="con-box">
							 			<div class="con-lis">
											<div class="u-time">
												<span class="t-date">4月25</span> <span class="t-hour">12:00</span>
											</div>
											<p>参与了工作坊信息提升活动，并发表了评论。</p>
											<span class="u-circle"></span>
										</div>
										<div class="con-lis">
											<div class="u-time">
												<span class="t-date">4月25</span> <span class="t-hour">12:00</span>
											</div>
											<p>参与了工作坊信息提升活动，并发表了评论。</p>
											<span class="u-circle"></span>
										</div>
										<div class="con-lis">
											<div class="u-time">
												<span class="t-date">4月25</span> <span class="t-hour">12:00</span>
											</div>
											<p>参与了工作坊信息提升活动，并发表了评论。</p>
											<span class="u-circle"></span>
										</div>
										<div class="con-lis">
											<div class="u-time">
												<span class="t-date">4月25</span> <span class="t-hour">12:00</span>
											</div>
											<p>参与了工作坊信息提升活动，并发表了评论。</p>
											<span class="u-circle"></span>
										</div>
										<div class="con-lis">
											<div class="u-time">
												<span class="t-date">4月25</span> <span class="t-hour">12:00</span>
											</div>
											<p>参与了工作坊信息提升活动，并发表了评论。</p>
											<span class="u-circle"></span> <span class="u-cover"></span>
										</div> -->
									</div>
								</div>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="g-new-info">
			<div id="listAnnouncementDiv">
			
			</div>
			<div id="newestPlanDiv">
			
			</div>
		</div>
		<div class="g-main">
			<div class="main-lf">
				<div id="listActivityDiv">
				
				</div>
				<div id="listResourceDiv">
				
				</div>
			</div>
			<div class="main-rt">
				<div id="listHotActivityDiv">
			
				</div>
				<div id="listHotResourceDiv">
			
				</div>
			</div>
		</div>
	</div>
</div>
<div id="editWorkshopDiv" class="new-workshop-layer layer"></div>
</tag:mainLayout_yx>
<script type="text/javascript">
	$(function(){
		changeTab('workshop');
		$('#backName').val('${workshop.name}');
		$('#hasMasterRole').val('${hasMasterRole}');
		$('#hasAssistRole').val('${hasAssistRole}');
 		$('#hasMemberRole').val('${hasMemberRole}');
		
 		listResource('${workshop.id}');
 		listAnnouncement('${workshop.id}');
 		listActivity();
 		listHotActivity('${workshop.id}');
 		listHotResource('${workshop.id}');
 		listWorkshopAuthorize();  
 		newestPlan('${workshop.id}');
		/* listWorkshopAuthorize();
		listHotActivity('${workshop.id}');
		listHotResource('${workshop.id}');
		listLiveStudio('${workshop.id}');
		newestPlan('${workshop.id}'); */
	});
	
	function listWorkshopAuthorize(){
		$('#listWorkshopAuthorizeDiv').load('${ctx}/workshop/authorize/listWorkshopAuthorize','limit=5&orders=CREATE_TIME.DESC&paramMap[workshopId]=${workshop.id}&paramMap[role]=member&paramMap[state]=pass');
	}
	
	function listActivity(){
		var hasMasterRole = "${hasMasterRole}";
		if(hasMasterRole == 'true'){
			$('#listActivityDiv').load('${ctx}/activity/listActivity','orders=IS_TOP.DESC,CREATE_TIME.DESC&paramMap[relationId]=${workshop.id}&'+$('#roleForm').serialize());
		}else{
			$('#listActivityDiv').load('${ctx}/activity/listActivity','paramMap[creator]=${sessionScope.loginer.id}&paramMap[others]=publishedOrCreator&orders=IS_TOP.DESC,CREATE_TIME.DESC&paramMap[relationId]=${workshop.id}&'+$('#roleForm').serialize());
		}
	}
	
	function listResource(relationId){
		$('#listResourceDiv').load('${ctx}/resource/listResource','orders=CREATE_TIME.DESC&paramMap[relationId]='+relationId+'&paramMap[relationType]=workshop');
	}
	
	function editWorkshop(id){
		$('#editWorkshopDiv').load('${ctx}/workshop/'+id+'/edit','',function() {
			commonCssUtils.openModelWindow($('#editWorkshopDiv'));
		});
	}
	
	function listAnnouncement(relationId){
		$('#listAnnouncementDiv').load('${ctx}/announcement/workshop/list','limit=3&orders=CREATE_TIME.DESC&paramMap[relationId]='+relationId+'&paramMap[hasMasterRole]=${hasMasterRole}');
	}
	
	function listHotActivity(relationId){
		$('#listHotActivityDiv').load('${ctx}/activity/listHotActivity','paramMap[states]=published&limit=5&orders=PARTICIPATE_NUM.DESC&paramMap[relationId]='+relationId);
	}
	
	function listHotResource(relationId){
		$('#listHotResourceDiv').load('${ctx}/resource/listHotResource','limit=5&orders=DOWNLOAD_NUM.DESC&paramMap[relationId]='+relationId);
	}
	
	function newestPlan(relationId){
		$('#newestPlanDiv').load('${ctx}/plan/newestPlan','limit=1&orders=CREATE_TIME.DESC&paramMap[relationId]='+relationId);
	}
	
	function listLiveStudio(relationId){
		$('#listLiveStudioDiv').load('${ctx}/liveStudio.do',"limit=2&paramMap[relationId]="+relationId);
	}
	function createLiveStudio() {
		$('#content').load("${ctx}/liveStudio/create.do","wsid=${workshop.id}&"+$('roleForm').serialize());
	}
	function listMoreLiveStudio(relationId) {
		$('#content').load("${ctx}/liveStudio/listMore.do", "paramMap[relationId]="+relationId);
	}
	$(function(){
		$.get("${ctx}/dynamic.do",{
			"creator.id":"${sessionScope.loginer.id}"
		},function(response){
			$('.m-show-zj').html(response);
		})
	})
	
	function addAnnouncement(relationId, type){
		$('#editAnnouncementDiv').load('${ctx}/announcement/create','announcementRelations[0].relation.id='+relationId+'&type='+type+'&announcementRelations[0].relation.type=workshop',function(){
			commonCssUtils.openModelWindow($('#editAnnouncementDiv'));
		});
	}
	
	function addActivity(relationId, relationType){
		$('#content').load('${ctx}/activity/create', 'activityRelations[0].relation.id='+relationId+'&activityRelations[0].relation.type='+relationType);
	}
	
	function viewActivity(id){
		$('#content').load('${ctx}/activity/'+id+'/view');
	}
	function editActivity(id){
		$('#content').load('${ctx}/activity/'+id+'/edit');
	}
	
	function addAuthorize(workshopId, state, role){
		$.post('${ctx}/workshop/authorize','workshop.id='+workshopId+'&state='+state+'&role='+role+'&workshopRelation.id='+$('#relationId').val(),function(data){
			if(data.responseCode=='00'){
				$('#apply').after('<li class="li-sq"><a href="#"><i class="u-sq"></i>申请中...</a></li>').hide();
				alert('您的申请已提交！进入审核状态');
			}else{
				alert(data.responseMsg);
			}
		});
	}
	
	function listMoreAuthorize(workshopId){
		//$('#content').load('${ctx}/workshop/authorize/more','orders=CREATE_TIME.DESC&paramMap[workshopId]='+workshopId+'&paramMap[workshopRelationId]='+workshopRelationId+'&'+$('#roleForm').serialize());
		$('#content').load('${ctx}/workshop/authorize/more','orders=CREATE_TIME.DESC&paramMap[workshopRelationId]='+$('#relationId').val()+'&paramMap[workshopId]='+workshopId+'&'+$('#roleForm').serialize());
	}
	
	function authorizeIndex(workshopId){
		//$('#content').load('${ctx}/workshop/authorize/more','orders=CREATE_TIME.DESC&paramMap[workshopId]='+workshopId+'&paramMap[workshopRelationId]='+workshopRelationId+'&'+$('#roleForm').serialize());
		$('#content').load('${ctx}/workshop/authorize/index','paramMap[workshopRelationId]='+$('#relationId').val()+'&paramMap[workshopId]='+workshopId+'&'+$('#roleForm').serialize());
	}
	
	function quitWorkshop(id, userId){
		confirm('确定要退出吗?', function(){
			$.ajaxDelete('${ctx}/workshop/authorize/'+id,'workshopRelation.id=${workshop.workshopRelations[0].id}&user.id='+userId,function(data){
				if(data.responseCode == '00'){
					alert('退出成功');
					$('#quit').after('<li id="apply" class="li-jr"><a onclick="addAuthorize(\'${workshop.id}\',\'apply\',\'member\')"><i class="u-jr"></i>申请加入</a></li>').hide();
				}
			})
		});
	}
	
	function listMoreWorkshopAnnouncement(relationId){
		$('#content').load('${ctx}/announcement/workshop/more','orders=CREATE_TIME.DESC&paramMap[relationId]='+relationId);
	}
	
	function deleteWorkshopAnnouncement(id,relationId){
		$.ajaxDelete("${ctx}/announcement?id="+id,null,function(response){
			if(response.responseCode == '00'){
				alert('删除成功');
				listMoreWorkshopAnnouncement(relationId);
			}
		});
	}
</script>
<script type="text/javascript"> 
$(function(){

    checkLength();
    showMoreInfo();
    showzj();

    function checkLength(){                 //判断P的长度，超过长度用...取代
        jQuery.fn.limit=function(){ 
        var self = $("p[limit]"); 
        self.each(function(){ 
        var objString = $(this).text(); 
        var objLength = $(this).text().length; 
        var num = $(this).attr("limit"); 
        if(objLength > num){ 
        //$(this).attr("title",objString);
        $('.detail-intro-more p').text(objString);
        objString = $(this).html(objString.substring(0,num) + "..."+"<a class='u-more'>[查看详情]</a>"); 
        $('#detail-intro .u-more').mouseover(function(){
            $('.detail-intro-more').fadeIn('slow');
        });
        $('#detail-intro .u-more').mouseout(function(){
            $('.detail-intro-more').fadeOut('slow');
        });
        } else{
            objString = $(this).html(objString); 
        }
        }) 
        } 
        $(function(){ 
        $(document.body).limit(); 
        }) 
    }

    function showMoreInfo(){                //热门活动，热门资源选项卡
        var tits=$('#ul-hot-res .li-tit');
        var cons=$('#ul-hot-res .li-con');
        var tits1=$('#ul-hot-act .li-tit');
        var cons1=$('#ul-hot-act .li-con');
        
        showCon(tits,cons);
        showCon(tits1,cons1);

        function showCon(tits,cons){
            for(var i=0;i<tits.length;i++){
            tits[i].id=i;
            tits[i].onmouseover=function(){
                for(var j=0;j<tits.length;j++){
                    cons[j].style.display='none';
                    tits[j].style.display='block';
                }
                cons[this.id].style.display='block';
                tits[this.id].style.display='none';
            }
        }
    }
    }

    function showzj(){          //点击小脚印显示足迹框
        $('.m-show-zj1').appendTo($('.btm-lt'));
        var zj1=$('.btm-lt .m-show-zj1').remove();
        $('.u-bor3').click(function(){
            zj1.appendTo($(this).parents(".wrap-info-lis").children(".zj1-box")).css({"display":"block","top":"0","left":"12px"});
        });
        $('.wrap-info-lis').mouseleave(function(){
            $('.wrap-info-lis .zj1-box').empty();
        });
    }
})
</script> 