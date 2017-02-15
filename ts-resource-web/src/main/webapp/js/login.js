$(function(){
	loginJs.indexs.init();
})
$(window).resize(function(){
	loginJs.indexs.init();
})

var loginJs = $(window).loginJs || {};

loginJs.indexs = {
	init : function(){
		var _ts = this,
			windowHeight = $(window).height();
		_ts.loginTab();
		_ts.diyCheckbox();
		_ts.diySelect();
		_ts.placeholderTxt();
	},
	// 登录框切换
	loginTab : function(){
		var $parents = $(".m-log-box"),
			$tabli = $parents.children(".m-tab-li"),
			$li = $tabli.children("a"),
			$tabCon = $parents.children(".m-tab-cont"),
			turnWidth = $parents.innerWidth();
		$li.on("click",function(){
			var tindex = $li.index(this);
			$li.removeClass("z-crt").eq(tindex).addClass("z-crt");
			$tabCon.stop();
			$tabCon.animate({
				left: -turnWidth * tindex + "px"
			},200)
		})
		this.hideTdcHint($li);
	},
	// 隐藏提示二维码登录框
	hideTdcHint : function($tdcBtn){
		var $hintBlock = $(".m-hint");
		$tdcBtn.on("click",function(){
			if($(this).hasClass("item2")){
				$hintBlock.fadeOut(300);
			}
		})
	},
	// 自定义复选框
	diyCheckbox : function(){
		var $parents = $(".m-diy-checkbox"),
			$checkboxIco = $parents.children(".u-checkbox");
		$parents.on("click",function(){
			if($checkboxIco.hasClass("z-slt")){
				$checkboxIco.removeClass("z-slt");
			}else {
				$checkboxIco.addClass("z-slt");
			}
		})
	},
	// 自定义下拉框
	diySelect : function(){
		var $parents = $(".m-bslt-mod"),
			$showBlcok = $parents.children(".show-txt"),
			$txtList = $parents.children(".txt-lst");
			$showText = $showBlcok.children(".txt");
			$sltText = $txtList.children("a");
		$showBlcok.on("click",function(e){
			e.stopPropagation();
			var _this = $(this);
			if(_this.hasClass("z-crt")){
				_this.removeClass("z-crt");
				$txtList.hide();
			}else{
				_this.addClass("z-crt");
				$txtList.show();
			}
			$sltText.on("click",function(){
				$sltText.removeClass("z-crt");
				$(this).addClass("z-crt");
				$showText.text($(this).text());
				$showBlcok.removeClass("z-crt");
				$txtList.hide();
			})
			$(document).one("click",function(e){
				var target = $(e.target);
				if(target.closest($txtList).length == 0){
					$txtList.hide();
					$showBlcok.removeClass("z-crt");
				}
			})
		})
	},
	//帐号错误提示框
	accountPopupHint : function(options){
		var defaults = {
			parents : ".m-ipt-account",
			txt : "请输入正确的帐号！",
			hintPopup : ".login-popup-hint",
			hint: ".txt",
			errorIco : ".icon-war-error"
		}
		var options = $.extend(defaults,options),
			$parents = $(options.parents),
			$hintPopup = $parents.find(options.hintPopup),
			$hint = $hintPopup.find(options.hint),
			$errorIco = $parents.find(options.errorIco),
			txt = options.txt;
		$hintPopup.show();
		$hint.text(txt);
		$errorIco.show();
	},
	//密码错误提示框
	passwordPopupHint : function(options){
		var defaults = {
			parents : ".m-ipt-password",
			txt : "密码错误，请重新输入密码！",
			hintPopup : ".login-popup-hint",
			hint: ".txt",
			errorIco : ".icon-war-error"
		}
		var options = $.extend(defaults,options),
			$parents = $(options.parents),
			$hintPopup = $parents.find(options.hintPopup),
			$hint = $hintPopup.find(options.hint),
			$errorIco = $parents.find(options.errorIco),
			txt = options.txt;
		$hintPopup.show();
		$hint.text(txt);
		$errorIco.show();
	},
	//还没选择角色，请选择
	selectPopupHint : function(options){
		var defaults = {
			parents : ".m-bslt-mod",
			txt : "密码错误，请重新输入密码！",
			hintPopup : ".login-popup-hint",
			hint: ".txt"
		}
		var options = $.extend(defaults,options),
			$parents = $(options.parents),
			$hintPopup = $parents.find(options.hintPopup),
			$hint = $hintPopup.find(options.hint),
			txt = options.txt;
		$hintPopup.show();
		$hint.text(txt);
	},
	placeholderTxt : function(){
		$(".m-ipt-mod .u-ipt").off().on("focus",function(){
			var $this = $(this),
				p_txt = $this.prevAll(".placeholder-txt");
			$this.keyup(function(event){
				if($this.val() == ""){
					p_txt.show();	
				}else {
					p_txt.hide();
				}
			    
			});			
		});
	}

}
