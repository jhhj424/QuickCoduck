package controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import logic.DuckService;

//AOP ���� : AdminController �� ��� �޼���� �ݵ�� admin���� �α��� �ؾ߸� ���� �ǵ��� �ϱ�
//AOP Ŭ�������� �̸� : AdminAspect
// 1. �α�����  �ȵȰ��  : �α��� �ϼ��� �޼��� ��� �� loginForm.shop ���� �̵�
// 2. �����ڰ� �ƴѰ�� : �����ڸ� ��� �����մϴ�. mypage.shop ���� �̵�

@Controller
public class AdminController {
	@Autowired
	private DuckService service;
}