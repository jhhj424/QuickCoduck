package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import exception.LoginException;
import logic.User;

@Component //객체화
@Aspect //나는 AOP 클래스로 사용할꺼양!
public class AdminAspect {
	/*
	 * advice 중 around : 핵심로직의 실행전, 실행후 호출되는 AOP 메서드
	 */
	@Around("execution(* controller.Admin*.*(..))")
	public Object userLoginCheck(ProceedingJoinPoint joinPoint) throws Throwable{
		//joinPoint.getArgs() : 핵심알고리즘의 매개변수 목록
		Object args[] = joinPoint.getArgs();
		HttpSession session = null;
		User loginUser = null;
		for (Object o : args ) {
			if(o instanceof HttpSession) {
				session = (HttpSession)o;
				loginUser = (User)session.getAttribute("loginUser");
			}
		}
		//HttpSession session = (HttpSession)joinPoint.getArgs()[0]; //첫번째매개변수가 session 일때 받아올수있음.
		if(loginUser == null) { //로그인이 안된경우
			throw new LoginException ("로그인 후 이용하세요","../user/loginForm.shop");
		}else { //로그인이 된경우
			if(!loginUser.getUserid().equals("admin")) { //관리자가 아닐때
				throw new LoginException ("관리자만 사용 가능합니다.","../user/mypage.shop?id="+loginUser.getUserid());
			}
		}
		Object ret = joinPoint.proceed();
		return ret;
	}
}
