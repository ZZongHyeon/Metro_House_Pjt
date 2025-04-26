package com.boot.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.boot.dto.BoardCommentDTO;


public interface BoardCommentDAO {
	public ArrayList<BoardCommentDTO> bcView(HashMap<String, String> param);

	public void bcWrite(HashMap<String, String> param);

	public void bcModify(HashMap<String, String> param);

	public void bcDelete(HashMap<String, String> param);
}
