package com.boot.apartment_recommend_detail.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.boot.apartment_recommend_detail.dto.ApartmentDTO;
import com.boot.apartment_recommend_detail.service.ApartmentDetailService;
import com.boot.apartment_recommend_detail.service.ApartmentRecommendService;


@Controller
public class ApartmentDetailController {
	@Autowired
	private ApartmentDetailService apartmentDetailService;
	
	@RequestMapping("apartment_detail")
	public String apartmentDetail(Model model, int apartmentId) {
		ApartmentDTO dto = apartmentDetailService.getApartmentInfo(apartmentId);
		model.addAttribute("apartment", dto);
		return "apartment/apartment_detail";
	}
}
