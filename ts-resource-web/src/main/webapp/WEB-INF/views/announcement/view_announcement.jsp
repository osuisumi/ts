<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<tag:mainLayout>
	<div id="wrap">
		<div id="g-bd">
			<div class="f-auto">
				<div class="g-inner-bd">
					<div class="m-crm">
						<span class="txt">您当前的位置： </span>
							<a onclick="home()" title="首页" class="u-goto-index"> <i class="u-sHome-ico"></i></a> <span class="trg">&gt;</span> 
							<c:if test="${announcement.type eq '2' }">
								<a href="${retUrl}">
									<c:choose>
										<c:when test="${announcement.announcementRelations[0].relation.type eq 'school' }">
											学校资讯
										</c:when>
										<c:when test="${announcement.announcementRelations[0].relation.type eq 'system' }">
											教育快讯
										</c:when>
										<c:when test="${announcement.announcementRelations[0].relation.type eq 'competition' }">
											活动公告
										</c:when>
										<c:when test="${announcement.announcementRelations[0].relation.type eq 'workshop' }">
											工作室通知
										</c:when>
										<c:otherwise>
											
										</c:otherwise>
									</c:choose>
								</a> 
							</c:if>
							<c:if test="${announcement.type eq '1' }">
								<a href="${retUrl}"> 
									通知公告
								</a>
							</c:if>
						<span class="trg">&gt;</span> <em>
							<c:if test="${announcement.type eq '2' }">
								<c:choose>
										<c:when test="${announcement.announcementRelations[0].relation.type eq 'school' }">
											学校资讯正文
										</c:when>
										<c:when test="${announcement.announcementRelations[0].relation.type eq 'system' }">
											教育快讯正文
										</c:when>
										<c:when test="${announcement.announcementRelations[0].relation.type eq 'competition' }">
											活动公告正文
										</c:when>
										<c:when test="${announcement.announcementRelations[0].relation.type eq 'workshop' }">
											工作室通知正文
										</c:when>
										<c:otherwise>
											
										</c:otherwise>
									</c:choose>
							</c:if>
							<c:if test="${announcement.type eq '1' }">
								通知公告正文
							</c:if>
						</em>
					</div>
					<div class="g-mn-mod">
						<div class="g-txt-detail">
							<h2 class="title">${announcement.title}</h2>
							<div class="info">
								<span>发布人：${announcement.creator.realName }</span> <span>发布日期：${sipc:formatDate(announcement.createTime,'yyyy-MM-dd') }</span>
							</div>
							<div class="txt-cont">
								<!-- <img src="../images/news-img2.jpg" alt="台山市“文明旅游进校园”道德讲堂"> -->
								${sipc:split(announcement.content,announcement.id,0) }
							</div>
						</div>
					</div>
					<div class="g-mn-mod">
						<ul id="announcementFile">
							<c:forEach items="${announcement.fileInfos }" var="file">
								<li class="m-arr-block">
                                    <i class="type-ico"></i>
                                    <h4 class="tt"><a onclick="downloadFile('${file.id}','${file.fileName }')">${file.fileName }</a></h4>
                                </li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</tag:mainLayout>
<script type="text/javascript">
	changeTab('announcement');
	changeFileType($('#announcementFile'),'li',' ','li',0,'a',0);
	
</script>
