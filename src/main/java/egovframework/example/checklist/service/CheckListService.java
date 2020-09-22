package egovframework.example.checklist.service;

import java.util.List;

public interface CheckListService {
	
	UserVO login(UserVO vo);
	
	List<UserVO> selectUserList();
	
	int insertBoard(BoardVO vo);
	
	int insertCheckList(CheckListVO vo);
	
	int insertShowList(ShowListVO vo);
	
	List<BoardVO> selectBoardListAll();
	
	List<BoardVO> selectBoardTopListAll();
	
	List<BoardVO> selectBoardList(UserVO vo);
	
	List<BoardVO> selectBoardTopList(UserVO vo);
	
	BoardVO selectBoard(BoardVO vo);
	
	LogVO selectLog(LogVO vo);
	
	int insertLog(LogVO vo);
	
	int updateLog(LogVO vo);
	
	List<CheckListVO> selectCheckList(BoardVO vo);
	
	List<ShowListVO> selectShowList(BoardVO vo);
	
	List<AnswerVO> selectAnswerList(BoardVO vo);
	
	AnswerVO selectAnswerOne(AnswerVO vo);
	
	int insertAnswer(AnswerVO vo);
	
	int updateAnswer(AnswerVO vo);
	
	List<LogVO> selectLogList(BoardVO vo);
	
}
