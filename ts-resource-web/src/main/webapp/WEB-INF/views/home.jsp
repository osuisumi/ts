<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<tag:mainLayout>
	<div id="g-bn">
		<script>
			$(function(){
				$('#g-bn').load('${ctx}/advert/list', "orders=CREATE_TIME.DESC&paramMap[state]=1&paramMap[location]=1");
			})
		</script>
	</div>
	<div id="g-bd">
		<div class="f-auto">
			<div class="g-frame">
				<!-- 教育快讯 -->
				<div id="JYKX" class="g-frame-mn">
					<script>
						$(function(){
							$('#JYKX').load('${ctx}/announcement/list/image', "orders=CREATE_TIME.DESC&paramMap[type]=2&paramMap[relationId]=system");
						})
					</script>
				</div>
				<!-- 通知公告 -->
				<div id="TZGG" class="g-frame-sd">
					<script>
					$(function(){
						$('#TZGG').load('${ctx}/announcement/list/index', "limit=5&orders=CREATE_TIME.DESC&paramMap[type]=1&paramMap[relationType]=cms");
					})
					</script>
				</div>
			</div>
			<div class="g-srh-box">
				<form id="searchForm" action="${ctx }/search">
					<input type="hidden" name="orders" value="CREATE_TIME.DESC">
					<input type="hidden" name="paramMap[type]" value="resource">
					<div class="m-slt-box">
						<div class="m-slt-block1">
							<a href="javascript:void(0);" class="show-txt" title=""> <span
								class="txt">请选择学段</span> <span class="pd"> <i class="trg"></i>
							</span>
							</a> <input id="stageParam" type="hidden" name="paramMap[stage]"
								value="${resource.resourceExtend.stage }">
							<dl id="stageSelect" class="lst">
	
							</dl>
						</div>
						<div class="m-slt-block1">
							<a href="javascript:void(0);" class="show-txt" title=""> <span
								class="txt">请选择学科</span> <span class="pd"> <i class="trg"></i>
							</span>
							</a> <input id="subjectParam" type="hidden" name="paramMap[subject]"
								value="${resource.resourceExtend.subject }">
							<dl id="subjectSelect" class="lst">
	
							</dl>
						</div>
						<div class="m-slt-block1" style="""width: 206px">
							<a href="javascript:void(0);" class="show-txt" title=""> <span
								class="txt">请选择年级</span> <span class="pd"> <i class="trg"></i>
							</span>
							</a> <input id="gradeParam" type="hidden" name="paramMap[grade]"
								value="${resource.resourceExtend.grade }">
							<dl id="gradeSelect" class="lst">
	
							</dl>
						</div>
					</div>
					<div id="cloneElementDiv" style="display: none;">
						<dl class="chapterSelect" class="lst"></dl>
						<dd class="cloneOption">
							<a></a>
						</dd>
					</div>
					<script>
						$(function() {
							initTextBookEntry('z-crt', 'select');
						});
					</script>
					<label class="m-srh-ipt placeIptMod">
						<input id="keywords" type="text" name="paramMap[keywords]" class="ipt" placeholder="关键字">
					</label> 
					<a href="###" onclick="submitSearchForm()" class="u-bSrh-btn u-cont-btn"> 
						<strong> <i class="u-bSrh-ico"></i>点击搜索</strong> 
						<!-- <p>已有3,480人 通过此功能查找资料</p> -->
					</a>
				</form>
			</div>
			<div class="g-frame">
				<div class="g-frame-mn">
					<div class="g-mn-mod">
						<div id="syncResourceDiv">
							<script>
								$(function() {
									$('#syncResourceDiv').load('${ctx}/resource/syncResource', '');
								});
							</script>
						</div>
						<div id="classifyResourceDiv">
							<script>
								$(function() {
									$('#classifyResourceDiv').load('${ctx}/resource/classifyResource');
								});
							</script>
						</div>
					</div>
				</div>
				<div class="g-frame-sd">
					<div class="g-sd-mod">
						<div id="newResourceDiv">
							<script>
								$(function() {
									$('#newResourceDiv').load('${ctx}/resource/listNewResource', 'limit=5&orders=CREATE_TIME.DESC');
								});
							</script>
						</div>
					</div>
					<div class="g-sd-mod">
						<div id="rankResourceDiv">
							<script>
								$(function() {
									$('#rankResourceDiv').load('${ctx}/resource/listRankResource');
								});
							</script>
						</div>
					</div>
				</div>
			</div>
			<!-- 精彩发现 -->
			<div id="discoveryDiv" class="g-layout-mod">
				<script>
					$(function(){
						$('#discoveryDiv').load('${ctx}/discovery', "limit=4&orders=BROWSE_NUM.DESC&paramMap[type]=discovery")
					})
				</script>
			</div>
			<div class="g-frame">
                <div class="g-frame-mn">
                    <div class="g-mn-mod">
                        <div class="m-workshop-box">
                            <div class="m-mn-tt m-sd-tt">
                                <h2 class="tt">名师工作室</h2>
                                <a onclick="workshopIndex()" class="more">更多&gt;</a>
                            </div>
                            <div id="workshopDiv" class="g-mn-dt">
                                <script type="text/javascript">
                                	$(function(){
                                		$('#workshopDiv').load('${ctx}/workshop?limit=4');
                                	})
                                </script>
                            </div>   
                        </div>
                    </div>
                </div>
                <div id="rankDiscussionDiv" class="g-frame-sd">
                    <script type="text/javascript">
                    	$('#rankDiscussionDiv').load('${ctx}/board/discussion/listRankDiscussion','paramMap[relationType]=board');
                    </script>
                </div>
            </div> 
			<div id="deptStatisticDiv" class="g-layout-mod">
				<script>
					$(function(){
						$('#deptStatisticDiv').load('${ctx}/dept/loadDeptStatistic');
					})
				</script>
			</div>
		</div>
	</div>
</tag:mainLayout>
<script>
$(function(){
	changeTab('home');
});

function submitSearchForm(){
	if($('#keywords').val().length == 0){
		alert('请输入关键字再搜索');
		return false;
	}
	searchIndex('searchForm');
}
</script>