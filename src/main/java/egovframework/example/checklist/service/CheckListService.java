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
}
