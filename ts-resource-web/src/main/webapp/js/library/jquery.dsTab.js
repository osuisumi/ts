(function($) {

    $.fn.extend({
        dsTab: function(opts) {
            _this = this;
            this.each(function(index, El) {
                new dsTab(opts, _this.eq(index));
            });
        },
        pos: function(index) {
            return this.change(this.opts.index);
        }
    });

    //标题点击显示选中状态
    $(".m-tabli a").click(function(){
        $(this).addClass("z-crt").siblings().removeClass("z-crt");
    });

    pageTab();
    function pageTab(){
        var conLst = $(".m-arr-lst");
        var pageBtn = $(".m-jump-page a").not(".prev").not(".next");
        var prev = $(".prev");
        var next = $(".next");

        pageBtn.click(function(){
            var val = $(this).html();
            $(this).addClass("z-crt").siblings().removeClass("z-crt");
            conLst.eq(val-1).addClass("z-crt").siblings().removeClass("z-crt");
        });

        prev.click(function(){
            var pageIndex = $(".m-jump-page a.z-crt").html();
            if(pageIndex!=1){
                conLst.eq(pageIndex-2).addClass("z-crt").siblings().removeClass("z-crt");
                pageBtn.eq(pageIndex-2).addClass("z-crt").siblings().removeClass("z-crt");
            }
        });
        next.click(function(){
            var pageIndex = $(".m-jump-page a.z-crt").html();
            if(pageIndex!=2){
                conLst.eq(pageIndex).addClass("z-crt").siblings().removeClass("z-crt");
                pageBtn.eq(pageIndex).addClass("z-crt").siblings().removeClass("z-crt");
            }
        });
    }

    showComment();
    function showComment(){
         $(".u-pl-btn").click(function(){            //点击评论按钮显示评论列表
            var this_is = $(this);
            if(this_is.hasClass("z-crt")){
                this_is.removeClass("z-crt");
            }else{
                this_is.addClass("z-crt");
            }
            this_is.parents(".c-info").next(".g-is-comment").toggle();
            this_is.parents(".am-cmt-block").siblings().find(".g-is-comment").hide();
            this_is.parents(".am-cmt-block").siblings().find(".u-pl-btn").removeClass("z-crt");
        });
    }

    //layer_del($("#test"),'../resource/layer-del.html');     //删除资源弹层
    
    //删除资源弹层
    // function layer_del(btn,html_url){
    //     var btn = btn;
    //     var html_url = html_url;
    //     btn.on('click',function(){
    //         layer.open({
    //             type:2,
    //             title: false,
    //             //maxmin: true,
    //             shadeClose: true, //点击遮罩关闭层
    //             area : ['400px','250px'],
    //             closeBtn :false,
    //             content: html_url
    //          });
    //     });
    // }


    function dsTab(opts, target) {
       
        this.opts = {};
        //默认参数
        this.defaults = {
            itemEl: '.content a',
            btnElName: 'btns',
            btnItem: 'li a',
            prev:'',
            next:'',
            currentClass: 'current', //按钮当前样式
            autoCreateTab: true,
            btnItemHtml: '<li class="btn@index"><a href="javascript:void(0)">@index</a></li>',
            index: 0,
            oldIndex: -1,
            size: 3,
            maxSize: 5, //最大个数
            action: 'mouseover', //默认切换动作
            mouseTime: '150',
            overStop: true,
            change: true,
            changeType: 'normal',
            changeTime: 5000 //自动切换时间,
        };
        this.tab = target;
        this.ch = null;
        this.contentItem = null; //内容Item
        this.btnItem = null; //按钮Item
        this.intervalProcess = null;
        this.init(opts);
        this.callback = this.opts.callback || function() {};
    }


    //初始化
    dsTab.prototype.init = function(opts) {
        //覆盖默认参数
        this.opts = $.extend({}, this.defaults, opts || {});
        this.contentItem = this.tab.find(this.opts.itemEl);
        //铰接为空时，无点击动作
        this.contentItem.each(function() {
            _this = this.tagName == 'A' ? $(this) : $(this).parents('a');
            if (_this.length) {
                var href = _this.attr('href');
                if (typeof(href) == 'undefined' || href == '#') {
                    _this.css('cursor', 'default').click(function() {
                        return false
                    });
                }
            }
        });
        //获取个数
        this.opts.size = this.contentItem.size();
        if (this.opts.size <= 1) {
            return; //如果个数不大于1个时,不显示按钮
        }
        if (this.opts.maxSize != -1 && this.opts.size > this.opts.maxSize) {
            this.opts.size = this.opts.maxSize;
        }
        //初始化prev,next 按钮
         if(this.opts.prev != ''){
            this.prev = this.tab.find(this.opts.prev);
        }
        if(this.opts.next != ''){
            this.next = this.tab.find(this.opts.next);
        }
        //自动生成tab按钮
        if (this.opts.autoCreateTab == true) {
            var btnsHtml = '';
            for (var i = 1; i <= this.opts.size; i++) {
                var li = this.opts.btnItemHtml;
                li = li.replace(/@index/g, i);
                btnsHtml += li;
            }
            var btns = this.tab.find(' .' + this.opts.btnElName);
            if (btns.length >= 1) {
                btns.eq(0).html('<ul>' + btnsHtml + '<ul>');
            } else {
                this.tab.append('<div class="' + this.opts.btnElName + '"><ul>' + btnsHtml + '</ul></div>');
            }
        }
        this.btnItem = this.tab.find('.' + this.opts.btnElName + ' ' + this.opts.btnItem);
        this.bind(); //绑定操作    
        this.change_handle();
        if (this.opts.change == true) {
            this.start();
        }
    }
    //绑定操作            
    dsTab.prototype.bind = function() {
        var _this = this;
        //鼠标移上后停止切换动作
        if (this.opts.change == true && this.opts.overStop == true) {
            this.tab.hover(function() {
                _this.stop();
            }, function() {
                _this.start();
            });
        }

        //prev切换动作
        if(this.prev){
            this.prev.click(function(){              
                _this.stop(); 
                _this.opts.index -=2;
                if(_this.opts.index < 0){
                    _this.opts.index = _this.opts.size -1;
                }
                _this.change_handle(_this.opts.index);

                _this.start();
                /*var btns = 
                var index = _this.btnItem.index(btns);
                    _this.opts.index = parseInt(index)+1;
                    _this.change_handle();*/
                
            });
        }
        //next切换动作
        if(this.next){
            this.next.click(function(){    
                _this.stop();              
                _this.change_handle(_this.opts.index);
                _this.start();
            });
        }


        //切换动作
        if (this.opts.action == 'mouseover') {
            this.btnItem.mouseover(function() {
                var btns = this;
                _this.ch = setTimeout(function() {
                    var index = _this.btnItem.index(btns);
                    _this.opts.index = parseInt(index);
                    _this.change_handle();
                }, _this.opts.mouseTime);
            });
            this.btnItem.mouseout(function() {
                clearTimeout(_this.ch);
            });
        } else {
            this.btnItem.bind(this.opts.action, function() {
                var index = _this.btnItem.index(this);
                _this.opts.index = parseInt(index);
                _this.change_handle();
                this.blur();
            });
        }
    }
    dsTab.prototype.start = function() {
        var _this = this;
        clearInterval(this.intervalProcess);
        this.intervalProcess = setInterval(function() {
            _this.change_handle();
        }, this.opts.changeTime);
    }
    dsTab.prototype.stop = function() {
        clearInterval(this.intervalProcess);
    }
    dsTab.prototype.change_handle = function() {
        if (this.opts.index > this.opts.size - 1) {
            this.opts.index = 0;
        }
        this.change(this.opts.index);
        this.opts.index += 1;
    }
    dsTab.prototype.change = function(index) {
        if (this.opts.oldIndex == index) {
            return;
        }
        this.opts.oldIndex = index;
        this.btnItem.removeClass(this.opts.currentClass);
        this.btnItem.eq(index).addClass(this.opts.currentClass);
        if (this.opts.changeType == 'normal') {
            this.contentItem.hide();
            this.contentItem.eq(index).show();
        } else if (this.opts.changeType == 'fade') {
            this.contentItem.fadeOut();
            this.contentItem.eq(index).fadeIn();
        }
        this.callback(index);
        return;
    }
    dsTab.prototype.callback = function(index, el) {

        this.opts.oldIndex = index;
        return index;
    }
})(jQuery)



$(document).ready(function(){

    commonJs.fn.init();

})



var commonJs = $(window).commonJs || {};

commonJs.fn = {
    //初始化
    init : function(){
        var _this = this;
        //自定义下拉框
        _this.drop_down_box();
        //星星等级评价
        _this.evaluateStat();
    },
    drop_down_box : function(){
        var $dd_box = $(".m-slt-block1");

        $dd_box.each(function(){
            var _ts = $(this),
                $show_block = _ts.children(".show-txt"),
                $show_txt = $show_block.children(".txt"),
                $lst = _ts.children(".lst"),
                $dd = $lst.children("a"),
                cur = "z-crt",
                readonly="readonly";
            if(_ts.hasClass(readonly)){
                return false;
            }
            //点击按钮选择选项
            $show_block.on("click",function(){
                //判断是否打开
                var $this = $(this);
                if($this.hasClass(cur)){

                    $lst.hide();
                    $this.removeClass(cur);
                }else {
                    $lst.show();
                    $this.addClass(cur);
                }

                //判断是否点击其他地方
                $(document).on("click",function(e){
                    var target = $(e.target);
                    if(target.closest(_ts).length == 0){
                        $lst.hide();
                        $show_block.removeClass(cur);
                    }
                });
                //点击选项关闭
                _ts.on("click",".lst a",function(){
                    $lst.hide();
                    $show_block.removeClass(cur);
                    $show_txt.text($(this).text());
                    $(this).addClass(cur).siblings().removeClass(cur);
                })
            })

        });

    },
    //星星等级评价
    evaluateStat : function(){
        //鼠标移动上去，星星变亮
        $(document).on('mouseenter','.u-stars i',function(event){
            var _ts = $(this);
            var star = _ts.parent().children('i');
            //判断鼠标移动上去的是第几个
            var indexs = star.index(_ts);
            //阻止冒泡事件
            event.stopPropagation();
            //全部移除再添加
            star.removeClass('z-crt');
            for(var i = 0; i <= indexs; i++){
                star.eq(i).addClass("z-crt");
            }
        });
        //鼠标移除，星星变灰
        $(document).on('mouseleave','.u-stars',function(){
            var _ts = $(this);
            var star = _ts.children('i');

            star.removeClass('z-crt');
        });
        //d点击让星星变亮
        $(document).on('click','.u-stars i',function(){
            var _ts = $(this);
            var star = _ts.parent().children('i');
            //var tips = _ts.siblings('.tips');
            var indexs = star.index(_ts);
            //var tipsTextArr = ['20','40','60','80','100'];
            //var tipsPositionX = [53,74,97,119,141];
            //添加星星
            star.removeClass('z-in');
            for(var i = 0; i <= indexs; i++){
                console.log(indexs);
                star.eq(i).addClass("z-in");
            }
            //修改评分文本
            //tips.show().find('span').text(tipsTextArr[indexs]);
            //修改评分位置
            //tips.show().css("left",tipsPositionX[indexs]);
        });
    },
    //弹出框
    aJumpLayer : function(layer){
        var width = layer.innerWidth(),
        height = layer.innerHeight();
        layer.show().css({'margin-top':-height/2+'px','margin-left':-width/2+'px'});
        $('.m-blackbg').show();
        commonJs.fn.layerColse(layer);
    },
    layerColse : function(layer){
        layer.on("click",".u-cancel-btn",function(){
             layer.hide();
            $('.m-blackbg').hide();
        })
        layer.on("click",".u-close-btn",function(){
             layer.hide();
            $('.m-blackbg').hide();
        })
    }

}

