package com.boot.apartment_recommend_detail.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.boot.apartment_recommend_detail.dto.ApartmentDTO;
import com.boot.user.dto.SafeUserDTO;

@Mapper
public interface ApartmentRecommendDAO {
	List<ApartmentDTO> recommend(SafeUserDTO user);
}
