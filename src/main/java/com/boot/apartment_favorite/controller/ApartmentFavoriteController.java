package com.boot.apartment_favorite.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.boot.user.dto.BasicUserDTO;
import com.boot.z_page.PageDTO;
import com.boot.z_page.criteria.ApartmentFavoriteCriteriaDTO;
import com.boot.z_page.criteria.CriteriaDTO;

@Controller
public class ApartmentFavoriteController {
	@Autowired
	private ApartmentFavoriteService apartmentFavoriteService;

	@RequestMapping("/favorite_apartment")
    public String getFavorites(Model model, HttpServletRequest request,
            ApartmentFavoriteCriteriaDTO apartmentFavoriteCriteriaDTO,
            @RequestParam(required = false) String region,
            @RequestParam(required = false) String district,
            @RequestParam(required = false) String priceRange,
            @RequestParam(defaultValue = "recent") String sort) {
        
        BasicUserDTO user = (BasicUserDTO) request.getAttribute("user");
        System.out.println("user.getUserNumber() : " + user.getUserNumber());
        
        // 파라미터 맵 생성
        Map<String, Object> params = new HashMap<>();
        params.put("userNumber", user.getUserNumber());
        params.put("criteria", apartmentFavoriteCriteriaDTO);
        
        // 필터링 조건 추가
        if (region != null && !region.isEmpty()) {
            params.put("region", region);
        }
        if (district != null && !district.isEmpty()) {
            params.put("district", district);
        }
        if (priceRange != null && !priceRange.isEmpty()) {
            params.put("priceRange", priceRange);
        }
        params.put("sort", sort);
        
        // 데이터 조회 (Map을 사용하는 새로운 메서드 호출)
        List<ApartmentFavoriteDTO> favorites = apartmentFavoriteService.getFavoriteListByUserNumber(params);
        int total = apartmentFavoriteService.getFavoriteListCount(params);

        model.addAttribute("pageMaker", new PageDTO(total, apartmentFavoriteCriteriaDTO));
        model.addAttribute("favorites", favorites);
        model.addAttribute("region", region);
        model.addAttribute("district", district);
        model.addAttribute("priceRange", priceRange);
        model.addAttribute("sort", sort);
        
        return "favorite_apartment";
    }
}
