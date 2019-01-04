package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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
import logic.User;

@Controller
public class BoardController {
	@Autowired
	private DuckService service;
	

	@RequestMapping(value = "board/list")
	public ModelAndView list(Integer pageNum, String searchType, String searchContent, Integer type, HttpSession session) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if(type==1)System.out.println("오픈소스게시판");
		if(type==2)System.out.println("개발자자유게시판");
		if(type==3)System.out.println("프로젝트공고모집게시판");
		ModelAndView mav = new ModelAndView();
		int limit = 10; // 한페이지에 출력할 게시물 갯수
		// 총 게시물 건수
		int listcount = service.boardcount(searchType, searchContent,type);
		// boardlist : 한페이지에 출력할 게시물 정보 저장
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
	public ModelAndView boardwrite(@Valid Board board, BindingResult br, HttpServletRequest request, HttpSession session) {
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
			throw new LoginException("게시글 등록에 실패하셨습니다", "write.duck?type="+board.getBoardtype());
		}
		return mav;
	}
	
	@RequestMapping(value="board/detail")
	public ModelAndView detail(Integer num,Integer type, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Board bo = new Board();
		bo.setBoardnum(num);
		bo.setBoardtype(type);
		Board board = service.getBoard(bo);
		mav.addObject("board",board);
		return mav;
	}
	@RequestMapping(value="board/deleteForm")
	public ModelAndView deleteForm(Integer num, Integer type, HttpSession session) {
		ModelAndView mav = new ModelAndView("board/delete");
		Board board = new Board();
		board.setBoardnum(num);
		board.setBoardtype(type);
		board = service.getBoard(board);
		User user = new User();
		user = service.select(board.getUserid());
		User loginUser = (User)session.getAttribute("loginUser");
		if(!loginUser.getUserid().equals("admin")&&!loginUser.getUserid().equals(user.getUserid())) {
			throw new LoginException("자신의 게시글만 삭제 가능합니다.", "detail.duck?num=" + num+"&type=" + type);
		}
		mav.addObject("board",board);
		return mav;
	}
	
	@RequestMapping(value = "board/delete", method = RequestMethod.POST)
	public ModelAndView delete(Integer boardnum,Integer type, String pass, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Board bo = new Board();
		bo.setBoardnum(boardnum);
		bo.setBoardtype(type);
		bo = service.getBoard(bo); //현재 게시물 객체
		User user = new User();
		user.setUserid(bo.getUserid());
		user = service.userSelect(user);
		if(user == null) {
			throw new LoginException("해당유저없음", "deleteForm.duck?num=" + bo.getBoardnum()+"&type=" + bo.getBoardtype());
		}
		if(!user.getPass().equals(pass)) {
			throw new LoginException("비밀번호 오류", "deleteForm.duck?num=" + bo.getBoardnum()+"&type=" + bo.getBoardtype());
		}
		//비밀번호 확인 성공
		try {
			service.boarddelete(bo.getBoardnum());
			mav.setViewName("redirect:list.duck?type="+bo.getBoardtype());
			Board board = new Board();
			mav.addObject("board",board);
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("게시글 삭제에 실패했습니다", "deleteForm.duck?num=" + bo.getBoardnum()+"&type=" + bo.getBoardtype());
		}
		return mav;
	}
	
	@RequestMapping(value = "board/update", method = RequestMethod.POST)
	public ModelAndView update(@Valid Board board, BindingResult br, HttpServletRequest request, HttpSession session) {
		//System.out.println("매개변수확인:"+board);
		ModelAndView mav = new ModelAndView();
		String pass = null;
		if(request.getParameter("pass")!=null) {
			pass = request.getParameter("pass");
		}
		//System.out.println("비번확인:"+pass);
		int num = Integer.parseInt(request.getParameter("boardnum"));
		Board b1 = new Board();
		b1.setBoardnum(num);
		b1.setBoardtype(board.getBoardtype());
		b1 = service.getBoard(b1); // 기존의 board
		//System.out.println("기존의 게시물:"+b1);
		User user = new User();
		user = service.select(b1.getUserid());
		//System.out.println("유저확인:"+user);
		if (br.hasErrors()) { // 유효성 검사
			mav.getModel().putAll(br.getModel());
			mav.addObject("board", b1);
			return mav;
		}
		if (pass==null || !pass.equals(user.getPass())) {// 비밀번호 오류
			throw new LoginException("비밀번호를 확인하세요", "update.duck?num=" + board.getBoardnum() + "&type=" + board.getBoardtype());
		} else { // 비번통과
			board.setFileurl(request.getParameter("file2")); //기존의 파일로 url 넣어놓기
			try { // 수정
				service.boardupdate(board,request);
				mav.addObject("board",board);
			} catch (Exception e) { // 수정시 오류 발생
				e.printStackTrace();
				throw new LoginException("게시글 수정에 실패했습니다", "update.duck?num=" + board.getBoardnum() + "&type=" + board.getBoardtype());
			}
		}
		mav.setViewName("redirect:list.duck?type="+board.getBoardtype());
		return mav;
	}
	
	@RequestMapping(value = "board/*", method = RequestMethod.GET)
	public ModelAndView getboard(Integer num, HttpServletRequest request , Integer type, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Board board = new Board();
		if(num!=null) {
			board.setBoardnum(num);
			board.setBoardtype(type);
			board = service.getBoard(board);
			User user = new User();
			user = service.select(board.getUserid());
			User loginUser = (User)session.getAttribute("loginUser");
			if(!loginUser.getUserid().equals("admin")&&!loginUser.getUserid().equals(user.getUserid())) {
				throw new LoginException("본인 게시물이 아닙니다.", "detail.duck?num=" + num+"&type=" + type);
			}
			if (request.getRequestURI().contains("detail")) { // 페이지경로가 datail을 포함할때 (상세보기)
				service.readcntadd(num); // 조회수 증가
			}
			board = service.getBoard(board);
		}
		mav.addObject("board", board);
		return mav;
	}
}
