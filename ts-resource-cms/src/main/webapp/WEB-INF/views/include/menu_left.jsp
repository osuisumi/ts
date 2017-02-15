<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div id="g-sidebar" style="margin-left: 0; width: 100%; overflow: auto; min-height: 400px;">
	<ul id="menuUl" class="m-side-menu">
		
	</ul>
</div>
<script>
$(function(){
	$.get('${ctx}/menu/getAuthMenuTree','',function(data){
		var json = $.parseJSON(data);
		$(json).each(function(){
			$('#menuUl').append('<li id="childMenu_'+this.id+'"><h3 class="tt">'+this.text+'</h3></li>');
			if(this.children!= null && this.children.length > 0){
				$(this.children).each(function(){
					$('#childMenu_'+this.pid).append('<a url="${ctx}'+this.attributes.url+'" class="menu-item '+this.iconCls+'"><span>'+this.text+'</span></a>');
				});
			}
		});
		$('#menuUl li a').click(function(){
			$('#menuUl li a').removeClass('z-crt');
			$(this).addClass('z-crt');
			easyui_tabs_add($('#layout_center_tabs'), $(this).attr('url'), $(this).find('span').text());
		});
	});
});
</script>