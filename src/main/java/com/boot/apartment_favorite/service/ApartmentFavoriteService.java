package com.boot.apartment_favorite.service;

import java.util.HashMap;
import java.util.List;

public interface ApartmentFavoriteService {
	public int addFavoriteList(HashMap<String, String> param); // 추가(맵에서 관심등록 눌렀을 때) insert

	public int checkFavoriteList(int userNumber, int boardNumber); // 검증(이미 눌렀으면) select

	public int getFavoriteListCount(int userNumber); // 관심목록 전체 카운트(갯수) select

	public List<Integer> getFavoriteListByUserNumber(int userNumber); // 유저 전체 관심목록 리스트 사이드바 + 관심아파트 jsp select

	public void removeFavoriteList(int userNumber, int boardNumber); // 삭제(관심아파트 페이지에서 하트눌렀을 때) delete
}
