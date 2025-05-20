package com.boot.apartment.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.boot.apartment.dto.ApartmentTradeDTO;
import com.boot.apartment.service.ApartmentDownloadService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequiredArgsConstructor
@Slf4j
public class ApartmentDownloadController {
	private final ApartmentDownloadService apartmentDownloadService;

	@GetMapping("/download_apartmentinfo")
	public ResponseEntity<List<ApartmentTradeDTO>> downloadApartmentinfo(String yearMonth) {
		try {
			List<ApartmentTradeDTO> trades = apartmentDownloadService.downloadApartmentinfo(yearMonth);
			log.info("C - s조회된 거래 데이터 수: {}", trades.size());

			return ResponseEntity.ok(trades);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.internalServerError().build();
		}
	}
}
