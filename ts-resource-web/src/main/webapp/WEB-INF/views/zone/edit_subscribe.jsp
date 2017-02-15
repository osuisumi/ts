<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/inc.jsp" %>
<div id="g-layer-wrap">
	<div class="g-layer-con">
		<!-- <div class="m-mn-tt">
            <h2 class="tt small">订阅设置</h2>
            <a class="u-close-ico"><i></i></a>
        </div> -->
		<div class="m-mn-dt">
			<div class="m-recommend">
				<h3 class="tt">
					<P>根据您的个人职业信息为您推荐了：</P>
					<!-- <a href="javascript:void(0);" class="u-modify"><i></i>修改个人资料</a> -->
				</h3>
				<div class="recommend-con">
					<div class="u-find-lst u-recommend" id="u-recommend">
					</div>
				</div>
				<div class="u-recommened">
					<p class="u-txt">已订阅：</p>
					<div class="u-find-lst u-subscribed" id="u-subscribed">
					</div>
				</div>
			</div>
			<div class="u-btn-box" style="margin-bottom: 20px;">
				<a onclick="save()" class="u-btn-com u-download">保存</a>
				<a onclick="cancel()" class="u-btn-com u-cancel">取消</a>
			</div>
		</div>
	</div>
</div>
<script>
$(function(){
    subscribe();    //订阅
    function subscribe(){
        var rcm = $("#u-recommend");     
        var rcm_lst = rcm.children('.u-lst');   //获取推荐列表
        var sub = $("#u-subscribed"); 
        var sub_lst = sub.children('.u-lst');   //获取已订阅列表
        var del = sub_lst.children('.u-del');       //获取订阅列表中的删除订阅按钮

        
            $("#u-subscribed").on('click',".u-del",function(){              //取消订阅
                var _this = $(this);
                _this.parent('.u-lst').appendTo(rcm);
            });

            rcm.on('click',".u-lst",function(){          //添加订阅
                var _this = $(this); 
                _this.appendTo(sub);
            });
    }
})

$(function(){
	$.post("${ctx}/zone/listData/subscribe",{
		'id':'${sessionScope.loginer.id}'
	},function(response){
		$.each($(response.unSubscribeList),function(i,sub){
			$('#u-recommend').append('<li href="javascript:void(0);" value='+sub.id+' class="u-lst"><span class="txt">'+sub.text+'</span><a href="javascript:void(0);" class="u-del" title="删除订阅">×</a></li>');
		});
		$.each($(response.subscribedList),function(i,sub){
			if(sub.type!='user'){
				$('#u-subscribed').append('<li href="javascript:void(0);" value='+sub.id+' class="u-lst"><span class="txt">'+sub.text+'</span><a href="javascript:void(0);" class="u-del" title="删除订阅">×</a></li>');
			}
		});
	})
	
})

function cancel(){
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    parent.layer.close(index);
}

function save(){
	var saveList = $('#u-subscribed li');
	var followedIds = '';
	$.each(saveList,function(i,li){
		followedIds = followedIds + $(li).attr('value')+",";
	});
	followedIds = followedIds.substr(0,followedIds.length-1);
	$.post("${ctx}/zone/myZone/subscribe/update",{
		'id':'${sessionScope.loginer.id}',
		'textBookEntryIds':followedIds
	},function(response){
		//parent.$('#subscribeContent').load('${ctx}/zone/myZone/subscribe');
		//parent.$('#subscribeResourceContent').load('${ctx}/zone/myZone/subscribe/resource',"paramMap[]=");
		//loadSubscribeResource();
		parent.$('#zoneContend').load("${ctx}/zone/myZone/index");
		cancel();
	});
	
}
</script>