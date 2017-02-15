function setIn(){
		$(".inside-wrap .from-wrap").css({"min-height":$(window).height()+"px"});
		$(".index-wrap .from-wrap").css({"min-height":$(window).height()-120+"px"});
		$(".side-right").css({"min-height":$(window).height()+"px"});
		$(".black-bg").css({"min-height":($(window).height()-123)+"px"});
		$(".con-height").css({"min-height":($(window).height()-123+150)+"px",'padding-bottom': '70px'});
		$(".wrap .audio-bg .audio-img").css({"height":($(".black-bg").height()-70)+"px"});
		$(".result-stu-block").css({"height":$(".result-right").height()-42+"px"});
	}
// JavaScript Document
$(document).ready(function(){ 
	//_auto.height.init();
	setIn();
	/*-----start-------窗口变化--------start-------*/
	$(window).resize(function(){
		setIn();
		xiaoshiJS.leftPT.Fixed();
	})
	/*-----end-------窗口变化--------end-------*/

	/*-----start-------判断高度宽度--------start-------*/
	
	/*-----end-------判断高度宽度--------end-------*/
	/*---start---左边导航固定定位---start---*/
	var xiaoshiJS = window.xiaoshiJS || {
		leftNav : $('.'+'p-side-nav')	
	};
	xiaoshiJS.leftPT = {
		Fixed : function()
		{
			var leftNav = xiaoshiJS.leftNav,
				leftH   = leftNav.height(),
				windowW = $(window).width(),
				windowH = $(window).height();
			if((leftH+100) <= windowH)
			{
				leftNav.css({
					'position':'fixed',
					'left': (windowW - 1000)/2 + 'px',
					'top' : '100px'
				});
				//alert(leftNavHeight);
			}else
			{
				xiaoshiJS.leftPT.Absolute(leftNav,leftH,windowH,windowW);
			}
			//ScrollH();
		},
		Absolute : function(leftNav,leftH,windowH,windowW)
		{
			
			$(window).scroll(function(){
				var scrollH = document.body.scrollTop || document.documentElement.scrollTop;
				if(scrollH > (leftH+120-windowH) )
				{
					//alert(1);
					leftNav.css({
						'position' : 'fixed',
						'left': (windowW - 1000)/2 + 'px',
						'top'    : 'auto',
						'bottom' : '20px'
					})
				}else
				{
					leftNav.css({
						'position' : 'absolute',
						'left': '0',
						'top'    : '0',
						'bottom' : 'auto'
					})
				}
			})
		}
	}
	xiaoshiJS.leftPT.Fixed();
	/*---end---左边导航固定定位---end---*/

	/*--start---  课程测试选项卡  ----start---*/
	$(".test-tab li").click(function(){
		var sideTab=$(".test-tab li").index(this);
		$(".test-tab li").removeClass("test-tab-in");
		$(this).addClass("test-tab-in");
		$(".test-subject").hide();
		$(".test-subject").eq(sideTab).show();
	})
	$(".tab-li-list li").click(function(){
		var indexTab=$(".tab-li-list li").index(this);
		$(this).parent().children().removeClass("tab-li-in");
		$(this).addClass("tab-li-in");
		$(this).parents(".tab-li-list").nextAll(".tab-con-list").find(".tab-block").hide();
		$(this).parents(".paper-tit").nextAll(".tab-con-list").find(".tab-block").hide();
		$(this).parents(".popup-tab").nextAll(".tab-con-list").children(".tab-block").hide();
		$(".tab-con-list .tab-block").eq(indexTab).show();
		//_auto.height.init();
	})
	/*------end------课程测试选项卡--------end-------*/
	alltab($('.index-side-tab a'),$('.index-wrap .side-right .b-tab'),'.side-tab-block');
	alltab($('.inside-side-tab li'),$('.inside-wrap .side-right .b-tab'),'.side-tab-block');
	function alltab(clickA,tabCon,tabList)
	{
		clickA.bind('click',function(){
			var index = clickA.index(this);
			//alert(index);
			clickA.removeClass("inIs");
			$(this).addClass("inIs");
			tabCon.find(tabList).hide();
			tabCon.find(tabList).eq(index).show();
		})
	}

	/*------start---------隐藏侧边栏------------start------------*/
	sideShrink($('.side-shrink'),'click');
	function sideShrink(clickIs,Event){
		var right=$('.inside-wrap .side-right');
		var width=right.outerWidth();
		var left=$('.mrDistance');
		var sideTop=$('.side-top-new');
		var sideTab=$('.inside-side-tab');
		var time=300;
		//alert(Width);
		clickIs.bind(Event,function(){
				_this=$(this);
				if(_this.hasClass('inIs')){
					_this.removeClass('inIs').text('>>').attr('title','隐藏侧边栏');
					rShow(right,width,time);
					rShow(sideTop,width,time);
					rShow(sideTab,width,time);
					left.animate({'margin-right':width+'px'},time);
					_this.animate({'right':width+'px'},time);
				}else{
					_this.addClass('inIs').text('<<').attr('title','显示侧边栏');
					rHide(right,time);
					rHide(sideTop,time);
					rHide(sideTab,time);
					left.animate({'margin-right':0},time);
					_this.animate({'right':0},time);
				}
				
				
		})
		function rHide(_ts,time){
			_ts.animate({'width':'0'},time);	
		}
		function rShow(_ts,width,time){
			_ts.animate({'width':width+'px'},time);	
		}
	}
	/*------end---------隐藏侧边栏------------end------------*/

	/*----start----上下按钮控制滚动条上下移动开始----start----*/
	$("#srollup").click(function(){
		document.body.scrollTop=document.body.scrollTop-100;
		document.documentElement.scrollTop=document.documentElement.scrollTop-100;		
	});
	$("#srolldown").click(function(){
		document.body.scrollTop=document.body.scrollTop+100;
		document.documentElement.scrollTop=document.documentElement.scrollTop+100;		
	});
	/*----end----上下按钮控制滚动条上下移动结束----end----*/

	
	/*----start----单选按钮效果----start----*/
	$(".wrap .alone-choice").click(function(){
		var topicLIndex=$(this).parents(".topic-list").index(".topic-list");
		$(".topic-list").eq(topicLIndex).find(".alone-choice").removeClass("thisTest");
		$(this).addClass("thisTest");
	})
	/*----start----单选按钮效果----start----*/
	
	/*----start----多选按钮效果----start----*/
	$(".more-choice-list .more-choice").bind("click",function(){
		if($(this).hasClass("thisTest"))
		{
			$(this).removeClass("thisTest");
		}else
		{
			$(this).addClass("thisTest");
		}		
	})
	$(".grouping-operate-top .check-all").bind("click",function(){
		$(this).parents(".grouping-operate-top").nextAll(".grouping-list-con").find(".more-choice").addClass("thisTest");
	})
	$(".grouping-operate-top .check-opposite").bind("click",function(){
		
		if($(this).parents(".grouping-operate-top").nextAll(".grouping-list-con").find(".more-choice").hasClass("thisTest"))
		{
			$(this).parents(".grouping-operate-top").nextAll(".grouping-list-con").find(".more-choice").removeClass("thisTest")	
		}else
		{
			$(this).parents(".grouping-operate-top").nextAll(".grouping-list-con").find(".more-choice").addClass("thisTest")	
		}
	})
	$(".wrap .sche-module-con .more-choice").bind("click",function(){
		if($(this).hasClass("thisTest"))
		{
			$(this).removeClass("thisTest");
		}else
		{
			$(this).addClass("thisTest");
		}	
	})
	$(".wrap .schedule-module-top .more-choice").bind("click",function(){
		var mChoiceIndex=$(".wrap .schedule-module-top .more-choice").index(this);
		if($(this).hasClass("thisTest"))
		{
			$(this).removeClass("thisTest");
			$(".wrap .sche-module-con").eq(mChoiceIndex).find(".more-choice").removeClass("thisTest");
		}else
		{
			$(this).addClass("thisTest");
			$(".wrap .sche-module-con").eq(mChoiceIndex).find(".more-choice").addClass("thisTest");
		}	
	})
	$(".schedule-list-top .more-choice").bind("click",function(){
		if($(this).hasClass("thisTest"))
		{
			$(this).removeClass("thisTest");
			$(".schedule-list-con .more-choice").removeClass("thisTest");
		}else
		{
			$(this).addClass("thisTest");
			$(".schedule-list-con .more-choice").addClass("thisTest");
		}	
	})
	
	/*----end----单选按钮效果----end----*/
	
	/*----start----jq判断班级学员模块宽度----start----*/
	/*classWidth();
	function classWidth()
	{
		var divWidth=$(".class-block").width();
		var geshu=(parseInt(divWidth/313)*313);
		var mWidth=(divWidth-geshu+10)/2;
		$(".class-block .student-list").css({"margin-left":mWidth+"px"});	
	}
	
	$(window).resize(function(){
    	classWidth();
	})*/
	/*----end----jq判断班级学员模块宽度----end----*/
	
	/*----start----课程笔记添加笔记和编辑笔记效果----start----*/
	$(".notice-popup-bnt").click(function(){
		var _this=$(this);
		$(".popup").hide();
		$(".add-pupop-bnt").removeClass("popupIn");	
		if(_this.hasClass("popupIn"))
		{
			_this.removeClass("popupIn");
			$(".s-notice-popup").hide();
		}else
		{
			$(".s-notice-popup").show();
			_this.addClass("popupIn");		
		}
	})
	$(".new-popup .newP-close-bnt").click(function(){
		$(this).parents(".new-popup").hide();
		$(".blackBg").hide();	
	})
	$(".pupop-close-bnt").click(function(){
		$(".popup-page").hide();
		$(".blackBg").hide();	
	})
	$(".p-notice-top a").bind("click",function(){
		$(this).parents(".s-notice-popup").hide();
		$(".notice-popup-bnt").removeClass("popupIn");
		$(".notice-detail").show();
		$(".blackBg").show();		
	})
	$(".s-notice-popup .issue-bnt").bind("click",function(){
		$(".notice-popup-bnt").removeClass("popupIn");
		$(this).parents(".s-notice-popup").hide();
		$(".issue-inform-popup").show();
		$(".blackBg").show();		
	})
	$(".add-pupop-bnt").click(function(){
		var _this=$(this);
		$(".popup").hide();
		$(".notice-popup-bnt").removeClass("popupIn");	
		if(_this.hasClass("popupIn"))
		{
			_this.removeClass("popupIn");
			$(".eOpa-popup").hide();
		}else
		{
			$(".eOpa-popup").show();
			_this.addClass("popupIn");		
		}		
	})
	$(".eOpa-popup .g-bnt").click(function(){
		$(".eOpa-popup").hide();
		$(".add-pupop-bnt").removeClass("popupIn");
		$(".survey-result").show();
		$(".evaluate-popup").show();
		$(".blackBg").show();
		$(".notice-popup").removeClass("displayBlock");
		$(".notice-popup-bnt").removeClass("popupIn");
		$(".notice-popup").addClass("displayNone");			
	})
	
	$(".add-note-bnt").click(function(){
		$(".add-note").show();
		$(".blackBg").show();
	})
	$(".pupop-redact-bnt").click(function(){
		$(".redact-note").show();
		$(".blackBg").show();
	})
	$(".add-que-bnt").click(function(){
		$(".add-que").show();
		$(".blackBg").show();
	})
	/*----end----课程笔记添加笔记和编辑笔记效果----end----*/

	/*----start----展开和关闭活动列表效果----start----*/
	$(".click-open a").click(function(){
		var _this=$(this);
		if(_this.hasClass("clickOpenIn"))
		{
			_this.parent().prevAll(".note-top-list").css({"height":35+"px"});
			_this.removeClass("clickOpenIn").text("[展开]");
			
		}else
		{
			_this.parent().prevAll(".note-top-list").css({"height":"inherit"});
			_this.addClass("clickOpenIn").text("[收起]");
		}

	})
	/*----end----展开和关闭活动列表效果----end----*/
	
	/*----start----日程管理和教学进展下拉列表效果----start----*/
	$(".r-operate-bnt a").click(function(){
		if($(".r-operate-bnt a").hasClass("clickIn"))
		{
			$(".r-operate-list").show(500);	
			$(".r-operate-bnt a").removeClass("clickIn");
			$(".righ-operate-text").hide(500);	
		}else
		{
			$(".r-operate-list").hide(500);
			$(".r-operate-bnt a").addClass("clickIn");
			$(".righ-operate-text").show(500);	
		}	
	})
	/*----end----日程管理和教学进展下拉列表效果----end----*/
	
	/*-----start------班级分组新增和自动分组效果-------start------*/
	$(".control-grouping").click(function(){
		$(".control-grouping-popup").show();
		$(".add-grouping-popup").hide();
	})
	$(".add-grouping").click(function(){
		$(".add-grouping-popup").show();
		$(".control-grouping-popup").hide();
	})
	/*-----end------班级分组新增和自动分组效果-------end------*/
	
	/*-----start------作业弹出框-------start------*/
	$(".y-task-bnt").click(function()
	{
		$(".inside-task-popup").show();
		$(".blackBg").show();	
	})
	$(".s-task-bnt").click(function()
	{
		$(".send-notes").show();
		$(".blackBg").show();	
	})
	$(".n-task-bnt").click(function()
	{
		$(".inside-task-popup").show();
		$(".blackBg").show();	
	})
	/*-----end------作业弹出框-------end------*/
	
	/*-----start------成绩统计弹出框------start-------*/
	$(".dis-bnt").click(function()
	{
		$(".inside-dis-popup").show();
		$(".blackBg").show();	
	})
	$(".task-bnt").click(function()
	{
		$(".inside-task-popup").show();
		$(".blackBg").show();	
	})
	$(".test-bnt").click(function()
	{
		$(".inside-test-popup").show();
		$(".blackBg").show();	
	})
	$(".inform-bnt").click(function()
	{
		$(".popup-inform").show();
		$(".blackBg").show();	
	})
	/*-----end------成绩统计弹出框------end-------*/
	
	/*-----start------教学日程和教学进展内容下拉效果-------start------*/
	$(".schedule-module .pull-down-bnt a").click(function(){
		shceIndex=$(".schedule-module .pull-down-bnt a").index(this);
		if($(".schedule-module .pull-down-bnt a").eq(shceIndex).hasClass("fa-angle-down"))
		{
			$(".schedule-module .pull-down-bnt a").eq(shceIndex).removeClass("fa-angle-down");	
			$(".schedule-module .pull-down-bnt a").eq(shceIndex).addClass("fa-angle-up");
			$(".schedule-module .pull-down-bnt a").eq(shceIndex).attr('title','点击显示模块内容');
			$(".schedule-module").eq(shceIndex).removeClass("border");	
			$(".schedule-module .sche-module-con").eq(shceIndex).hide();	
		}else
		{
			$(".schedule-module .pull-down-bnt a").removeClass("fa-angle-down");	
			$(".schedule-module .pull-down-bnt a").addClass("fa-angle-up");
			$(".schedule-module .pull-down-bnt a").attr('title','点击显示模块内容');
			$(".schedule-module .sche-module-con").hide();
			$(".schedule-module").removeClass("border");	
			$(".schedule-module .pull-down-bnt a").eq(shceIndex).removeClass("fa-angle-up");	
			$(".schedule-module .pull-down-bnt a").eq(shceIndex).addClass("fa-angle-down");	
			$(".schedule-module .pull-down-bnt a").eq(shceIndex).attr('title','点击隐藏模块内容');
			$(".schedule-module .sche-module-con").eq(shceIndex).show();
			$(".schedule-module").eq(shceIndex).addClass("border");	
		}
	})
	/*-----end------教学日程和教学进展内容下拉效果-------end------*/
	
	/*------start-----内页侧边栏课程目录时间图标hover效果-------start------*/
	$(".w-directory .time-ico").hover(function(){
		var tIndex=$(".w-directory .time-ico").index(this);
		$(".w-directory .work-time-text").eq(tIndex).show();	
	},function(){
		$(".w-directory .work-time-text").hide();	
	})
	/*------end-----内页侧边栏课程目录时间图标hover效果-------end------*/
	
	/*-----start------侧边栏小纸条效果-------start------*/
	$(".people-con .people-pull-down").click(function(){
		if($(".people-con .people-pull-down").hasClass("inIs"))
		{
			$(".people-con .people-pull-down .fa").removeClass("fa-angle-double-down");	
			$(".people-con .people-pull-down .fa").addClass("fa-angle-double-up");
			$(".people-con .people-pull-down").removeClass("inIs");	
			$(".people-con .people-list").css({"height":"inherit"});
			$(".people-con .people-list").animate({height:'inherit'});
			$(".people-con .people-pull-down span").text("点击收起");
		}else
		{
			$(".people-con .people-pull-down .fa").addClass("fa-angle-double-down");	
			$(".people-con .people-pull-down .fa").removeClass("fa-angle-double-up");	
			$(".people-con .people-pull-down").addClass("inIs");
			$(".people-con .people-list").css({"height":"90px"});
			$(".people-con .people-pull-down span").text("显示全部");
			
		}	
	})
	/*$(".n-add-people .people-ul li").live("click",function(){
		var p_list=$(".w-pa-people .people-list");
		alert(p_list.height());
		if(p_list.height()>90)
		{
			$(".people-pull-down").show();
			p_list.css({height:"90px",overflow:"hidden"})	
		}	
	})*/
	/*-----end------侧边栏小纸条效果-------end------*/
	
	/*----start-------课程制作开关按钮效果-------start------*/
	$(".on-off-bnt").click(function(){
		if($(this).hasClass("on-in"))
		{
			$(this).removeClass("on-in").removeClass("on-off-g-bnt");
			$(this).addClass("off-in").addClass("on-off-r-bnt");
		}else
		{
			$(this).removeClass("off-in").removeClass("on-off-r-bnt");
			$(this).addClass("on-in").addClass("on-off-g-bnt");
		}
	})
	/*----end-------课程制作开关按钮效果-------end------*/
	/*function index(current, obj){ 
		for (var i = 0, length = obj.length; i<length; i++) { 
			if (obj[i] == current) { 
			return i; 
			} 
		} 
	}*/
	$(".module .post-act-bnt").live("click",function(){
		//alert(moduleConI);
		$(this).hide();
		$(this).parents(".module-block").next(".module-content").find(".add-module-data").hide();
		$(this).parents(".module-block").next(".module-content").find(".work-types").show();
		$(this).parents(".module-block").next(".module-content").show();

	})
	$(".module-content .close-m-ico").live("click",function(){
		$(this).parents(".module-content").hide();
		$(this).parents(".module-content").prevAll(".module-block").find(".post-act-bnt").show();
		$(this).parents(".module-cont-top").nextAll(".work-type").show();
		$(this).prevAll("b").text("请选择活动类型");
	})
	$(".data-tit-tab a").live("click",function(){
		var tabIndex=$(this).parent().children("a").index(this);
		//alert(tabIndex);
		$(this).parent().children("a").removeClass("in-tab");
		$(this).addClass("in-tab");
		$(this).parent().next(".data-con").children(".data-labele").hide();
		$(this).parent().next(".data-con").children(".data-labele").eq(tabIndex).show();
	})
	$(".v-add-module .preview-bnt").click(function(){
		//var previewIndex=$(".preview-bnt").index(this);
		$(".v-add-module .preview-bnt").val("使用这个视频");
		$(".v-add-module .preview-bnt").addClass("green1-bnt").addClass("v-upload-bnt");
		$(".v-add-module .preview-bnt").removeClass("blue1-bnt").removeClass("preview-bnt");
		$(".v-add-module .preview-video").show();
	})
	$(".has-content .post-up").live("click",function(){
		if($(this).hasClass("fa-caret-up"))
		{
			$(this).removeClass("fa-caret-up").addClass("fa-caret-down");
			$(this).parents(".module-block").next(".module-content").hide();

		}else
		{
			$(this).addClass("fa-caret-up").removeClass("fa-caret-down");
			$(this).parents(".module-block").next(".module-content").show();
		}
	})
	
	/*------start-------输​入​框​获​得​和​失​去​焦​点​时​隐​藏​或​者​显​示​文​字-------start--------*/
	var inputEl=$(".input_text");
	defVal=inputEl.val();
	inputEl.live({
		focus:function()
		{
			var _this=$(this);
			if(_this.val()==defVal)
			{
				_this.val("");	
			}
		},
		blur:function()
		{
			var _this=$(this);
			if(_this.val()=="")
			{
				_this.val(defVal);	
			}
		}	
	})
	/*------end-------输​入​框​获​得​和​失​去​焦​点​时​隐​藏​或​者​显​示​文​字-------end--------*/
	
	/*------start-------课程内页主题讨论效果-------start--------*/
	$(".dis-block-reply .doubt-discuss").bind("click",function(){
		var _this=$(this);
		if(_this.hasClass("open_dis_reply"))
		{
			_this.parents(".dis-reply-ico").nextAll(".dis-reply-con").hide();
			_this.removeClass("open_dis_reply");	
		}else
		{
			$(".dis-block-reply .dis-reply-con").hide();
			_this.parents(".dis-reply-ico").nextAll(".dis-reply-con").show();
			_this.addClass("open_dis_reply");		
		}
		_this.parents(".dis-reply-ico")
	})
	$(".dis-block-reply .reply-p-bnt").bind("click",function(){
		var _this=$(this);
		if(_this.parent().next().is(".re-personage"))
		{
				
		}else
		{
			$(".dis-block-reply .re-personage").detach();
			_this.parent().after('<div class="re-personage clearfix"><div class="topic-input-text padding0-10 mb10"><textarea></textarea></div><input type="submit" value="回复" class="green1-bnt set-bnt XXL-bnt fr"></div>');
		}
	})
	$(".opa-upport-bnt").bind("click",function(){
		var _this=$(this);
		if(_this.hasClass("inIs"))
		{
			_this.children(".opa-text").text("置顶");	
			_this.removeClass("inIs");
		}else
		{
			_this.children(".opa-text").text("取消置顶");	
			_this.addClass("inIs");	
		}	
	})
	$(".opa-essence-bnt").bind("click",function(){
		var _this=$(this);
		if(_this.hasClass("inIs"))
		{
			_this.children(".opa-text").text("设置精华");	
			_this.removeClass("inIs");
		}else
		{
			_this.children(".opa-text").text("取消精华");	
			_this.addClass("inIs");	
		}	
	})
	$(".yet-grade-bnt").bind("click",function(){
		var _this=$(this);
		$(".teacher-grade").hide();
		_this.hide();
		_this.next(".teacher-grade").show();	
	})
	$(".teacher-grade .need-grade-bnt").bind("click",function(){
		var _this=$(this);
		if(_this.prevAll(".grade-text-input").val()=="")
		{
				
		}else
		{
			$(".teacher-grade").hide();
			_this.parents(".teacher-grade").prevAll(".card-grade").find("span").text(_this.prevAll(".grade-text-input").val());
			_this.parents(".teacher-grade").hide();
			_this.parents(".teacher-grade").prevAll(".yet-grade-bnt").show();
		}
			
	})
	$(".dis-sort-list li a").bind("click",function(){
		var _this=$(this);
		_this.parents(".dis-sort-list").find("a").removeClass("inIs");
		_this.addClass("inIs");
		if(_this.hasClass("d-sort-time")){
			var sort_timeA=$(this);
			if(sort_timeA.hasClass("sort-time-new")){
				sort_timeA.removeClass("sort-time-new");
				sort_timeA.addClass("sort-time-before");
				sort_timeA.attr('title','从最久时间开始');
				sort_timeA.find(".d-sort-ico").removeClass("fa-arrow-up");
				sort_timeA.find(".d-sort-ico").addClass("fa-arrow-down");
			}else{
				sort_timeA.removeClass("sort-time-before");
				sort_timeA.addClass("sort-time-new");
				sort_timeA.attr('title','从最近时间开始');
				sort_timeA.find(".d-sort-ico").addClass("fa-arrow-up");
				sort_timeA.find(".d-sort-ico").removeClass("fa-arrow-down");
			}
			//('title','点击显示模块内容');
		}	
	})
	/*------end-------课程内页主题讨论效果-------end--------*/
	
	/*------start-------选项卡-------start--------*/
	$(".tabLi li").bind("click",function(){
		tabLiIndex=	$(".tabLi li").index(this);
		$(".tabLi li").removeClass("inIs");
		$(this).addClass("inIs");
		$(".tabCon .tabList").hide();
		$(".tabCon .tabList").eq(tabLiIndex).show();
	})
	/*------end-------选项卡-------end--------*/
	
	/*------start-------课程制作题库制作-------start--------*/
	$(".l-opacity-bg").bind("click",function(){
		var l_module=$(this).parents(".l-top-module");
		
		if(l_module.hasClass("inIs"))
		{
			l_module.removeClass("inIs");	
		}else
		{
			l_module.addClass("inIs");	
		}
	})
	$(".block-opa-bnt").bind("click",function(){
		var _this=$(this);
		
		if(_this.hasClass("inIs"))
		{
			_this.removeClass("inIs");
			_this.prev(".l-bottom-opaBg").hide();	
		}else
		{
			$(".l-bottom-opaBg").hide();
		$(".block-opa-bnt").removeClass("inIs");
			_this.addClass("inIs");	
			_this.prev(".l-bottom-opaBg").show();
		}
	})
	$(".all-choice-bnt").bind("click",function(){
		var _this=$(this);
		_this.addClass("inIs");
		$(".l-top-module").addClass("inIs");
	})
	$(".library-popup .lTopic-close-bnt").bind("click",function(){
		var _this=$(this);
		$(".blackBg").hide();
		_this.parents(".library-popup").hide();
	})
	$(".l-delete-bnt").bind("click",function(){
		$(".blackBg").show();
		$(".i-delete-topic").show();	
	})
	$(".l-deleteT-bnt").bind("click",function(){
		$(".blackBg").show();
		$(".i-delete-test").show();	
	})
	$(".all-delete-bnt").bind("click",function(){
		$(".blackBg").show();
		$(".i-delete-topic").show();	
	})
	$(".ad-top-bnt").bind("click",function(){
		$(".blackBg").show();
		$(".i-add-topic").show();	
	})
	
	$(".tNav-oc-ico").bind("click",function(){
		var _this=$(this);
		if(_this.hasClass("tNav-close-ico"))
		{
			_this.removeClass("tNav-close-ico");
			_this.addClass("tNav-open-ico");
			_this.parent(".nav-layer").addClass("floor-close");	
		}else
		{
			_this.addClass("tNav-close-ico");
			_this.removeClass("tNav-open-ico");		
			_this.parent(".nav-layer").removeClass("floor-close");	
		}
		leftHeight();	
	})
	$(".test-file").change(function(){
		$(this).next().show();
	})
	$(".add-test-bnt").bind("click",function(){
			$(".t-add-test").show();
			$(".blackBg").show();
	})
	$(".add-rand-bnt").bind("click",function(){
			$(".t-add-rand").show();
			$(".blackBg").show();
	})
	$(".task-save-bnt").bind("click",function(){
			$(".l-save-popup").show();
			$(".blackBg").show();
	})
	$(".l-save-popup .lTopic-save-bnt").bind("click",function(){
			$(this).parents(".l-save-popup").hide();
			$(".blackBg").hide();
			$(".task-save-bnt").addClass("inIs");
	})
	$(".add-qb-bnt").bind("click",function(){
			$(".blackBg").show();
			$(".add-que-bank").show();
	})
	$(".more-opa-bnt").bind("click",function(){
		var _this=$(this);
		if(_this.hasClass("more-opa-isIn"))
		{
			$(".more-opa").hide();
			_this.removeClass("more-opa-isIn");
		}else
		{
			$(".more-opa").show();
			_this.addClass("more-opa-isIn");	
		}
	})
	/*------end-------课程制作题库制作-------end--------*/


	$(".fileField").live("change",function(){
		var _this=$(this);
		_this.parent().nextAll(".a_file_text").find(".fileText").text(_this.val());
		//$(this).prev(".textFile").val($(this).val());
	})

	/*------start-------信息中心下拉显示操作-------start--------*/
	$(".infor_opa_bolck .infor_opa_bnt").bind("click",function(){
		var inforOpaB=$(this).parent();
		if(inforOpaB.hasClass("inIs")){
			inforOpaB.removeClass("inIs");
		}else{
			$(".infor_opa_bolck").removeClass("inIs");
			inforOpaB.addClass("inIs");
		}
	})
	/*------end-------信息中心下拉显示操作-------end--------*/

	/*------start-------信息中心多选按钮-------start--------*/
	$(".an_choose_ico").live("click",function(){
		var _this=$(this);
		if(_this.hasClass("inIs")){
			_this.removeClass("inIs");
		}else{
			_this.addClass("inIs");
		}
	})
	$(".inforB_opa .b_choose_ico").live("click",function(){
		var _this=$(this);
		if(_this.hasClass("inIs")){
			$(".infor_mod .b_choose_ico").removeClass("inIs");
			_this.removeClass("inIs");
		}else{
			$(".infor_mod .b_choose_ico").addClass("inIs");
			_this.addClass("inIs");
		}
	})
	/*------end-------信息中心多选按钮-------end--------*/
	
	/*------start-------题库管理左边高度问题-------start--------*/
	function leftHeight(){
		var t_leftHeight=$(".topic-i-cont .left-frame").height();
		$(".right-frame .l-right").css({'min-height':t_leftHeight+'px'})
	}
	leftHeight();
	/*------end-------题库管理左边高度问题-------end--------*/
})









