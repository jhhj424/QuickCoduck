package controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import exception.LoginException;
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

	@RequestMapping("user/userForm")
	public ModelAndView userForm() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new User());
		return mav;
	}
	@RequestMapping("user/userEntry")
	public ModelAndView userEntry(@Valid User user, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("user/userForm"); //a �Է��ϸ� a.jsp�� �̵���.
		String pass1 = request.getParameter("pass");
		String pass2 = request.getParameter("pass2");
		if(pass1 != pass2) { //��й�ȣ ����ġ
			throw new LoginException("��й�ȣ�� ��ġ���� �ʽ��ϴ�.", "../user/userForm.duck");
		}
		try {
			System.out.println(user.getType());
			service.userCreate(user, request);
			mav.setViewName("user/login");
			mav.addObject("user",user);
		}catch(DataIntegrityViolationException e) {
			return mav;
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
}
