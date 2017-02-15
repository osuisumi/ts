var commonCssUtils = {
	
	//打开固定模态化窗口
	openModelWindow : function(obj){
		var width = obj.width(),
        height = obj.height();
		obj.show().css({'margin-top':-height/2+'px','margin-left':-width/2+'px'});
        $('.blackBg').show();
	},

	//绑定固定模态化窗口关闭事件
	bindCloseWindowEvent : function(obj){
		obj.find('.colse-btn').bind('click',function(){
			obj.hide();
	        $('.blackBg').hide();
	    });
	    obj.find('.cancel-btn').bind('click',function(){
	    	obj.hide();
	        $('.blackBg').hide();
	    });
	},
	
	closeModelWindow : function(obj){
		obj.hide();
        $('.blackBg').hide();
	}

}