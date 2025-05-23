package com.boot.apartment_recommend.service;

import java.util.List;

import com.boot.apartment_recommend.dto.ApartmentRecommendDTO;
import com.boot.user.dto.BasicUserDTO;

public interface ApartmentRecommendService {
	List<ApartmentRecommendDTO> recommend(BasicUserDTO user);
}
