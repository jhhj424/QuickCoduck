package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import exception.LoginException;
import logic.User;

@Component //��üȭ
@Aspect //���� AOP Ŭ������ ����Ҳ���!
public class LoginAspect {
	/*
	 * advice �� around : �ٽɷ����� ������, ������ ȣ��Ǵ� AOP �޼���
	 */
	@Around("execution(* controller.User*.*(..)) && args(id, session,..)")
	public Object userLoginCheck(ProceedingJoinPoint joinPoint, String id, HttpSession session) throws Throwable{
		//joinPoint.getArgs() : �ٽɾ˰����� �Ű����� ���
		//1. �α��� �ȵ� ���
		User user = (User)session.getAttribute("loginUser");
		if(user == null) {
			throw new LoginException ("�α��� �� �̿����ּ���","../user/loginForm.duck");
		}
		//2. admin�� �ƴϰ�, id�� �α��� ������ �ٸ� ���.
		if(!id.equals(user.getUserid()) && !user.getUserid().equals("admin")) {
			throw new LoginException ("���θ� Ȯ�� �����մϴ�.","../user/mypage_main.duck?id=" + user.getUserid());
		}
		Object ret = joinPoint.proceed();
		return ret;
	}
	
	@Around("execution(* controller.User*.*(..)) && args(session,user,..)")
	public Object userUpdateCheck(ProceedingJoinPoint joinPoint, HttpSession session, User user) throws Throwable{
		//joinPoint.getArgs() : �ٽɾ˰����� �Ű����� ���
		//1. �α��� �ȵ� ���
		User loginuser = (User)session.getAttribute("loginUser");
		if(loginuser == null) {
			throw new LoginException ("�α��� �� ���������մϴ�.","../user/loginForm.duck");
		}
		//2. admin�� �ƴϰ�, id�� �α��� ������ �ٸ� ���.
		if(!user.getUserid().equals(loginuser.getUserid()) && !loginuser.getUserid().equals("admin")) {
			throw new LoginException ("���� ������ ���� �����մϴ�.","../user/mypage_main.duck?id=" + loginuser.getUserid());
		}
		Object ret = joinPoint.proceed();
		return ret;
	}
}
