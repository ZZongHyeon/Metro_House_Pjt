package com.boot.service;

import com.boot.dto.ApartmentTradeDTO;
import com.boot.dto.UserDTO;

import java.util.List;

public interface ApartmentTradeService {
    public List<ApartmentTradeDTO> getTradeData(String sigunguCode, String yearMonth);
    public List<ApartmentTradeDTO> getTradeData(String sigunguCode, String yearMonth, String numOfRows);
    //    public String getSigunguCodeFromAddress(String address);
//    public String recommend(UserDTO loginUser);
    List<ApartmentTradeDTO> recommend(UserDTO loginUser);
}
