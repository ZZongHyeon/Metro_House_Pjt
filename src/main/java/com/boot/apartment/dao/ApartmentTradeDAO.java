package com.boot.apartment.dao;

import java.util.List;

import com.boot.apartment.dto.ApartmentTradeDTO;

public interface ApartmentTradeDAO {

	public List<ApartmentTradeDTO> getTradeData(String sigunguCode, String yearMonth);

}
