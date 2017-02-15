//学段
function initTextBookEntry(selectedClassName, type){
	var option = $('#cloneElementDiv .cloneOption');
	var msg = '全部';
	if(type == 'select'){
		msg = '请选择学段';
	}
	var value = $('#stageParam').val();
	$('#stageSelect').empty();
	var op = option.clone();
	op.find('a').addClass(selectedClassName).text(msg);
	$('#stageSelect').append(op);
	$.ajax({
		url: $('#ctx').val()+'/textBook/getEntryList',
		async:false,
		type:'get',
		data:'textBookTypeCode=STAGE',
		success:function(data){
			$(data).each(function(){
				var op = option.clone();
				if(this.textBookValue == value){
					op.find('a').addClass(selectedClassName).attr('value',this.textBookValue).text(this.textBookName)
				}else{
					op.find('a').attr('value',this.textBookValue).text(this.textBookName)
				}
				$('#stageSelect').append(op);
			});
			$('#stageSelect a').click(function(){
				$('#stageParam').val($(this).attr('value'));
				$('#stageSelect a').removeClass(selectedClassName);
				$(this).addClass(selectedClassName);
				changeSubject(option, selectedClassName, type);
			});
			if($('#stageSelect a[value="'+value+'"]').length > 0){
				$('#stageSelect a[value="'+value+'"]').trigger('click');
				var _this = $('#stageSelect').find('dd a[value="'+value+'"]');
				$('#stageSelect').siblings('.show-txt').find('.txt').text(_this.text());
			}else{
				$('#stageSelect a:first').trigger('click');
			}
		}
	});
	
	//教材版本
	var value = $('#tbVersionParam').val();
	$('#tbVersionSelect').empty();
	var msg = '全部';
	if(type == 'select'){
		msg = '请选择教材版本';
	}
	var op = option.clone();
	op.find('a').addClass(selectedClassName).text(msg)
	$('#tbVersionSelect').append(op);
	$.ajax({
		url: $('#ctx').val()+'/textBook/getEntryList',
		async:false,
		type:'get',
		data:'textBookTypeCode=VERSION',
		success:function(data){
			$(data).each(function(){
				var op = option.clone();
				if(this.textBookValue == value){
					op.find('a').addClass(selectedClassName).attr('value',this.textBookValue).text(this.textBookName);
				}else{
					op.find('a').attr('value',this.textBookValue).text(this.textBookName);
				}
				$('#tbVersionSelect').append(op);
			});
			$('#tbVersionSelect a').click(function(){
				$('#tbVersionParam').val($(this).attr('value'));
				$('#tbVersionSelect a').removeClass(selectedClassName);
				$(this).addClass(selectedClassName);
				changeSection(option, selectedClassName, type);
			});
			if($('#tbVersionSelect a[value="'+value+'"]').length > 0){
				$('#tbVersionSelect a[value="'+value+'"]').trigger('click');
				var _this = $('#tbVersionSelect').find('dd a[value="'+value+'"]');
				$('#tbVersionSelect').siblings('.show-txt').find('.txt').text(_this.text());
			}else{
				$('#tbVersionSelect a:first').trigger('click');
			}
		}
	});
}

//学科
function changeSubject(option, selectedClassName, type){
	var value = $('#subjectParam').val();
	$('#subjectSelect').empty();
	var msg = '全部';
	if(type == 'select'){
		msg = '请选择学科';
	}
	var op = option.clone();
	op.find('a').addClass(selectedClassName).text(msg)
	$('#subjectSelect').append(op);
	var stage = $('#stageParam').val();
	$.ajax({
		url: $('#ctx').val()+'/textBook/getEntryListByEntity',
		async:false,
		type:'get',
		data:'textBookTypeCode=SUBJECT&stage='+stage,
		success:function(data){
			$(data).each(function(){
				var op = option.clone();
				if(this.textBookValue == stage){
					op.find('a').addClass(selectedClassName).attr('value',this.textBookValue).text(this.textBookName);
				}else{
					op.find('a').attr('value',this.textBookValue).text(this.textBookName);
				}
				$('#subjectSelect').append(op);
			});
		}
	});
	$('#subjectSelect a').click(function(){
		$('#subjectParam').val($(this).attr('value'));
		$('#subjectSelect a').removeClass(selectedClassName);
		$(this).addClass(selectedClassName);
		changeGrade(option, selectedClassName, type);
	});
	if($('#subjectSelect a[value="'+value+'"]').length > 0){
		$('#subjectSelect a[value="'+value+'"]').trigger('click');
		var _this = $('#subjectSelect').find('dd a[value="'+value+'"]');
		$('#subjectSelect').siblings('.show-txt').find('.txt').text(_this.text());
	}else{
		$('#subjectSelect a:first').trigger('click');
	}
}

//年级
function changeGrade(option, selectedClassName, type){
	var value = $('#gradeParam').val();
	$('#gradeSelect').empty();
	var msg = '全部';
	if(type == 'select'){
		msg = '请选择年级';
	}
	var op = option.clone();
	op.find('a').addClass(selectedClassName).text(msg)
	$('#gradeSelect').append(op);
	var stage = $('#stageParam').val();
	var subject = $('#subjectParam').val();
	$.ajax({
		url: $('#ctx').val()+'/textBook/getEntryListByEntity',
		async:false,
		type:'get',
		data:'textBookTypeCode=GRADE&stage='+stage+'&subject='+subject,
		success:function(data){
			$(data).each(function(){
				var op = option.clone();
				if(this.textBookValue == value){
					op.find('a').addClass(selectedClassName).attr('value',this.textBookValue).text(this.textBookName);
				}else{
					op.find('a').attr('value',this.textBookValue).text(this.textBookName);
				}
				$('#gradeSelect').append(op);
			});
		}
	});
	$('#gradeSelect a').click(function(){
		$('#gradeParam').val($(this).attr('value'));
		$('#gradeSelect a').removeClass(selectedClassName);
		$(this).addClass(selectedClassName);
		changeSection(option, selectedClassName, type);
	});
	if($('#gradeSelect a[value="'+value+'"]').length > 0){
		$('#gradeSelect a[value="'+value+'"]').trigger('click');
		var _this = $('#gradeSelect').find('dd a[value="'+value+'"]');
		$('#gradeSelect').siblings('.show-txt').find('.txt').text(_this.text());
	}else{
		$('#gradeSelect a:first').trigger('click');
	}
}

//章
function changeSection(option, selectedClassName, type){
	var chapterSelect = getOuterHtml($('#cloneElementDiv .chapterSelect'));
	var value = $('#sectionParam').val();
	var subject = $('#subjectParam').val();
	var grade = $('#gradeParam').val();
	var stage = $('#stageParam').val();
	var tbVersion = $('#tbVersionParam').val();
	$('#sectionSelect').empty();
	var msg = '全部';
	if(type == 'select'){
		msg = '请选择章节';
		var op = option.clone();
		op.find('a').addClass(selectedClassName).text(msg);
		$('#sectionSelect').append(op);
	}
	if(subject != '' && grade != '' && stage != '' && tbVersion != ''){
		$.ajax({
			url: $('#ctx').val()+'/textBook/getEntryListByEntity',
			async:false,
			type:'get',
			data:'textBookTypeCode=SECTION&subject='+subject+'&grade='+grade+'&stage='+stage+'&version='+tbVersion,
			success:function(data){
				if(type == 'select'){
					$('#chapterListDiv').html('')
					$(data).each(function(){
						var op = option.clone();
						if(this.textBookValue == value){
							op.find('a').addClass(selectedClassName).attr('value',this.textBookValue).text(this.textBookName).click(function(){
								changeChapter($(this).attr('value'), type);
							});;
						}else{
							op.find('a').attr('value',this.textBookValue).text(this.textBookName).click(function(){
								changeChapter($(this).attr('value'), type);
							});;
						}
						$('#sectionSelect').append(op);
						var op = option.clone();
						op.find('a').addClass(selectedClassName).text(msg);
						$('#chapterListDiv').append($(chapterSelect).attr('id','chapterSelect_'+this.textBookValue).append(op));
						var childList = this.childTextBookEntrys;
						var parentValue = this.textBookValue;
						if($(childList).length > 0){
							$(childList).each(function(){
								var op = option.clone();
								op.find('a').attr('value',this.textBookValue).text(this.textBookName)
								$('#chapterSelect_'+parentValue).append(op);
							});
						}
					});
				}else{
					$(data).each(function(){
						var op = option.clone();
						if(this.textBookValue == value){
							op.find('a').addClass(selectedClassName).attr('value',this.textBookValue).text(this.textBookName).click(function(){
								changeChapter($(this).attr('value'), type);
							});
						}else{
							op.find('a').attr('value',this.textBookValue).text(this.textBookName).click(function(){
								changeChapter($(this).attr('value'), type);
							});;
						}
						op.append($(chapterSelect).attr('id','chapterSelect_'+this.textBookValue));
						$('#sectionSelect').append(op);
						var childList = this.childTextBookEntrys;
						var parentValue = this.textBookValue;
						if($(childList).length > 0){
							$(childList).each(function(){
								var op = option.clone();
								op.find('a').attr('value',this.textBookValue).text(this.textBookName).click(function(){
									$('#chapterParam').val($(this).attr('value'));
									listMoreResource();
								});
								$('#chapterSelect_'+parentValue).append(op);
							});
						}
					});
				}
			}
		});
	}
	if($('#sectionSelect a[value="'+value+'"]').length > 0){
		$('#sectionSelect a[value="'+value+'"]').trigger('click');
		var _this = $('#sectionSelect').find('dd a[value="'+value+'"]');
		$('#sectionSelect').siblings('.show-txt').find('.txt').text(_this.text());
	}else{
		$('#sectionSelect a:first').trigger('click');
	}	
	if(type == 'radio' && $('#sectionSelect a').length == 0){
		$('#sectionParam').val('');
		$('#chapterParam').val('');
		listMoreResource();
	}
}


//节
function changeChapter(textBookValue, type){
	var value = $('#chapterParam').val();
	$('#sectionParam').val(textBookValue);
	if(textBookValue != null && textBookValue != ''){
		if(type == 'select'){
			$('#chapterSelect').html($('#chapterSelect_'+textBookValue).html());
			$('#chapterDiv').show();
		}
		$('#chapterSelect a').click(function(){
			$('#chapterParam').val($(this).attr('value'));
		});
		if($('#chapterSelect a[value="'+value+'"]').length > 0){
			$('#chapterSelect a[value="'+value+'"]').trigger('click');
		}else{
			$('#chapterSelect a:first').trigger('click');
		}	
	}else{
		$('#chapterParam').val('');
		$('#chapterDiv').hide();
	}
	if(type == 'radio'){
		$('#chapterParam').val('');
		listMoreResource();
	}else{
		if($('#chapterSelect a[value="'+value+'"]').length > 0){
			$('#chapterSelect a[value="'+value+'"]').trigger('click');
			var _this = $('#chapterSelect').find('dd a[value="'+value+'"]');
			$('#chapterSelect').siblings('.show-txt').find('.txt').text(_this.text());
		}
	}
}