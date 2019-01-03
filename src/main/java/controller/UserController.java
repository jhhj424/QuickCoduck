package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import exception.LoginException;
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

	@RequestMapping("user/userForm")
	public ModelAndView userForm() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new User());
		return mav;
	}

	@RequestMapping("user/main")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}

	@RequestMapping("user/login")
	public ModelAndView login(@Valid User user, BindingResult bindResult, HttpSession session) {
		// @Valid : 유효성 검증. Item 클래스에 정의된 내용으로 검증을 함.
		ModelAndView mav = new ModelAndView();
		if (bindResult.hasErrors()) {
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		// db에서 아이디의 회원정보 조회하고 비밀번호 검증하여 session에 등록
		// 로그인 성공시 loginSucess.jsp 페이지 출력하기
		// 아이디, 패스워드 모두 입력된 경우
		try {
			// dbuser : 아이디에 해당하는 db의 사용자 정보 저장
			User dbuser = service.userSelect(user);
			// 아이디 존재하는 경우
			if (dbuser == null) {
				bindResult.reject("error.login.id");
				mav.getModel().putAll(bindResult.getModel());
				return mav;
			}
			if (user.getPass().equals(dbuser.getPass())) { // 비밀번호가 일치
				session.setAttribute("loginUser", dbuser); // 로그인 성공
			} else { // 비밀번호가 불일치
				bindResult.reject("error.login.password");
				mav.getModel().putAll(bindResult.getModel());
				return mav;
			}
		} catch (Exception e) {
			e.printStackTrace();
			bindResult.reject("error.user.login");
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		mav.setViewName("user/main");
		return mav;
	}

	@RequestMapping("user/userEntry")
	public ModelAndView userEntry(@Valid User user, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("user/userForm"); // a 입력하면 a.jsp로 이동됨.
		String pass1 = request.getParameter("pass");
		String pass2 = request.getParameter("pass2");
		if (pass1.equals(pass2)) { // 비밀번호 일치
			try {
				service.userCreate(user, request);
				mav.setViewName("user/login");
				mav.addObject("user", user);
			} catch (DataIntegrityViolationException e) {
				return mav;
			}
		} else {
			throw new LoginException("비밀번호가 일치하지 않습니다.", "../user/userForm.duck");
		}
		return mav;
	}

	@RequestMapping("user/signup")
	public ModelAndView signup(@Valid User user, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("user/start");
		String pass = request.getParameter("pass");
		String checkpass = request.getParameter("pass2");
		if (pass.equals(checkpass)) {
			service.userCreate(user, request);
			mav.addObject("user", user);
			mav.setViewName("redirect:start.duck");
		} else {
			throw new LoginException("비밀번호가 일치하지 않습니다.", "../user/start.duck");
		}
		return mav;
	}

	@RequestMapping("user/loginForm")
	public ModelAndView loginForm() {
		ModelAndView mav = new ModelAndView("user/login");
		mav.addObject(new User());
		return mav;
	}

	@RequestMapping("user/loginSuccess")
	public ModelAndView loginSuccess() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}

	@RequestMapping("user/logout")
	public ModelAndView logout(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		session.invalidate();
		mav.setViewName("redirect:loginForm.duck");
		return mav;
	}

	@RequestMapping("user/mypage")
	public ModelAndView mypage(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.select(id);
		mav.addObject("user", user);
		return mav;
	}
}
