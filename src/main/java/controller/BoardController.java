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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import exception.LoginException;
import logic.Board;
import logic.Comment;
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
	@RequestMapping(value = "board/find")
	public ModelAndView find(Integer pageNum, String searchType, String searchContent, Integer type, HttpSession session) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if(type != null) {
			if(type==1)System.out.println("오픈소스게시판");
			if(type==3)System.out.println("프로젝트공고모집게시판");
		}
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
	@RequestMapping(value = "board/pfind")
	public ModelAndView pfind(Integer pageNum, String searchType, String searchContent, Integer type, HttpSession session , String chk) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if(type != null) {
			if(type==1)System.out.println("오픈소스게시판");
			if(type==3)System.out.println("프로젝트공고모집게시판");
		}
		System.out.println("페이징기술목록:"+chk);
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
	public ModelAndView boardwrite(@Valid Board board, BindingResult br, HttpServletRequest request, HttpSession session, String techlist) {
		System.out.println(board);
		String tech = "";
		if(techlist != null) {
			System.out.println("보드컨트롤러글쓰기:"+techlist);
			String techarr[] = techlist.split(",");
			for(int i=0;i<techarr.length;i++) {
				tech += techarr[i];
			}
		}
		board.setUsetech(tech);
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
		List<Comment> comment = service.commentlist(num);
		int commentCount = service.commentcount(bo.getBoardnum());
		System.out.println("댓글개수:"+commentCount);
		Board board = service.getBoard(bo);
		mav.addObject("board",board);
		mav.addObject("comment",comment);
		mav.addObject("commentCount", commentCount);
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
			}/*
			if (request.getRequestURI().contains("detail")) { // 페이지경로가 datail을 포함할때 (상세보기)
				service.readcntadd(num); // 조회수 증가
			}*/
			board = service.getBoard(board);
		}
		mav.addObject("board", board);
		return mav;
	}
//	@ResponseBody
//	@RequestMapping(value="board/check",method=RequestMethod.POST)
//	public void check(@RequestParam(value="valueArr[]") List<String>valueArr) {
//		System.out.println(valueArr);
//	}
	//댓글 등록
    @RequestMapping(value="board/comment*", method=RequestMethod.POST)
	public ModelAndView comment(Comment comment, HttpSession session,HttpServletRequest request) {
    	ModelAndView mav = new ModelAndView();
    	System.out.println("댓글내용:"+comment.getContent());
    	User user = (User)session.getAttribute("loginUser");
    	System.out.println("아이디:" + user.getUserid());

    	int boardnum = Integer.parseInt(request.getParameter("num"));
    	int boardtype = Integer.parseInt(request.getParameter("type"));
    	System.out.println("bnum:"+boardnum);
    	System.out.println("btype:"+boardtype);
    	int commentCount = service.commentcount(boardnum);
    	

    	try {
    		service.commentadd(comment,request,user.getUserid());
    		mav.addObject("content", comment.getContent());
			mav.addObject("userid", user.getUserid());
			mav.addObject("commentCount", commentCount);
			mav.setViewName("redirect:detail.duck?type="+boardtype+"&num="+boardnum);
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("댓글 등록에 실패하셨습니다", "detail.duck?type="+boardtype+"&num="+boardnum);
		}		
		return mav;
	}
 
    //댓글 삭제
/*    @RequestMapping(value="/board/delcomment")
    public ModelAndView delComment(Integer boardnum, Integer num, HttpServletRequest request) {
    	System.out.println("원글번호:"+boardnum);
    	System.out.println("댓글번호:"+num);
    	ModelAndView mav = new ModelAndView();
    	
    	int bnum = Integer.parseInt((request.getParameter("num")));
    	int btype = Integer.parseInt((request.getParameter("type")));

    	try {
    		service.delcomment(num);    
    		mav.addObject("num", num);
			mav.setViewName("redirect:detail.duck?type="+btype+"&num="+bnum);
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("댓글 삭제에 실패하셨습니다", "detail.duck?type="+btype+"&num="+bnum);
		}	
        return mav;
     }
*/ 
}
