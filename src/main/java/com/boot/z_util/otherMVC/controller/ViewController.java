package com.boot.z_util.otherMVC.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.boot.apartment.dto.ApartmentTradeDTO;
import com.boot.apartment.service.ApartmentTradeService;
import com.boot.user.dto.UserDTO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ViewController {
	private int todayViews = 0;
	@Autowired
	private ApartmentTradeService apartmentTradeService; //의존성주입

	@RequestMapping("/")
	public String getMainBookInfo(Model model, HttpSession session) {
		// 세션에서 방문 여부 확인
		Boolean hasVisited = (Boolean) session.getAttribute("hasVisitedToday");

		// 방문 기록이 없는 경우에만 카운트 증가
		if (hasVisited == null || !hasVisited) {
			todayViews += 1;
			// 방문 기록을 세션에 저장
			session.setAttribute("hasVisitedToday", true);
		}
		model.addAttribute("currentPage", "main"); // 헤더 식별용
		model.addAttribute("todayViews", todayViews);
		//세션에서 로그인 성공한 유저의 정보가져오기(로그인시, 추천아파트 구현하기위해 address 가져오려고)
		UserDTO user = (UserDTO) session.getAttribute("loginUser");

		//여기서 recommend 메서드 호출
		if (user != null)
		{
//            String sigunguCode = apartmentTradeService.recommend(user);
			List<ApartmentTradeDTO> apartmentList = apartmentTradeService.recommend(user);
			model.addAttribute("apartmentList", apartmentList); // 모델 객체에 담아서, main.jsp로 쏴준다.
//            System.out.println("추천 시군구 코드: " + sigunguCode);
		}

		return "main";
	}

//	@RequestMapping("/loginView")
	@RequestMapping("/loginForm")
	public String loginPage(HttpServletRequest request) {

		return "user/login";
	}

//	@RequestMapping("/joinView")
	@RequestMapping("/joinForm")
	public String join() {
		return "user/join";
	}

	// board
	@RequestMapping("/board_write")
	public String boardViewWrite() {
		return "board/board_write";
	}
	@RequestMapping("/favorite_apartment")
	public String favorite_apartment(Model model) {
		model.addAttribute("currentPage", "favorite_apartment"); // 헤더식별용
		return "favorite_apartment";
	}
	@RequestMapping("/privacy")
	public String privacy() {
		return "privacy";
	}

}
