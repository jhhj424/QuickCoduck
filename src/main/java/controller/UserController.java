package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
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
		// @Valid : ��ȿ�� ����. Item Ŭ������ ���ǵ� �������� ������ ��.
		ModelAndView mav = new ModelAndView();
		if (bindResult.hasErrors()) {
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		// db���� ���̵��� ȸ������ ��ȸ�ϰ� ��й�ȣ �����Ͽ� session�� ���
		// �α��� ������ loginSucess.jsp ������ ����ϱ�
		// ���̵�, �н����� ��� �Էµ� ���
		try {
			// dbuser : ���̵� �ش��ϴ� db�� ����� ���� ����
			User dbuser = service.userSelect(user);
			// ���̵� �����ϴ� ���
			if (dbuser == null) {
				bindResult.reject("error.login.id");
				mav.getModel().putAll(bindResult.getModel());
				return mav;
			}
			if (user.getPass().equals(dbuser.getPass())) { // ��й�ȣ�� ��ġ
				session.setAttribute("loginUser", dbuser); // �α��� ����
				mav.setViewName("redirect:main.duck");
			} else { // ��й�ȣ�� ����ġ
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
		//mav.setViewName("user/main"); <-���� �α��μ����� main.duck�ȳ����� login.duck�̶�� ��.
		return mav;
	}

	@RequestMapping("user/userEntry")
	public ModelAndView userEntry(@Valid User user, BindingResult bindResult, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("user/userForm"); // a �Է��ϸ� a.jsp�� �̵���.
		if(bindResult.hasErrors()) { //�Է¿����� �߻��� ���
			mav.getModel().putAll(bindResult.getModel()); //
			return mav;
		}
		String pass1 = request.getParameter("pass");
		String pass2 = request.getParameter("pass2");
		if (pass1.equals(pass2)) { // ��й�ȣ ��ġ
			try {
				service.userCreate(user, request);
				mav.setViewName("redirect:start.duck");
				mav.addObject("user",user);
			}catch(DataIntegrityViolationException e) {
				bindResult.reject("error.duplicate.user");
				mav.getModel().putAll(bindResult.getModel());
				return mav;
			}
		} else {
			throw new LoginException("��й�ȣ�� ��ġ���� �ʽ��ϴ�.", "../user/userForm.duck");
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
			throw new LoginException("��й�ȣ�� ��ġ���� �ʽ��ϴ�.", "../user/start.duck");
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
	
	@RequestMapping("user/updateForm")
	public ModelAndView update(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.select(id);
		mav.addObject("user", user);
		return mav;
	}
	@RequestMapping(value="user/update",method = RequestMethod.POST)
	public ModelAndView update(HttpSession session, User user) {
		ModelAndView mav = new ModelAndView("user/updateForm");
		User dbuser = service.select(user.getUserid());//��й�ȣ  ���� 
		if(user.getPass().equals(dbuser.getPass())) { //��й�ȣ�� ��ġ
			//��������
			try {
				service.userUpdate(user);
				//mav.addObject("user",user);
				mav.setViewName("redirect:mypage.duck?id="+user.getUserid());
			}catch(Exception e) {
				e.printStackTrace();
				//mav.setViewName("user/updateForm");
			}
		}else {
			return mav;
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
}
