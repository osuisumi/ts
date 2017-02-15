// JavaScript Document
$(function(){
   selectDiy();
   lastChild('.ta-dynamic-cont','.ta-dynamic-list .ta-dynamic-line');
   //subNavFixed();
   haoyuJs.selectSearchBox.init();
   smallScreen();
})
$(window).resize(function() {
  //subNavFixed();
  smallScreen();
});
/*下拉框 */
function selectDiy(){
    $(".selectDiy .selectClick").on("click",function(){
        var _this=$(this);
        var selectText=_this.parents(".selectText");
        var selectTextH=_this.parents(".selectText").height();
        var selectTextW=_this.parents(".selectText").width();
        //alert(selectTextW);
        var selectOption=selectText.next(".selectOption");
        selectOption.css({"top":selectTextH+"px","width":(selectTextW-2)+"px"})
        if(_this.hasClass("inIs")){
            $(".selectDiy .selectClick").removeClass("inIs");
            $(".selectDiy .selectOption").hide();
            _this.removeClass("inIs");
            selectOption.hide();
        }else{
            $(".selectDiy .selectClick").removeClass("inIs");
            $(".selectDiy .selectOption").hide();
            _this.addClass("inIs");
            selectOption.show();
        }
    })
    $(".selectDiy .selectOption a").on("click",function(){
        var _this=$(this);
        var selectOption=_this.parents(".selectOption");
        var selectText=selectOption.prev(".selectText");
        selectOption.hide();
         _this.parents(".selectOption").find("a").removeClass("inIs");
        _this.addClass("inIs");
        selectText.find(".selectClick").removeClass("inIs");
        selectText.find(".text").text(_this.text());
        selectText.find(".selectValue").val(_this.text());
    })
}

/* 固定定位弹出框  */
function jumpLayer(clickBtn,layer,Event){
    var width = layer.innerWidth(),
        height = layer.innerHeight();

    clickBtn.on('click',function(){
        layer.show().css({'margin-top':-height/2+'px','margin-left':-width/2+'px'});
        $('.blackBg').show();

    })
    layer.find('.colse-btn').on('click',function(){
        layer.hide();
        $('.blackBg').hide();
    })
    layer.find('.cancel-btn').on('click',function(){
        layer.hide();
        $('.blackBg').hide();
    })
}
/* 固定定位弹出框1  */
function oJumpLayer(clickBtn,layer){
    var width = layer.innerWidth(),
        height = layer.innerHeight();

    clickBtn.on('click',function(){
        layer.show().css({'margin-top':-height/2+'px','margin-left':-width/2+'px'});
        $('.oBlackBg').show();

    })
    layer.find('.colse-btn').on('click',function(){
        layer.hide();
        $('.oBlackBg').hide();
    })
    layer.find('.cancel-btn').on('click',function(){
        layer.hide();
        $('.oBlackBg').hide();
    })
}

/* 绝对定位弹出框  */
function paLayer(clickBtn,layer){
    var width = layer.width(),
        height = layer.height();
    var scorllH = document.documentElement.scrollTop || document.body.scrollTop;
    clickBtn.on('click',function(){
        //alert(scorllH);
        layer.show().css({'top':scorllH+100+'px','margin-left':-width/2+'px'});
        $('.blackBg').show();
    })
    $(window).scroll(function(){
        var scorllH1 = document.documentElement.scrollTop || document.body.scrollTop;
        clickBtn.on('click',function(){
            layer.css({'top':scorllH1+100+'px'});
        })
    })
    layer.find('.close-btn').on('click',function(){
        layer.hide();
        $('.blackBg').hide();
    })
    layer.find('.colse-btn').on('click',function(){
        layer.hide();
        $('.blackBg').hide();
    })
    layer.find('.cancel-btn').on('click',function(){
        layer.hide();
        $('.blackBg').hide();
    })
}

/* 列表奇数背景颜色  */
function inpageBg(inpage){
    var bgcolor = $('.' + inpage);
    bgcolor.find('li:odd').css('background-color','#fafafa');
}

/* 右边iframe自适应高度  */
function iFrameHeight() {
    var ifm= document.getElementById("iframepage");
    var subWeb = document.frames ? document.frames["iframepage"].document :
    ifm.contentDocument;
    if(ifm != null && subWeb != null) {
    ifm.height = subWeb.body.scrollHeight;
    }
}


/*--start-----选项卡---start---*/
function _tab(tabLi,tabParent,tabList)
{
    tabLi.on('click',function(){
        var _this = $(this);
        var  index = tabLi.index(this);
        tabLi.removeClass('inIs');
        _this.addClass('inIs');
        tabParent.find(tabList).hide();
        tabParent.find(tabList).eq(index).show();
    })

}
/*--end-----选项卡---end---*/

/*--start----多个同类名选项卡----start---*/
$.fn.extend({
    myTab : function(options)
    {
        var defaults =
        {
            pars    : '.myTab',   //最外层父级
            tabNav  : '.tabNav',  //标签导航
            li      : 'li',       //标签
            tabCon  : '.tabCon',  //区域父级
            tabList : '.tabList', //t区域模块
            cur     : 'cur',      //选中类
            eType   : 'click'     //事件
        }
        var options = $.extend(defaults,options),
        _ts = $(this),
        tabBtn  = _ts.find(options.tabNav).find(options.li);
        tabList  = _ts.find(options.tabCon).find(options.tabList);
        this.each(function(){
            tabBtn.first().addClass(options.cur);
            tabBtn.eq(0).show();
            tabBtn.on(options.eType,function(){
                var index = $(this).parents(options.tabNav).find(options.li).index(this);
                $(this).addClass(options.cur).siblings().removeClass(options.cur);
                $(this).parents(options.pars).find(options.tabCon).find(options.tabList).eq(index).css({'display':'block'}).siblings().css({'display':'none'});
            })
        })
        return this;
    }
})
/*--end-----多个同类名选项卡---end---*/

/*--start-----input修改标题内容框---start---*/
function alterBox(par,alterText,alterBnt,alterBox,alterInput)
{
    $(par).find(alterBnt).on('click',function(){
        $(this).parents(par).find(alterBox).fadeIn(500);
        $(this).parents(par).find(alterInput).val($(this).parents(par).find(alterText).find('.text').text());
        $(this).parents(par).find(alterText).hide();
    })
    $(par).find(alterBox).find('.cancel-btn').on('click',function(){
        $(this).parents(alterBox).hide();
        $(this).parents(par).find(alterText).show();
    })
    $(par).find(alterBox).find('.confirm-btn').on('click',function(){
        $(this).parents(par).find(alterText).find('.text').text($(this).parents(par).find(alterInput).val());
        $(this).parents(alterBox).hide();
        $(this).parents(par).find(alterText).show();
    })
}
/*--end-----input修改标题内容框---end---*/

/*---start----最后一个元素----start---*/
function lastChild(part,elements){
    var $part = $(part);
    $part.each(function(){
        var $elements = $(this).find(elements);
        var t_last = $elements.length - 1;
        $elements.removeClass('last-child');
        $elements.eq(t_last).addClass('last-child');
    })
}
/*---end----最后一个元素----end---*/

/*---start----侧边固定导航定位----start---*/
/*function subNavFixed(){
    var $subNav = $('#sub-nav'),
        windowWidth = $(window).width(),
        contWidth = $('.content-auto').innerWidth(),
        subNavWidth = parseInt($subNav.css('width')),
        tWidth = (windowWidth - contWidth)/2 - 70 -20;
    //alert(subNavWidth);
    if(tWidth > 0){
        $subNav.css('left', tWidth + 'px');
        $subNav.removeClass("no-fixed");

    }else {
        $subNav.addClass('no-fixed');
    }
    //alert(subNavWidth);
}*/
/*---end----侧边固定导航定位----end---*/

var haoyuJs = $(window).haoyuJs || {};
/*--start-----绝对定位弹出框---start---*/
haoyuJs.paLyaer = {
    init : function(options){
        var defaults = {
            btn : '.btn', //点击的按钮
            btnPart : '.btnPart', //点击的父级
            layer : '.paLyaer', //弹出层
            bColor : '.whiteBg', //白色背景
            ld : '0', //左边距离
            td1 : '0',  //正上边距离1
            td2 : '0',  //反上边距离2
            colseBtn : '.colse-btn', //关闭按钮
            cancelBtn : '.cancel-btn', //取消按钮
            confirmBtn : '.confirm-btn', //确定按钮
            inIs : 'inIs',  //鼠标点中效果
            opst : 'opst',  //layer在按钮上面是的样式
            eType : 'click' //鼠标效果
        }
        var _ts = this;
            options = $.extend(defaults,options),
            btnPart = options.btnPart,
            btn = options.btn,
            layer = $(options.layer),
            bColor = $(options.bColor),
            inIs = options.inIs,
            opst = options.opst,
            eType = options.eType,
            ld = parseFloat(options.ld),
            td1 = parseFloat(options.td1),
            td2 = parseFloat(options.td2),
            lHeight = layer.height();

        _ts.tevent(bColor,layer,btnPart,btn,inIs,opst,options.eType,ld,td1,td2);
        _ts.tclose(
            bColor,
            layer,
            btnPart,
            btn,
            options.colseBtn,
            options.cancelBtn,
            options.confirmBtn,
            inIs,
            opst
        );
    },
    tevent :function(bColor,layer,btnPart,btn,inIs,opst,eType,ld,td1,td2){
        var wHeight = $(window).height();
        $(btnPart).find(btn).on(eType,function(){
            var _this = $(this),
                scrollT = $(window).scrollTop(),
                Left = _this.offset().left,
                Top = _this.offset().top,
                lHeight = layer.innerHeight();
            if(wHeight-(Top-scrollT)>lHeight+30){
                layer.show().css({'top':Top+td1,'left':Left+ld}).removeClass(opst);
            }else{
                layer.show().css({'top':Top-lHeight-td2,'left':Left+ld}).addClass(opst);
            }
            _this.addClass(inIs);
            bColor.show();
        })

        $(window).scroll(function(){
            var scrollT = $(window).scrollTop();
            $(btnPart).find(btn).on(eType,function(){
                var _this = $(this),
                    Left = _this.offset().left,
                    Top = _this.offset().top,
                    lHeight = layer.innerHeight();
                if(wHeight-(Top-scrollT)>lHeight+30){
                    layer.show().css({'top':Top+td1,'left':Left+ld}).removeClass(opst);
                }else{
                    //alert(Top-scrollT-lHeight-td2);
                    //alert(Top);
                    layer.show().css({'top':Top-lHeight-td2,'left':Left+ld}).addClass(opst);
                }
                _this.addClass(inIs);
                bColor.show();
            })
        })
    },
    tclose : function(bColor,layer,btnPart,btn,colseBtn,cancelBtn,confirmBtn,inIs,opst){
        bColor.on('click',function(){
            $(this).hide();
            layer.hide().removeClass(opst);
            $(btnPart).find(btn).removeClass(inIs);
        })
        layer.find(colseBtn).on('click',function(){
            bColor.hide();
            layer.hide().removeClass(opst);
            $(btnPart).find(btn).removeClass(inIs);
        })
        layer.find(cancelBtn).on('click',function(){
            bColor.hide();
            layer.hide().removeClass(opst);
            $(btnPart).find(btn).removeClass(inIs);
        })
        layer.find(confirmBtn).on('click',function(){
            bColor.hide();
            layer.hide().removeClass(opst);
            $(btnPart).find(btn).removeClass(inIs);
        })
    }
};
/*------end-------绝对定位弹出框--------end--------*/

/*------start-------登录框效果--------start--------*/
haoyuJs.loginFocus={
    init : function(options){
        var defaults = {
            loginForm : '#loginForm',// 提交表单
            prt : '.prts', // 父级
            showText : '.showText', // 显示的字
            inputText : '.inputText',// 输入框
            hintText : '.hintText',// 输入框
            focusColor : '#ccc' // 输入框获取焦点是字体颜色
        }
        var options = $.extend(defaults,options),
            loginForm = $(options.loginForm),
            prt = loginForm.find(options.prt),
            showText = options.showText;
            inputText = options.inputText,
            hintText = options.hintText,
            blurColor = prt.find(showText).css('color');
        prt.each(function(){
            var _this = $(this);
            if($(this).find(inputText).val() == ""){
                $(this).find(showText).show();
            }else{
                $(this).find(showText).hide();
            }
        })
        prt.find(inputText).eq(0).focus();
        prt.find(inputText).on({
            focus:function(){
                var _this = $(this);
                _this.parents(options.prt).find(showText).css({'color':options.focusColor});
                if(_this.val() == ""){
                    _this.parents(options.prt).find(showText).show();
                }else{
                    _this.parents(options.prt).find(showText).hide();
                }
            },
            keyup:function(){
                var _this = $(this);
                if(_this.val() == ""){
                    _this.parents(options.prt).find(showText).show();
                }else{
                    _this.parents(options.prt).find(showText).hide();
                }
            },
            keydown:function(){
                var _this = $(this);
                if(_this.val() == ""){
                    _this.parents(options.prt).find(showText).show();
                }else{
                    _this.parents(options.prt).find(showText).hide();
                }
                 if (event.keyCode==13) {
                    if(prt.find(inputText).eq(0).val() && prt.find(inputText).eq(1).val() == ''){
                        $(hintText).css('height','inherit');
                        setTimeout(function(){$(hintText).css('height',0)},3000);
                    }else{
                        _this.blur();
                        loginForm.submit();
                    }


                 }
            },
            blur:function(){
                var _this = $(this);
                _this.parents(options.prt).find(showText).css({'color':blurColor});
                if(_this.val() == ""){
                    _this.parents(options.prt).find(showText).show();
                }else{
                    _this.parents(options.prt).find(showText).hide();
                }
            }
        });
    }
}
/*------end-------登录框效果--------end--------*/

/*------start-------选择搜索框--------start--------*/
haoyuJs.selectSearchBox={
    init : function(){
        var $part = $('.select-search-box'),
            $cBtn = $part.find('.s-text'),
            $hBlocks = $part.find('.h-block'),
            $whiteBg = $('.whiteBg');
        $cBtn.on('click',function(){
            var _ts = $(this),
                $parts = _ts.parents('.select-search-box'),
                $hBlock = $parts.find('.h-block');
            if(_ts.hasClass('cur')){
                _ts.removeClass('cur').css('z-index','inherit');
                 $hBlock.hide();
                 $whiteBg.hide();
            }else {
                 _ts.addClass('cur').css('z-index','100');
                 $hBlock.show();
                 $whiteBg.show();
            }
        })
        $whiteBg.click('click',function(){
            $cBtn.removeClass('cur').css('z-index','inherit');
            $(this).hide();
            $hBlocks.hide();
        })
        $hBlocks.find('a').on('click',function(){
            var _ts = $(this),
                $parts = _ts.parents('.select-search-box'),
                $sText = $parts.find('.s-text'),
                $par = _ts.parent();
            $par.find('a').removeClass('inIs');
            _ts.addClass('inIs');
            $sText.removeClass('cur').css('z-index','inherit');
            $sText.find('em').text(_ts.text());
            $par.hide();
            $whiteBg.hide();
        })

    }
}
/*------end-------选择搜索框--------end--------*/
/*------start-------侧边栏隐藏展开--------start--------*/
haoyuJs.hideSidebar = {
    init : function(options){
        var defaults = {
            btn : '.tuck-right',
            hideLyaer : '.course-right-fixed',
            inIs : 'inIs',
            needTxt : true,
            times : 300
        }
        var options = $.extend(defaults,options),
            btn = $(''+options.btn),
            hideLyaer = $('' + options.hideLyaer),
            inIs = options.inIs,
            needTxt = options.needTxt,
            times = options.times,
            widths = hideLyaer.innerWidth();
        this.actions(btn,hideLyaer,inIs,needTxt,widths,times);


    },
    actions : function(btn,hideLyaer,inIs,needTxt,widths,times){
        btn.on('click',function(){
            var _ts = $(this);
            if(btn.hasClass(inIs)){
                haoyuJs.hideSidebar.showAnimation(hideLyaer,widths,times);
                if(needTxt){
                    _ts.removeClass(inIs).text('>>').attr('title','点击收起');
                }else {
                    _ts.removeClass(inIs).attr('title','点击收起');
                }
            }else{
                haoyuJs.hideSidebar.hideAnimation(hideLyaer,widths,times);
                if(needTxt){
                    _ts.addClass(inIs).text('<<').attr('title','点击展开');
                }else {
                    _ts.addClass(inIs).attr('title','点击展开');
                }

            }
        })
    },
    hideAnimation : function(hideLyaer,widths,times){
        //hideLyaer.animate({'width':'0'},times);
        hideLyaer.animate({'right': -widths+ 'px'},times);
        //hideLyaer.find(".cont").hide();
    },
    showAnimation : function(hideLyaer,widths,times){
        //hideLyaer.animate({'width': widths+ 'px'},times);
        hideLyaer.animate({'right':'0px'},times);
        //hideLyaer.find(".cont").show();
    }
}

/*------start-------图片按比例显示--------start--------*/
haoyuJs.setImgRatio={
    init : function(options){
        var defaults = {
            imgListWrap : '.imgListWrap',// 图片列表父级
            imgParent : '.imgParent', // 图片父级
            img : 'img', // 图片
            maxWidth : '100', // 最大宽度
            maxHeight : '100' // 最大高度
        }
        var options = $.extend(defaults,options),
            $imgListWrap = $(options.imgListWrap),
            $imgParent = $imgListWrap.find(options.imgParent),
            $img = options.img,
            maxWidth = options.maxWidth,
            maxHeight = options.maxHeight;

        $imgParent.each(function(){
            var _ts = $(this),
                $imgs = _ts.find($img),
                imgWidth = $imgs.width(),
                imgHeight = $imgs.height();
            if(imgWidth >= imgHeight ) {
                $imgs.css('height', maxHeight + 'px');
            }else {
                $imgs.css('width', maxWidth + 'px');
            }
        })

    }
}
/*------end-------图片按比例显示--------end--------*/

/*------start-------图片预览--------start--------*/
haoyuJs.lookPhoto={
    init:function(){
        var $photoWrap = $('.photo-preview-wrap'),
            $bImgWrap = $('.b-photo-area'),
            $sImgWrap = $('.s-photo-area'),
            $bImgList = $bImgWrap.find('.b-photo-list'),
            $sImgList = $sImgWrap.find('.s-photo-list'),
            $picList = $('.pic-listing');
        var sLength = $sImgList.find('li').length,
            sImgListWidth = sLength * 55;
        var moveWidth = 0;
        $sImgList.css('width', sImgListWidth + 'px');
        this.lookBigPhoto($picList,$bImgList,$sImgList);
        moveWidth = this.sImgNext(moveWidth,sImgListWidth,$sImgList);
        //alert(moveWidth);
        moveWidth = this.sImgPrev(moveWidth,sImgListWidth,$sImgList);
    },
    lookBigPhoto:function($picList,$bImgList,$sImgList){
       $picList.find('.li .t-block').on('click',function(){
            var _ts = $(this),
                pIndex = $picList.find('.li .t-block').index(this);
            $bImgList.find('li').removeClass('inIs');
            $bImgList.find('li').eq(pIndex).addClass('inIs');
            $sImgList.find('li').removeClass('inIs');
            $sImgList.find('li').eq(pIndex).addClass('inIs');
        })
    },
    sImgNext:function(moveWidth,sImgListWidth,$sImgList){
        var $sImgNext = $('#sImgNext');
        $sImgNext.on('click',function(){
            if(moveWidth < -sImgListWidth + 11* 55){
                moveWidth = moveWidth;
            }else {
                moveWidth = moveWidth - 11*55;
            }
            $sImgList.animate({
                left: moveWidth
            },500);
            console.log(moveWidth);
            return moveWidth;
            //console.log(moveWidth);
        })

    },
    sImgPrev:function(moveWidth,sImgListWidth,$sImgList){
        var $sImgPrev = $('#sImgPrev');
        $sImgPrev.on('click',function(){
            console.log(moveWidth);
             return moveWidth;
            /*if(moveWidth == 0){
                moveWidth = moveWidth;
            }else {
                moveWidth = moveWidth + 11*55;

            }
            $sImgList.animate({
                left: moveWidth
            },500);*/

        })
        //return moveWidth;
    }
}
/*------end-------图片预览--------end--------*/

//时间轴
function timershafts(){
    var $tsParents = $(".m-timerShaft-tab");
    $tsParents.children("a").each(function(){
        var _ts = $(this),
            $round = _ts.siblings(".round"),
            lefts = Math.floor(_ts.position().left);
        if(_ts.hasClass("z-crt")){
            $round.stop().animate({
                left: lefts + 23 + "px"
            },500);
        }
        _ts.on("mouseover",function(){
            _ts.siblings().removeClass("z-crt");
            _ts.addClass("z-crt");
            $round.stop().animate({
                left: lefts + 23 + "px"
            },150);
        })
    })
}


smallScreen();
function smallScreen(){
    var windowWidth = document.body.clientWidth;
    //var bodys = document.getElementsByTagName("body");
    var bodys = $("body");
    if(windowWidth <= 1366){
        bodys.attr("id","smallScreen");
        //bodys.id = "smallScreen";
        //alert(1);
    }else {
        bodys.attr("id","");
        //bodys.id = "";
    }
}