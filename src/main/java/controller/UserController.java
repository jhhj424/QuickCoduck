package controller;


import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import logic.ShopService;
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
	private ShopService service;

	@RequestMapping("user/userForm")
	public ModelAndView userForm() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new User());
		return mav;
	}

	@RequestMapping("user/userEntry")
	public ModelAndView userEntry(@Valid User user, BindingResult bindResult, HttpSession session) {
		// @Valid : 유효성 검증. Item 클래스에 정의된 내용으로 검증을 함.
		ModelAndView mav = new ModelAndView("user/userForm");
		if (bindResult.hasErrors()) {
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		try {
			// 받아온 user.password를 해쉬값으로 변경
			// user등록
			service.userCreate(user);
			mav.setViewName("user/login");
			mav.addObject("user", user);
		} catch (DataIntegrityViolationException e) {
			bindResult.reject("error.duplicate.user");
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
		mav.setViewName("redirect:loginForm.shop");
		return mav;
	}

	@RequestMapping("user/updateForm")
	public ModelAndView updateForm(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.userSelect(id);
		mav.addObject("user", user);
		return mav;
	}

	/*
	 * 1. 관리자가 다른 회원을 강제 탈퇴 1. 비밀번호에 관리자 비밀번호를 입력하기. 2. 관리자비밀번호가 맞는 경우 회원 정보 삭제. 3.
	 * 강제탈퇴 성공 : admin/list.shop 페이지 이동 강제탈퇴 실패 : 예외발생 후 delete.jsp 페이지에 출력 2. 본인 회원
	 * 탈퇴 1. 비밀번호에 회원 비밀번호를 입력하기 2. 비밀번호가 맞는경우 회원 정보 삭제. 탈퇴 성공 : session 종료 후
	 * loginForm.shop페이지 이동 탈퇴 실패 : 예외발생 후 delete.jsp 페이지에 출력
	 */
	@RequestMapping(value = "user/delete", method = RequestMethod.GET)
	public ModelAndView deleteForm(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.userSelect(id);
		mav.addObject("user", user);
		return mav;
	}
}
