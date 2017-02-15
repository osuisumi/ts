<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="relationId" type="java.lang.String" required="false"%>
<%@ attribute name="entity" type="java.lang.String" required="false"%>
<c:if test="${not empty relationId}">
	<script>
		$.get('/tags','relation.id=${relationId}',
						function(data) {
							if (data != null) {
								var $tag_lst = $(".m-add-tag .m-tag-lst");
								$.each(data.items,function(i, tag) {
									$tag_lst.append('<li id="'+tag.id+'" class="labelLi">'+ '<span class="txt">'
														  + tag.name
														  + '</span>'
														  + '<a href="javascript:void(0);" class="dlt" title="删除标签">×</a>'
														  + '</li>');
									})

							}
						});
	</script>
</c:if>
<div class="am-pb-mod">
	<div class="c-txt">
		<em></em><span>标签：</span>
	</div>
	<div class="c-center">
		<div class="am-add-tag f-cb">
			<div class="am-tagipt am-ipt-mod">
				<input type="text" placeholder="添加标签，如：教案" value="" class="au-ipt"> 
				<a class="au-nbtn au-add-tag">+添加</a>
				<div class="l-slt-lst">
					<i class="trg"></i> <i class="trgs"></i>
					<div class="lst"></div>
				</div>
			</div>
			<ul id="labelList" class="am-tag-lst">

			</ul>
		</div>
	</div>
</div>
<script>
$(function() {
	initLabelUtils();
	
	//添加标签
	function initLabelUtils() {
		var $tag_parents = $(".am-add-tag");
	    $tag_parents.each(function(){
	        var _ts = $(this);
	            $ipt_parents = _ts.find(".am-tagipt"),
	            $ipt = $ipt_parents.find(".au-ipt"),
	            $hint_lst = $ipt_parents.find(".l-slt-lst"),
	            $add_btn = _ts.find(".au-add-tag"),
	            $tag_lst = _ts.find(".am-tag-lst");
	        //显示标签提示框  
	        tag_hint_show($ipt,$hint_lst,$add_btn);  
	        add_tag($ipt,$add_btn,$tag_lst);  
	        delete_tag($tag_lst);  
	    });
	    initLabelParam();
	}
	// 显示标签提示框
	function tag_hint_show($ipt, $hint_lst ,$add_btn) {
		// 输入框获取焦点
		$ipt.on("focus", function() {
			if (!$(this).val() == "") {
				$hint_lst.show();
			}
		});
		$ipt.on("keyup", function() {
			// 判断输入文字是，提示框显示
			if (!$(this).val() == "") {
				$.get('/tags','tag.name='+$(this).val(),function(data){
					if(data != null){
						var nameArray = data.items;
						if($(nameArray).length > 0){
							$hint_lst.find('.lst').empty();
							$(nameArray).each(function(){
								$hint_lst.find('.lst').append('<a href="###" id="'+this.id+'" title="'+this.name+'">'+this.name+'</a>');
							});
							$hint_lst.show();
						}
					}
				});
			} else {
				$hint_lst.hide();
			}
		});
		tag_hint_hide($ipt, $hint_lst ,$add_btn);
	}
	// 关闭标签提示框
	function tag_hint_hide($ipt, $hint_lst) {
		// 获取
		$(document).on("click", function(e) {
			var target = $(e.target);
			// 判断是否点击的是标签提示框和输入框，如果不是，隐藏标签提示框
			if (target.closest($hint_lst).length == 0 && target.closest($ipt).length == 0) {
				$hint_lst.hide();
			}
		});
		// 选择提示框选项关闭提示框
		$hint_lst.on("click", "a", function() {
			$hint_lst.hide();
			$ipt.val($(this).text());
			$add_btn.trigger('click');
		});
	}
	// 添加标签
	function add_tag($ipt, $add_btn, $tag_lst) {
		$add_btn.on("click", function() {
			var ss = false;
			var lengths = $tag_lst.children().length;
			// 判断输入框是否为空
			if ($ipt.val() != "") {
				// 遍历标签列表
				for (var i = 0; i < lengths; i++) {
					// 如果已有相同标签
					if ($ipt.val() == $tag_lst.children().eq(i).find(".txt").text()) {
						alert("已有相同标签");
						ss = true;
					}
				}
				// 如果没有相同标签，添加新的标签
				if (!ss) {
					//如果列表中不存在该标签, 则要插入数据库
					var id = '';
					var name = '';
					var $match = $hint_lst.find('.lst').find('a[title="'+$ipt.val()+'"]');
					if($match.length == 0){
						$.ajax({
							url: '/tags',
							data: 'name='+$ipt.val(),
							type: 'post',
							async: false,
							success: function(data){
								if(data.responseCode == '00' ){
									var label = data.responseData;
									id = label.id;
									name = label.name;
								}	
							}
						});
					}else{
						id = $match.attr('id');
						name = $match.attr('title');
					}
					$tag_lst.append('<li class="labelLi" id="'+id+'" >' 
							+ '<span class="txt">' + name + '</span>' 
							+ '<a href="javascript:void(0);" class="dlt" title="删除标签">×</a>' 
						+ '</li>');
					// 添加标签后，清除输入框中的文字
					$ipt.val("");
					//更新参数
					initLabelParam();
				}
			}else{
				alert('请输入标签内容');
			}
		});
	}
	// 删除标签
	function delete_tag($tag_lst) {
		$(document).on("click", "#labelList .dlt", function() {
			$(this).parent().remove();
			initLabelParam();
		});
	}

	function initLabelParam(){
		var $form = $('#labelList').closest('form');
		$form.find('.labelParam').remove();
		$('#labelList').find('.labelLi').each(function(i) {
			var id = $(this).attr('id');
			if('${entity}' != ''){
				$form.append('<input class="labelParam" name="${entity}.tags[' + i + '].id" value="' + id + '" type="hidden"/>');
			}else{
				$form.append('<input class="labelParam" name="tags[' + i + '].id" value="' + id + '" type="hidden"/>');	
			}
		});
	}
});
</script>