package com.boot.apartment.service;

import com.boot.apartment.dto.ApartmentTradeDTO;
import java.util.List;
import java.util.Map;

public interface ApartmentDownloadService {

	int downloadApartmentinfo(String yearMonth);

	List<ApartmentTradeDTO> getRegionTradeData(String sigunguCode, String yearMonth);

	List<ApartmentTradeDTO> getRegionTradeDataPaged(String sigunguCode, String yearMonth, int pageNo, int numOfRows);

	List<ApartmentTradeDTO> getStoredApartmentData(String yearMonth);

	boolean isDataCollectionCompleted(String yearMonth);

	Map<String, Object> getCollectionStatus();

	int deleteApartmentData(String yearMonth);

}
