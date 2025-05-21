package com.boot.apartment_favorite.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.boot.apartment_favorite.dto.ApartmentFavoriteDTO;
import com.boot.apartment_favorite.service.ApartmentFavoriteService;
import com.boot.user.dto.BasicUserDTO;
import com.boot.z_page.PageDTO;
import com.boot.z_page.criteria.ApartmentFavoriteCriteriaDTO;

@Controller
public class ApartmentFavoriteController {
	@Autowired
	private ApartmentFavoriteService apartmentFavoriteService;

	@RequestMapping("/favorite_apartment")
	public String getFavorites(Model model, HttpServletRequest request,
			ApartmentFavoriteCriteriaDTO apartmentFavoriteCriteriaDTO, @RequestParam(required = false) String region,
			@RequestParam(required = false) String district, @RequestParam(required = false) String priceRange,
			@RequestParam(defaultValue = "recent") String sort) {
		BasicUserDTO user = (BasicUserDTO) request.getAttribute("user");
//		System.out.println("user.getUserNumber() : " + user.getUserNumber());
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
//		System.out.println("@#favorites => " +  favorites);
		int total = apartmentFavoriteService.getFavoriteListCount(params);
		model.addAttribute("pageMaker", new PageDTO(total, apartmentFavoriteCriteriaDTO));
		model.addAttribute("favorites", favorites);
		
		model.addAttribute("region", region);
		model.addAttribute("district", district);
		model.addAttribute("priceRange", priceRange);
		model.addAttribute("sort", sort);
		return "favorite_apartment";
	}

	// 관심 아파트 삭제
	@PostMapping("/apartment_favorite_remove")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> removeFavorite(@RequestParam("favoriteId") int favoriteId, String lat, String lng, String dealAmount,
			HttpServletRequest request) {
		
		Map<String, Object> response = new HashMap<>();

		try {
			// 세션에서 로그인한 사용자 정보 가져오기
			BasicUserDTO user = (BasicUserDTO) request.getAttribute("user");

			// 로그인 확인
			if (user == null) {
				response.put("success", false);
				response.put("message", "로그인이 필요합니다.");
				return ResponseEntity.ok(response);
			}

			
			
			HashMap<String, String> param = new HashMap<>();
			param.put("lat", lat);
			param.put("lng", lng);
			param.put("dealAmount", dealAmount);
			int result = apartmentFavoriteService.removeFavoriteList(user.getUserNumber(), favoriteId, param);

			if (result > 0) {
				response.put("success", true);
				response.put("message", "관심 아파트가 삭제되었습니다.");
			} else {
				response.put("success", false);
				response.put("message", "관심 아파트 삭제에 실패했습니다.");
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.put("success", false);
			response.put("message", "서버 오류가 발생했습니다.");
		}

		return ResponseEntity.ok(response);
	}

	// 관심등록 insert
	@PostMapping("/favorite/insert")
	@ResponseBody
	public ResponseEntity<String> insertFavorite(@RequestBody HashMap<String, Object> param,
			HttpServletRequest request) {
		System.out.println("param 전체 => " + param);// 전체 파라미터 로그찍어보기
		BasicUserDTO user = (BasicUserDTO) request.getAttribute("user");
		System.out.println("user => " + user);
		if (user == null) {
			return ResponseEntity.status(401).body("로그인이 필요합니다.");
		}
		try {
			// lat, lng 파라미터 체크
			String latStr = param.get("lat") != null ? param.get("lat").toString().trim() : "";
			String lngStr = param.get("lng") != null ? param.get("lng").toString().trim() : "";
			System.out.println("latStr =>" + latStr); // 위도경도 로그 찍어봄(값 잘 전달되는지? )
			System.out.println("lngStr =>" + lngStr);
//            System.out.println("여기왓소.");
			if (latStr.isEmpty() || lngStr.isEmpty()) {
//                System.out.println("여기왓소.1");
				return ResponseEntity.badRequest().body("위도/경도 값이 누락되었습니다.");
			}

//            System.out.println("여기왓소.2");
//            double lat = Double.parseDouble(latStr);
//            double lng = Double.parseDouble(lngStr);

//            System.out.println("여기왓소.3");

			param.put("userNumber", user.getUserNumber());
//            System.out.println("여기왓당.");
			int result = apartmentFavoriteService.addFavoriteList(param);
//            System.out.println("여기왓당.2");

			if (result > 0) {
//                System.out.println("여기왓당.3");
				return ResponseEntity.ok("관심등록 성공");
			} else {
//                System.out.println("여기왓당.4");
				return ResponseEntity.status(500).body("등록 실패");
			}

		} catch (NumberFormatException e) {
			return ResponseEntity.badRequest().body("위도/경도 값이 유효하지 않습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(500).body("서버 오류 발생");
		}
	}

}
