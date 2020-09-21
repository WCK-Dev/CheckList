package egovframework.example.checklist.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.example.checklist.service.CheckListService;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class CheckListController {
	
	/** EgovSampleService */
	@Resource(name = "checkListService")
	private CheckListService checkListService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	
	
	@RequestMapping(value="checkListMain.do")
	public String checkListMain() {
		return "checkList/checkListMain";
	}
	
}
