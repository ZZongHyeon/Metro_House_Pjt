package com.boot.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dao.UserDAO;
import com.boot.dto.UserDTO;


@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int userJoin(HashMap<String, String> param) {
		int re = -1;
		UserDAO dao = sqlSession.getMapper(UserDAO.class);
		re = dao.userJoin(param);
		return re;
	}

	@Override
	public ArrayList<UserDTO> userLogin(HashMap<String, String> param) {
		UserDAO dao = sqlSession.getMapper(UserDAO.class);
		ArrayList<UserDTO> list = dao.userLogin(param);
		return list;
	}

	@Override
	public UserDTO checkId(HashMap<String, String> param) {
		UserDAO dao = sqlSession.getMapper(UserDAO.class);
		UserDTO dto = dao.checkId(param);
		return dto;
	}

	@Override
	public UserDTO getUserInfo(HashMap<String, String> param) {
		UserDAO dao = sqlSession.getMapper(UserDAO.class);
		UserDTO dto = dao.getUserInfo(param);
		return dto;
	}

	@Override
	public int updateUserInfo(HashMap<String, String> param) {
		UserDAO dao = sqlSession.getMapper(UserDAO.class);
		int re = dao.updateUserInfo(param);
		return re;
	}

	@Override
	public int updateUserPwInfo(HashMap<String, String> param) {
		UserDAO dao = sqlSession.getMapper(UserDAO.class);
		int re = dao.updateUserPwInfo(param);
		return re;
	}


}
