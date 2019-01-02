package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import logic.DuckService;
import logic.User;

//AOP 설정 : AdminController 의 모든 메서드는 반드시 admin으로 로그인 해야만 실행 되도록 하기
//AOP 클래스파일 이름 : AdminAspect
// 1. 로그인이  안된경우  : 로그인 하세요 메세지 출력 후 loginForm.shop 으로 이동
// 2. 관리자가 아닌경우 : 관리자만 사용 가능합니다. mypage.shop 으로 이동

@Controller
public class AdminController {
	@Autowired
	private DuckService service;
	
	@RequestMapping("admin/list")
	public ModelAndView list(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<User> userlist = service.userList();
		mav.addObject("userlist",userlist);
		return mav;
	}
}
