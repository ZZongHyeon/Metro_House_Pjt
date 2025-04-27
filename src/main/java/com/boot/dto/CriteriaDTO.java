package com.boot.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class CriteriaDTO {
	private int pageNum; // 페이지 번호
	private int amount; // 페이지당 글 갯수
	private String type;
	private String keyword;

	public CriteriaDTO() {
		this(1, 10);
	}

	public CriteriaDTO(int pageNum, int amount) {
		this.amount = amount;
		this.pageNum = pageNum;
	}
}