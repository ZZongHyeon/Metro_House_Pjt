package com.boot.apartment.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.apartment_comparison.dto.ApartmentComparisonDTO;
import com.boot.apartment_comparison.service.ApartmentComparisonService;
import com.boot.user.dto.BasicUserDTO;
import com.boot.user.dto.UserDTO;
import com.boot.z_config.security.UserUtils;

@Controller
public class MapController {

	@Value("${kakao.api.key}")
	private String kakaoApiKey;
//	@Autowired
//	private UserUtils userUtils;
	@Autowired
	private ApartmentComparisonService apartmentComparisonService;

	@RequestMapping("/search_map")
	public String search_map(Model model, HttpServletRequest request, @RequestParam HashMap<String, String> param) {
		BasicUserDTO user = (BasicUserDTO) request.getAttribute("user");
		// 파라미터 로깅
		for (Map.Entry<String, String> entry : param.entrySet()) {
			System.out.println(entry.getKey() + ": " + entry.getValue());
		}

		model.addAttribute("searchParams", param);
		model.addAttribute("kakaoApiKey", kakaoApiKey);
		model.addAttribute("stationName", param.get("station"));
		if (user != null) {
			List<ApartmentComparisonDTO> favorites = apartmentComparisonService
					.getFavoriteListByUserNumber(user.getUserNumber());
			model.addAttribute("interestList", favorites);
		}

		return "search_map";
	}

}
