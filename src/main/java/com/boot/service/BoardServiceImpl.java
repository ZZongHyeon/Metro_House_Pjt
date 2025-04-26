package com.boot.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dao.BoardDAO;
import com.boot.dto.BoardDTO;


@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void boardWrite(HashMap<String, String> param) {
		BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
		dao.boardWrite(param);
	}

	@Override
	public ArrayList<BoardDTO> boardView() {
		BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
		ArrayList<BoardDTO> list = dao.boardView();
		return list;
	}

	@Override
	public BoardDTO boardDetailView(HashMap<String, String> param) {
		BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
		dao.boardHit(param);
		BoardDTO dto = dao.boardDetailView(param);
		return dto;
	}

	@Override
	public void boardModify(HashMap<String, String> param) {
		BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
		dao.boardModify(param);

	}

	@Override
	public void boardDelete(HashMap<String, String> param) {
		BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
		dao.boardDelete(param);
	}

	@Override
	public boolean boardHasLiked(HashMap<String, String> param) {
		BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
		return dao.boardCheckLiked(param) > 0;
	}

	@Override
	public int boardAddLike(HashMap<String, String> param) {
		BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
		dao.boardAddLike(param);
		dao.boardIncrementLike(param);
		return dao.boardgetLike(param);
	}

}
