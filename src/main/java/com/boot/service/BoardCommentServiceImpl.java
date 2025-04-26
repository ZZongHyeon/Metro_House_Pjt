package com.boot.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dao.BoardCommentDAO;
import com.boot.dto.BoardCommentDTO;


@Service
public class BoardCommentServiceImpl implements BoardCommentService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<BoardCommentDTO> bcView(HashMap<String, String> param) {
		BoardCommentDAO dao = sqlSession.getMapper(BoardCommentDAO.class);

		ArrayList<BoardCommentDTO> list = dao.bcView(param);
		return list;
	}

	@Override
	public void bcWrite(HashMap<String, String> param) {
		BoardCommentDAO dao = sqlSession.getMapper(BoardCommentDAO.class);
		dao.bcWrite(param);
	}

	@Override
	public void bcModify(HashMap<String, String> param) {
		BoardCommentDAO dao = sqlSession.getMapper(BoardCommentDAO.class);
		dao.bcModify(param);
	}

	@Override
	public void bcDelete(HashMap<String, String> param) {
		BoardCommentDAO dao = sqlSession.getMapper(BoardCommentDAO.class);
		dao.bcDelete(param);
	}

}
