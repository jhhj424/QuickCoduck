package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TreeSet;

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

	@RequestMapping(value = "user/main")
	public ModelAndView main(HttpSession session, Integer boardnum) {
		ModelAndView mav = new ModelAndView();
		List<Board> boardlist = service.boardlist(boardnum);
		List<Board> boardlist2 = service.boardlist2(boardnum);
		int usercount = service.usercount();
		mav.addObject("usercount", usercount);
		mav.addObject("boardlist", boardlist);
		mav.addObject("boardlist2", boardlist2);
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
		User dbuser = service.select(id);
		System.out.println("maxcount" + dbuser.getMaxcount());
		User user = (User) session.getAttribute("loginUser");
		if (!dbuser.getUserid().equals(user.getUserid()) && !user.getUserid().equals("admin")) {
			throw new LoginException("���������� ��ȸ �����մϴ�", "../user/mypage_main.duck?id=" + user.getUserid());
		}
		mav.addObject("user", dbuser);
		return mav;
	}

	@RequestMapping(value = "user/update", method = RequestMethod.POST)
	public ModelAndView update(HttpSession session, User user, HttpServletRequest request)
			throws NoSuchAlgorithmException {
		ModelAndView mav = new ModelAndView("user/mypage_update");
		user.setFileurl(request.getParameter("file2"));
		if (user.getType() == 2 && user.getCreditpass().length() == 4) {
			int count = service.creditchk(user.getCreditnum());
			if (count == 0) {
				String hashpass = service.getHashvalue(user.getCreditpass());
				user.setCreditpass(hashpass);
				service.userUpdate(user, request);
				User user1 = service.select(user.getUserid());
				session.setAttribute("loginUser", user1);
				mav.setViewName("redirect:mypage_main.duck?id=" + user1.getUserid());
			} else if (count == 1 && user.getCreditpass().length() > 4) {// �ߺ������� �̹� creditpass�� �ؽ��˰��� ȭ �Ǿ��ִ� ���
				service.userUpdate(user, request);
				User user1 = service.select(user.getUserid());
				session.setAttribute("loginUser", user1);
				mav.setViewName("redirect:mypage_main.duck?id=" + user1.getUserid());
			} else if (count == 1 && user.getCreditpass().length() == 4) {// �ߺ��̰� ó���� �ؽ��˰��� ȭ �ϱ� �� pass �ڸ����� 4�ڸ��� ���
				throw new LoginException("ī���ȣ �ߺ��Դϴ� Ȯ�����ּ���", "../user/mypage_update.duck?id=" + user.getUserid());
			}
		} else {
			service.userUpdate(user, request);
			User user1 = service.select(user.getUserid());
			session.setAttribute("loginUser", user1);
			mav.setViewName("redirect:mypage_main.duck?id=" + user1.getUserid());
		}
		return mav;
	}

	@RequestMapping(value = "user/payment*", method = RequestMethod.POST)
	public ModelAndView payment(HttpSession session, User user, HttpServletRequest request)
			throws NoSuchAlgorithmException {
		ModelAndView mav = new ModelAndView("user/mypage_itempay");
		int itemtype = Integer.parseInt(request.getParameter("itemtype"));
		User dbuser = service.select(user.getUserid());
		String hashpass = service.getHashvalue(user.getCreditpass());
		if (hashpass.equals(dbuser.getCreditpass())) {
			if (itemtype == 1) {
				dbuser.setMaxcount(10);
			} else if (itemtype == 2) {
				dbuser.setMaxcount(20);
			} else {
				dbuser.setMaxcount(30);
			}
			service.maxcountUpdate(dbuser);
			session.setAttribute("loginUser", dbuser);
			mav.setViewName("redirect:mypage_main.duck?id=" + dbuser.getUserid());
		} else {
			throw new LoginException("������й�ȣ ����!",
					"../user/mypage_itempay.duck?id=" + user.getUserid() + "&itemtype=" + itemtype);
		}
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


	@RequestMapping(value = "user/delete", method = RequestMethod.POST)
	public ModelAndView delete(String id, HttpSession session, String pass) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User) session.getAttribute("loginUser");// ����α��ε�����
		System.out.println("session" + loginUser.getUserid());
		if (loginUser.getPass().equals(pass)) {
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
				throw new LoginException("�����ڴ� �����Ұ�", "../user/mypage_delete.duck?id=" + id);
			}
		} else {// ����Ʋ��
			throw new LoginException("��й�ȣ����", "../user/mypage_delete.duck?id=" + id);
		}
		return mav;
	}

	@RequestMapping(value = "user/myduck")
	public ModelAndView list(Integer pageNum, String searchType, String searchContent, Integer type,
			HttpSession session, String id, Integer boardnum, Integer ducktype, Integer matching) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		ModelAndView mav = new ModelAndView();
		User user = service.select(id);
		mav.addObject("user", user);
		/*String dtype = "";
		if(ducktype == 2) {
			dtype = "2,3,5";
		}else {
			dtype = ducktype + "";
		}*/
		int limit = 10; // ���������� ����� �Խù� ����
		// �� �Խù� �Ǽ�
		int listcount = service.boardcount(searchType, searchContent, type, id, ducktype);
		// boardlist : ���������� ����� �Խù� ���� ����
		List<Board> boardlist = service.boardlist(searchType, searchContent, pageNum, limit, type, id, ducktype);
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
		mav.addObject("type", type);
		mav.addObject("ducktype", ducktype);
		return mav;
	}

	@RequestMapping(value = "user/supporterlist", method = RequestMethod.GET)
	public ModelAndView supporterlist(HttpSession session, Integer boardnum, String userid) {
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("loginUser");
		int matching = 1;
		int ducktype = 2;
		List<User> supporterlist = service.supporterlist(userid, matching, boardnum, ducktype);
		mav.addObject("user", user);
		mav.addObject("supporterlist", supporterlist);
		return mav;
	}

	@RequestMapping(value = "user/matchuser")
	public ModelAndView matchuser(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("loginUser"); // ���� �α�������
		Board board = (Board) session.getAttribute("clientboard"); // ���� �� �Խñ�
		String needtech = board.getUsetech(); // ���� ������ �ʿ� ���
		String tech[] = needtech.split(",");
		List<User> matchinguserList = new ArrayList<User>();
		List<String> useridlist = new ArrayList<String>();
		try {
			for (int i = 0; i < tech.length; i++) {
				matchinguserList.addAll(service.matchinguserList(tech[i] + ",")); // �����Ͽ� �´� ���� ����Ʈ
			}
			for (int i = 0; i < matchinguserList.size(); i++) { // �������� tech�� ���ý� �ߺ����� �ִ� list
				useridlist.add(matchinguserList.get(i).getUserid()); // �Խñ۹�ȣ�� ����
			}
			matchinguserList.clear(); // �ߺ�����մ� ����Ʈ ����
			TreeSet<String> arr1 = new TreeSet<String>(useridlist);
			ArrayList<String> arr2 = new ArrayList<String>(arr1);
			String uid = "'" + arr2.get(0) + "',";
			for (int i = 1; i < arr2.size() - 1; i++) {
				uid += "'" + arr2.get(i) + "',";
				;
			}
			uid += "'" + arr2.get(arr2.size() - 1) + "'";
			System.out.println(uid);
			matchinguserList = service.userList(uid); //�ߺ����� ����Ʈ ����
			if(matchinguserList.size() > 3) {
				for (int i=matchinguserList.size();i>3;i--) {
					int ran = (int)(i * (Math.random()*10))/10;
					System.out.println("������:"+i+" ������:"+ran);
					matchinguserList.remove(ran);
				}
			}
			System.out.println("����Ʈ:"+matchinguserList);
		} catch (Exception e) {// �����Ͽ� �ش��ϴ� �����ڰ� ����
			e.printStackTrace();
			System.out.println("�����Ͽ� �ش��ϴ� �����ڰ� ����");
			mav.addObject("ON", 1);
//			boardlist.add(new Board());
//			model.addAttribute("ON", 1);
		}
		session.setAttribute("loginUser", user);
		mav.addObject("userlist", matchinguserList);
		mav.addObject("clientboard", board);
		return mav;
	}

	@RequestMapping(value = "user/fail")
	public ModelAndView fail(HttpSession session, Integer boardnum, String userid) {
		ModelAndView mav = new ModelAndView("user/supporterlist");
		User user = (User) session.getAttribute("loginUser");
		mav.addObject("user", user);
		String duckid = service.duckidselect(boardnum,userid); // boardnum���� ���� duck���̺��� userid��������
		System.out.println("boardnum:" + boardnum);
		System.out.println("duckid:" + duckid);
		int ducktype = 2;
		int duckselect = service.duckselect(duckid, boardnum, ducktype);
		System.out.println("duckselect:" + duckselect);
		if (duckselect == 1) { // �ش� �Խñۿ� �ش���̵��� Duck�� ������
			service.fail(duckid, boardnum);
			mav.setViewName("redirect:supporterlist.duck?userid=" + user.getUserid() + "&boardnum=" + boardnum);
		} else {// �ش� �Խñۿ� �ش� ���̵��� Duck�� ������
			// map.put("msg", "�̹� �³��ϼ̽��ϴ�!");
		}
		return mav;
	}

	@RequestMapping(value = "user/accept")
	public ModelAndView accept(HttpSession session, Integer boardnum, String userid) {
		ModelAndView mav = new ModelAndView("user/supporterlist");
		User user = (User) session.getAttribute("loginUser");
		mav.addObject("user", user);
		String duckid = service.duckidselect(boardnum,userid); // boardnum���� ���� duck���̺��� userid��������
		System.out.println("boardnum:" + boardnum);
		System.out.println("duckid:" + duckid);
		int ducktype = 2;
		int duckselect = service.duckselect(duckid, boardnum, ducktype);
		System.out.println("duckselect:" + duckselect);
		if (duckselect == 1) { // �ش� �Խñۿ� �ش���̵��� Duck�� ������
			service.accept(duckid, boardnum);
			mav.setViewName("redirect:supporterlist.duck?userid=" + user.getUserid() + "&boardnum=" + boardnum);
		} else {// �ش� �Խñۿ� �ش� ���̵��� Duck�� ������
			// map.put("msg", "�̹� �³��ϼ̽��ϴ�!");
		}
		return mav;
	}
	
	@RequestMapping(value = "user/mypage_ducklist")
	public ModelAndView ducklist(Integer pageNum, String searchType, String searchContent, HttpSession session, String id, Integer ducktype,Integer boardtype) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if (searchType == null || searchType.equals("")) {
			searchType = null;
		}
		if (searchContent == null || searchContent.equals("")) {
			searchContent = null;
		}
		ModelAndView mav = new ModelAndView();
		User user = service.select(id); //���� �α����� ������ ����
		mav.addObject("user", user);
		int limit = 10; // ���������� ����� �Խù� ����
		// �� �Խù� �Ǽ�
		int listcount = service.myduckcount(searchType, searchContent, id, ducktype,boardtype);
		// boardlist : ���������� ����� �Խù� ���� ����
		List<Board> boardlist = service.myducklist(searchType, searchContent, pageNum, limit, id, ducktype,boardtype);
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
		mav.addObject("ducktype", ducktype);
		mav.addObject("type", 1);
		return mav;
	}
	@RequestMapping("user/mypage_suggestlist")
	public ModelAndView mypage_suggestlist(Integer pageNum, String searchType, String searchContent, HttpSession session, String id, Integer ducktype) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if (searchType == null || searchType.equals("")) {
			searchType = null;
		}
		if (searchContent == null || searchContent.equals("")) {
			searchContent = null;
		}
		ModelAndView mav = new ModelAndView();
		User user = service.select(id); //���� �α����� ������ ����
		mav.addObject("user", user);
		int limit = 10; // ���������� ����� �Խù� ����
		// �� �Խù� �Ǽ�
		System.out.println("�˻�Ÿ��:"+searchType);
		System.out.println("�˻�����:"+searchContent);
		System.out.println("���̵�:"+id);
		System.out.println("��Ÿ��:"+ducktype);
		int listcount = service.myduckcount(searchType, searchContent, id, ducktype);
		// boardlist : ���������� ����� �Խù� ���� ����
		List<Board> boardlist = service.myducklist(searchType, searchContent, pageNum, limit, id, ducktype);
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
		mav.addObject("ducktype", ducktype);
		mav.addObject("type", 6);
		return mav;
	}
	@RequestMapping("user/mypage_waitlist")
	public ModelAndView mypage_waitlist(Integer pageNum, String searchType, String searchContent, HttpSession session) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if (searchType == null || searchType.equals("")) {
			searchType = null;
		}
		if (searchContent == null || searchContent.equals("")) {
			searchContent = null;
		}
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser"); //���� �α����� ������ ����
		mav.addObject("user", user);
		int limit = 10; // ���������� ����� �Խù� ����
		// �� �Խù� �Ǽ�
		System.out.println("�˻�Ÿ��:"+searchType);
		System.out.println("�˻�����:"+searchContent);
		int waitlistcount = service.waitlistcount(searchType, searchContent, user.getUserid());
		// boardlist : ���������� ����� �Խù� ���� ����
		List<Board> waitlist = service.waitlist(searchType, searchContent, pageNum, limit, user.getUserid());
		System.out.println("waitlist:" + waitlist);
		int maxpage = (int) ((double) waitlistcount / limit + 0.95);
		int startpage = ((int) ((pageNum / 10.0 + 0.9) - 1)) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		int boardcnt = waitlistcount - (pageNum - 1) * limit;
		mav.addObject("id", user.getUserid());
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", waitlistcount);
		mav.addObject("waitlist", waitlist);
		mav.addObject("boardcnt", boardcnt);
		return mav;
	}

	@RequestMapping("user/mypage_proceedlist")
	public ModelAndView mypage_proceedlist(Integer pageNum, String searchType, String searchContent, HttpSession session) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if (searchType == null || searchType.equals("")) {
			searchType = null;
		}
		if (searchContent == null || searchContent.equals("")) {
			searchContent = null;
		}
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser"); //���� �α����� ������ ����
		mav.addObject("user", user);
		int limit = 10; // ���������� ����� �Խù� ����
		// �� �Խù� �Ǽ�
		System.out.println("�˻�Ÿ��:"+searchType);
		System.out.println("�˻�����:"+searchContent);
		int proceedlistcnt = service.proceedlistcnt(searchType, searchContent, user.getUserid());
		// boardlist : ���������� ����� �Խù� ���� ����
		List<Board> proceedlist = service.proceedlist(searchType, searchContent, pageNum, limit, user.getUserid());
		System.out.println("proceedlist:" + proceedlist);
		int maxpage = (int) ((double) proceedlistcnt / limit + 0.95);
		int startpage = ((int) ((pageNum / 10.0 + 0.9) - 1)) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		int boardcnt = proceedlistcnt - (pageNum - 1) * limit;
		mav.addObject("id", user.getUserid());
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", proceedlistcnt);
		mav.addObject("proceedlist", proceedlist);
		mav.addObject("boardcnt", boardcnt);
		return mav;
	}
	@RequestMapping("user/mypage_completelist")
	public ModelAndView mypage_completelist(Integer pageNum, String searchType, String searchContent, HttpSession session) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if (searchType == null || searchType.equals("")) {
			searchType = null;
		}
		if (searchContent == null || searchContent.equals("")) {
			searchContent = null;
		}
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser"); //���� �α����� ������ ����
		mav.addObject("user", user);
		int limit = 10; // ���������� ����� �Խù� ����
		// �� �Խù� �Ǽ�
		System.out.println("�˻�Ÿ��:"+searchType);
		System.out.println("�˻�����:"+searchContent);
		int completelistcnt = service.completelistcnt(searchType, searchContent, user.getUserid());
		// boardlist : ���������� ����� �Խù� ���� ����
		List<Board> completelist = service.completelist(searchType, searchContent, pageNum, limit, user.getUserid());
		System.out.println("proceedlist:" + completelist);
		int maxpage = (int) ((double) completelistcnt / limit + 0.95);
		int startpage = ((int) ((pageNum / 10.0 + 0.9) - 1)) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		int boardcnt = completelistcnt - (pageNum - 1) * limit;
		mav.addObject("id", user.getUserid());
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", completelistcnt);
		mav.addObject("completelist", completelist);
		mav.addObject("boardcnt", boardcnt);
		return mav;
	}
	@RequestMapping("user/mypage_developcomplete")
	public ModelAndView mypage_developcomplete(Integer pageNum, String searchType, String searchContent, HttpSession session) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if (searchType == null || searchType.equals("")) {
			searchType = null;
		}
		if (searchContent == null || searchContent.equals("")) {
			searchContent = null;
		}
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser"); //���� �α����� ������ ����
		mav.addObject("user", user);
		int limit = 10; // ���������� ����� �Խù� ����
		// �� �Խù� �Ǽ�
		System.out.println("�˻�Ÿ��:"+searchType);
		System.out.println("�˻�����:"+searchContent);
		int developcompletecnt = service.developcompletecnt(searchType, searchContent, user.getUserid());
		// boardlist : ���������� ����� �Խù� ���� ����
		List<Board> developcomplete = service.developcomplete(searchType, searchContent, pageNum, limit, user.getUserid());
		System.out.println("proceedlist:" + developcomplete);
		int maxpage = (int) ((double) developcompletecnt / limit + 0.95);
		int startpage = ((int) ((pageNum / 10.0 + 0.9) - 1)) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		int boardcnt = developcompletecnt - (pageNum - 1) * limit;
		mav.addObject("id", user.getUserid());
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", developcompletecnt);
		mav.addObject("developcomplete", developcomplete);
		mav.addObject("boardcnt", boardcnt);
		return mav;
	}
	
	@RequestMapping("user/mypage_recmdlist")
	public ModelAndView mypage_recmdlist(Integer pageNum, HttpSession session) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		ModelAndView mav = new ModelAndView();
		User loginUser = (User)session.getAttribute("loginUser");//���� �α����� ������ ����
		mav.addObject("user", loginUser);
		int limit = 10; // ���������� ����� �Խù� ����
		// �� �Խù� �Ǽ�
		int personcnt = service.personcnt(loginUser.getUserid());//userid�� ���ؼ� ��õ���� ��ϼ� ��������
		// boardlist : ���������� ����� �Խù� ���� ����
		List<User> recmdpersonlist = service.recmdpersonlist(loginUser.getUserid(), pageNum, limit);
		System.out.println("boardlist:" + recmdpersonlist);
		int maxpage = (int) ((double) personcnt / limit + 0.95);
		int startpage = ((int) ((pageNum / 10.0 + 0.9) - 1)) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		int boardcnt = personcnt - (pageNum - 1) * limit;
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("personcnt", personcnt);
		mav.addObject("recmdpersonlist", recmdpersonlist);
		mav.addObject("boardcnt", boardcnt);
		mav.addObject("type", 6);
		return mav;
	}
	
	//�����ڰ� ��û �³��Ҷ�
	@RequestMapping(value = "user/userproaccept")
	public ModelAndView userproaccept(HttpSession session, String userid, Integer num) {
		ModelAndView mav = new ModelAndView("user/myduck");
		User user = (User) session.getAttribute("loginUser");
		mav.addObject("user", user);
		int duckselect2 = service.select(userid, num);
		System.out.println("boardnum:" + num);
		System.out.println("duckselect2:" + duckselect2);
		if (duckselect2 == 1) {//�ش� ���̵� Duck���̺��� ���� ������ id/num/type=3
			service.duckdelete(userid,num); //���������� �Ѿ�� ducktype�� 3�̾ƴϸ� �� ����
			service.userproaccept(userid,num); // matching=2�� �����Ͽ� ���� ����
			service.nowpersonupdate(num); //����������Ʈ�����ο� + 1
			mav.setViewName("redirect: myduck.duck?id="+ user.getUserid() +"&ducktype=3&type=3");
		} else {// �ش� �Խñۿ� �ش� ���̵��� Duck�� ������
			 //map.put("msg", "�̹� �³��ϼ̽��ϴ�!");
		}
		return mav;
	}
	//�����ڰ� ����&���� �Ҷ�
	@RequestMapping(value = "user/userprodelete")
	public ModelAndView userprodelete(HttpSession session, String userid, Integer num, Integer ducktype) {
		ModelAndView mav = new ModelAndView("user/myduck");
		User user = (User) session.getAttribute("loginUser");
		mav.addObject("user", user);
		
		/*String dtype = "";
		if(ducktype == 2) {
			dtype = "2,3,5";
		}else {
			dtype = ducktype + "";
		}*/
		service.userprodelete(userid,num,ducktype);
		System.out.println("userid:" + userid);
		System.out.println("boardnum:" + num);
		System.out.println("ducktype:" + ducktype);
		mav.setViewName("redirect:myduck.duck?id=" + user.getUserid() + "&ducktype="+ducktype+"&type=3");
		
		int duckselect3 = service.sel(userid); //id��/ducktype 2/3/5�ִ� ������Ʈ ã��
		System.out.println("duckselect3:" + duckselect3);
		if (duckselect3 < 1) {//��û���̰ų� ��������/�������� ������Ʈ�� ������
			service.usernullmatching(userid);
			//mav.setViewName("redirect:myduck.duck?id=" + user.getUserid() + "&ducktype="+ducktype+"&type=3&matching=1");
		}/* else {// ��û/����/�������� ������Ʈ�� ������ ����&����
	
		}*/
		return mav;
	}
}
