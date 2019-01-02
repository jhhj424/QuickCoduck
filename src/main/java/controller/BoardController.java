package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import exception.LoginException;
import logic.Board;
import logic.DuckService;

@Controller
public class BoardController {
	@Autowired
	private DuckService service;

	@RequestMapping(value = "board/list")
	public ModelAndView list(Integer pageNum, String searchType, String searchContent, int type) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if(type==1)System.out.println("���¼ҽ��Խ���");
		if(type==2)System.out.println("�����������Խ���");
		if(type==3)System.out.println("������Ʈ��������Խ���");
		ModelAndView mav = new ModelAndView();
		int limit = 10; // ���������� ����� �Խù� ����
		// �� �Խù� �Ǽ�
		int listcount = service.boardcount(searchType, searchContent,type);
		// boardlist : ���������� ����� �Խù� ���� ����
		List<Board> boardlist = service.boardlist(searchType, searchContent, pageNum, limit,type);
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
	@RequestMapping(value = "board/write", method = RequestMethod.POST)
	public ModelAndView boardwrite(@Valid Board board, BindingResult br, HttpServletRequest request) {
		System.out.println(board);
		ModelAndView mav = new ModelAndView();
		if (br.hasErrors()) {
			mav.getModel().putAll(br.getModel());
			return mav;
		}
		try {
			service.boardadd(board, request);
			mav.addObject("board", board);
			mav.setViewName("redirect:list.duck?type="+board.getBoardtype());
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("�Խñ� ��Ͽ� �����ϼ̽��ϴ�", "write.duck?type="+board.getBoardtype());
		}
		return mav;
	}

	@RequestMapping(value = "board/*", method = RequestMethod.GET)
	public ModelAndView getboard(Integer num, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Board board = new Board();
		if (num != null) {
			if (request.getRequestURI().contains("detail")) { // ��������ΰ� datail�� �����Ҷ� (�󼼺���)
				service.readcntadd(num); // ��ȸ�� ����
			}
			board = service.getBoard(num);
		}
		mav.addObject("board", board);
		return mav;
	}
}
