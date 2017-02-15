<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="file" uri="http://file.haoyu.com" %>
<%@ attribute name="url" type="java.lang.String" required="true"%>
<c:set var="suffix" value="${file:getFileSuffix(url) }" />
<c:choose>
	<c:when test="${fn:contains('doc, docx, pdf, ppt, pptx', suffix) }">
		<iframe src="${file:getPreviewPath(url) }" 
			width='100%' height='500px' frameborder='0'>
			<!-- <a target='_blank' href='http://office.com'>Microsoft Office</a> 文档，由 
			<a target='_blank' href='http://office.com/webapps'>Office Online</a> 支持。 -->
		</iframe>
	</c:when>
	<c:when test="${fn:contains('mp4, flv, mp3, flash', suffix) }">
		<div id="jp_container_1" class="jp-video" role="application" aria-label="media player">
			<div class="jp-type-single">
				<div id="jquery_jplayer_1" class="jp-jplayer"></div>
				<div class="jp-gui">
					<div class="jp-video-play">
						<button class="jp-video-play-icon" role="button" tabindex="0">play</button>
					</div>
					<div class="jp-interface">
						<div class="jp-progress">
							<div class="jp-seek-bar">
								<div class="jp-play-bar"></div>
							</div>
						</div>
						<div class="jp-current-time" role="timer" aria-label="time">&nbsp;</div>
						<div class="jp-duration" role="timer" aria-label="duration">&nbsp;</div>
						<div class="jp-controls-holder">
							<div class="jp-controls">
								<button class="jp-play" role="button" tabindex="0">play</button>
								<button class="jp-stop" role="button" tabindex="0">stop</button>
							</div>
							<div class="jp-volume-controls">
								<button class="jp-mute" role="button" tabindex="0">mute</button>
								<button class="jp-volume-max" role="button" tabindex="0">max volume</button>
								<div class="jp-volume-bar">
									<div class="jp-volume-bar-value"></div>
								</div>
							</div>
							<div class="jp-toggles">
								<button class="jp-repeat" role="button" tabindex="0">repeat</button>
								<button class="jp-full-screen" role="button" tabindex="0">full screen</button>
							</div>
						</div>
						<div class="jp-details">
							<div class="jp-title" aria-label="title">&nbsp;</div>
						</div>
					</div>
				</div>
				<div class="jp-no-solution">
					<span>Update Required</span> To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
				</div>
			</div>
		</div>
		<script type="text/javascript">
				$(function(){
					createJPlayer('${file:getFileUrl(url)}', '');
				});
		</script>
	</c:when>
	<c:otherwise>
		<a href="###" class="u-zip-dl"><i></i></a>
	</c:otherwise>
</c:choose>
