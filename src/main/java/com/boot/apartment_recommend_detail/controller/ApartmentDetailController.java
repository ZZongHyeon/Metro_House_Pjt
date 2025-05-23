package com.boot.apartment_recommend_detail.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.apartment_recommend_detail.dto.ApartmentDTO;
import com.boot.apartment_recommend_detail.service.ApartmentDetailService;
import com.boot.apartment_recommend_detail.service.ApartmentRecommendService;
import com.boot.apartment_review.dto.ReviewDTO;
import com.boot.apartment_review.dto.ReviewStatsDTO;
import com.boot.apartment_review.service.ReviewService;
import com.boot.user.dto.BasicUserDTO;
import com.boot.z_page.PageDTO;
import com.boot.z_page.criteria.ReviewCriteriaDTO;

@Controller
public class ApartmentDetailController {
	@Autowired
	private ApartmentDetailService apartmentDetailService;
	@Autowired
	private ReviewService reviewService;

	@GetMapping("/apartment_detail")
	public String apartmentDetail(
	        @RequestParam("apartmentId") int apartmentId, 
	        ReviewCriteriaDTO reviewCriteriaDTO,
	        Model model) {

	    // 아파트 상세 정보 조회
	    ApartmentDTO apartment = apartmentDetailService.getApartmentInfo(apartmentId);
	    model.addAttribute("apartment", apartment);
	    
	    // 페이징 파라미터 설정
//	    if (reviewCriteriaDTO.getPageNum() <= 0) {
//	        reviewCriteriaDTO.setPageNum(1);
//	    }
//	    if (reviewCriteriaDTO.getAmount() <= 0) {
//	        reviewCriteriaDTO.setAmount(3); // 기본값은 3으로 설정
//	    }
	    
	    Map<String, Object> param = new HashMap<>();
	    param.put("apartmentId", apartmentId);
	    param.put("pageNum", reviewCriteriaDTO.getPageNum());
	    param.put("amount", reviewCriteriaDTO.getAmount());
	    
	    // 리뷰 목록 조회
	    List<ReviewDTO> reviewList = reviewService.getReviews(param);
	    model.addAttribute("reviewList", reviewList);
	    
	    // 리뷰 통계 조회
	    ReviewStatsDTO reviewStats = reviewService.getReviewStats(apartmentId);
	    model.addAttribute("reviewStats", reviewStats);
	    
	    // 페이징 정보 설정
	    int total = reviewService.getReviewCount(param);
	    PageDTO pageDTO = new PageDTO(total, reviewCriteriaDTO);
	    model.addAttribute("pageMaker", pageDTO);
	    
	    return "apartment/apartment_detail";
	}
}
