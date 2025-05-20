package com.boot.apartment_comparison.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boot.apartment_comparison.dto.ApartmentComparisonDTO;
import com.boot.apartment_comparison.service.ApartmentComparisonService;
import com.boot.user.dto.BasicUserDTO;

@Controller
public class ApartmentComparisonController {
	@Autowired
	private ApartmentComparisonService apartmentComparisonService;
	
	@GetMapping("/api/favorites")
    @ResponseBody
    public List<ApartmentComparisonDTO> getFavorites(HttpServletRequest request) {
        BasicUserDTO user = (BasicUserDTO) request.getAttribute("user");
        
        if (user == null) {
            return List.of(); // 로그인하지 않은 경우 빈 목록 반환
        }
        
        return apartmentComparisonService.getFavoriteListByUserNumber(user.getUserNumber());
    }
}
