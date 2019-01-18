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
		if (searchType == null || searchType.equals("")) {
			searchType = null;
		}
		if (searchContent == null || searchContent.equals("")) {
			searchContent = null;
		}
//		if(type==1)System.out.println("오픈소스게시판");
//		if(type==2)System.out.println("개발자자유게시판");
//		if(type==3)System.out.println("프로젝트공고모집게시판");
		ModelAndView mav = new ModelAndView();
		int limit = 10; // 한페이지에 출력할 게시물 갯수
		// 총 게시물 건수
		int listcount = service.boardcount(searchType, searchContent,type);
		
		List<Board> noticelist = service.noticelist(searchType, searchContent, type);
		mav.addObject("noticelist",noticelist);
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
		String projectcnt = service.projectcnt();
		System.out.println("projectcnt:"+projectcnt);
		mav.addObject("projectcnt",projectcnt);
		String projecttotalprice = service.projecttotalprice();
		mav.addObject("projecttotalprice",projecttotalprice);
		String usertotalcnt = service.usertotalcnt();
		mav.addObject("usertotalcnt",usertotalcnt);
		return mav;
	}
	@RequestMapping(value = "board/find")
	public ModelAndView find(Integer pageNum, String searchType, String searchContent, Integer type, HttpSession session) {
		User user = (User)session.getAttribute("loginUser");
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if (searchType == null || searchType.equals("")) {
			searchType = null;
		}
		if (searchContent == null || searchContent.equals("")) {
			searchContent = null;
		}
		if(type != null) {
			if(type==1)System.out.println("오픈소스게시판");
			if(type==3)System.out.println("프로젝트공고모집게시판");
		}
		ModelAndView mav = new ModelAndView();
		int limit = 10; // 한페이지에 출력할 게시물 갯수
		// 총 게시물 건수
		int listcount = service.boardcount(searchType, searchContent,type);
		int mycount = service.boardcount(searchType, searchContent,type,user.getUserid());//나만의소스카운트용
		// boardlist : 한페이지에 출력할 게시물 정보 저장
		List<Board> boardlist = service.boardlist(searchType, searchContent, pageNum, limit,type);
		if(type==5) {
			boardlist.clear();
			boardlist = service.boardlist(searchType, searchContent, pageNum, limit,type,user.getUserid());
		}
		int maxpage = (int) ((double) listcount / limit + 0.95);
		if(type==5) {
			maxpage = 0;
			maxpage = (int) ((double) mycount / limit + 0.95);
		}
		int startpage = ((int) ((pageNum / 10.0 + 0.9) - 1)) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		int boardcnt = listcount - (pageNum - 1) * limit;
		if(type==5) {
			boardcnt = 0;
			boardcnt = mycount - (pageNum - 1) * limit;
		}
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", listcount);
		mav.addObject("mycount", mycount);
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
		String tech = "";
		User dbuser = (User)session.getAttribute("loginUser");
		int type = Integer.parseInt(request.getParameter("boardtype"));
		if(techlist != null) {
			System.out.println("tl:"+techlist);
			board.setUsetech(techlist);
		}
		ModelAndView mav = new ModelAndView();
		if (br.hasErrors()) {
			mav.getModel().putAll(br.getModel());
			mav.addObject("boardtype",board.getBoardtype());
			return mav;
		}
		try {
			if(request.getParameter("maxperson") != null) {
				int maxperson = Integer.parseInt(request.getParameter("maxperson"));
				board.setMaxperson(maxperson);//최대인원 설정
			}			
			service.boardadd(board, request);
			if(dbuser.getType()==1) {
				board = service.getBoard(board);
			}
			if(dbuser.getType()==2) {
				board = service.getBoard(board);
			}
			if(dbuser.getType()==3) {
				board = service.getNotice(board);
			}
			if(type == 3 && dbuser.getMaxcount() != 0) {//클라이언트 공고게시일때 maxcount -1
				service.cntmaxcount(dbuser);
				User user = service.select(dbuser.getUserid());
				mav.addObject("loginUser",user);
				session.setAttribute("loginUser",user);
			}
			mav.addObject("board", board);
			if(board.getBoardtype()==2) {
				mav.setViewName("redirect:list.duck?type="+board.getBoardtype());	
			}else if(board.getBoardtype()==3) {
				mav.setViewName("redirect:clientsuccess.duck?boardnum="+board.getBoardnum());
			}else {
				mav.setViewName("redirect:find.duck?type="+board.getBoardtype());				
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("게시글 등록에 실패하셨습니다", "write.duck?type="+board.getBoardtype());
		}
		return mav;
	}
	
	@RequestMapping(value="board/clientsuccess")
	public ModelAndView clientsuccess(Integer boardnum, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Board bo = new Board();
		bo.setBoardnum(boardnum);
		bo.setBoardtype(3);
		User user = (User)session.getAttribute("loginUser");
		Board board = service.getBoard(bo);
		mav.addObject("board", board);
		mav.addObject("User", user);
		session.setAttribute("loginUser", user);
		session.setAttribute("clientboard", board);
		return mav;
	}	
	
	@RequestMapping(value="board/suggest_detail")
	public ModelAndView suggest_detail(Integer boardnum, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Board bo = new Board();
		bo.setBoardnum(boardnum);
		bo.setBoardtype(3);
		User user = (User)session.getAttribute("loginUser");
		Board board = service.getBoard(bo);
		mav.addObject("board", board);
		mav.addObject("User", user);
		session.setAttribute("loginUser", user);
		session.setAttribute("clientboard", board);
		return mav;
	}	
	
	@RequestMapping(value="board/detail")
	public ModelAndView detail(Integer num,Integer type, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Board bo = new Board();
		bo.setBoardnum(num);
		bo.setBoardtype(type);
		//조회수증가----
		service.readcntadd(num);
		//------------
		List<Comment> comment = service.commentlist(num);
		int commentCount = service.commentcount(bo.getBoardnum());
		System.out.println("댓글개수:"+commentCount);
		Board board = service.getBoard(bo);
		mav.addObject("board",board);
		Board notice = service.getNotice(bo);
		mav.addObject("notice",notice);
		mav.addObject("comment",comment);
		mav.addObject("commentCount", commentCount);
		String projectcnt = service.projectcnt();
		System.out.println("projectcnt:"+projectcnt);
		mav.addObject("projectcnt",projectcnt);
		String projecttotalprice = service.projecttotalprice();
		mav.addObject("projecttotalprice",projecttotalprice);
		String usertotalcnt = service.usertotalcnt();
		mav.addObject("usertotalcnt",usertotalcnt);
		return mav;
	}
	@RequestMapping(value="board/deleteForm")
	public ModelAndView deleteForm(Integer num, Integer type, HttpSession session) {
		ModelAndView mav = new ModelAndView("board/delete");
		User loginUser = (User)session.getAttribute("loginUser");
		Board board = new Board();
		board.setBoardnum(num);
		board.setBoardtype(type);
		//board = service.getBoard(board);
		if(loginUser.getType()==1) {
			board = service.getBoard(board);
		}
		if(loginUser.getType()==2) {
			board = service.getBoard(board);
		}
		if(loginUser.getType()==3) {
			board = service.getNotice(board);
		}
		User user = new User();
		user = service.select(board.getUserid());
		if(!loginUser.getUserid().equals("admin")&&!loginUser.getUserid().equals(user.getUserid())) {
			throw new LoginException("자신의 게시글만 삭제 가능합니다.", "detail.duck?num=" + num+"&type=" + type);
		}
		mav.addObject("board",board);
		String projectcnt = service.projectcnt();
		System.out.println("projectcnt:"+projectcnt);
		mav.addObject("projectcnt",projectcnt);
		String projecttotalprice = service.projecttotalprice();
		mav.addObject("projecttotalprice",projecttotalprice);
		String usertotalcnt = service.usertotalcnt();
		mav.addObject("usertotalcnt",usertotalcnt);
		return mav;
	}
	
	@RequestMapping(value = "board/delete", method = RequestMethod.POST)
	public ModelAndView delete(Integer boardnum,Integer type, String pass, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Board bo = new Board();
		bo.setBoardnum(boardnum);
		bo.setBoardtype(type);
		User loginUser = (User)session.getAttribute("loginUser");
		//bo = service.getBoard(bo); //현재 게시물 객체
		if(loginUser.getType()==1) {
			bo = service.getBoard(bo);
		}
		if(loginUser.getType()==2) {
			bo = service.getBoard(bo);
		}
		if(loginUser.getType()==3) {
			bo = service.getNotice(bo);
		}
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
			if(type == 2) {
				mav.setViewName("redirect:list.duck?type="+bo.getBoardtype());				
			}else {
				mav.setViewName("redirect:find.duck?type="+bo.getBoardtype());
			}
			Board board = new Board();
			mav.addObject("board",board);
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("게시글 삭제에 실패했습니다", "deleteForm.duck?num=" + bo.getBoardnum()+"&type=" + bo.getBoardtype());
		}
		return mav;
	}
	
	@RequestMapping(value = "board/update", method = RequestMethod.POST)
	public ModelAndView update(@Valid Board board, BindingResult br, HttpServletRequest request, HttpSession session,String techlist) {
		//System.out.println("매개변수확인:"+board);
		ModelAndView mav = new ModelAndView();
		String pass = null;
		String finaltech = "";
		if(techlist!=null) { 
			board.setUsetech(techlist);
		}else {
			board.setUsetech(finaltech);
		}
		if(request.getParameter("pass")!=null) {
			pass = request.getParameter("pass");
		}
		System.out.println("비번확인:"+pass);
		int num = Integer.parseInt(request.getParameter("boardnum"));
		Board b1 = new Board();
		b1.setBoardnum(num);
		b1.setBoardtype(board.getBoardtype());
		//b1 = service.getBoard(b1); // 기존의 board
		//System.out.println("기존의 게시물:"+b1);
		User loginUser = (User)session.getAttribute("loginUser");
		if(loginUser.getType()==1) {
			b1 = service.getBoard(b1);
		}
		if(loginUser.getType()==2) {
			b1 = service.getBoard(b1);
		}
		if(loginUser.getType()==3) {
			b1 = service.getNotice(b1);
		}
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
		if(board.getBoardtype()==2) {
			mav.setViewName("redirect:list.duck?type="+board.getBoardtype());	
		}else {
			mav.setViewName("redirect:find.duck?type="+board.getBoardtype());				
		}
		return mav;
	}
	
	@RequestMapping(value = "board/*", method = RequestMethod.GET)
	public ModelAndView getboard(Integer num, HttpServletRequest request , Integer type, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Board board = new Board();
		User loginUser = (User)session.getAttribute("loginUser");
		if(num!=null) {
			board.setBoardnum(num);
			board.setBoardtype(type);
			//board = service.getBoard(board); getBoard와 getNotice를 같이 쓸수 없음
			if(loginUser.getType()==1) {
				board = service.getBoard(board);
			}
			if(loginUser.getType()==2) {
				board = service.getBoard(board);
			}
			if(loginUser.getType()==3) {
				board = service.getNotice(board);
			}
			User user = new User();
			user = service.select(board.getUserid());
			if(!loginUser.getUserid().equals("admin")&&!loginUser.getUserid().equals(user.getUserid())) {
				throw new LoginException("본인 게시물이 아닙니다.", "detail.duck?num=" + num+"&type=" + type);
			}/*
			if (request.getRequestURI().contains("detail")) { // 페이지경로가 datail을 포함할때 (상세보기)
				service.readcntadd(num); // 조회수 증가
			}*/
			//board = service.getBoard(board);
			if(loginUser.getType()==1) {
				board = service.getBoard(board);
			}
			if(loginUser.getType()==2) {
				board = service.getBoard(board);
			}
			if(loginUser.getType()==3) {
				board = service.getNotice(board);
			}
		}
		mav.addObject("board", board);
		String projectcnt = service.projectcnt();
		System.out.println("projectcnt:"+projectcnt);
		mav.addObject("projectcnt",projectcnt);
		String projecttotalprice = service.projecttotalprice();
		mav.addObject("projecttotalprice",projecttotalprice);
		String usertotalcnt = service.usertotalcnt();
		mav.addObject("usertotalcnt",usertotalcnt);
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
//    	System.out.println("댓글내용:"+comment.getContent());
    	User user = (User)session.getAttribute("loginUser");
//    	System.out.println("아이디:" + user.getUserid());

    	int rnum = service.refnum();
    	int boardnum = Integer.parseInt(request.getParameter("num"));
    	int boardtype = Integer.parseInt(request.getParameter("type"));
    	int commentCount = service.commentcount(boardnum);
//    	System.out.println("bnum:"+boardnum);
//    	System.out.println("btype:"+boardtype);    	
//    	System.out.println("ref:"+rnum);

    	try {
    		service.commentadd(comment,request,user.getUserid(),rnum);
    		mav.addObject("content", comment.getContent());
			mav.addObject("userid", user.getUserid());
			mav.addObject("commentCount", commentCount);
			mav.addObject("ref", rnum);
			mav.setViewName("redirect:detail.duck?type="+boardtype+"&num="+boardnum);
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("댓글 등록에 실패하셨습니다", "detail.duck?type="+boardtype+"&num="+boardnum);
		}		
		return mav;
	}
    //답변 등록
    @RequestMapping(value="board/reply", method=RequestMethod.GET)
	public ModelAndView reply(String reply,Integer num, Integer type, HttpSession session,HttpServletRequest request) {
    	ModelAndView mav = new ModelAndView();
    	Comment comment = service.selectcomment(num); //num : 원댓글번호
//    	System.out.println("ref"+comment.getRef());
//    	System.out.println("reflevel"+comment.getReflevel());
//    	System.out.println("refstep"+comment.getRefstep());
//    	System.out.println("================================");
//    	System.out.println("답변 내용:"+reply); //reply : 답글의 내용
    	User user = (User)session.getAttribute("loginUser");
//    	System.out.println("아이디:" + user.getUserid());
    	int commentCount = service.commentcount(comment.getBoardnum());
    	int refstep = comment.getRefstep();
    	int step = refstep + 1;
    	//System.out.println(step);
    	int boardnum = comment.getBoardnum();
    	
    	try {
    		service.replyadd(reply,user.getUserid(),step,boardnum,comment.getRef());
    		mav.addObject("content", comment.getContent());
			mav.addObject("userid", user.getUserid());
			mav.addObject("commentCount", commentCount);
			mav.addObject("refstep", step);
			mav.setViewName("redirect:detail.duck?type="+type+"&num="+boardnum);
			System.out.println("답글등록성공");
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("댓글 등록에 실패하셨습니다", "detail.duck?type="+type+"&num="+boardnum);
		}		
		return mav;
	}
    @RequestMapping("board/match_suggest")
    public ModelAndView match_suggest(Integer boardnum, String idchk, HttpSession session) { // 클라이언트 공고등록후에 매칭유저 선택 => 제안보내기
    	ModelAndView mav = new ModelAndView();
    	String userid[] = idchk.split(",");
    	int ducktype = 6; // 덕타입:6 => 클라이언트가 개발자한테 요청을 보낸 게시물(덕)
    	try {
    		for(int i=0; i<userid.length;i++) {
    			service.match_insert(userid[i],boardnum,ducktype);
    		}    		
    	}catch (Exception e) {
			e.printStackTrace();
		}
    	return mav;
    }
    @RequestMapping("board/selectdevelop")
    public ModelAndView selectdevelop(String userid, Integer boardnum, HttpSession session) {
    	ModelAndView mav = new ModelAndView();
		int matching = 1; // 유저의 매칭타입이 1
		int ducktype = 6; // 유저의 덕타입이 6
		List<User> developlist = service.supporterlist(userid, matching, boardnum, ducktype);
		List<User> refuselist = service.supporterlist(userid, matching, boardnum, 8); //거절목록
		List<User> acceptlist = service.supporterlist(userid, 2, boardnum, 4); //수락목록
		System.out.println("개발자목록:"+developlist);
		System.out.println("거절목록:"+refuselist);
		System.out.println("수락목록:"+acceptlist);
    	mav.addObject("developlist",developlist);
    	mav.addObject("refuselist",refuselist);
    	mav.addObject("acceptlist",acceptlist);
    	String projectcnt = service.projectcnt();
		System.out.println("projectcnt:"+projectcnt);
		mav.addObject("projectcnt",projectcnt);
		String projecttotalprice = service.projecttotalprice();
		mav.addObject("projecttotalprice",projecttotalprice);
		String usertotalcnt = service.usertotalcnt();
		mav.addObject("usertotalcnt",usertotalcnt);
    	return mav;
    }
    @RequestMapping("board/suggest_accept")
    public ModelAndView suggest_accept(String userid, Integer boardnum, HttpSession session, HttpServletRequest request) {
    	ModelAndView mav = new ModelAndView();
		//현재 보드객체의 board에 nowperson을 1 증가시킴
		try {
			User user = service.select(userid);
			System.out.println("유저:"+user);
			if(user.getMatching()==1) { //매칭타입 1일때만 수락가능
				service.nowpersonupdate(boardnum);// 여기서 해당 게시판의 현재 인원수 1증가
				service.duckupdate(userid,boardnum); // 덕테이블에있던 데이터를 진행중인상태로 변경 : 덕타입 : 4
				service.usermatchingupdate(userid); //현재 유저의 매칭상태를 2로 변경 : 프로젝트진행중인 유저<
				mav.addObject("suggest_message","수락에 성공하셨습니다.");
				mav.addObject("suggest_url","../user/myduck.duck?id="+userid+"&ducktype=4&type=3");
			}else { //매칭타입이 1이 아닐경우 // 수락 불가능
				mav.addObject("suggest_message","이미 진행중인 프로젝트가 있습니다.");
				mav.addObject("suggest_url","suggest_detail.duck?boardnum="+boardnum+"&type="+3);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("수락에 실패하셨습니다", "suggest_detail.duck?boardnum="+boardnum+"&type="+3);
		}	
		return mav;
    }
    @RequestMapping("board/suggest_refuse")
    public ModelAndView suggest_refuse(String userid, Integer boardnum, HttpSession session, HttpServletRequest request) {
    	ModelAndView mav = new ModelAndView();
		//현재 보드객체의 board에 nowperson을 1 증가시킴
		try {
			service.suggest_refuse(userid,boardnum); // 덕테이블에있던 데이터를 삭제
			mav.addObject("suggest_message","거절에 성공하셨습니다.");
			mav.addObject("suggest_url","../user/mypage_suggestlist.duck?id="+userid+"&ducktype=6");
		} catch (Exception e) {
			throw new LoginException("거절에 실패하셨습니다", "suggest_detail.duck?boardnum="+boardnum+"&type="+3);
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
