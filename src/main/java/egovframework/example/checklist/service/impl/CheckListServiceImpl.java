/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.checklist.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.example.checklist.service.BoardVO;
import egovframework.example.checklist.service.CheckListService;
import egovframework.example.checklist.service.CheckListVO;
import egovframework.example.checklist.service.ShowListVO;
import egovframework.example.checklist.service.UserVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("checkListService")
public class CheckListServiceImpl extends EgovAbstractServiceImpl implements CheckListService {

	private static final Logger LOGGER = LoggerFactory.getLogger(CheckListServiceImpl.class);

	// mybatis 사용
	@Resource(name="checkListMapper")
	private CheckListMapper checkListDAO;

	@Resource(name = "egovIdGnrService")
	private EgovIdGnrService egovIdGnrService;

	@Override
	public UserVO login(UserVO vo) {
		return checkListDAO.login(vo);
	}

	@Override
	public List<UserVO> selectUserList() {
		return checkListDAO.selectUserList();
	}

	@Override
	public int insertBoard(BoardVO vo) {
		return checkListDAO.insertBoard(vo);
	}

	@Override
	public int insertCheckList(CheckListVO vo) {
		return checkListDAO.insertCheckList(vo);
	}

	@Override
	public int insertShowList(ShowListVO vo) {
		return checkListDAO.insertShowList(vo);
	}

	@Override
	public List<BoardVO> selectBoardListAll() {
		return checkListDAO.selectBoardListAll();
	}

	@Override
	public List<BoardVO> selectBoardTopListAll() {
		return checkListDAO.selectBoardTopListAll();
	}
	
}
