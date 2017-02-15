<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<tag:mainLayout>
	<div id="g-bd">
		<div class="f-auto">
			<div class="g-layout-mod">
				<div class="m-logo-box">
					<div class="logo-lt">
						<a class="u-logo"> 
							<c:choose>
								<c:when test="${empty dept.imageUrl }">
									<img src="${ctx}/images/no-logo.png" width="91" height="91">
								</c:when>
								<c:otherwise>
									<img src="${file:getFileUrl(dept.imageUrl) }" width="91" height="91">
								</c:otherwise>
							</c:choose>
							<h1>${dept.deptName}校本资源平台</h1>
							<p>育人为本，自主发展，追求卓越</p>
						</a>
					</div>
					<div class="logo-rt">
						<p>资源总量：${resourceNum } 个</p>
						<p>本月新增：${newResourceNum }个</p>
					</div>
					<div class="u-light-line"></div>
                    <a onclick="goSchool('${dept.website }')"  class="u-rt-btn">前往学校</a>
				</div>
			</div>
			<div  class="g-layout-mod">
				<div  id="XXZX" class="g-mn-mod">
					<!--  学校资讯 插入内容   list_announcement_xxzx.jsp -->
					<script type="text/javascript">
						$('#XXZX').load('${ctx}/announcement/list/xxzx', "orders=CREATE_TIME.DESC&paramMap[type]=2&paramMap[relationId]=${dept.id}&paramMap[state]=1");
					</script>
				</div>
			</div>
			<div class="g-frame">
				<div id="g-frame-mn" class="g-frame-mn">
					<%-- 这里插入shareMaster.jsp  --%>
					<script type="text/javascript">
						$('#g-frame-mn').load('${ctx}/dept/shareMaster', "paramMap[deptId]=${dept.id}");
					</script>
				</div>
				<div id="g-frame-sd" class="g-frame-sd">
					<%-- 这里插入dynamic/list-dynamic.jsp --%>
					<script type="text/javascript">
						$("#g-frame-sd").load('${ctx}/dynamic/list?deptId=${dept.id}');
					</script>
				</div>
			</div>
			<div class="g-frame">
				<div class="g-frame-mn">
					<div class="g-mn-mod">
						<div class="m-resource-box">
							<div class="m-mn-tt">
								<h2 class="tt small">
									最新上传资源<a onclick="resourceIndex('${dept.id}')" class="u-more">更多&gt;</a>
								</h2>
							</div>								
							<div id="listSyncResourceDiv">
								<script type="text/javascript">
									$('#listSyncResourceDiv').load('${ctx }/resource/listResource', "limit=4&paramMap[relationId]=${dept.id}")
								</script>
							</div>						
							<!--  从这里开始引入list_resource.jsp  这一部分现已修改放到  div id = listSyncResourceDiv-->
						</div>
					</div>
				</div>
				<div class="g-frame-sd">
					<div class="g-sd-mod">
						<!-- 这里引入list_new_discovery.jsp -->
						<div class="m-new-trend" style="min-height: 325px;">
							<div class="m-sd-tt">
								<h3 class="tt">
									最新发现
									<a href="javascript:discoveryIndex('${dept.id}');" class="u-more">更多&gt;</a>
								</h3>
							</div>
							<div  id="discovery">
								<script type="text/javascript">
									$('#discovery').load('${ctx}/discovery/listNewDiscovery', "limit=4&orders=CREATE_TIME.DESC&paramMap[type]=discovery&paramMap[relationId]=${dept.id}")
								</script>
								<!--  这里引入list_new_discovery.jsp结束 -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(function(){
			changeTab('school');
		})
	</script>
</tag:mainLayout>
<script>
function goSchool(url){
	if(url != null && url != ''){
		window.open(url);
	}else{
		alert('此学校还未设置链接网站');
	}
}
</script>