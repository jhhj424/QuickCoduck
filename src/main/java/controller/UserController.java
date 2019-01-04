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
				mav.setViewName("redirect:main.duck");
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
		//mav.setViewName("user/main"); <-쓰면 로그인성공시 main.duck안나오고 login.duck이라고 뜸.
		return mav;
	}

	@RequestMapping("user/userEntry")
	public ModelAndView userEntry(@Valid User user, BindingResult bindResult, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("user/userForm"); // a 입력하면 a.jsp로 이동됨.
		if(bindResult.hasErrors()) { //입력오류가 발생한 경우
			mav.getModel().putAll(bindResult.getModel()); //
			return mav;
		}
		String pass1 = request.getParameter("pass");
		String pass2 = request.getParameter("pass2");
		if (pass1.equals(pass2)) { // 비밀번호 일치
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
		User dbuser = service.select(user.getUserid());//비밀번호  검증 
		if(user.getPass().equals(dbuser.getPass())) { //비밀번호가 일치
			//정보수정
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
}
