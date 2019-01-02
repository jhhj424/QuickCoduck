package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import logic.DuckService;
import logic.User;

//AOP ���� : AdminController �� ��� �޼���� �ݵ�� admin���� �α��� �ؾ߸� ���� �ǵ��� �ϱ�
//AOP Ŭ�������� �̸� : AdminAspect
// 1. �α�����  �ȵȰ��  : �α��� �ϼ��� �޼��� ��� �� loginForm.shop ���� �̵�
// 2. �����ڰ� �ƴѰ�� : �����ڸ� ��� �����մϴ�. mypage.shop ���� �̵�

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
