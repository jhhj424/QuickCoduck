package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import exception.LoginException;
import logic.Board;
import logic.Duck;
import logic.DuckService;
import logic.User;

/*
 * 1. ȸ�� ����/������ �̸����� ��ȣȭ �Ͽ� db�� �����ϱ�
 * 2. ��ȸ�� ��ȣȭ �Ͽ� ȭ�� ���.
 * 	    ȸ�� ��ȸ.
 * 	    ȸ�� ���. 
 */
@Controller
public class UserController {
	@Autowired
	private DuckService service;

	@RequestMapping("user/start")
	public ModelAndView start() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}

	@RequestMapping("user/main")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}

	@RequestMapping("user/signup")
	public ModelAndView signup(User user, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("user/start");
		String pass = request.getParameter("pass");
		String pass2 = request.getParameter("pass2");
		String userid = request.getParameter("userid");

		int count = service.idchk(userid);
		if (count != 0) {
			throw new LoginException("���̵� �ߺ��Դϴ�", "../user/start.duck");
		} else {
			if (pass.equals(pass2) && !(pass.length() < 4 || pass.length() > 12)) {
				service.userCreate(user, request);
				mav.addObject("user", user);
				mav.setViewName("redirect:start.duck");
			} else {

				throw new LoginException("��й�ȣ�� ��ġ���� �ʽ��ϴ�.", "../user/start.duck");

			}
		}
		return mav;
	}

	@RequestMapping("user/start_login")
	public ModelAndView start_login(User user, HttpSession session) {
		// @Valid : ��ȿ�� ����. Item Ŭ������ ���ǵ� �������� ������ ��.
		ModelAndView mav = new ModelAndView();

		User dbuser = service.userSelect(user);
		if (dbuser == null) {// ���̵� �������� �ʴ°��
			throw new LoginException("���̵� ���� X", "../user/start.duck");
		}
		if (user.getPass().equals(dbuser.getPass())) { // ��й�ȣ�� ��ġ
			session.setAttribute("loginUser", dbuser);
			mav.setViewName("redirect:main.duck");

		} else {// ��й�ȣ ����ġ
			if (user.getPass().length() < 4 || user.getPass().length() > 12) { // ��й�ȣ �ڸ��� ����
				throw new LoginException("��й�ȣ�� 4~12�ڸ� �� ����", "../user/start.duck");
			} else {
				throw new LoginException("��й�ȣ�� ��ġ���� �ʽ��ϴ�.", "../user/start.duck");
			}
		}

		return mav;
	}

	@RequestMapping("user/login")
	public ModelAndView login(User user, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User dbuser = service.userSelect(user);
		if (dbuser == null) {// ���̵� �������� �ʴ°��
			throw new LoginException("���̵� ���� X", "../user/loginForm.duck");
		}
		if (user.getPass().equals(dbuser.getPass())) { // ��й�ȣ�� ��ġ
			session.setAttribute("loginUser", dbuser);
			mav.setViewName("redirect:main.duck");
		} else {// ��й�ȣ ����ġ
			if (user.getPass().length() < 4 || user.getPass().length() > 12) { // ��й�ȣ �ڸ��� ����
				throw new LoginException("��й�ȣ�� 4~12�ڸ� �� ����", "../user/loginForm.duck");
			} else {
				throw new LoginException("��й�ȣ�� ��ġ���� �ʽ��ϴ�.", "../user/loginForm.duck");
			}
		}
		return mav;
	}

	@RequestMapping("user/userEntry")
	public ModelAndView userEntry(User user, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); // a �Է��ϸ� a.jsp�� �̵���.
		String pass1 = request.getParameter("pass");
		String pass2 = request.getParameter("pass2");

		if (pass1.equals(pass2) && !(pass1.length() < 4 || pass1.length() > 12)) { // ��й�ȣ ��ġ
			service.userCreate(user, request);
			mav.addObject("user", user);
			mav.setViewName("redirect:loginForm.duck");
		} else {
			throw new LoginException("��й�ȣ�� Ȯ�����ּ���", "../user/loginForm.duck");
		}
		return mav;
	}

	@RequestMapping("user/loginForm")
	public ModelAndView loginForm() {
		ModelAndView mav = new ModelAndView("user/login");
		mav.addObject(new User());
		return mav;
	}

	@RequestMapping("user/logout")
	public ModelAndView logout(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		session.invalidate();
		mav.setViewName("redirect:loginForm.duck");
		return mav;
	}

	@RequestMapping("user/mypage_main")
	public ModelAndView mypage_main(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.select(id);
		mav.addObject("user", user);
		return mav;
	}

	@RequestMapping(value = "user/mypage_*")
	public ModelAndView mypage(String id, HttpSession session, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		User dbuser = (User) session.getAttribute("loginUser");
		mav.addObject("user", dbuser);
		return mav;
	}

	@RequestMapping("user/updateForm")
	public ModelAndView update11(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.select(id);
		mav.addObject("user", user);
		return mav;
	}

	@RequestMapping(value = "user/update", method = RequestMethod.POST)
	public ModelAndView update(HttpSession session, User user, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("user/mypage_update");
		service.userUpdate(user, request);
		User user1 = service.select(user.getUserid());
		System.out.println("����:"+user1);
		session.setAttribute("loginUser", user1);
		mav.setViewName("redirect:mypage_main.duck?id=" + user1.getUserid());
		return mav;
	}

	@InitBinder // �Ķ���� �� ����ȯ�� ���� �޼���
	public void initBinder(WebDataBinder binder) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		/*
		 * Date.class : �Ķ���Ͱ��� DateŸ������ ����ȯ ��. User ��ü�� Date �� ������ Ÿ���̾�� ��. new
		 * CustomDateEditor : �Ķ���� ����ȯ. ������ dateFormat�� ����. true : ���Է� ���. false : �ݵ��
		 * �Է�.
		 * 
		 * ������ Ʋ����� : typeMismatch.�Ķ�����̸� �ڵ带 ������ �����.
		 */
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); // false:�ʼ��Է� true:�����Է�
	}

	@RequestMapping(value = "user/delete", method = RequestMethod.GET)
	public ModelAndView delete(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.select(id);
		mav.addObject("user", user);
		return mav;
	}

	@RequestMapping(value = "user/delete", method = RequestMethod.POST)
	public ModelAndView delete(String id, HttpSession session, String password) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User) session.getAttribute("loginUser");// ����α��ε�����
		if (loginUser.getPass().equals(password)) {
			try {
				service.userDelete(id);
				if (!loginUser.getUserid().equals("admin")) {
					session.invalidate();
					mav.setViewName("redirect:loginForm.duck");
				} else {// ������
					mav.setViewName("redirect:../admin/list.duck");
				}
			} catch (Exception e) {
				e.printStackTrace();
				throw new LoginException("Ż�����", "../user/delete.duck?id=" + id);
			}
		} else {// ����Ʋ��
			throw new LoginException("��й�ȣ����", "../user/delete.duck?id=" + id);
		}
		return mav;
	}

	@RequestMapping(value = "user/myduck")
	public ModelAndView list(Integer pageNum, String searchType, String searchContent, Integer boardtype,
			HttpSession session, String id, Integer boardnum, Integer ducktype) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		ModelAndView mav = new ModelAndView();
		User user = service.select(id);
		mav.addObject("user", user);
		int limit = 10; // ���������� ����� �Խù� ����
		// �� �Խù� �Ǽ�
		int listcount = service.boardcount(searchType, searchContent, boardtype, id, ducktype);
		// boardlist : ���������� ����� �Խù� ���� ����
		List<Board> boardlist = service.boardlist(searchType, searchContent, pageNum, limit, boardtype, id, ducktype);
		System.out.println("boardlist:" + boardlist);
		int maxpage = (int) ((double) listcount / limit + 0.95);
		int startpage = ((int) ((pageNum / 10.0 + 0.9) - 1)) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		int boardcnt = listcount - (pageNum - 1) * limit;
		mav.addObject("id", id);
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", listcount);
		mav.addObject("boardlist", boardlist);
		mav.addObject("boardcnt", boardcnt);
		mav.addObject("boardtype", boardtype);
		mav.addObject("ducktype", ducktype);
		return mav;
	}

	@RequestMapping(value = "user/submain")
	public ModelAndView submain(HttpSession session, Integer boardnum) {
		ModelAndView mav = new ModelAndView();
		// boardlist : ���������� ����� �Խù� ���� ����
		List<Board> boardlist = service.boardlist(boardnum);
		List<Board> boardlist2 = service.boardlist2(boardnum);
		System.out.println("boardlist:" + boardlist);
		System.out.println("boardlist2:" + boardlist2);
		mav.addObject("boardlist", boardlist);
		mav.addObject("boardlist2", boardlist2);
		return mav;
	}
}
