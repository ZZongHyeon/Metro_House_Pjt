package com.boot.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.dto.ApartmentDTO;

@Controller
public class MapController {

	@Value("${kakao.api.key}")
    private String kakaoApiKey;

	@RequestMapping("/search_map")
	public String search_map(Model model, HttpServletRequest request, @RequestParam HashMap<String, String> param) {
		System.out.println("Received parameters: " + param);

		// 파라미터 로깅
		for (Map.Entry<String, String> entry : param.entrySet()) {
			System.out.println(entry.getKey() + ": " + entry.getValue());
		}
		
		model.addAttribute("currentPage", "search_map"); // 헤더 식별용
		model.addAttribute("searchParams", param);
		model.addAttribute("kakaoApiKey", kakaoApiKey);
		model.addAttribute("stationName", param.get("station"));

		return "search_map";
	}

}
