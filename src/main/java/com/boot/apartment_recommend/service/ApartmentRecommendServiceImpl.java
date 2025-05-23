package com.boot.apartment_recommend.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.apartment_recommend.dao.ApartmentRecommendDAO;
import com.boot.apartment_recommend.dto.ApartmentRecommendDTO;
import com.boot.user.dto.BasicUserDTO;

@Service
public class ApartmentRecommendServiceImpl implements ApartmentRecommendService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ApartmentRecommendDTO> recommend(BasicUserDTO user) {
		ApartmentRecommendDAO dao = sqlSession.getMapper(ApartmentRecommendDAO.class);
		List<ApartmentRecommendDTO> list = dao.recommend(user);
		return list;
	}

}
