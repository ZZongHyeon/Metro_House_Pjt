package com.boot.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.boot.dto.BoardDTO;


public interface BoardDAO {
	public void boardWrite(HashMap<String, String> param);

	public ArrayList<BoardDTO> boardView();

	public BoardDTO boardDetailView(HashMap<String, String> param);

	public void boardModify(HashMap<String, String> param);

	public void boardDelete(HashMap<String, String> param);

	public void boardHit(HashMap<String, String> param);

	public int boardCheckLiked(HashMap<String, String> param);

	public void boardAddLike(HashMap<String, String> param);

	public void boardIncrementLike(HashMap<String, String> param);

	public int boardgetLike(HashMap<String, String> param);
}
