package com.haoyu.plan.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.tip.plan.entity.Plan;
import com.haoyu.tip.plan.service.IPlanService;

@Controller
@RequestMapping("plan")
public class PlanBizController extends AbstractBaseController{
	
	@Resource
	private IPlanService planService;

	@RequestMapping("newestPlan")
	public String newestPlan(SearchParam searchParam, Model model){
		List<Plan> plans = planService.list(searchParam, getPageBounds(10, true));
		if (Collections3.isNotEmpty(plans)) {
			model.addAttribute("plan", plans.get(0));
		}
		return "plan/newestPlan";
	}
}
