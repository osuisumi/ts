<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="relationId" type="java.lang.String" required="false"%>
<c:choose>
	<c:when test="${not empty relationId}">
		<script>
			$.get('/tags','relation.id=${relationId}',function(data) {
				if (data != null) {
					$.each(data.items,function(i, tag) {
						var $tag = $('#tagId').clone();
						$('#tagId').after($tag.text(tag.name));
					});  
					$('#tagId').remove();
				}
			});
		</script>
	</c:when>
	<c:otherwise>
		<script>	
			$('#tagId').remove();
		</script>	
	</c:otherwise>
</c:choose>
