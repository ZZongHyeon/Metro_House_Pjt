package com.boot.dao;

import com.boot.dto.ApartmentTradeDTO;

import java.util.List;

public interface ApartmentTradeDAO {
    public List<ApartmentTradeDTO> getTradeData(String sigunguCode, String yearMonth);

    }
