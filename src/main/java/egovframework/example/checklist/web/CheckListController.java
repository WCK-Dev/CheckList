package egovframework.example.checklist.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.checklist.service.BoardVO;
import egovframework.example.checklist.service.CheckListService;
import egovframework.example.checklist.service.CheckListVO;
import egovframework.example.checklist.service.ShowListVO;
import egovframework.example.checklist.service.UserVO;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class CheckListController {
	
	/** EgovSampleService */
	@Resource(name = "checkListService")
	private CheckListService checkListService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	
	@RequestMapping(value="login.do", method=RequestMethod.GET)
	public String login() {
		
		return "checkList/login";
	}
	
	@RequestMapping(value="login.do", method=RequestMethod.POST)
	public String login(UserVO uvo, HttpServletRequest request, RedirectAttributes ra) {
		
		UserVO user = new UserVO();
		user = checkListService.login(uvo);
		
		if(user == null) {
			ra.addFlashAttribute("loginErrMsg", "true");
			return "redirect:/login.do";
		} else {
			request.getSession().setAttribute("user", user);

			if(user.getU_roll().equals("admin"))
				return "redirect:/checkListAdmin.do";
			else 
				return "redirect:/checkListMain.do";
		}
	}
	
	@RequestMapping(value="logout.do")
	public String logout(HttpServletRequest request) {
		request.getSession().removeAttribute("user");
		
		return "redirect:/login.do";
	}
	
	
	@RequestMapping(value="checkListMain.do")
	public String checkListMain() {
		return "checkList/checkListMain";
	}
	
	@RequestMapping(value="checkListAdmin.do")
	public String checkListAdmin(ModelMap model) {
		
		model.addAttribute("boardListAll", checkListService.selectBoardListAll());
		model.addAttribute("boardTopListAll", checkListService.selectBoardTopListAll());
		
		return "checkList/checkListAdmin";
	}
	
	@RequestMapping(value="writeBoard.do", method=RequestMethod.GET)
	public String writeBoard(ModelMap model) {
		
		model.addAttribute("userList", checkListService.selectUserList());
		return "checkList/writeBoard";
	}
	
	@RequestMapping(value="writeBoard.do", method=RequestMethod.POST)
	public String writeBoard(BoardVO bvo, String c_nameList, HttpServletRequest request) {
		
		checkListService.insertBoard(bvo);
		
		//해당 글의 체크리스트 항목 DB 입력
		int b_seq = bvo.getB_seq();
		String[] nameList = c_nameList.split(",");
		
		CheckListVO cvo = new CheckListVO();
		cvo.setB_seq(b_seq);
		
		for(String c_name : nameList) {
			cvo.setC_name(c_name);
			checkListService.insertCheckList(cvo);
		}
		
		//해당 글의 보여줄 유저값을 db입력
		String[] showU_id = request.getParameterValues("showU_id");
		ShowListVO svo = new ShowListVO();
		svo.setB_seq(b_seq);
		
		for(String u_id : showU_id) {
			svo.setU_id(u_id);
			checkListService.insertShowList(svo);
		}
		
		return "redirect:/checkListAdmin.do";
	}
	
}
