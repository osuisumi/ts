$(document).ready(function(){
	haoyuJsF.inPageFixed.init();
})
$(window).resize(function(){
	haoyuJsF.inPageFixed.init();
})



var haoyuJsF = window.haoyuJsF || {};

haoyuJsF.studyFixed = {
	init : function(options)
	{
		var defaults = 
		{
			parFrame   : '.index-wrap .w-con',
			leftFrame  : '.index-wrap .from-wrap',
			rightFrame : '.index-wrap .side-right',
		}
		var options = $.extend(defaults,options),
			parFrame = $(options.parFrame),
		    leftFrame = $(options.leftFrame),
		    rightFrame = $(options.rightFrame);
		//alert(options.one);
		this.sfScroll(parFrame,leftFrame,rightFrame);
	},
	sfScroll : function(parFrame,leftFrame,rightFrame)
	{
		var wHeight = $(window).height(),
		    lWidht  = leftFrame.width(),
		    pWidht  = parFrame.width(),
		    rWidht  = rightFrame.width(),
		    wWidth  = $(window).width();
		$(window).scroll(function(){
			var scrollH = $(window).scrollTop(),
				lHeight = leftFrame.height(),
				rHeight = rightFrame.height();
		    if(lHeight > rHeight)
		    {
		    	if(scrollH+wHeight > rHeight+120)
		    	{
		    		//console.log(1);
		    		rightFrame.css({
		    			'position': 'fixed',
		    			'bottom' : '20px',
		    			'right' : (wWidth-pWidht)/2
		    		})
		    	}else
		    	{
		    		rightFrame.css({
		    			'position': 'static', 
		    			'bottom' : 0,
		    			'right' : 0
		    		})
		    	}
		    }else
		    {
		    	if(scrollH+wHeight >= lHeight+120)
		    	{
		    		//console.log(1);
		    		leftFrame.css({
		    			'position': 'fixed',
		    			'bottom' : '20px',
		    			'right' : (wWidth-pWidht)/2 +302
		    		})
		    	}else
		    	{
		    		leftFrame.css({
		    			'position': 'static',
		    			'bottom' : 0,
		    			'right' : 0
		    		})
		    	}
		    }


		})	
	}

}




haoyuJsF.inPageFixed = {
	init : function(options)
	{
		var defaults = 
		{
			parFrame   : '.inside-wrap .w-con',
			leftFrame  : '.inside-wrap .from-wrap',
			rightFrame : '.inside-wrap .side-right',
		}
		var options = $.extend(defaults,options),
			parFrame = $(options.parFrame),
		    leftFrame = $(options.leftFrame),
		    rightFrame = $(options.rightFrame);
		//alert(options.one);
		this.sfScroll(parFrame,leftFrame,rightFrame);
	},
	sfScroll : function(parFrame,leftFrame,rightFrame)
	{
		var wHeight = $(window).height(),
		    lWidht  = leftFrame.width(),
		    pWidht  = parFrame.width(),
		    rWidht  = rightFrame.width(),
		    wWidth  = $(window).width();
		$(window).scroll(function(){
			var scrollH = $(window).scrollTop(),
			lHeight = leftFrame.innerHeight(),
			rHeight = rightFrame.innerHeight();
		    if(lHeight > rHeight)
		    {
		    	if(scrollH+wHeight > rHeight+50)
		    	{
		    		//console.log(1);
		    		rightFrame.css({
		    			'position': 'fixed',
		    			'top': -(rHeight-wHeight+50),
		    			'right' : 0
		    		})
		    	}else
		    	{
		    		rightFrame.css({
		    			'position': 'absolute', 
		    			'top' : 0,
		    			'right' : 0
		    		})
		    	}
		    }else
		    {
		    	if(scrollH+wHeight >= lHeight)
		    	{
		    		//console.log(1);
		    		leftFrame.css({
		    			'position': 'fixed',
		    			'top': -(lHeight-wHeight),
		    			'left' : 0
		    		})
		    	}else
		    	{
		    		leftFrame.css({
		    			'position': 'static',
		    			'top': 0,
		    			'right' : 0
		    		})
		    	}
		    }
		})	
	}

}