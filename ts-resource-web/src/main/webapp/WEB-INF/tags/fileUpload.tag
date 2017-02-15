<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="relationId" type="java.lang.String" required="false"%>
<%@ attribute name="btnTitle" type="java.lang.String" required="false"%>
<%@ attribute name="fileLimit" type="java.lang.String" required="false"%>
<div class="am-file-upload">
	<div class="am-ful-btn">
		<a href="javascript:void(0);" class="au-file-show-btn l-btn" id="picker"> <i class="au-link-ico"></i><span id="btnTitle">选择附件</span></a> 
	</div>
	<ul id="fileList" class="am-ful-lst">
	</ul>
</div>
<c:if test="${not empty relationId}">
	<script>
		$.get('/file','relationId=${relationId}',function(data) {
			if (data != null) {
				var $tag_lst = $("#fileList");
				$.each(data,function(i, tag) {
					$tag_lst.append('<li class="fileLi success" fileId="'+this.id+'">'+
										'<a class="txt">'+this.fileName+'</a>'+
										'<a class="dlt" title="删除附件">×</a>'+
									'</li>'
					);
				});
				initFileParam();
			}
		});
	</script>
</c:if>
<script>
	$(function(){
		if('${btnTitle}' != ''){
			$('#btnTitle').text('${btnTitle}');
		}
		
		initRemoteUploader('${ctx}/file/uploadTemp.do','${fileLimit}');
	});
</script>