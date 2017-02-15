function easyui_tabs_add(tab, url, title){
	if (tab.tabs('exists', title)){
		tab.tabs('close', title);
		easyui_tabs_add(tab, url, title);
    }else{
    	tab.tabs('add',{  
    		href:url,
    	    title:title,
    	    closable:true,
    	    cache:false
    	});
    }
}

function easyui_form_query(formId, divId){
	$('#'+divId).panel('options').queryParams= $('#'+formId).serializeObject();
	tab.panel('refresh',$('#'+formId).attr('action'));
}

function easyui_tabs_update(formId, tabId){
	var tab = $('#'+tabId).tabs('getSelected');  
	tab.panel('options').queryParams= $('#'+formId).serializeObject();
	tab.panel('refresh',$('#'+formId).attr('action'));
}

function easyui_window_update(formId,windowId){
	var window = $('#'+windowId);
	window.panel('options').queryParams= $('#'+formId).serializeObject();
	window.window('refresh',$('#'+formId).attr('action'));
}

function easyui_modal_open(id,title,width,height,href,model,onCloseFunction){
	if(width == 0){
		width = $(window).width() * 75 / 100;
	}
	if(height == 0){
		height = $(window).height() * 95 / 100;
	}
	var top=10;
	if($(window).height()>height){
		top=($(window).height() - height)*0.5;
	}
	$("<div id='"+id+"'/>").window({    
		title:title,
	    width: width,    
	    height: height,
	    href: href,    
	    modal: model,
	    collapsible: false,
	    minimizable: false,
	    draggable:true,
	    onClose:function(){
	    	$(this).window('destroy');
	    	if(onCloseFunction!=undefined){
				var $callback = onCloseFunction;
				if (! $.isFunction($callback)) $callback = eval('(' + onCloseFunction + ')');
				$callback();
			}
	    },
	});
}

function easyui_modal_close(id){
	$("#"+id).window('close');   
}