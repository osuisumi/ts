package tag;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.haoyu.sip.tag.entity.Tag;
import com.haoyu.sip.tag.service.ITagRelationService;
import com.haoyu.sip.tag.service.ITagService;


public class TagTest {
	
	public static void main(String[] args) {
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		ITagRelationService tagRelationService = (ITagRelationService) ac.getBean("tagRelationServiceImpl");
		List<String> relationIds = new ArrayList<String>();
		relationIds.add("51bc6a718dfc4c5a9aad2c515e832875");
		List result = tagRelationService.findTagRelationsByRelationIds(relationIds);
		System.out.println(result);
		
		ITagService tagService = (ITagService) ac.getBean("tagService");
		Map<String,List<Tag>> re = tagService.findEntityTagsByEntityIds(relationIds);
		System.out.println(re);
	}

}
