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
			throw new LoginException ("�α��� �� �ŷ��ϼ���","../user/loginForm.shop");
		}
		//2. admin�� �ƴϰ�, id�� �α��� ������ �ٸ� ���.
		if(!id.equals(user.getUserId()) && !user.getUserId().equals("admin")) {
			throw new LoginException ("���θ� �ŷ� �����մϴ�.","../user/mypage.shop?id=" + user.getUserId());
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
			throw new LoginException ("�α��� �� ���������մϴ�.","../user/loginForm.shop");
		}
		//2. admin�� �ƴϰ�, id�� �α��� ������ �ٸ� ���.
		if(!user.getUserId().equals(loginuser.getUserId()) && !loginuser.getUserId().equals("admin")) {
			throw new LoginException ("���� ������ ���� �����մϴ�.","../user/mypage.shop?id=" + loginuser.getUserId());
		}
		Object ret = joinPoint.proceed();
		return ret;
	}
}
