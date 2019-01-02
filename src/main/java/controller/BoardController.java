package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import logic.Board;
import logic.DuckService;

@Controller
public class BoardController {
	@Autowired
	private DuckService service;

	@RequestMapping(value = "board/list")
	public ModelAndView list(Integer pageNum, String searchType, String searchContent) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		ModelAndView mav = new ModelAndView();
		int limit = 10; // 한페이지에 출력할 게시물 갯수
		// 총 게시물 건수
		int listcount = service.boardcount(searchType, searchContent);
		// boardlist : 한페이지에 출력할 게시물 정보 저장
		List<Board> boardlist = service.boardlist(searchType, searchContent, pageNum, limit);
		int maxpage = (int) ((double) listcount / limit + 0.95);
		int startpage = ((int) ((pageNum / 10.0 + 0.9) - 1)) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		int boardcnt = listcount - (pageNum - 1) * limit;
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", listcount);
		mav.addObject("boardlist", boardlist);
		mav.addObject("boardcnt", boardcnt);
		return mav;
	}

	@RequestMapping(value = "board/*", method = RequestMethod.GET)
	public ModelAndView getboard(Integer num, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Board board = new Board();
		if (num != null) {
			if (request.getRequestURI().contains("detail")) { // 페이지경로가 datail을 포함할때 (상세보기)
				service.readcntadd(num); // 조회수 증가
			}
			board = service.getBoard(num);
		}
		mav.addObject("board", board);
		return mav;
	}
}
