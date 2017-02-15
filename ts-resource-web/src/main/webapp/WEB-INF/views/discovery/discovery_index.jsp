<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<tag:mainLayout>
	<div id="wrap">
		<div id="g-bd">
			<div class="f-auto">
				<c:if test="${not empty relationId }">
				<div class="g-layout-mod">
	                <div class="m-crm">
	                    <span class="txt">您当前的位置： </span>
	                    <a onclick="home()" href="###" title="首页" class="u-goto-index">
	                        <i class="u-sHome-ico"></i>
	                    </a>
	                    <span class="trg">&gt;</span>
	                    <a onclick="viewDept('${dept.id}')" href="###">${dept.deptName }</a>
	                    <span class="trg">&gt;</span>
	                    <em>资源</em>
	                </div>
					<div class="m-logo-box">
						<div class="logo-lt">
							<a class="u-logo"> 
								<c:choose>
									<c:when test="${empty dept.imageUrl }">
										<img src="${ctx}/images/no-logo.png" width="91" height="91">
									</c:when>
									<c:otherwise>
										<img src="${file:getFileUrl(dept.imageUrl) }" width="91" height="91">
									</c:otherwise>
								</c:choose>
								<h1>${dept.deptName}校本资源平台</h1>
								<p>育人为本，自主发展，追求卓越</p>
							</a>
						</div>
						<div class="logo-rt">
							<p>资源总量：${resourceNum } 个</p>
							<p>本月新增：${newResourceNum }个</p>
						</div>
						<div class="u-light-line"></div>
	                    <a onclick="goSchool('${dept.website }')"  class="u-rt-btn">前往学校</a>
					</div>
	            </div>
			</c:if>
				<div class="g-inner-bd">
					<div class="g-frame">
						<div class="g-frame-mn one-spc">
							<div class="g-mn-mod">
								<div class="m-find-box" style="overflow: hidden; padding-bottom: 20px; padding-top: 10px;">
                                <div class="m-mn-tt spc">
                                    <h2 class="tt">发现</h2>
                                    <div class="u-find-wrap spc">
                                        <div class="find-box">
                                            <ul class="u-find-lst">
                                            	<c:forEach items="${tags }" var="tag">
                                            		<li href="javascript:void(0);" class="u-lst" value="${tag.id}">${tag.name }</li>
                                            	</c:forEach>
                                            </ul>
                                        </div>
                                        <a href="javascript:void(0);" class="u-updown">展开全部<i></i></a>
                                    </div>
                                </div>
									<div id="discoveryContent" style="min-height: 500px;">
									
									</div>
								</div>
							</div>
						</div>
						<div class="g-frame-sd  one-spc">
							<div class="g-btn-mod small">
								<a onclick="loginAddDiscovery()" class="u-bSrh-btn u-cont-btn u-share-btn">
									<strong> <i class="u-share-ico"></i>分享发现</strong>
									<c:if test="${empty relationId }">
										<p>已有<span id="memberNum">${numMap.teacherNum }</span>人 ，分享<span id="discoveryNum">${numMap.resourceNum }</span>个发现</p>
									</c:if>
								</a>
							</div>
							<div id="agreeDiscoveryDiv" class="g-sd-mod">
								<div class="m-new-find">
									<div class="m-sd-tt">
										<h3 class="tt">最赞发现</h3>
									</div>
									<div class="m-sd-dt">
										<ul class="m-news-lst">
											
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</tag:mainLayout>
<script>
	$(function(){
	    showall();
	
	    function showall(){
	        $(".u-find-lst").each(function(){                //判断列表的高度来显示或隐藏按钮
	            var status=$(this).height();
	            if(parseInt(status)<=31){
	                $(this).parent().next().css("display","none");
	            }
	        });
	
	        $(".u-updown").click(function(){                        //点击按钮显示全部列表
	            var childH=$(this).prev().children().height();
	            var parentH=$(this).prev().height();
	            if(childH>31){
	                if(parentH==31){
	                    $(this).prev().height("inherit");
	                }else{
	                    $(this).prev().height("31px");
	                }
	            }
	        });
	    }
	})


	$(function(){
		changeTab('discovery');
		
		$('#discoveryContent').load("${ctx}/discovery/more","limit=12&orders=CREATE_TIME.DESC&paramMap[type]=discovery&paramMap[relationId]=${relationId[0]}");
	});

	function loginAddDiscovery(){
		goLogin(function(){
			addDiscovery();
		});
	}
	
	$(function(){
		$('.u-find-lst').on('click','li',function(){
			var classAttr = $(this).attr('class');
			if(classAttr.indexOf('z-crt')>0){
				//包含，去掉z-crt
				$(this).attr('class','u-lst');
			}else{
				$('.u-find-lst li').attr('class','u-lst');
				$(this).attr('class','u-lst z-crt');
			}
			//查询
			var extendType = '';
			$('.u-find-lst li').each(function(){
				if($(this).attr('class').indexOf('z-crt')>0){
					extendType =$(this).attr('value');
				}
			});
			console.log(extendType);
			$('#discoveryType').val(extendType);
			$.get("${ctx}/discovery/more",{
				"paramMap[tag]":extendType,
				"paramMap[type]":"discovery",
				"paramMap[relationId]":'${relationId[0]}',
				"limit":12,
				"orders":"CREATE_TIME.DESC"
				},function(response){
				$('#discoveryContent').html(response);
			});
		});
	})
	
	//最赞发现
	$(function(){
		$.post("${ctx}/discovery/listData",{
			"paramMap[type]":"discovery",
			"paramMap[stateNotEquils]":"${dict:getEntryValue('EDIT_STATE','不通过')}",
			"paramMap[relationId]":'${relationId[0]}',
			"orders":"SUPPORT_NUM.DESC",
			"limit":"5"
		},function(response){
			if(response){
				if($(response.items).size()>0){
					$.each($(response.items),function(i,discovery){
						$('.m-news-lst').append('<li><a onclick="viewDiscovery(\''+discovery.id+'\')">'+discovery.title+'</a></li>');
					});
				}else{
					$('#agreeDiscoveryDiv').hide();
				}
			}
		});
	})
	
	</script>
