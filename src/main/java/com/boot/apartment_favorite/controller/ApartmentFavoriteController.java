package com.boot.apartment_favorite.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.apartment_favorite.dto.ApartmentFavoriteDTO;
import com.boot.apartment_favorite.service.ApartmentFavoriteService;
import com.boot.z_page.CriteriaDTO;

@Controller
public class ApartmentFavoriteController {
//	@Autowired
//	private ApartmentFavoriteService apartmentFavoriteService;

//	@RequestMapping("addFavorite")
//	public ResponseEntity<String> addFavorite(@RequestParam HashMap<String, String> param, HttpServletRequest request) {
//		// public int addFavoriteList(HashMap<String, String> param);
//		Object user = request.getAttribute("user");
//	    if (user == null) {
//	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인필요");
//	    }
//	    
//	}
}
