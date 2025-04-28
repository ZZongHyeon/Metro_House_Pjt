package com.boot.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;



@Controller
public class ViewController {
	private int todayViews = 0;
	@RequestMapping("/main")
	public String getMainBookInfo(Model model, HttpSession session) {
	    // 세션에서 방문 여부 확인
	    Boolean hasVisited = (Boolean) session.getAttribute("hasVisitedToday");
	    
	    // 방문 기록이 없는 경우에만 카운트 증가
	    if (hasVisited == null || !hasVisited) {
	        todayViews += 1;
	        // 방문 기록을 세션에 저장
	        session.setAttribute("hasVisitedToday", true);
	    }
	    
	    model.addAttribute("todayViews", todayViews);
	    return "main";
	}

	@RequestMapping("/loginView")
	public String loginPage(HttpServletRequest request) {

		return "login";
	}

	@RequestMapping("/joinView")
	public String join() {
		return "join";
	}

	// board
	@RequestMapping("/board_write")
	public String boardViewWrite() {
		return "board_write";
	}

}
