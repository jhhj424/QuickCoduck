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
//		if(type==1)System.out.println("���¼ҽ��Խ���");
//		if(type==2)System.out.println("�����������Խ���");
//		if(type==3)System.out.println("������Ʈ��������Խ���");
		ModelAndView mav = new ModelAndView();
		int limit = 10; // ���������� ����� �Խù� ����
		// �� �Խù� �Ǽ�
		int listcount = service.boardcount(searchType, searchContent,type);
		
		List<Board> noticelist = service.noticelist(searchType, searchContent, type);
		mav.addObject("noticelist",noticelist);
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
			if(type==1)System.out.println("���¼ҽ��Խ���");
			if(type==3)System.out.println("������Ʈ��������Խ���");
		}
		ModelAndView mav = new ModelAndView();
		int limit = 10; // ���������� ����� �Խù� ����
		// �� �Խù� �Ǽ�
		int listcount = service.boardcount(searchType, searchContent,type);
		int mycount = service.boardcount(searchType, searchContent,type,user.getUserid());//�����Ǽҽ�ī��Ʈ��
		// boardlist : ���������� ����� �Խù� ���� ����
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
			if(type==1)System.out.println("���¼ҽ��Խ���");
			if(type==3)System.out.println("������Ʈ��������Խ���");
		}
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
				board.setMaxperson(maxperson);//�ִ��ο� ����
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
			if(type == 3 && dbuser.getMaxcount() != 0) {//Ŭ���̾�Ʈ ����Խ��϶� maxcount -1
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
			throw new LoginException("�Խñ� ��Ͽ� �����ϼ̽��ϴ�", "write.duck?type="+board.getBoardtype());
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
		//��ȸ������----
		service.readcntadd(num);
		//------------
		List<Comment> comment = service.commentlist(num);
		int commentCount = service.commentcount(bo.getBoardnum());
		System.out.println("��۰���:"+commentCount);
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
			throw new LoginException("�ڽ��� �Խñ۸� ���� �����մϴ�.", "detail.duck?num=" + num+"&type=" + type);
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
		//bo = service.getBoard(bo); //���� �Խù� ��ü
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
			throw new LoginException("�ش���������", "deleteForm.duck?num=" + bo.getBoardnum()+"&type=" + bo.getBoardtype());
		}
		if(!user.getPass().equals(pass)) {
			throw new LoginException("��й�ȣ ����", "deleteForm.duck?num=" + bo.getBoardnum()+"&type=" + bo.getBoardtype());
		}
		//��й�ȣ Ȯ�� ����
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
			throw new LoginException("�Խñ� ������ �����߽��ϴ�", "deleteForm.duck?num=" + bo.getBoardnum()+"&type=" + bo.getBoardtype());
		}
		return mav;
	}
	
	@RequestMapping(value = "board/update", method = RequestMethod.POST)
	public ModelAndView update(@Valid Board board, BindingResult br, HttpServletRequest request, HttpSession session,String techlist) {
		//System.out.println("�Ű�����Ȯ��:"+board);
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
		System.out.println("���Ȯ��:"+pass);
		int num = Integer.parseInt(request.getParameter("boardnum"));
		Board b1 = new Board();
		b1.setBoardnum(num);
		b1.setBoardtype(board.getBoardtype());
		//b1 = service.getBoard(b1); // ������ board
		//System.out.println("������ �Խù�:"+b1);
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
		//System.out.println("����Ȯ��:"+user);
		if (br.hasErrors()) { // ��ȿ�� �˻�
			mav.getModel().putAll(br.getModel());
			mav.addObject("board", b1);
			return mav;
		}
		if (pass==null || !pass.equals(user.getPass())) {// ��й�ȣ ����
			throw new LoginException("��й�ȣ�� Ȯ���ϼ���", "update.duck?num=" + board.getBoardnum() + "&type=" + board.getBoardtype());
		} else { // ������
			board.setFileurl(request.getParameter("file2")); //������ ���Ϸ� url �־����
			try { // ����
				service.boardupdate(board,request);
				mav.addObject("board",board);
			} catch (Exception e) { // ������ ���� �߻�
				e.printStackTrace();
				throw new LoginException("�Խñ� ������ �����߽��ϴ�", "update.duck?num=" + board.getBoardnum() + "&type=" + board.getBoardtype());
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
			//board = service.getBoard(board); getBoard�� getNotice�� ���� ���� ����
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
				throw new LoginException("���� �Խù��� �ƴմϴ�.", "detail.duck?num=" + num+"&type=" + type);
			}/*
			if (request.getRequestURI().contains("detail")) { // ��������ΰ� datail�� �����Ҷ� (�󼼺���)
				service.readcntadd(num); // ��ȸ�� ����
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
	//��� ���
    @RequestMapping(value="board/comment*", method=RequestMethod.POST)
	public ModelAndView comment(Comment comment, HttpSession session,HttpServletRequest request) {
    	ModelAndView mav = new ModelAndView();
//    	System.out.println("��۳���:"+comment.getContent());
    	User user = (User)session.getAttribute("loginUser");
//    	System.out.println("���̵�:" + user.getUserid());

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
			throw new LoginException("��� ��Ͽ� �����ϼ̽��ϴ�", "detail.duck?type="+boardtype+"&num="+boardnum);
		}		
		return mav;
	}
    //�亯 ���
    @RequestMapping(value="board/reply", method=RequestMethod.GET)
	public ModelAndView reply(String reply,Integer num, Integer type, HttpSession session,HttpServletRequest request) {
    	ModelAndView mav = new ModelAndView();
    	Comment comment = service.selectcomment(num); //num : ����۹�ȣ
//    	System.out.println("ref"+comment.getRef());
//    	System.out.println("reflevel"+comment.getReflevel());
//    	System.out.println("refstep"+comment.getRefstep());
//    	System.out.println("================================");
//    	System.out.println("�亯 ����:"+reply); //reply : ����� ����
    	User user = (User)session.getAttribute("loginUser");
//    	System.out.println("���̵�:" + user.getUserid());
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
			System.out.println("��۵�ϼ���");
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("��� ��Ͽ� �����ϼ̽��ϴ�", "detail.duck?type="+type+"&num="+boardnum);
		}		
		return mav;
	}
    @RequestMapping("board/match_suggest")
    public ModelAndView match_suggest(Integer boardnum, String idchk, HttpSession session) { // Ŭ���̾�Ʈ �������Ŀ� ��Ī���� ���� => ���Ⱥ�����
    	ModelAndView mav = new ModelAndView();
    	String userid[] = idchk.split(",");
    	int ducktype = 6; // ��Ÿ��:6 => Ŭ���̾�Ʈ�� ���������� ��û�� ���� �Խù�(��)
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
		int matching = 1; // ������ ��ĪŸ���� 1
		int ducktype = 6; // ������ ��Ÿ���� 6
		List<User> developlist = service.supporterlist(userid, matching, boardnum, ducktype);
		List<User> refuselist = service.supporterlist(userid, matching, boardnum, 8); //�������
		List<User> acceptlist = service.supporterlist(userid, 2, boardnum, 4); //�������
		System.out.println("�����ڸ��:"+developlist);
		System.out.println("�������:"+refuselist);
		System.out.println("�������:"+acceptlist);
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
		//���� ���尴ü�� board�� nowperson�� 1 ������Ŵ
		try {
			User user = service.select(userid);
			System.out.println("����:"+user);
			if(user.getMatching()==1) { //��ĪŸ�� 1�϶��� ��������
				service.nowpersonupdate(boardnum);// ���⼭ �ش� �Խ����� ���� �ο��� 1����
				service.duckupdate(userid,boardnum); // �����̺��ִ� �����͸� �������λ��·� ���� : ��Ÿ�� : 4
				service.usermatchingupdate(userid); //���� ������ ��Ī���¸� 2�� ���� : ������Ʈ�������� ����<
				mav.addObject("suggest_message","������ �����ϼ̽��ϴ�.");
				mav.addObject("suggest_url","../user/myduck.duck?id="+userid+"&ducktype=4&type=3");
			}else { //��ĪŸ���� 1�� �ƴҰ�� // ���� �Ұ���
				mav.addObject("suggest_message","�̹� �������� ������Ʈ�� �ֽ��ϴ�.");
				mav.addObject("suggest_url","suggest_detail.duck?boardnum="+boardnum+"&type="+3);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("������ �����ϼ̽��ϴ�", "suggest_detail.duck?boardnum="+boardnum+"&type="+3);
		}	
		return mav;
    }
    @RequestMapping("board/suggest_refuse")
    public ModelAndView suggest_refuse(String userid, Integer boardnum, HttpSession session, HttpServletRequest request) {
    	ModelAndView mav = new ModelAndView();
		//���� ���尴ü�� board�� nowperson�� 1 ������Ŵ
		try {
			service.suggest_refuse(userid,boardnum); // �����̺��ִ� �����͸� ����
			mav.addObject("suggest_message","������ �����ϼ̽��ϴ�.");
			mav.addObject("suggest_url","../user/mypage_suggestlist.duck?id="+userid+"&ducktype=6");
		} catch (Exception e) {
			throw new LoginException("������ �����ϼ̽��ϴ�", "suggest_detail.duck?boardnum="+boardnum+"&type="+3);
		}	
		return mav;
    }
 
    //��� ����
/*    @RequestMapping(value="/board/delcomment")
    public ModelAndView delComment(Integer boardnum, Integer num, HttpServletRequest request) {
    	System.out.println("���۹�ȣ:"+boardnum);
    	System.out.println("��۹�ȣ:"+num);
    	ModelAndView mav = new ModelAndView();
    	
    	int bnum = Integer.parseInt((request.getParameter("num")));
    	int btype = Integer.parseInt((request.getParameter("type")));

    	try {
    		service.delcomment(num);    
    		mav.addObject("num", num);
			mav.setViewName("redirect:detail.duck?type="+btype+"&num="+bnum);
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("��� ������ �����ϼ̽��ϴ�", "detail.duck?type="+btype+"&num="+bnum);
		}	
        return mav;
     }
*/ 
}
