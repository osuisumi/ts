function home() {
	window.location.href = $('#ctx').val() + '/home'
}

function workshopIndex(){
	window.location.href = $('#ctx').val() + '/workshop/more?orders=CREATE_TIME.DESC';
}

function viewWorkshop(id){
	window.location.href = $('#ctx').val() + '/workshop/'+id+'/view';
}

function resourceIndex(relationId) {
	var url = $('#ctx').val() + '/resource/resourceIndex';
	if(relationId){
		url += '?relationId='+relationId;
	}
	window.location.href = url;
}

function addResource(relationType,relationId) {
	if(!relationType){
		relationType = 'default';
	}
	if(!relationId){
		relationId = 'default';
	}
	window.location.href = $('#ctx').val() + '/resource/addResource?resourceRelations[0].relation.type='+relationType+'&resourceRelations[0].relation.id='+relationId;
	//$('#content').load($('#ctx').val() + '/resource/addResource?resourceRelations[0].relation.type='+relationType+'&resourceRelations[0].relation.id='+relationId);
}

function editResource(id) {
	window.location.href = $('#ctx').val() + '/resource/editResource', 'id=' + id;
}

function viewResource(id) {
	//$('#content').load($('#ctx').val() + '/resource/viewResource', 'id=' + id);
	window.open($('#ctx').val() + '/resource/viewResource?id='+id);
}

function goLoginForAddResource(type,relationId){
	goLogin(function(){
		addResource(type,relationId);
	});
}

function announcementIndex(){
	//$('#content').load($('#ctx').val()+'/announcement/more',"paramMap[type]=1");
	window.location.href = $('#ctx').val()+'/announcement/announcementIndex';
}
function viewAnnouncement(id){
	//$('#content').load();
	window.open($('#ctx').val()+"/announcement/"+id+"/view");
}

function listMoreAnnouncement(relationId){
	window.location.href=$('#ctx').val() + "/announcement/more?orders=CREATE_TIME.DESC&limit=10&paramMap[relationId]="+relationId;
}

function discoveryIndex(){
	//$('#content').load($('#ctx').val()+'/discovery/index');
	window.location.href = $('#ctx').val()+'/discovery/index';
}

function addDiscovery(backPage){
	$('#content').load($('#ctx').val()+"/discovery/create?backPage="+backPage);
}

function deleteDiscovery(id,backPage) {
	confirm("确定删除？", function() {
		$.ajaxDelete($('#ctx').val()+"/discovery/" + id + "/delete", null, function(response) {
			if (response.responseCode == '00') {
				alert("删除成功");
				if(backPage == 'zone'){
					zoneIndex();
				}else{
					discoveryIndex();
				}
			}
		});
	});
}

function editDiscovery(id,backPage) {
	$('#content').load($('#ctx').val()+'/discovery/' + id + '/edit?backPage='+backPage);
}

function viewDiscovery(id){
	//$('#content').load($('#ctx').val()+"/discovery/"+id+"/view");
	window.open($('#ctx').val()+"/discovery/"+id+"/view");
}

function viewBoardDiscussion(id){
	//$('#content').load($('#ctx').val()+"/discussion/"+id+"/view");
	window.location.href = $('#ctx').val()+"/board/discussion/"+id+"/view";
}

function boardIndex(boardId){
	if(!boardId){
		boardId = 'default';
	}
	window.location.href = $('#ctx').val()+"/board/index?boardId="+boardId;
}

function zoneIndex(item){
	if(!item){
		item = 'default';
	}
	window.location.href = $('#ctx').val()+"/zone/index?item="+item;
}

function competitionIndex(){
	window.location.href = $('#ctx').val()+"/competition/index"
}

function viewCompetition(id){
	window.open($('#ctx').val()+"/competition/"+id+"/view");
}
//对活动的资源投票
function vote(resourceId,relationId,a){
	$.post($('#ctx').val()+"/competition/getDataByResource",{
		"resourceRelations[0].relation.id":relationId
	},function(response){
		var competition = response;
		var now = new Date();
		if(now.getTime()<competition.attitudeTimePeriod.startTime){
			alert('投票尚未开始');
			return false;
		}else if(now.getTime() >competition.attitudeTimePeriod.endTime ){
			alert('投票时间结束');
			return false;
		}
		attitude_support(resourceId,'competition',a,'vote');
	});
}

function deleteResource(id, url){
	confirm('确定要删除这个资源吗?', function(){
		$.post($('#ctx').val() + '/resource/deleteResource', 'id='+id, function(data){
			alert('删除成功', function(){
				window.location.href = url;
			});
		});
	});
}

function downloadFile(id, fileName, type, relationId) {
	$('#downloadFileForm input[name="id"]').val(id);
	$('#downloadFileForm input[name="fileName"]').val(fileName);
	$('#downloadFileForm input[name="fileRelations[0].type"]').val(type);
	$('#downloadFileForm input[name="fileRelations[0].relation.id"]').val(relationId);
	goLogin(function(){
		$('#downloadFileForm').submit();
	});
}

function updateFile(id, fileName) {
	$('#updateFileForm input[name="id"]').val(id);
	$('#updateFileForm input[name="fileName"]').val(fileName);
	$.post($('#ctx').val()+'/file/updateFileInfo.do', $('#updateFileForm').serialize());
}

function deleteFileRelation(fileId, relationId, relationType) {
	$('#deleteFileRelationForm input[name="fileId"]').val(fileId);
	$('#deleteFileRelationForm input[name="relation.id"]').val(relationId);
	$('#deleteFileRelationForm input[name="type"]').val(relationType);
	$.post($('#ctx').val()+'/file/deleteFileRelation.do', $('#deleteFileRelationForm').serialize());
}

function attitude_support(id,type,a,attitude){
	if(!attitude){
		var attitude = 'support';
	}
	goLogin(function (){
		$.post($('#ctx').val()+"/attitudes",{
			"attitude":attitude,
			"relation.id":id,
			"relation.type":type
		},function(response){
			if(response.responseCode == '00'){
				var numSpan = $(a).closest('.attitude_num').find('.sup_num');
				numSpan.text(parseInt(numSpan.text())+1);
				alert('操作成功');
				if(attitude == 'vote'){
					$(a).after('<p class="u-yt z-crt">已投票</p>').hide();
				}
			}else{
				if(attitude == 'vote'){
					alert('已投票');
				}else{
					alert('已经赞过');
				}
			}
		})
	},function(){
		if(type == 'discovery'){
			viewDiscovery(id);
		}else if(type =='resource'){
			viewResource(id);
		}else if(type =='discussion'){
			viewBoardDiscussion(id);
		}else if(type == 'discussionPost'){
			var mainPostId = $(a).closest('.discussionPost').find('.u-floor').attr('value');
			$('#content').load($('#ctx').val()+"/board/discussion/"+id+"/view","targetId="+mainPostId+"&page="+Math.ceil(mainPostId/10));
		}else if(type == 'competition'){
			
		}
	});
}

function searchIndex(formId){
	window.location.href = $('#'+formId).attr('action')+'?'+$('#'+formId).serialize();
	//$.ajaxQuery(formId,'content');
}

//listId:列表id(ul) listliType:列表项类型(li)  append:追加类型时的分割符号(' ','-')  imgElementType:图标所在的元素类型(a)  imgElementIndex:图标所在元素类型对应的index replaceRule:替换规则
function changeFileType(list,listliType,append,imgElementType,imgElementIndex,fileElementType,fileElementIndex,replaceRule){
	replaceRule = arguments[2]||{
		"video":"video",
		"pic":"pic",
		"txt":"txt",
		"word":"word",
		"excel":"excel",
		"zip":"zip",
		"ppt":"ppt"
			
	};
	//拿到所有待替换的元素
	var video = ['mp4','flv'];
	var pic = ['bmp','png','jpeg','jpg','gif'];
	var txt = ['txt'];
	var word = ['doc','docx'];
	var excel = ['xls','xlsx'];
	var zip = ['rar','zip'];
	var ppt = ['ppt', 'pptx'];
	var pdf = ['pdf'];
	var lis = $(list).find(listliType);
	//拿到文件名
	$.each(lis,function(i,li){
		var fileName;
		if(listliType == fileElementType){
			fileName = $(li).text();
		}else{
			fileName = $(li).find(fileElementType).eq(fileElementIndex).text()
		}
		var fileType = fileName.substr(fileName.lastIndexOf(".")+1).trim();
		
		//图标元素的class
		var imageElement;
		if($(li).find(imgElementType).size()<=0 && listliType == imgElementType){
			imageElement = $(li);
		}else{
			imageElement = $(li).find(imgElementType).eq(imgElementIndex);
		}
		var resultType = '';
		for(var i=0;i<video.length;i++){
			if(video[i].equalsIgnoreCase(fileType)){
				resultType = 'video';
				break;
			}
		}
		
	 	if(resultType == ''){
			for(var i=0;i<pic.length;i++){
				if(pic[i].equalsIgnoreCase(fileType)){
					resultType = 'pic';
					break;
				}
			}
		}
		
		if(resultType == ''){
			for(var i=0;i<txt.length;i++){
				if(txt[i].equalsIgnoreCase(fileType)){
					resultType = 'txt';
					break;
				}
			}
		}
		
		if(resultType == ''){
			for(var i=0;i<word.length;i++){
				if(word[i].equalsIgnoreCase(fileType)){
					resultType = 'word';
					break;
				}
			}
		}
		
		if(resultType == ''){
			for(var i=0;i<excel.length;i++){
				if(excel[i].equalsIgnoreCase(fileType)){
					resultType = 'excel';
					break;
				}
			}
		}
		
		if(resultType == ''){
			for(var i=0;i<zip.length;i++){
				if(zip[i].equalsIgnoreCase(fileType)){
					resultType = 'zip';
					break;
				}
			}
		} 
		
		if(resultType == ''){
			for(var i=0;i<ppt.length;i++){
				if(ppt[i].equalsIgnoreCase(fileType)){
					resultType = 'ppt';
					break;
				}
			}
		} 
		if(resultType == ''){
			for(var i=0;i<pdf.length;i++){
				if(pdf[i].equalsIgnoreCase(fileType)){
					resultType = 'pdf';
					break;
				}
			}
		} 
		imageElement.attr('class',imageElement.attr('class')+append+resultType);
	});
}
/** 学校栏目 hqy*/
function schoolIndex(){
	//$('#content').load($('#ctx').val() + '/dept/more?paramMap[deptType]=2&orders=CREATE_TIME.DESC');
	window.location.href = $('#ctx').val() + '/dept/index';
}
/** 发现主页 */
function discoveryIndex(relationId) {
	var url = $('#ctx').val() + '/discovery/index';
	if(relationId){
		url += '?relationId='+relationId;
	}
	window.location.href = url;
}
function editPlan(id){
	$('#editPlanDiv').load($('#ctx').val()+'/plan/'+id+'/edit.do',null,function() {
		commonCssUtils.openModelWindow($('#editPlanDiv'));
	});
}

function deletePlan(id,relationId){
	confirm('确认要删除该计划吗?',function(){
		$.ajaxDelete($('#ctx').val()+'/plan/'+id,null,function(response){
			if(response.responseCode == '00'){
				listMorePlan(relationId);
			}
		})
	});
}

function viewDept(deptId) {
	//$('#content').load('${ctx}/dept?id=' + deptId, null);
	window.location.href = $('#ctx').val()+"/dept?id=" + deptId;
}
