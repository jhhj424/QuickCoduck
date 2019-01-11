package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.security.NoSuchAlgorithmException;
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
 * 1. 회원 가입/수정시 이메일을 암호화 하여 db에 저장하기
 * 2. 조회시 복호화 하여 화면 출력.
 * 	    회원 조회.
 * 	    회원 목록. 
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
			throw new LoginException("아이디 중복입니다", "../user/start.duck");
		} else {
			if (pass.equals(pass2) && !(pass.length() < 4 || pass.length() > 12)) {
				service.userCreate(user, request);
				mav.addObject("user", user);
				mav.setViewName("redirect:start.duck");
			} else {

				throw new LoginException("비밀번호가 일치하지 않습니다.", "../user/start.duck");

			}
		}
		return mav;
	}

	@RequestMapping("user/start_login")
	public ModelAndView start_login(User user, HttpSession session) {
		// @Valid : 유효성 검증. Item 클래스에 정의된 내용으로 검증을 함.
		ModelAndView mav = new ModelAndView();

		User dbuser = service.userSelect(user);
		if (dbuser == null) {// 아이디 존재하지 않는경우
			throw new LoginException("아이디 존재 X", "../user/start.duck");
		}
		if (user.getPass().equals(dbuser.getPass())) { // 비밀번호가 일치
			session.setAttribute("loginUser", dbuser);
			mav.setViewName("redirect:main.duck");

		} else {// 비밀번호 불일치
			if (user.getPass().length() < 4 || user.getPass().length() > 12) { // 비밀번호 자리수 오류
				throw new LoginException("비밀번호는 4~12자리 만 가능", "../user/start.duck");
			} else {
				throw new LoginException("비밀번호가 일치하지 않습니다.", "../user/start.duck");
			}
		}

		return mav;
	}

	@RequestMapping("user/login")
	public ModelAndView login(User user, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User dbuser = service.userSelect(user);
		if (dbuser == null) {// 아이디 존재하지 않는경우
			throw new LoginException("아이디 존재 X", "../user/loginForm.duck");
		}
		if (user.getPass().equals(dbuser.getPass())) { // 비밀번호가 일치
			session.setAttribute("loginUser", dbuser);
			mav.setViewName("redirect:main.duck");
		} else {// 비밀번호 불일치
			if (user.getPass().length() < 4 || user.getPass().length() > 12) { // 비밀번호 자리수 오류
				throw new LoginException("비밀번호는 4~12자리 만 가능", "../user/loginForm.duck");
			} else {
				throw new LoginException("비밀번호가 일치하지 않습니다.", "../user/loginForm.duck");
			}
		}
		return mav;
	}

	@RequestMapping("user/userEntry")
	public ModelAndView userEntry(User user, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); // a 입력하면 a.jsp로 이동됨.
		String pass1 = request.getParameter("pass");
		String pass2 = request.getParameter("pass2");

		if (pass1.equals(pass2) && !(pass1.length() < 4 || pass1.length() > 12)) { // 비밀번호 일치
			service.userCreate(user, request);
			mav.addObject("user", user);
			mav.setViewName("redirect:loginForm.duck");
		} else {
			throw new LoginException("비밀번호를 확인해주세여", "../user/loginForm.duck");
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
			throw new LoginException("본인정보만 조회 가능합니다", "../user/mypage_main.duck?id=" + user.getUserid());
		}
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
	public ModelAndView update(HttpSession session, User user, HttpServletRequest request)
			throws NoSuchAlgorithmException {
		ModelAndView mav = new ModelAndView("user/mypage_update");
		user.setFileurl(request.getParameter("file2"));
		if (user.getCreditpass().length() == 4) {// 초기에 4자리 결제 비밀번호로 들어올때만
			String hashpass = service.getHashvalue(user.getCreditpass());
			user.setCreditpass(hashpass);
		}
		int count = service.creditchk(user.getCreditnum());
		if (count == 0) {
			service.userUpdate(user, request);
			User user1 = service.select(user.getUserid());
			session.setAttribute("loginUser", user1);
			mav.setViewName("redirect:mypage_main.duck?id=" + user1.getUserid());
		} else {
			throw new LoginException("카드번호 중복입니다 확인해주세요", "../user/mypage_update.duck?id=" + user.getUserid());
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
			throw new LoginException("결제비밀번호 오류!",
					"../user/mypage_itempay.duck?id=" + user.getUserid() + "&itemtype=" + itemtype);
		}
		return mav;
	}

	@InitBinder // 파라미터 값 형변환을 위한 메서드
	public void initBinder(WebDataBinder binder) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		/*
		 * Date.class : 파라미터값을 Date타입으로 형변환 함. User 객체에 Date 과 동일한 타입이어야 함. new
		 * CustomDateEditor : 파라미터 형변환. 형식은 dateFormat을 따름. true : 비입력 허용. false : 반드시
		 * 입력.
		 * 
		 * 형식이 틀린경우 : typeMismatch.파라미터이름 코드를 오류로 등록함.
		 */
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); // false:필수입력 true:선택입력
	}

	@RequestMapping(value = "user/delete", method = RequestMethod.GET)
	public ModelAndView delete(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.select(id);
		mav.addObject("user", user);
		return mav;
	}

	@RequestMapping(value = "user/delete", method = RequestMethod.POST)
	public ModelAndView delete(String id, HttpSession session, String pass) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User) session.getAttribute("loginUser");// 현재로그인된유저
		System.out.println("session"+loginUser.getUserid());
		if (loginUser.getPass().equals(pass)) {
			try {
				service.userDelete(id);
				if (!loginUser.getUserid().equals("admin")) {
					session.invalidate();
					mav.setViewName("redirect:loginForm.duck");
				} else {// 관리자
					mav.setViewName("redirect:../admin/list.duck");
				}
			} catch (Exception e) {
				e.printStackTrace();
				throw new LoginException("관리자는 삭제불가", "../user/mypage_delete.duck?id=" + id);
			}
		} else {// 버번틀림
			throw new LoginException("비밀번호오류", "../user/mypage_delete.duck?id=" + id);
		}
		return mav;
	}

	@RequestMapping(value = "user/myduck")
	public ModelAndView list(Integer pageNum, String searchType, String searchContent, Integer type,
			HttpSession session, String id, Integer boardnum, Integer ducktype) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		ModelAndView mav = new ModelAndView();
		User user = service.select(id);
		mav.addObject("user", user);
		int limit = 10; // 한페이지에 출력할 게시물 갯수
		// 총 게시물 건수
		int listcount = service.boardcount(searchType, searchContent, type, id, ducktype);
		// boardlist : 한페이지에 출력할 게시물 정보 저장
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

	@RequestMapping(value = "user/submain")
	public ModelAndView submain(HttpSession session, Integer boardnum) {
		ModelAndView mav = new ModelAndView();
		// boardlist : 한페이지에 출력할 게시물 정보 저장
		List<Board> boardlist = service.boardlist(boardnum);
		List<Board> boardlist2 = service.boardlist2(boardnum);
		System.out.println("boardlist:" + boardlist);
		System.out.println("boardlist2:" + boardlist2);
		mav.addObject("boardlist", boardlist);
		mav.addObject("boardlist2", boardlist2);
		return mav;
	}

	@RequestMapping(value = "user/supporterlist")
	public ModelAndView supporterlist(HttpSession session, Integer boardnum) {
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("loginUser");
		int matching = 1;
		int ducktype = 1;
		List<User> supporterlist = service.supporterlist(user.getUserid(), matching, boardnum, ducktype);
		mav.addObject("user", user);
		mav.addObject("supporterlist", supporterlist);
		return mav;
	}
}
