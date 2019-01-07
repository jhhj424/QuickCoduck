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
			throw new LoginException("�Խñ� ��Ͽ� �����ϼ̽��ϴ�", "write.duck?type="+board.getBoardtype());
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
			throw new LoginException("�ڽ��� �Խñ۸� ���� �����մϴ�.", "detail.duck?num=" + num+"&type=" + type);
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
		bo = service.getBoard(bo); //���� �Խù� ��ü
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
			mav.setViewName("redirect:list.duck?type="+bo.getBoardtype());
			Board board = new Board();
			mav.addObject("board",board);
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("�Խñ� ������ �����߽��ϴ�", "deleteForm.duck?num=" + bo.getBoardnum()+"&type=" + bo.getBoardtype());
		}
		return mav;
	}
	
	@RequestMapping(value = "board/update", method = RequestMethod.POST)
	public ModelAndView update(@Valid Board board, BindingResult br, HttpServletRequest request, HttpSession session) {
		//System.out.println("�Ű�����Ȯ��:"+board);
		ModelAndView mav = new ModelAndView();
		String pass = null;
		if(request.getParameter("pass")!=null) {
			pass = request.getParameter("pass");
		}
		//System.out.println("���Ȯ��:"+pass);
		int num = Integer.parseInt(request.getParameter("boardnum"));
		Board b1 = new Board();
		b1.setBoardnum(num);
		b1.setBoardtype(board.getBoardtype());
		b1 = service.getBoard(b1); // ������ board
		//System.out.println("������ �Խù�:"+b1);
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
				throw new LoginException("���� �Խù��� �ƴմϴ�.", "detail.duck?num=" + num+"&type=" + type);
			}
			if (request.getRequestURI().contains("detail")) { // ��������ΰ� datail�� �����Ҷ� (�󼼺���)
				service.readcntadd(num); // ��ȸ�� ����
			}
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
}
