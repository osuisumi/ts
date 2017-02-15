String.prototype.trim= function(){  
    return this.replace(/(^\s*)|(\s*$)/g, "");  
};
$.extend({
	ajaxQuery:function(formId,divId,callback,type){
		if(type == null || type == ''){
			type = 'get';
		}
		$.ajax({
			url:$("#"+formId).attr("action"),
			data:$("#"+formId).serialize(),
			type:type,
			success:function(data){
				$("#"+divId).html(data);
				if(callback!=undefined){
					var $callback = callback;
					if (! $.isFunction($callback)) $callback = eval('(' + callback + ')');
					$callback();
				}
			}
		});		
	},
	ajaxSubmit:function(formId){
		var data = $("#"+formId).serialize();
		var method = $("#"+formId).attr("method");
		if (method == 'delete' || method == 'DELETE' || method == 'put' || method == 'PUT') {
			data = '_method='+method+'&'+data;
		}
		var rData = $.ajax({
			url:$("#"+formId).attr("action"),
			data:data,
			type:'post',
			async:false,
			success:function(data){
				
			}
		}).responseText;
		return rData;
	},
	ajaxDelete:function(url, data, callback){
		$.ajax({
			url:url,
			type:'post',
			data:'_method=DELETE&'+data,
			success:function(data){
				if(callback!=undefined){
					var $callback = callback;
					if (! $.isFunction($callback)) $callback = eval('(' + callback + ')');
					$callback(data);
				}
			}
		});
	},
	put:function(url, data, callback){
		$.ajax({
			url:url,
			type:'post',
			data:'_method=PUT&'+data,
			success:function(data){
				if(callback!=undefined){
					var $callback = callback;
					if (! $.isFunction($callback)) $callback = eval('(' + callback + ')');
					$callback(data);
				}
			}
		});
	}
});

function assignParam(formId,objectId){
	$.each($('#'+formId+' :input'),function(){
		$(this).val($('#'+$(this).attr('id')+'_'+objectId).text());
	});
}

function checkAllBox(formId, obj){
	if($(obj).prop("checked")){
		$('#'+formId+' :checkbox').each(function(){
			$(this).prop("checked",true);			
		});
	}else{
		$('#'+formId+' :checkbox').each(function(){
			$(this).prop("checked",false);			
		});
	}
}

//txt:鏂囨湰妗唈query瀵硅薄
//limit:闄愬埗鐨勫瓧鏁�
//isbyte:true:瑙唋imit涓哄瓧鑺傛暟锛沠alse:瑙唋imit涓哄瓧绗︽暟
//cb锛氬洖璋冨嚱鏁帮紝鍙傛暟涓哄彲杈撳叆鐨勫瓧鏁�
function initLimit(txt,limit,isbyte,cb){
	txt.keyup(function(){
		var str=txt.val();
		var charLen;
		var byteLen=0;
		if(isbyte){
			for(var i=0;i<str.length;i++){
				if(str.charCodeAt(i)>255){
					byteLen+=2;
				}else{
					byteLen++;
				}
			}
			charLen = Math.floor((limit-byteLen)/2);
		}else{
			byteLen=str.length;
			charLen=limit-byteLen;
		}
		cb(charLen);
	});	
}

function guid(){
	var guid = (G() + G() + "" + G() + "" + G() + "" + 
			G() + "" + G() + G() + G()).toUpperCase();
	return guid;
}
function G() {
	return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
}

function hintJumpLayer(){
	$('.hint-blackbg').show();
	var layer = $('.g-hint-layer');
	var width = layer.innerWidth(),
    height = layer.innerHeight();
    layer.show().css({'margin-top':-height/2+'px','margin-left':-width/2+'px'});
}

window.alert = function(txt){
	$('.hintBlackBg').show();
	$(document.body).prepend(
		'<div class="hint-layer" style="display:block;">'
			+'<div class="tit">'
				+'<b class="title">提示</b>'
				+'<a href="###" onclick="$(this).parents(\'.hint-layer\').remove();$(\'.hintBlackBg\').hide();" class="colse-btn">×</a>'
			+'</div>'
			+'<div class="cont">'
				+'<div class="hint-text">'
					+'<p>'+txt+'</p>'
				+'</div>'
			+'</div>'
			+'<div class="btnDiv">'
				+'<button class="confirm-btn main-btn btn" onclick="$(this).parents(\'.hint-layer\').remove();$(\'.hintBlackBg\').hide();">确定</button>'
			+'</div>'
		+'</div>'
	);
};

window.confirm = function(txt, confirmFn, cancelFn){
	$('.hintBlackBg').show();
	$(document.body).prepend(
		'<div class="hint-layer" style="display:block;">'
			+'<div class="tit">'
				+'<b class="title">确认</b>'
			+'</div>'
			+'<div class="cont">'
				+'<div class="hint-text">'
					+'<p>'+txt+'</p>'
				+'</div>'
			+'</div>'
			+'<div class="btnDiv">'
				+'<button type="button" class="confirm-btn main-btn btn" onclick="ok(this)">确定</button>'
				+'<button type="button" class="cancel-btn gray-btn btn" onclick="cancel(this)">取消</button>'
			+'</div>'
		+'</div>'
	);
	this.cancel = function(obj){
		$(obj).parents('.hint-layer').remove();
		$('.hintBlackBg').hide();
		if(cancelFn!=undefined){			
			var $callback = cancelFn;
			if (! $.isFunction($callback)){
				$callback = eval('(' + callback + ')');
			} 
			$callback();
		}
		return false;
	};
	this.ok = function(obj){
		$(obj).parents('.hint-layer').remove();
		$('.hintBlackBg').hide();
		if(confirmFn!=undefined){
			var $callback = confirmFn;
			if (! $.isFunction($callback)){
				$callback = eval('(' + callback + ')');
			} 
			$callback();
		}
		return true;
	};
};

function getByteLength(value){
	var length = value.trim().length; 
    for(var i = 0; i < value.length; i++){      
        if(value.charCodeAt(i) > 127){      
        	length = length+2;      
        }      
    }
    return length;
}

function getSuffix(fileName){
	var index = fileName.lastIndexOf(".");
	return fileName.substring(index+1,fileName.length);
}

function getOuterHtml(obj) {
    var box = $('<div></div>');
    for (var i = 0; i < obj.length; i ++) {
        box.append($(obj[i]).clone());
    }
    return box.html();
}