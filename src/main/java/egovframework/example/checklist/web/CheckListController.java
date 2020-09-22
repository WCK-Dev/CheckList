package egovframework.example.checklist.web;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.checklist.service.AnswerVO;
import egovframework.example.checklist.service.BoardVO;
import egovframework.example.checklist.service.CheckListService;
import egovframework.example.checklist.service.CheckListVO;
import egovframework.example.checklist.service.LogVO;
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
	public String checkListMain(HttpSession session, ModelMap model) {
		UserVO uvo = (UserVO)session.getAttribute("user");
		
		model.addAttribute("boardList", checkListService.selectBoardList(uvo));
		model.addAttribute("boardTopList", checkListService.selectBoardTopList(uvo));
		
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
	
	@RequestMapping(value="readBoard.do", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> readBoard(BoardVO bvo) {
		
		HashMap<String, Object> boardMap = new HashMap<>();
		boardMap.put("bvo", checkListService.selectBoard(bvo));
		boardMap.put("cvoList", checkListService.selectCheckList(bvo));
		boardMap.put("svoList", checkListService.selectShowList(bvo));
		
		return boardMap;
	}
	
	@RequestMapping(value="readCheckList.do", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> readCheckList(BoardVO bvo, HttpSession session) {
		
		HashMap<String, Object> boardMap = new HashMap<>();
		boardMap.put("bvo", checkListService.selectBoard(bvo));
		boardMap.put("cvoList", checkListService.selectCheckList(bvo));
		boardMap.put("avoList", checkListService.selectAnswerList(bvo));
		
		//체크리스트 조회로그 입력
		//기존에 읽은적이 있는 로그인지 확인
		String u_id = ((UserVO)session.getAttribute("user")).getU_id();
		LogVO lvo = new LogVO();
		lvo.setB_seq(bvo.getB_seq());
		lvo.setU_id(u_id);
		
		LogVO exsitingLog = checkListService.selectLog(lvo);
		
		if(exsitingLog == null) { //로그 기록이 없으면 로그 입력
			checkListService.insertLog(lvo);
		} else { //있으면 로그 업데이트(최종 조회시간 갱신)
			checkListService.updateLog(lvo);
		}
		
		return boardMap;
	}
	
	@RequestMapping(value="saveAnswer.do", method=RequestMethod.POST)
	@ResponseBody
	public String saveAnswer(@RequestBody AnswerVO[] send_Json, HttpSession session) {
		
		int result = 0;
		
		boolean isUpdate = false;
		
		String u_id = (String)((UserVO)session.getAttribute("user")).getU_id();
		
		for(AnswerVO avo : send_Json) {
			
			avo.setU_id(u_id);
			
			AnswerVO existingAVO = checkListService.selectAnswerOne(avo);
			
			isUpdate = existingAVO == null ? false : true;
			
			if(!isUpdate) {
				result += checkListService.insertAnswer(avo);
			} else {
				avo.setAnswer_id(existingAVO.getU_id());
				result += checkListService.updateAnswer(avo);
			}
			
		}
		
		return result + "";
	}
	
	@RequestMapping(value="selectUserLog.do")
	public String selectUserLog(BoardVO bvo, ModelMap model, RedirectAttributes ra) {
		
		bvo = checkListService.selectBoard(bvo);
		
		if(bvo == null) { 
			ra.addFlashAttribute("logErrorMsg", "true");
			return "redirect:/checkListAdmin.do";
			
		} else {
			model.addAttribute("boardInfo", bvo);
			model.addAttribute("svoList", checkListService.selectShowList(bvo));
			model.addAttribute("lvoList", checkListService.selectLogList(bvo));
			return "checkList/selectUserLog";
		}
	}
}
