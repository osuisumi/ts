<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="termIds" type="java.lang.String" required="false"%>
<%@ attribute name="formId" type="java.lang.String" required="true"%>
<%@ attribute name="entity" type="java.lang.String" required="true"%>
<script>
	$.get('/term/listTermByOrgId','',
		function(data) {
			if (data != null) {
				$('#termCheckboxUl').append(
						'<li class="">'
							+ '<input type="checkbox" id="checkAllBtn" />'
							+ '<span class="txt">全部期次</span>'
						+ '</li>');
				$.each(data,function(i, vo) {
					$('#termCheckboxUl').append('<li class="">');
					if ('${termIds}'.contains(vo.id)) {
						$('#termCheckboxUl').append('<input type="checkbox" class="termCheckbox" value="'+vo.id+'" checked="checked" />');
					}else{
						$('#termCheckboxUl').append('<input type="checkbox" class="termCheckbox" value="'+vo.id+'" />');
					}
					$('#termCheckboxUl').append('<span class="txt">'+vo.termName+'</span></li>');
				});
				$('#checkAllBtn').unbind().click(function(){
					checkAllBox('${formId}', this)
				});
				$('#${formId} :checkbox').click(initCheckboxParam);
				initCheckboxParam();
			}
		});
</script>
<ul id="termCheckboxUl">

</ul>
<script>
function initCheckboxParam(){
	$('#${formId} .termParam').remove();
	$('#${formId} .termCheckbox:checked').each(function(i){
		var id = $(this).attr('value');
		$('#${formId}').append('<input type="hidden" name="${entity}Relations['+i+'].relation.id" class="termParam" value="'+id+'" />');
	});
}
</script>