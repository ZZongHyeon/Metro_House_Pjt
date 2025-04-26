package com.boot.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.stereotype.Service;

import com.boot.dto.BoardCommentDTO;


public interface BoardCommentService {
	public ArrayList<BoardCommentDTO> bcView(HashMap<String, String> param);

	public void bcWrite(HashMap<String, String> param);

	public void bcModify(HashMap<String, String> param);

	public void bcDelete(HashMap<String, String> param);
}
