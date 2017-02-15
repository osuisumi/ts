function setEntryList_ul(frameId, code, hiddenId){
	$('#'+frameId).empty();
	$('#'+frameId).append('<li><a value="" class="act">全部</a></li>');
	$.ajax({
		url: $('#ctx').val()+'/dict/getEntryList',
		type:'get',
		data:'dictTypeCode='+code,
		success:function(data){
			$(data).each(function(){
				$('#'+frameId).append('<li><a value="'+this.dictValue+'">'+this.dictName+'</a></li>');
			});
			$('#'+frameId).find('li a').click(function(){
				$('#'+hiddenId).val($(this).attr('value'));
				$('#'+frameId).find('li a').removeClass('act');
				$(this).addClass('act');
			});
		}
	});
}

function setEntryList_dl(frameId, code, hiddenId){
	var value = $('#'+hiddenId).val();
	$('#'+frameId).empty();
	$('#'+frameId).append('<dd><a class="z-crt">请选择</a></dd>');
	$.ajax({
		url: $('#ctx').val()+'/dict/getEntryList',
		async:false,
		type:'get',
		data:'dictTypeCode='+code,
		success:function(data){
			$(data).each(function(){
				if(this.dictValue == value){
					$('#'+frameId).append('<dd><a class="z-crt" value="'+this.dictValue+'">'+this.dictName+'</a></dd>');
				}else{
					$('#'+frameId).append('<dd><a value="'+this.dictValue+'">'+this.dictName+'</a></dd>');
				}
			});
			$('#'+frameId).find('dd a').click(function(){
				$('#'+hiddenId).val($(this).attr('value'));
				$('#'+frameId).find('dd a').removeClass('z-crt');
				$(this).addClass('z-crt');
			});
			if($('#'+frameId).find('dd a[value="'+value+'"]').length > 0){
				var _this = $('#'+frameId).find('dd a[value="'+value+'"]');
				$('#'+frameId).siblings('.show-txt').find('.txt').text(_this.text());
			}
		}
	});
}

function setTextBookEntryList_ul(frameId, code, hiddenId){
	$('#'+frameId).empty();
	$('#'+frameId).append('<li><a value="" class="act">全部</a></li>');
	$.ajax({
		url: $('#ctx').val()+'/textBook/getEntryList',
		type:'get',
		data:'textBookTypeCode='+code,
		success:function(data){
			$(data).each(function(){
				$('#'+frameId).append('<li><a value="'+this.textBookValue+'">'+this.textBookName+'</a></li>');
			});
			$('#'+frameId).find('li a').click(function(){
				$('#'+hiddenId).val($(this).attr('value'));
				$('#'+frameId).find('li a').removeClass('act');
				$(this).addClass('act');
			});
		}
	});
}

function setTextBookEntryList_dl(frameId, code, hiddenId){
	var value = $('#'+hiddenId).val();
	$('#'+frameId).empty();
	$('#'+frameId).append('<dd><a class="z-crt">请选择</a></dd>');
	$.ajax({
		url: $('#ctx').val()+'/textBook/getEntryList',
		type:'get',
		data:'textBookTypeCode='+code,
		success:function(data){
			$(data).each(function(){
				if(this.dictValue == value){
					$('#'+frameId).append('<dd><a class="z-crt" value="'+this.textBookValue+'">'+this.textBookName+'</a></dd>');
				}else{
					$('#'+frameId).append('<dd><a value="'+this.textBookValue+'">'+this.textBookName+'</a></dd>');
				}
			});
			$('#'+frameId).find('dd a').click(function(){
				$('#'+hiddenId).val($(this).attr('value'));
				$('#'+frameId).find('dd a').removeClass('z-crt');
				$(this).addClass('z-crt');
			});
		}
	});
}