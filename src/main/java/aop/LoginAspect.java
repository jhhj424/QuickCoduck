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
public class LoginAspect {
	/*
	 * advice 중 around : 핵심로직의 실행전, 실행후 호출되는 AOP 메서드
	 */
	@Around("execution(* controller.User*.*(..)) && args(id, session,..)")
	public Object userLoginCheck(ProceedingJoinPoint joinPoint, String id, HttpSession session) throws Throwable{
		//joinPoint.getArgs() : 핵심알고리즘의 매개변수 목록
		//1. 로그인 안된 경우
		User user = (User)session.getAttribute("loginUser");
		if(user == null) {
			throw new LoginException ("로그인 후 이용해주세요","../user/loginForm.duck");
		}
		//2. admin가 아니고, id와 로그인 정보가 다른 경우.
		if(!id.equals(user.getUserid()) && !user.getUserid().equals("admin")) {
			throw new LoginException ("본인만 확인 가능합니다.","../user/mypage_main.duck?id=" + user.getUserid());
		}
		Object ret = joinPoint.proceed();
		return ret;
	}
	
	@Around("execution(* controller.User*.*(..)) && args(session,user,..)")
	public Object userUpdateCheck(ProceedingJoinPoint joinPoint, HttpSession session, User user) throws Throwable{
		//joinPoint.getArgs() : 핵심알고리즘의 매개변수 목록
		//1. 로그인 안된 경우
		User loginuser = (User)session.getAttribute("loginUser");
		if(loginuser == null) {
			throw new LoginException ("로그인 후 수정가능합니다.","../user/loginForm.duck");
		}
		//2. admin가 아니고, id와 로그인 정보가 다른 경우.
		if(!user.getUserid().equals(loginuser.getUserid()) && !loginuser.getUserid().equals("admin")) {
			throw new LoginException ("본인 정보만 수정 가능합니다.","../user/mypage_main.duck?id=" + loginuser.getUserid());
		}
		Object ret = joinPoint.proceed();
		return ret;
	}
}
