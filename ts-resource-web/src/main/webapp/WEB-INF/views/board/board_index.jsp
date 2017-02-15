<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<tag:mainLayout>
	<input id="boardId" type="hidden">
	<input id="boardName" type="hidden">
	<c:choose>
		<c:when test="${not empty board.fileInfos}">
			<input type="hidden" id="boardImgUrl" value="${file:getFileUrl(board.fileInfos[0].url)}">
		</c:when>
		<c:otherwise>
			<input type="hidden" id="boardImgUrl" value="">
		</c:otherwise>
	</c:choose>
	<input type="hidden" value="">
		<div id="g-bd">
			<div class="f-auto">
				<div class="g-inner-bd">
					<div class="g-frame">
						<div class="g-frame-mn">
							<div class="g-mn-mod">
								<div class="m-community-box">
									<div class="m-mn-tt">
										<h2 class="tt">社区</h2>
										<a onclick="createDiscussion($('#boardId').val())" class="u-btn-com u-publish">发帖</a>
									</div>
									<div class="g-mn-dt">
										<div class="m-community-tit">
											<ul class="u-tit-ul">
												
											</ul>
										</div>
										<div id="discussionContent"></div>
									</div>
								</div>
							</div>
						</div>
						<div class="g-frame-sd">
							<div class="g-sd-mod">
								<div class="m-sd-rank">
									<div class="m-sd-tt tab" id="tab-tt">
										<h3 class="tt">
											<a class="li-tt z-crt" href="javascript:void(0);">最新热帖
											<!-- <span>/</span></a><a class="li-tt" href="javascript:void(0);">最新精华 -->
											</a>
										</h3>
									</div>
									<div  class="m-sd-dt" id="tab-con">
										<ul id="hotDiscussion" class="m-arr-lst tab discussion" style="display: block;">
	<!-- 										<li class="m-arr-block first"><strong class="rank">1</strong>
												<h4 class="tt">
													<a href="javascript:void(0);">关于填报应急相关数据、表格的通知</a>
												</h4></li> -->
										</ul>
										<ul id="essenceDiscussion" class="m-arr-lst tab discussion">
											
										</ul>
									</div>
								</div>
							</div>
							<div class="g-sd-mod">
								<div class="m-sd-rank">
									<div class="m-sd-tt">
										<h3 class="tt">本版活跃用户</h3>
									</div>
									<div id="activeUserDiv" class="m-sd-dt">
	
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
	changeTab('board');
	
    $('#g-bn').dsTab({
        itemEl        : '.m-bn li',
        btnElName     : 'm-bn-focus',
        btnItem       : 'a',
        currentClass  : 'z-crt',
        maxSize       : 5,
        changeType    : 'fade',
        change        : true,
        changeTime    : 3000,
        autoCreateTab : false
    });
    //news silde
    $('#activeSilde').dsTab({
        itemEl        : '.lst li',
        btnElName     : 'focus',
        btnItem       : 'a',
        currentClass  : 'z-crt',
        maxSize       : 5,
        changeType    : 'fade',
        change        : true,
        changeTime    : 4000,
        autoCreateTab : false
    });

    //最新热帖、最新精华选项卡
    tab();
    function tab(){
        var $tt=$("#tab-tt .li-tt");
        var $con=$("#tab-con .m-arr-lst");
        $tt.click(function(){
            $this=$(this);
            $t=$this.index();
            $tt.removeClass("z-crt");
            $this.addClass("z-crt");
            $con.css("display","none");
            $con.eq($t).css("display","block");
        });
    }

    //社区小标题选项卡
    $(".u-tit-ul li").on('click',function(){        
        var index = $(this).index();
        //点击标题高亮显示
        $(this).addClass("z-crt").siblings().removeClass("z-crt");   
        //显示每一个标题下面对应的内容
        $(".m-community-con .u-con-ul").eq(index).addClass("z-crt").siblings().removeClass("z-crt");   
    });
})

//后台js
	$(function(){
		var boardImgUrl = $('#boardImgUrl').val();
		
		$('.u-tit-ul').on('click','li',function(){
			$('.u-tit-ul li').attr('class','');
			$(this).attr('class','z-crt');
			$('#boardId').val($(this).find('a').attr('id'));
			$('#boardName').val($(this).find('a').text());
			$('#discussionContent').load('${ctx}/board/discussion',"paramMap[relationId]="+$('#boardId').val()+"&paramMap[relationName]="+$('#boardName').val()+"&paramMap[boardImgUrl]="+boardImgUrl+"&orders=IS_TOP.DESC,IS_ESSENCE.DESC,REPLY_NUM.DESC,CREATE_TIME.DESC");
			loadHotDiscussion();
			loadEssenceDiscussion();
			loadActiveUser();
		});
	})
	//最新热帖
	function loadHotDiscussion(){
		$('#hotDiscussion').html('');
		$.post('${ctx}/discussion/listData',{
			"paramMap[relationId]":$('#boardId').val(),
			"orders":"REPLY_NUM.DESC,CREATE_TIME.DESC",
			"limit":"8"
		},function(response){
			if(response.items){
				$.each($(response.items),function(i,discussion){
					var style
					switch(i){
						case 0:
							style = "first";
							break;
						case 1:
							style = "second";
							break;
						case 2:
							style = "thirdly";
							break;
						default:
							style = "none";
					}
					$('#hotDiscussion').append('<li value="'+discussion.id+'" class="m-arr-block '+style+'"><strong class="rank">'+(i+1)+'</strong><h4 class="tt"><a href="javascript:void(0);">'+discussion.title+'</a></h4></li>');
				})
			}
		});
	}
	
	//最新精华
	function loadEssenceDiscussion(){
		$('#essenceDiscussion').html('');
		$.post('${ctx}/discussion/listData',{
			"paramMap[relationId]":$('#boardId').val(),
			"orders":"CREATE_TIME.DESC",
			"paramMap[isEssence]":"Y",
			"limit":"8"
		},function(response){
			if(response.items){
				$.each($(response.items),function(i,discussion){
					var style
					switch(i){
						case 0:
							style = "first";
							break;
						case 1:
							style = "second";
							break;
						case 2:
							style = "thirdly";
							break;
						default:
							style = "none";
					}
					$('#essenceDiscussion').append('<li value="'+discussion.id+'" class="m-arr-block '+style+'"><strong class="rank">'+(i+1)+'</strong><h4 class="tt"><a href="javascript:void(0);">'+discussion.title+'</a></h4></li>');
				})
			}
		});
	}
	
	$(function(){
		$('.discussion').on('click','li',function(){
			viewBoardDiscussion($(this).attr('value'));
		})
	})
	//模块列表
	$(function(){
		$.post("${ctx}/board/getBoardList",null,function(response){
			$.each(response,function(i,board){
				$('.u-tit-ul').append('<li><a id="'+board.id+'">'+board.name+'</a> <span class="u-line">|</span> <span class="u-bor"></span></li>');
			})
			var boardId = "${boardId[0]}";
			if(boardId !='default'){
				$('#'+boardId).click();
			}else{
				$('.u-tit-ul li').eq(0).click();
			}
		});
	})
	
	function createDiscussion(relationId){
		goLogin(function(){
			$('#content').load("${ctx}/board/discussion/create?discussionRelations[0].relation.id="+relationId);
		});
	}
	
	//活跃用户
	function loadActiveUser(){
		$('#activeUserDiv').load("${ctx}/board/listActiveUser","paramMap[relationId]="+$('#boardId').val());		
	}
</script>
