package com.boot.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.boot.dto.UserDTO;

public interface UserDAO {
	public int userJoin(HashMap<String, String> param);

	public ArrayList<UserDTO> userLogin(HashMap<String, String> param);

	public UserDTO checkId(HashMap<String, String> param);

	public UserDTO getUserInfo(HashMap<String, String> param);

	public int updateUserInfo(HashMap<String, String> param);

	public int updateUserPwInfo(HashMap<String, String> param);

	public UserDTO findByUserId(String userId);
}
