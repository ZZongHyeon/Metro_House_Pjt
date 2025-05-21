package com.boot.apartment.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.boot.apartment.dto.ApartmentTradeDTO;
import com.boot.apartment.service.ApartmentDownloadService;
import com.boot.user.dto.BasicUserDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequiredArgsConstructor
@Slf4j
public class ApartmentDownloadController {
	private final ApartmentDownloadService apartmentDownloadService;

	@GetMapping("/download")
	public ResponseEntity<?> downloadApartmentinfo(@RequestParam(required = false) String yearMonth,
			HttpServletRequest request) {
		BasicUserDTO user = (BasicUserDTO) request.getAttribute("user");
		if (user.getUserAdmin() != 1) {
			return ResponseEntity.status(404).build();
		}
		try {
			// 서비스 호출 - 이제 데이터를 반환하지 않고 처리 결과만 반환하도록 수정
			int processedCount = apartmentDownloadService.downloadApartmentinfo(yearMonth);

			// 처리 결과를 담은 응답 객체 생성
			Map<String, Object> response = new HashMap<>();
			response.put("success", true);
			response.put("message", "아파트 정보 수집 및 저장 완료");
			response.put("processedCount", processedCount);

			log.info("아파트 정보 수집 완료. 처리된 데이터 수: {}", processedCount);
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			log.error("아파트 정보 수집 중 오류 발생: {}", e.getMessage(), e);

			Map<String, Object> errorResponse = new HashMap<>();
			errorResponse.put("success", false);
			errorResponse.put("message", "아파트 정보 수집 중 오류 발생");
			errorResponse.put("error", e.getMessage());

			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
		}
	}
}
