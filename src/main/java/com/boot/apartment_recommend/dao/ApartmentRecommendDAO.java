package com.boot.apartment_recommend.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.boot.apartment_recommend.dto.ApartmentRecommendDTO;
import com.boot.user.dto.BasicUserDTO;

@Mapper
public interface ApartmentRecommendDAO {
	List<ApartmentRecommendDTO> recommend(BasicUserDTO user);
}
