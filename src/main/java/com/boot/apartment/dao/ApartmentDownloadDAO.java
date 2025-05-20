package com.boot.apartment.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.boot.apartment.dto.ApartmentTradeDTO;

@Mapper
public interface ApartmentDownloadDAO {

//	int insertApartmentInfoBatch(Map<String, Object> params);

	List<ApartmentTradeDTO> getApartmentDataByYearMonth(Map<String, Object> params);

	Integer countApartmentDataByYearMonth(Map<String, Object> params);

	int deleteApartmentDataByYearMonth(Map<String, Object> params);

	void insertApartmentInfo(ApartmentTradeDTO apartmentInfo);
}