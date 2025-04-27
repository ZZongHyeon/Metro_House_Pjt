package com.boot.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.boot.dto.UserDTO;
import com.boot.service.UserService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UserController {
	@Autowired
	private UserService service;


	@RequestMapping("/login")
	public String login(HttpServletRequest request, @RequestParam HashMap<String, String> param) {
	    ArrayList<UserDTO> dtos = service.userLogin(param);
	    
	    if (dtos.isEmpty()) {
	        // 사용자가 존재하지 않는 경우
	        return "redirect:loginView?error=invalid";
	    } else {
	        if (param.get("userPw").equals(dtos.get(0).getUserPw())) {
	            UserDTO dto = service.getUserInfo(param);
	            
	            // 사용자 ID 가져오기
	            String userId = dto.getUserId();
	            
	            // 새 세션 생성
	            HttpSession session = request.getSession(true);
	            session.setAttribute("loginUser", dto);
	            
	            // 세션 정보 저장
	            HashMap<String, String> sessionParam = new HashMap<>();
	            sessionParam.put("userId", userId);
	            sessionParam.put("sessionId", session.getId());
	            
	            return "redirect:main";
	        }
	        // 비밀번호가 일치하지 않는 경우
	        return "redirect:loginView?error=invalid";
	    }
	}
	
	@RequestMapping("/join")
	public ResponseEntity<String> join(HttpServletRequest request, @RequestParam HashMap<String, String> param) {

		if (service.checkId(param) != null) {

		} else {
			int re = service.userJoin(param);
			if (re == 1) {
				return ResponseEntity.ok("available");
			}
		}
		return ResponseEntity.status(HttpStatus.CONFLICT).body("duplicate");
	}

	@RequestMapping("/user_info")
	public String getUserInfo(int u_number) {
		return "user_info";
	}

	@RequestMapping("/mypage")
	public String mypage(HttpServletRequest request, @RequestParam HashMap<String, String> param, Model model) {
		UserDTO dto = (UserDTO) request.getSession().getAttribute("loginUser");

		param.put("userNumber", String.valueOf(dto.getUserNumber()));

		return "mypage";
	}

	@RequestMapping("/user_update_view")
	public String updateUserInfo(UserDTO user) {
		return "user_update";
	}

	@RequestMapping("/userUpdate")
	public String updateUserInfo(@RequestParam HashMap<String, String> param, HttpSession session) {
		int result = service.updateUserInfo(param);
		if (result > 0) {
			session.invalidate(); // 세션 초기화 → 자동 로그아웃
			return "redirect:/loginView"; // 로그인 페이지로
		} else {
			return "redirect:/user_update_view"; // 실패 시 다시 수정 화면
		}

	}

	@RequestMapping("/userPwUpdate")
	public String updateUserPwInfo(@RequestParam HashMap<String, String> param, HttpSession session, Model model) {
		UserDTO user = (UserDTO) session.getAttribute("loginUser");
		int result = -1;

		String inputPw = param.get("userPw");
		String newPw = param.get("userNewPw");
		String confirmPw = param.get("userNewPwCheck");

		if (user.getUserPw().equals(param.get("userPw"))) {
			result = service.updateUserPwInfo(param);
		}

		if (result > 0) {
			session.invalidate(); // 세션 초기화 → 자동 로그아웃
			return "redirect:/loginView"; // 로그인 페이지로
		} else {
			model.addAttribute("errorMsg", "현재 비밀번호가 일치하지 않습니다.");
			model.addAttribute("userPw", inputPw);
			model.addAttribute("userNewPw", newPw);
			model.addAttribute("userNewPwCheck", confirmPw);
			return "mypage"; // 이 JSP가 위 코드와 같은 JSP라고 가정
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
	    HttpSession session = request.getSession(false);
	    
	    if (session != null) {
	        // 세션에서 사용자 정보 가져오기
	        UserDTO user = (UserDTO) session.getAttribute("loginUser");
	        
//	        if (user != null) {
//	            // 데이터베이스에서 세션 정보 삭제
//	            String userId = user.getUserId();
//	            HashMap<String, String> param = new HashMap<>();
//	            param.put("userId", userId);
//	            
//	            try {
//	                // 세션 정보 삭제
//	                System.out.println("로그아웃: 사용자 " + userId + "의 세션 정보가 데이터베이스에서 삭제됨");
//	            } catch (Exception e) {
//	                System.out.println("세션 정보 삭제 중 오류 발생: " + e.getMessage());
//	                e.printStackTrace();
//	            }
//	        }
	        
	        // 세션 무효화
	        session.invalidate();
//	        System.out.println("로그아웃: 세션이 무효화됨");
	    }
	    
	    return "redirect:loginView";
	}
}
