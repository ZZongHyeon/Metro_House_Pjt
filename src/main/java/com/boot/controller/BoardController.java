package com.boot.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.boot.dto.BoardCommentDTO;
import com.boot.dto.BoardDTO;
import com.boot.dto.CriteriaDTO;
import com.boot.dto.PageDTO;
import com.boot.dto.UserDTO;
import com.boot.service.BoardCommentService;
import com.boot.service.BoardCommentServiceImpl;
import com.boot.service.BoardService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class BoardController {

	private final BoardCommentServiceImpl boardCommentServiceImpl;
	@Autowired
	private BoardService service;

	@Autowired
	private BoardCommentService bcService;

	BoardController(BoardCommentServiceImpl boardCommentServiceImpl) {
		this.boardCommentServiceImpl = boardCommentServiceImpl;
	}

	@RequestMapping("/board_view")
	public String boardView(CriteriaDTO criteriaDTO, Model model) {
		ArrayList<BoardDTO> list = service.boardView(criteriaDTO);
		int total = service.getTotalCount(criteriaDTO);

		model.addAttribute("boardList", list);
		model.addAttribute("pageMaker", new PageDTO(total, criteriaDTO));

		return "board_view";
	}

	@RequestMapping("/board_write_ok")
	public String boardViewWrite(@RequestParam HashMap<String, String> param) {

		service.boardWrite(param);

		return "board_view";
	}

	@RequestMapping("/delete_post")
	public String boardViewDelete(@RequestParam HashMap<String, String> param, RedirectAttributes rttr) {
		service.boardDelete(param);
		rttr.addAttribute("pageNum", param.get("pageNum"));
		rttr.addAttribute("amount", param.get("amount"));
		return "board_view";
	}

	@RequestMapping("/board_update_ok")
	public String boardViewUpdate(@RequestParam HashMap<String, String> param) {
		service.boardModify(param);
		return "board_view";
	}

	@RequestMapping("/board_update")
	public String boardViewUpdate(@RequestParam HashMap<String, String> param, Model model, RedirectAttributes rttr) {
		BoardDTO dto = service.boardDetailView(param);

		// 날짜 변환 처리
		convertBoardDate(dto);

		rttr.addAttribute("pageNum", param.get("pageNum"));
		rttr.addAttribute("amount", param.get("amount"));
		model.addAttribute("board", dto);
		return "board_update";
	}

	@RequestMapping("/board_detail_view")
	public String boardViewDetail(@RequestParam HashMap<String, String> param, Model model, CriteriaDTO criteriaDTO,
			@RequestParam(value = "skipViewCount", required = false) Boolean skipViewCount) {
		if (skipViewCount == null || !skipViewCount) {
			// 조회수 증가 로직
			service.boardHit(param);
		}
		BoardDTO dto = service.boardDetailView(param);
		ArrayList<BoardCommentDTO> commentList = bcService.bcView(param, criteriaDTO);
		int total = bcService.getTotalCount(param);
		int allTotal = bcService.getAllCount(param);

		model.addAttribute("allCount", allTotal);
		model.addAttribute("board", dto);
		model.addAttribute("commentList", commentList);
		model.addAttribute("pageMaker", new PageDTO(total, criteriaDTO));
		return "board_detail";
	}

	@RequestMapping("/boardLikes")
	public ResponseEntity<String> boardLikes(@RequestParam HashMap<String, String> param, HttpSession session) {
		UserDTO user = (UserDTO) session.getAttribute("loginUser");
		if (user == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인필요");
		}
		int boardNumber = Integer.parseInt(param.get("boardNumber"));
		int userNumber = user.getUserNumber();
		param.put("userNumber", String.valueOf(userNumber));

		if (service.boardHasLiked(param)) {
			return ResponseEntity.status(HttpStatus.CONFLICT).body("이미 추천 완료");
		}
		try {
			service.boardAddLike(param);
			return ResponseEntity.ok("추천 완료");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류 발생");
		}
	}

	@RequestMapping("/comment_write_ok")
	public String commentWriteOk(@RequestParam HashMap<String, String> param) {
		String boardNumber = param.get("boardNumber");
		if (param.get("commentContent") == "") {
			return "redirect:/board_detail_view?boardNumber=" + boardNumber;
		}
		bcService.bcWrite(param);

		return "redirect:/board_detail_view?boardNumber=" + boardNumber + "&skipViewCount=true";
	}

	// 게시글 목록의 날짜 변환을 처리하는 메소드
	private void convertBoardDates(ArrayList<BoardDTO> boardList) {
		if (boardList == null)
			return;

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		for (BoardDTO board : boardList) {
			convertBoardDate(board);
		}
	}

	// 단일 게시글의 날짜 변환을 처리하는 메소드
	private void convertBoardDate(BoardDTO board) {
		if (board == null)
			return;

		Object dateObj = board.getBoardWriteDate();
		if (dateObj instanceof String) {
			String dateStr = (String) dateObj;
			// 대괄호 제거 (있는 경우)
			dateStr = dateStr.replace("[", "").replace("]", "");

			try {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date date = sdf.parse(dateStr);
				board.setBoardWriteDate(dateStr);
			} catch (ParseException e) {
				// 날짜 형식이 다른 경우 다른 형식으로 시도
				try {
					SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
					Date date = sdf2.parse(dateStr);
					board.setBoardWriteDate(dateStr);
				} catch (ParseException e2) {
					// 변환 실패 시 로그 출력
					System.err.println("날짜 변환 실패: " + dateStr);
				}
			}
		}
	}
}