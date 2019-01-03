package aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import exception.LoginException;
import logic.User;

@Component //��üȭ
@Aspect //���� AOP Ŭ������ ����Ҳ���!
public class BoardAspect {
	/*
	 * advice �� around : �ٽɷ����� ������, ������ ȣ��Ǵ� AOP �޼���
	 */
	@Around("execution(* controller.Board*.*(..))")
	public Object userLoginCheck(ProceedingJoinPoint joinPoint) throws Throwable{
		//joinPoint.getArgs() : �ٽɾ˰����� �Ű����� ���
		Object args[] = joinPoint.getArgs();
		HttpSession session = null;
		User loginUser = null;
		for (Object o : args ) {
			if(o instanceof HttpSession) {
				session = (HttpSession)o;
				loginUser = (User)session.getAttribute("loginUser");
				System.out.println(loginUser);
			}
		}
		//HttpSession session = (HttpSession)joinPoint.getArgs()[0]; //ù��°�Ű������� session �϶� �޾ƿü�����.
		if(loginUser == null) { //�α����� �ȵȰ��
			throw new LoginException ("�α��� �� �̿��ϼ���","../user/loginForm.duck");
		}
		Object ret = joinPoint.proceed();
		return ret;
	}
}
