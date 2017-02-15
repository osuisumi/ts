package test;

import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.haoyu.competition.service.ICompetitionService;
import com.haoyu.sip.core.web.SearchParam;

import org.springframework.context.ApplicationContext;

public class CompetitionDateTest {
	
	static ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
	
	public static void main(String[] args) {
		ICompetitionService cs = (ICompetitionService) ac.getBean("competitionService");
		SearchParam searchParam = new SearchParam();
		searchParam.getParamMap().put("timeState", "begin");
		cs.list(searchParam, null);
	}

}
