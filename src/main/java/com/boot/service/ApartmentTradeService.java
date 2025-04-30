package com.boot.service;

import com.boot.dto.ApartmentTradeDTO;

import java.util.List;

public interface ApartmentTradeService {
    public List<ApartmentTradeDTO> getTradeData(String sigunguCode, String yearMonth);

}
