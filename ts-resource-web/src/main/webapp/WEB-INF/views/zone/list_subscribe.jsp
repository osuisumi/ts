<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
		<h2 class="tt small-size">订阅内容</h2>
		<div class="u-find-wrap u-read">
			<div class="u-find-lst u-read">
				<div class="u-scroll" id="u-scroll">
				</div>
				<!-- 学段 学科  以及学段学科查询的年级 -->
				<!-- <a href="javascript:void(0);" class="u-search"><i></i></a> -->
			</div>
			<a onclick="" id="open-layer" class="u-lst u-add z-crt">+ 添加</a> 
			<a href="javascript:void(0);" class="u-ico u-tRt" id="toRt" style="top:12px"><i></i></a> 
			<a href="javascript:void(0);" class="u-ico u-tLt" id="toLt" style="top:12px"><i></i></a>
		</div>
<script>

//订阅列表
//订阅内容左右滚动
function scroll(){              
    var toLt = $("#toLt");      //获取左按钮
    var toRt = $("#toRt");      //获取右按钮
    var par = $("#u-scroll");   //获取要滚动的元素
    var len = par.children('.u-lst').length;
    var offsetW = 96;           //设置每次滚动的偏移量                 
    toRt.on('click',function(){
        //获取滚动元素当前的left值
        var lt = parseInt(par.css("left"));
        //如果滚动到最后一个子元素，设置向右按钮为不可用状态
        if(lt>((len-1)*(-offsetW))){
            if(!par.is(":animated")){
                par.animate({
                    'left':"-="+offsetW+"px"
                },300);
            }
        }else{
            toRt.attr("disabled","true");
        }
    });
    toLt.on('click',function(){
        //获取滚动元素当前的left值
        var lt = parseInt(par.css("left"));
        //如果滚动到第一个子元素，设置向左按钮为不可用状态
        if(lt<0){
            if(!par.is(":animated")){
                par.animate({
                    'left':"+="+offsetW+"px"
                },300);
            }
        }else{
            toLt.attr("disabled","true");
        }
    });
}

$("#open-layer").on('click',function(){
    //alert("test");
    layer.open({
        type:2,
        title: ['订阅设置','font-size:18px;color:#1a1d29;'],
        maxmin: false,
        shadeClose: false, //点击遮罩关闭层
        area : ['640px','320px'],
        closeBtn : 1,
        content: '${ctx}/zone/myZone/subscribe/edit',
        offset : ['' , '']
        
     });
    //layer.tips('Hello tips!','#open-layer');
});


$(function(){
	$.post("${ctx}/zone/listData/subscribe",{
		'id':'${sessionScope.loginer.id}'
	},function(response){
		$.each($(response.subscribedList),function(i,sub){
			$('#u-scroll').append('<li onclick="listResource(this)" href="javascript:void(0);" class="u-lst" value="'+sub.value+'" type="'+sub.type+'">'+sub.text+'</li>');
		});
		scroll();
		if($('#u-scroll li').size()>0){
			$('#u-scroll li').eq(0).click();
		}
	})
})


function listResource(li){
	var typeCode = $(li).attr('type');
	if(typeCode == 'user'){
		typeCode = typeCode.toLowerCase();
		var value = $(li).attr('value');
		$('#u-scroll li').attr('class','u-lst');
		$(li).attr('class','u-lst z-crt');
		$('#subscribeResourceContent').load("${ctx}/zone/myZone/subscribe/resource","paramMap[creator]="+value);
	}else{
		typeCode = typeCode.toLowerCase();
		var value = $(li).attr('value');
		$('#u-scroll li').attr('class','u-lst');
		$(li).attr('class','u-lst z-crt');
		$('#subscribeResourceContent').load("${ctx}/zone/myZone/subscribe/resource","paramMap["+typeCode+"]="+value);
	}
}
/*
$(function(){
	$('#u-scroll').on('click','li',function(){
		var typeCode = $(this).attr('type');
		typeCode = typeCode.toLowerCase();
		var value = $(this).attr('value');
		$('#subscribeResourceContent').load("${ctx}/zone/myZone/subscribe/resource","paramMap["+typeCode+"]="+value);
	});
})
*/
</script>