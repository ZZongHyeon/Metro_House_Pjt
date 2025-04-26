package com.boot.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;



@Controller
public class ViewController {

	@RequestMapping("/main")
	public String getMainBookInfo(Model model) {

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
