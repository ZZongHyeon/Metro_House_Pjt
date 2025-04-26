package com.boot.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.boot.dto.BoardDTO;


public interface BoardService {
	public void boardWrite(HashMap<String, String> param);

	public ArrayList<BoardDTO> boardView();

	public BoardDTO boardDetailView(HashMap<String, String> param);

	public void boardModify(HashMap<String, String> param);

	public void boardDelete(HashMap<String, String> param);

	public boolean boardHasLiked(HashMap<String, String> param);

	public int boardAddLike(HashMap<String, String> param);

}
