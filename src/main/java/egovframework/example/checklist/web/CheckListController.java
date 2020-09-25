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
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class CheckListController {
	
	/** EgovSampleService */
	@Resource(name = "checkListService")
	private CheckListService checkListService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	//로그인 화면이동
	@RequestMapping(value="login.do", method=RequestMethod.GET)
	public String login() {
		
		return "checkList/login";
	}
	
	//로그인 수행
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
	
	//로그아웃
	@RequestMapping(value="logout.do")
	public String logout(HttpServletRequest request) {
		request.getSession().removeAttribute("user");
		
		return "redirect:/login.do";
	}
	
	//유저 로그인시 체크리스트 메인페이지
	@RequestMapping(value="checkListMain.do")
	public String checkListMain(HttpSession session, ModelMap model, BoardVO bvo) {
		
		String u_id = ((UserVO)session.getAttribute("user")).getU_id();
		bvo.setU_id(u_id);
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(bvo.getPageIndex());
		paginationInfo.setRecordCountPerPage(bvo.getPageUnit());
		paginationInfo.setPageSize(bvo.getPageSize());
		
		bvo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bvo.setLastIndex(paginationInfo.getLastRecordIndex());
		bvo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		int totCnt = checkListService.selectBoardListTotCnt(bvo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("boardList", checkListService.selectBoardList(bvo));
		model.addAttribute("boardTopList", checkListService.selectBoardTopList(bvo));
		
		return "checkList/checkListMain";
	}
	
	//관리자 로그인시 체크리스트 관리페이지
	@RequestMapping(value="checkListAdmin.do")
	public String checkListAdmin(ModelMap model, BoardVO bvo) {
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(bvo.getPageIndex());
		paginationInfo.setRecordCountPerPage(bvo.getPageUnit());
		paginationInfo.setPageSize(bvo.getPageSize());
		
		bvo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bvo.setLastIndex(paginationInfo.getLastRecordIndex());
		bvo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		int totCnt = checkListService.selectBoardListAllTotCnt(bvo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("boardListAll", checkListService.selectBoardListAll(bvo));
		model.addAttribute("boardTopListAll", checkListService.selectBoardTopListAll());
		
		return "checkList/checkListAdmin";
	}
	
	//관리자의 체크리스트 작성 페이지 이동
	@RequestMapping(value="writeBoard.do", method=RequestMethod.GET)
	public String writeBoard(ModelMap model) {
		
		model.addAttribute("userList", checkListService.selectUserList());
		return "checkList/writeBoard";
	}

	//관리자 체크리스트 글 작성
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
		if(request.getParameterValues("showU_id") != null) { // 보여줄 유저목록에 체크된 값이 있을때만 수행
			String[] showU_id = request.getParameterValues("showU_id");
			ShowListVO svo = new ShowListVO();
			svo.setB_seq(b_seq);
			
			for(String u_id : showU_id) {
				svo.setU_id(u_id);
				checkListService.insertShowList(svo);
			}
		}
		
		return "redirect:/checkListAdmin.do";
	}
	
	//관리자 글 조회
	@RequestMapping(value="readBoard.do", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> readBoard(BoardVO bvo) {
		
		HashMap<String, Object> boardMap = new HashMap<>();
		boardMap.put("bvo", checkListService.selectBoard(bvo));
		boardMap.put("cvoList", checkListService.selectCheckList(bvo));
		boardMap.put("svoList", checkListService.selectShowList(bvo));
		
		return boardMap;
	}

	//관리자 체크리스트 글 수정 페이지 이동
	@RequestMapping(value="modifyBoard.do", method=RequestMethod.GET)
	public String modifyBoard(BoardVO bvo, ModelMap model, RedirectAttributes ra) {
		
		BoardVO board = checkListService.selectBoard(bvo);
		if(board == null) {
			ra.addFlashAttribute("bSeqErrorMsg", "true");
			return "redirect:/checkListAdmin.do";
		}
		
		model.addAttribute("board", checkListService.selectBoard(bvo));
		model.addAttribute("checkList", checkListService.selectCheckList(bvo));
		model.addAttribute("userList", checkListService.selectUserList());
		model.addAttribute("showList", checkListService.selectShowList(bvo));
		
		return "checkList/modifyBoard"; 
	}
	
	//관리자 체크리스트 글 수정
	@RequestMapping(value="modifyBoard.do", method=RequestMethod.POST)
	public String modifyBoard(BoardVO bvo, String delCheckList, String newCheckList, HttpServletRequest request) {
		
		checkListService.updateBoard(bvo);
		
		//해당 게시글의 체크리스트 설정
		int b_seq = bvo.getB_seq();
		CheckListVO cvo = new CheckListVO();
		cvo.setB_seq(b_seq);
		
		//제거된 기존 체크리스트 항목 삭제
		String[] delList = delCheckList.split(",");
		
		for(String delChk : delList) {
			if(!delChk.equals("")) {
				cvo.setC_seq(Integer.parseInt(delChk));
				checkListService.deleteCheckList(cvo);
			}
		}
		
		//새롭게 추가된 체크리스트 항목 추가
		String[] newChkList = newCheckList.split(",");
		for(String newChk : newChkList) {
			if(!newChk.equals("")) {
				cvo.setC_name(newChk);
				checkListService.insertCheckList(cvo);
			}
		}
		
		//기존에 설정 되어있던 조회가능 유저 리스트 삭제후 재입력
		ShowListVO svo = new ShowListVO();
		svo.setB_seq(b_seq);
		
		checkListService.deleteShowList(svo); //기존 설정된 조회유저 리스트 삭제
		
		if(request.getParameterValues("showU_id") != null) { //새롭게 설정된 조회유저리스트 입력
			String[] showU_id = request.getParameterValues("showU_id");
			
			for(String u_id : showU_id) {
				svo.setU_id(u_id);
				checkListService.insertShowList(svo);
			}
		}
		
		return "redirect:/checkListAdmin.do"; 
	}
	
	//관리자 게시글 삭제
	@RequestMapping(value="deleteBoard.do", method=RequestMethod.POST)
	@ResponseBody
	public String deleteBoard(BoardVO bvo) {
		return checkListService.deleteBoard(bvo) + "";
	}
	
	//관리자가 사용자의 체크리스트 게시글 조회여부 확인
	@RequestMapping(value="selectUserLog.do")
	public String selectUserLog(BoardVO bvo, ModelMap model, RedirectAttributes ra) {
		
		bvo = checkListService.selectBoard(bvo);
		
		if(bvo == null) { 
			ra.addFlashAttribute("bSeqErrorMsg", "true");
			return "redirect:/checkListAdmin.do";
			
		} else {
			model.addAttribute("boardInfo", bvo);
			model.addAttribute("svoList", checkListService.selectShowList(bvo));
			model.addAttribute("lvoList", checkListService.selectLogList(bvo));
			model.addAttribute("userAnswerList", checkListService.selectUserAnswerList(bvo));
			return "checkList/selectUserLog";
		}
	}
	
	//관리자가 사용자의 체크리스트 저장 목록을 확인후, 상세내용 조회
	@RequestMapping(value="readUserAnswer.do", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> readUserAnswer(BoardVO bvo) {
		HashMap<String, Object> answerMap = new HashMap<>();
		answerMap.put("cvoList", checkListService.selectCheckList(bvo));
		answerMap.put("avoList", checkListService.selectAnswerList(bvo));
		
		return answerMap; 
	}
		
	//사용자가 체크리스트 조회
	@RequestMapping(value="readCheckList.do", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> readCheckList(BoardVO bvo, HttpSession session) {
		String u_id = ((UserVO)session.getAttribute("user")).getU_id();
		bvo.setU_id(u_id);
		
		HashMap<String, Object> boardMap = new HashMap<>();
		boardMap.put("bvo", checkListService.selectBoard(bvo));
		boardMap.put("cvoList", checkListService.selectCheckList(bvo));
		boardMap.put("avoList", checkListService.selectAnswerList(bvo));
		
		//체크리스트 조회로그 입력
		//기존에 읽은적이 있는 로그인지 확인
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
	
	//사용자 체크리스트 저장
	@RequestMapping(value="saveAnswer.do", method=RequestMethod.POST)
	@ResponseBody
	public String saveAnswer(@RequestBody AnswerVO[] send_Json, HttpSession session) {
		
		int result = 0;
		
		boolean isUpdate = false;
		
		String u_id = ((UserVO)session.getAttribute("user")).getU_id();
		
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
	
}
