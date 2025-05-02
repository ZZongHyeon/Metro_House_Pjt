package com.boot.dao;

import com.boot.dto.ApartmentTradeDTO;

import java.util.HashMap;
import java.util.List;

public interface FavoriteListDAO {
    public void addFavoriteList(HashMap<String, String> param);

    public void removeFavoriteList(int userNumber, int boardNumber);

    public int checkFavoriteList(int userNumber, int boardNumber);

    public int getFavoriteListCount(int userNumber);

    public int getFavoriteListCountByBoardNumber(int boardNumber);

    public List<Integer> getFavoriteListByUserNumber(int userNumber);

    public List<Integer> getFavoriteListByBoardNumber(int boardNumber);

    public List<ApartmentTradeDTO> getFavoriteListSortedByPrice(int userNumber, boolean ascending);
    public List<ApartmentTradeDTO> getFavoriteListSortedByDate(int userNumber, boolean ascending);

}
