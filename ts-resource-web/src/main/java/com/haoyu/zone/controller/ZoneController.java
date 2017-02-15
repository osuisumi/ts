package com.haoyu.zone.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.google.common.collect.Maps;
import com.haoyu.aip.discussion.service.IDiscussionService;
import com.haoyu.competition.service.ICompetitionService;
import com.haoyu.discussion.service.IDiscussionBizService;
import com.haoyu.follow.service.IFollowBizService;
import com.haoyu.resource.service.IResourceBizService;
import com.haoyu.sip.core.entity.Relation;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.follow.entity.Follow;
import com.haoyu.sip.follow.service.IFollowService;
import com.haoyu.sip.textbook.entity.TextBookEntry;
import com.haoyu.user.entity.User;
import com.haoyu.user.service.IAccountService;
import com.haoyu.user.service.IUserService;
import com.haoyu.zone.entity.Subscribe;
import com.haoyu.zone.entity.ZoneInfo;
import com.haoyu.zone.service.IZoneService;

@Controller
@RequestMapping("zone")
public class ZoneController extends AbstractBaseController {
	@Resource
	private IResourceBizService resourceBizService;
	@Resource
	private IUserService userService;
	@Resource
	private IAccountService accountService;
	@Resource
	private IZoneService zoneService;
	@Resource
	private ICompetitionService competitionService;
	@Resource
	private IFollowService followService;
	@Resource
	private IDiscussionService discussionService;
	@Resource
	private IFollowBizService followBizService;
	@Resource
	private IDiscussionBizService discussionBizService;

	@RequestMapping(value = "index", method = RequestMethod.GET)
	public String index(Model model) {
		model.addAllAttributes(request.getParameterMap());
		return "zone/index";
	}

	/* 个人空间 */
	@RequestMapping(value = "myZone/index")
	public String myZoneIndex(Model model) {
		return "zone/myZone_index";
	}

	@RequestMapping(value = "myZone/subscribe")
	public String subscribe(Model model) {
		model.addAttribute("user", userService.get(ThreadContext.getUser().getId()));
		return "zone/list_subscribe";
	}

	@RequestMapping(value = "myZone/subscribe/resource")
	public String subscribeResource(SearchParam searchParam, Model model) {
		if(!searchParam.getParamMap().isEmpty()){
			model.addAttribute("resources", resourceBizService.listResource(searchParam, getPageBounds(10, true), true));
		}
		return "zone/list_subscribe_resource";
	}

	@RequestMapping(value = "myZone/subscribe/edit")
	public String editSubscribe(Model model) {
		model.addAttribute("user", userService.get(ThreadContext.getUser().getId()));
		return "zone/edit_subscribe";
	}

	// 取得用户的推荐列表
	@RequestMapping(value = "listData/subscribe")
	@ResponseBody
	public Map<String, Object> getSubscribeList(User user, Model model) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<TextBookEntry> subscribedList = zoneService.listSubscribed(user);
		result.put("subscribedList", addSubScribedUserAndConver(subscribedList));
		result.put("unSubscribeList", conver(zoneService.listUnsubscribe(user)));
		return result;
	}
	//更新订阅
	@RequestMapping(value="myZone/subscribe/update")
	@ResponseBody
	public Response updateSubscribe(User user,String textBookEntryIds){
		return zoneService.updateSubscribe(user, textBookEntryIds);
	}

	/* 云资源库 */
	@RequestMapping(value = "myResources/index")
	public String myResourcesIndex(SearchParam searchParam, Model model) {
		return "zone/myResources_index";
	}

	@RequestMapping(value = "myResources/list", method = RequestMethod.GET)
	public String myResources(SearchParam searchParam, Model model) {
		model.addAttribute("myResources", resourceBizService.listResource(searchParam, getPageBounds(10, true), true));
		return "zone/list_myResources";
	}

	/* 教研活动 */
	@RequestMapping(value="myCompetition/index")
	public String myCompetitionIndex(){
		return "zone/myCompetition_index";
	}
	
	@RequestMapping(value = "myCompetition/list", method = RequestMethod.GET)
	public String myCompetition(SearchParam searchParam,Model model) {
		model.addAttribute("myCompetitions",competitionService.list(searchParam, getPageBounds(10, true)) );
		return "zone/list_myCompetition";
	}

	/* 我的发现 */
	@RequestMapping(value = "myDiscovery/index")
	public String myDiscoveryIndex(SearchParam searchParam, Model model) {
		return "zone/myDiscovery_index";
	}

	@RequestMapping(value = "myDiscovery/list", method = RequestMethod.GET)
	public String myDiscovery(SearchParam searchParam, Model model) {
		model.addAttribute("myDiscoverys", resourceBizService.listResource(searchParam, getPageBounds(10, true)));
		return "zone/list_myDiscovery";
	}
	/*我的讨论*/
	@RequestMapping(value="myDiscussion/list",method=RequestMethod.GET)
	public String myDiscussion(SearchParam searchParam,Model model){
		model.addAttribute("myDiscussions", discussionBizService.listBoardDiscussion(searchParam, getPageBounds(10,true)));
		return "zone/list_myDiscussion";
	}
	

	/* 账号设置 */
	@RequestMapping(value = "user", method = RequestMethod.GET)
	public String account(User user, Model model) {
		model.addAttribute("user", userService.get(user.getId()));
		return "zone/account_index";
	}

	@RequestMapping("user/update")
	@ResponseBody
	public Response updateUser(User user, String birthday, String imageUrl) {
		if (StringUtils.isNotEmpty(birthday)) {
			try {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				user.setBornDate(sdf.parse(birthday));
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		if (StringUtils.isNotEmpty(imageUrl)) {
			user.setAvatar(imageUrl);
		}
		return userService.update(user);
	}

	/* 修改密码 */
	@RequestMapping(value = "password", method = RequestMethod.GET)
	public String password() {
		return "zone/password";
	}

	@RequestMapping(value = "password/modify")
	@ResponseBody
	public Response modifyPassword(User user, Model model, HttpSession session) {
		User currentUser = userService.get(user.getId());
		String oldPassword = request.getParameter("oldPassword");
		if (DigestUtils.md5Hex(oldPassword).equals(currentUser.getAccount().getPassword())) {
			user.getAccount().setPassword(DigestUtils.md5Hex(user.getAccount().getPassword()));
			user.getAccount().setId(currentUser.getAccount().getId());
			return accountService.update(user.getAccount());
		} else {
			return Response.failInstance().responseMsg("error oldPassword");
		}
	}

	@RequestMapping("listData/zoneInfo")
	@ResponseBody
	public ZoneInfo zoneInfo(SearchParam searchParam){
		return zoneService.zoneInfo(searchParam);
	}
	
	@RequestMapping("personal/homepage")
	public String personalHomePage(String userId,Model model){
		User user = userService.get(userId);
		model.addAttribute("user",user);
		SearchParam searchParam = new SearchParam();
		searchParam.getParamMap().put("creator", userId);
		ZoneInfo zoneInfo = zoneService.zoneInfo(searchParam);
		model.addAttribute("personalInfo", zoneInfo);
		return "zone/personal/homepage";
	}
	
	@RequestMapping("personal/resource")
	public String personalResource(SearchParam searchParam,Model model){
		model.addAttribute("myResources", resourceBizService.listResource(searchParam, getPageBounds(10, true), true));
		return "zone/personal/list_resource";
	}
	
	@RequestMapping("personal/discovery")
	public String personalDiscovery(SearchParam searchParam,Model model){
		model.addAttribute("myDiscoverys", resourceBizService.listResource(searchParam, getPageBounds(10, true)));
		return "zone/personal/list_discovery";
	}
	@RequestMapping("personal/competition")
	public String personalCompetition(SearchParam searchParam,Model model){
		model.addAttribute("myCompetitions", competitionService.list(searchParam, getPageBounds(10, true)));
		return "zone/personal/list_competition";
	}
	@RequestMapping("personal/discussion")
	public String personalDiscussion(SearchParam searchParam,Model model){
		model.addAttribute("discussions",discussionBizService.listBoardDiscussion(searchParam, getPageBounds(10, true)));
		return "zone/personal/list_discussion";
	}
	
	@RequestMapping("personal/listSubscribeUser")
	public String getSubscribe(String userId,Model model){
		Map<String,Object> parameter = Maps.newHashMap();
		parameter.put("creator",userId );
		if(ThreadContext.getUser()!= null){
			if(ThreadContext.getUser().getId().equals(userId)){
				parameter.put("idNotEqual",userId );
			}
		}
		model.addAttribute("userId",userId);
		List<User> result = followBizService.findFollowUser(parameter, getPageBounds(3,true));
		model.addAttribute("subUsers", result);
		if(CollectionUtils.isNotEmpty(result)){
			PageList pageList = (PageList)result;
			model.addAttribute("paginator",pageList.getPaginator());
		}
		return "zone/personal/list_subscribeUser";
	}
	
	private List<Subscribe> addSubScribedUserAndConver(List<TextBookEntry> subscribeList){
		List<Subscribe> result = new ArrayList<Subscribe>();
		Relation relation = new Relation();
		relation.setType("subscribe_user");
		List<Follow> follows = followService.findFollowByFollowEntity(relation, null);
		List<User> followUsers = new ArrayList<User>();
		if(CollectionUtils.isNotEmpty(follows)){
			List<String> followUserIds = new ArrayList<String>();
			for(Follow f:follows){
				followUserIds.add(f.getFollowEntity().getId());
			}
			SearchParam searchParam = new SearchParam();
			searchParam.getParamMap().put("ids",followUserIds);
			followUsers = userService.list(searchParam, null);
		}
		
		if(CollectionUtils.isNotEmpty(followUsers)){
			for(User u:followUsers){
				Subscribe s = new Subscribe(u.getRealName(), u.getId(), "user");
				result.add(s);
			}
		}
		
		if(CollectionUtils.isNotEmpty(subscribeList)){
			result.addAll(conver(subscribeList));
		}
		return result;
	}
	
	
	private List<Subscribe> conver(List<TextBookEntry> textBookEntries){
		List<Subscribe> result = new ArrayList<Subscribe>(); 
		if(CollectionUtils.isNotEmpty(textBookEntries)){
			for(TextBookEntry tb:textBookEntries){
				Subscribe s = new Subscribe(tb.getTextBookName(), tb.getTextBookValue(), tb.getTextBookTypeCode());
				s.setId(tb.getId());
				result.add(s);
			}
		}
		return result;
	}

}
