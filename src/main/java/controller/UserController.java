package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthSeparatorUI;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.github.scribejava.core.model.OAuth2AccessToken;

import exception.LoginException;
import logic.Board;
import logic.Duck;
import logic.DuckService;
import logic.NaverLoginBO;
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
	/* NaverLoginBO */
	@Autowired
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	@RequestMapping("user/start")
	public ModelAndView start() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}

	@RequestMapping(value = "user/main")
	public ModelAndView main(HttpSession session, Integer boardnum) {
		ModelAndView mav = new ModelAndView();
		List<Board> boardlist = service.boardlist(boardnum);
		List<Board> boardlist2 = service.boardlist2(boardnum);
		int usercount = service.usercount();
		mav.addObject("usercount", usercount);
		mav.addObject("boardlist", boardlist);
		mav.addObject("boardlist2", boardlist2);
		String projectcnt = service.projectcnt();
		System.out.println("projectcnt:" + projectcnt);
		mav.addObject("projectcnt", projectcnt);
		String projecttotalprice = service.projecttotalprice();
		mav.addObject("projecttotalprice", projecttotalprice);
		String usertotalcnt = service.usertotalcnt();
		mav.addObject("usertotalcnt", usertotalcnt);
		return mav;
	}

	@RequestMapping(value = "user/submain")
	public ModelAndView submain(HttpSession session, Integer boardnum) {
		ModelAndView mav = new ModelAndView();
		// boardlist : 한페이지에 출력할 게시물 정보 저장
		List<Board> boardlist = service.boardlist(boardnum);
		List<Board> boardlist2 = service.boardlist2(boardnum);
		System.out.println("boardlist:" + boardlist);
		System.out.println("boardlist2:" + boardlist2);
		mav.addObject("boardlist", boardlist);
		mav.addObject("boardlist2", boardlist2);
		return mav;
	}

	@RequestMapping("user/signup")
	public ModelAndView signup(User user, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("user/start");
		String pass = request.getParameter("pass");
		String pass2 = request.getParameter("pass2");
		String userid = request.getParameter("userid");

		int count = service.idchk(userid);
		if (count != 0) {
			throw new LoginException("아이디 중복입니다", "../user/start.duck");
		} else {
			if (pass.equals(pass2) && !(pass.length() < 4 || pass.length() > 12)) {
				service.userCreate(user, request);
				mav.addObject("user", user);
				mav.setViewName("redirect:start.duck");
			} else {

				throw new LoginException("비밀번호가 일치하지 않습니다.", "../user/start.duck");

			}
		}
		return mav;
	}

	@RequestMapping("user/start_login")
	public ModelAndView start_login(User user, HttpSession session) {
		// @Valid : 유효성 검증. Item 클래스에 정의된 내용으로 검증을 함.
		ModelAndView mav = new ModelAndView();

		User dbuser = service.userSelect(user);
		if (dbuser == null) {// 아이디 존재하지 않는경우
			throw new LoginException("아이디 존재 X", "../user/start.duck");
		}
		if (user.getPass().equals(dbuser.getPass())) { // 비밀번호가 일치
			session.setAttribute("loginUser", dbuser);
			mav.setViewName("redirect:main.duck");

		} else {// 비밀번호 불일치
			if (user.getPass().length() < 4 || user.getPass().length() > 12) { // 비밀번호 자리수 오류
				throw new LoginException("비밀번호는 4~12자리 만 가능", "../user/start.duck");
			} else {
				throw new LoginException("비밀번호가 일치하지 않습니다.", "../user/start.duck");
			}
		}

		return mav;
	}

	@RequestMapping("user/login")
	public ModelAndView login(User user, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User dbuser = service.userSelect(user);
		if (dbuser == null) {// 아이디 존재하지 않는경우
			throw new LoginException("아이디 존재 X", "../user/loginForm.duck");
		}
		if (user.getPass().equals(dbuser.getPass())) { // 비밀번호가 일치
			session.setAttribute("loginUser", dbuser);
			mav.setViewName("redirect:main.duck");
		} else {// 비밀번호 불일치
			if (user.getPass().length() < 4 || user.getPass().length() > 12) { // 비밀번호 자리수 오류
				throw new LoginException("비밀번호는 4~12자리 만 가능", "../user/loginForm.duck");
			} else {
				throw new LoginException("비밀번호가 일치하지 않습니다.", "../user/loginForm.duck");
			}
		}
		return mav;
	}

	@RequestMapping("user/userEntry")
	public ModelAndView userEntry(User user, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); // a 입력하면 a.jsp로 이동됨.
		String pass1 = request.getParameter("pass");
		String pass2 = request.getParameter("pass2");

		int count = service.idchk(user.getUserid());

		if (count != 0) {
			throw new LoginException("아이디 중복입니다", "../user/loginForm.duck");
		} else {
			if (pass1.equals(pass2) && !(pass1.length() < 4 || pass1.length() > 12)) { // 비밀번호 일치
				service.userCreate(user, request);
				mav.addObject("user", user);
				mav.setViewName("redirect:loginForm.duck");
			} else {
				throw new LoginException("비밀번호를 확인해주세여", "../user/loginForm.duck");
			}
		}
		return mav;
	}

	@RequestMapping("user/loginForm")
	public ModelAndView loginForm(HttpSession session) {
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		ModelAndView mav = new ModelAndView("user/login", "url", naverAuthUrl);
		System.out.println("naverAuthUrl:" + naverAuthUrl);
		mav.addObject(new User());
		String projectcnt = service.projectcnt();
		System.out.println("projectcnt:" + projectcnt);
		mav.addObject("projectcnt", projectcnt);
		String projecttotalprice = service.projecttotalprice();
		mav.addObject("projecttotalprice", projecttotalprice);
		String usertotalcnt = service.usertotalcnt();
		mav.addObject("usertotalcnt", usertotalcnt);
		return mav;
	}

	// 네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/user/callback", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView callback(Model model, @RequestParam String code, @RequestParam String state,
			HttpSession session) throws IOException {
		ModelAndView mav = new ModelAndView("user/naverSuccess");
		System.out.println("여기는 callback");
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		// 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken);
		System.out.println(apiResult.toString());
		model.addAttribute("result", apiResult);
		System.out.println("result:" + apiResult);

		return mav;
	}

	@RequestMapping("user/logout")
	public ModelAndView logout(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		session.invalidate();
		mav.setViewName("redirect:loginForm.duck");
		return mav;
	}

	@RequestMapping("user/mypage_main")
	public ModelAndView mypage_main(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.select(id);
		float profess = 0;
		float proaction = 0;
		float prosatisfact = 0;
		float prodate = 0;
		float procommunicate = 0;
		// 평균 측정 점수들 변수선언

		List<User> alluser = service.alluser();// 유저 중에서 rating 있는 사람의 수 / 평균점수
		for (int i = 0; i < alluser.size(); i++) {
			profess += alluser.get(i).getProfess();
			proaction += alluser.get(i).getProaction();
			prosatisfact += alluser.get(i).getProsatisfact();
			prodate += alluser.get(i).getProdate();
			procommunicate += alluser.get(i).getProcommunicate();
		}
		profess = (profess / alluser.size());
		proaction = (proaction / alluser.size());
		prosatisfact = (prosatisfact / alluser.size());
		prodate = (prodate / alluser.size());
		procommunicate = (procommunicate / alluser.size());

		User avguser = new User();// 평균 유저 객체로 session 에다가 addObject 해주기
		avguser.setProfess(profess);
		avguser.setProaction(proaction);
		avguser.setProsatisfact(prosatisfact);
		avguser.setProdate(prodate);
		avguser.setProcommunicate(procommunicate);

		profess = 0;
		proaction = 0;
		prosatisfact = 0;
		prodate = 0;
		procommunicate = 0;
		// 변수 초기화 해서 재사용

		List<User> allclient = service.allcliet();// client 중에서 rating 있는 사람수 / 평균점수
		for (int i = 0; i < allclient.size(); i++) {
			profess += allclient.get(i).getProfess();
			proaction += allclient.get(i).getProaction();
			prosatisfact += allclient.get(i).getProsatisfact();
			prodate += allclient.get(i).getProdate();
			procommunicate += allclient.get(i).getProcommunicate();
		}
		profess = (profess / allclient.size());
		proaction = (proaction / allclient.size());
		prosatisfact = (prosatisfact / allclient.size());
		prodate = (prodate / allclient.size());
		procommunicate = (procommunicate / allclient.size());

		User avgclient = new User();// avgclient 객체로 session에 addObject() 해주기
		avgclient.setProfess(profess);
		avgclient.setProaction(proaction);
		avgclient.setProsatisfact(prosatisfact);
		avgclient.setProdate(prodate);
		avgclient.setProcommunicate(procommunicate);

		List<String> all_tech = new ArrayList<String>();
		all_tech = service.all_tech();

		String all_string = "";

		int Ajax = 0, Android = 0, C_plus = 0, C = 0, JSP = 0, Java = 0, Python = 0, Ruby = 0, Unity = 0, jQuery = 0;// 변수
																														// 선언(개발쪽)

		int BootStrap = 0, CSS = 0, DreamWeaver = 0, HTML = 0, JavaScript = 0, PhotoShop = 0, Sketch = 0, Unity3d = 0,
				XML = 0, iOS = 0;// 변수 선언(디자인쪽)

		for (int i = 0; i < all_tech.size(); i++) {
			all_string += all_tech.get(i);
		} // 리스트를 하나의 string으로 변환
		String allarr[] = all_string.split(",");// 한줄의 string 값을 "," 으로 쪼개기

		for (String b : allarr) {// 쪼갠 값을 case 문으로 해당 값이 있을때마다 값 증가시키기
			if (b.equals("Ajax")) {
				Ajax++;
			}
			if (b.equals("Android")) {
				Android++;
			}
			if (b.equals("C++")) {
				C_plus++;
			}
			if (b.equals("C")) {
				C++;
			}
			if (b.equals("JSP")) {
				JSP++;
			}
			if (b.equals("Java")) {
				Java++;
			}
			if (b.equals("Python")) {
				Python++;
			}
			if (b.equals("Ruby")) {
				Ruby++;
			}
			if (b.equals("Unity")) {
				Unity++;
			}
			if (b.equals("jQuery")) {
				jQuery++;
			}
			// 개발쪽 파트 카운트 끝
			if (b.equals("BootStrap")) {
				BootStrap++;
			}
			if (b.equals("CSS")) {
				CSS++;
			}
			if (b.equals("DreamWeaver")) {
				DreamWeaver++;
			}
			if (b.equals("HTML")) {
				HTML++;
			}
			if (b.equals("JavaScript")) {
				JavaScript++;
			}
			if (b.equals("PhotoShop")) {
				PhotoShop++;
			}
			if (b.equals("Sketch")) {
				Sketch++;
			}
			if (b.equals("Unity3d")) {
				Unity3d++;
			}
			if (b.equals("XML")) {
				XML++;
			}
			if (b.equals("iOS")) {
				iOS++;
			}
			// 디자인 파트 카운트 끝!
		}

		TreeMap<String, Object> map = new TreeMap<String, Object>();// 보유기술 Map
		map.put("Ajax", Ajax);
		map.put("Android", Android);
		map.put("C_plus", C_plus);
		map.put("C", C);
		map.put("JSP", JSP);
		map.put("Java", Java);
		map.put("Python", Python);
		map.put("Ruby", Ruby);
		map.put("Unity", Unity);
		map.put("jQuery", jQuery);
		map.put("BootStrap", BootStrap);
		map.put("CSS", CSS);
		map.put("DreamWeaver", DreamWeaver);
		map.put("HTML", HTML);
		map.put("JavaScript", JavaScript);
		map.put("PhotoShop", PhotoShop);
		map.put("Sketch", Sketch);
		map.put("Unity3d", Unity3d);
		map.put("XML", XML);
		map.put("iOS", iOS);

		Iterator raking = sortByValue(map).iterator();// Iterator 형태로 해서 sort후 내림차순 정렬
		int cnt = 0;// 횟수 재한용 변수
		List<String> top5_key = new ArrayList<String>();
		List<Integer> top5_value = new ArrayList<Integer>();
		System.out.println("------------sort 후 -------------");
		while (raking.hasNext()) {
			String key = (String) raking.next();
			int value = (int) map.get(key);
			top5_key.add(key);
			top5_value.add(value);
			cnt++;
			if (cnt > 4)
				break;
		} // top5 뽑아내는 while 구문
		cnt = 0;// 재활용 변수

		Iterator<String> iteratorKey = map.keySet().iterator();// 키값 오름차순 정렬(기본)
		List<String> user_key = new ArrayList<String>();
		List<Integer> user_value = new ArrayList<Integer>();

		while (iteratorKey.hasNext()) {
			String key = iteratorKey.next();
			int value = (int) map.get(key);
			user_key.add(key);
			user_value.add(value);
			System.out.println(key + "," + map.get(key));
		}
		Ajax = 0;
		Android = 0;
		C_plus = 0;
		C = 0;
		JSP = 0;
		Java = 0;
		Python = 0;
		Ruby = 0;
		Unity = 0;
		jQuery = 0;
		BootStrap = 0;
		CSS = 0;
		DreamWeaver = 0;
		HTML = 0;
		JavaScript = 0;
		PhotoShop = 0;
		Sketch = 0;
		Unity3d = 0;
		XML = 0;
		iOS = 0; // 변수 초기화(재활용)

		List<String> client_tech = new ArrayList<String>();
		client_tech = service.client_tech();
		String client_string = "";
		for (int i = 0; i < client_tech.size(); i++) {
			client_string += client_tech.get(i);
		} // 리스트를 하나의 string으로 변환
		String techarr2[] = client_string.split(",");// 한줄의 string 값을 "," 으로 쪼개기

		for (String b : techarr2) {// 쪼갠 값을 case 문으로 해당 값이 있을때마다 값 증가시키기
			if (b.equals("Ajax")) {
				Ajax++;
			}
			if (b.equals("Android")) {
				Android++;
			}
			if (b.equals("C++")) {
				C_plus++;
			}
			if (b.equals("C")) {
				C++;
			}
			if (b.equals("JSP")) {
				JSP++;
			}
			if (b.equals("Java")) {
				Java++;
			}
			if (b.equals("Python")) {
				Python++;
			}
			if (b.equals("Ruby")) {
				Ruby++;
			}
			if (b.equals("Unity")) {
				Unity++;
			}
			if (b.equals("jQuery")) {
				jQuery++;
			}
			// 개발쪽 파트 카운트 끝
			if (b.equals("BootStrap")) {
				BootStrap++;
			}
			if (b.equals("CSS")) {
				CSS++;
			}
			if (b.equals("DreamWeaver")) {
				DreamWeaver++;
			}
			if (b.equals("HTML")) {
				HTML++;
			}
			if (b.equals("JavaScript")) {
				JavaScript++;
			}
			if (b.equals("PhotoShop")) {
				PhotoShop++;
			}
			if (b.equals("Sketch")) {
				Sketch++;
			}
			if (b.equals("Unity3d")) {
				Unity3d++;
			}
			if (b.equals("XML")) {
				XML++;
			}
			if (b.equals("iOS")) {
				iOS++;
			}
			// 디자인 파트 카운트 끝!
		}
		TreeMap<String, Object> client_map = new TreeMap<String, Object>();// 보유기술 Map
		client_map.put("Ajax", Ajax);
		client_map.put("Android", Android);
		client_map.put("C_plus", C_plus);
		client_map.put("C", C);
		client_map.put("JSP", JSP);
		client_map.put("Java", Java);
		client_map.put("Python", Python);
		client_map.put("Ruby", Ruby);
		client_map.put("Unity", Unity);
		client_map.put("jQuery", jQuery);
		client_map.put("BootStrap", BootStrap);
		client_map.put("CSS", CSS);
		client_map.put("DreamWeaver", DreamWeaver);
		client_map.put("HTML", HTML);
		client_map.put("JavaScript", JavaScript);
		client_map.put("PhotoShop", PhotoShop);
		client_map.put("Sketch", Sketch);
		client_map.put("Unity3d", Unity3d);
		client_map.put("XML", XML);
		client_map.put("iOS", iOS);

		Iterator<String> iteratorKey2 = client_map.keySet().iterator();// 키값 오름차순 정렬(기본)
		List<Integer> client_value = new ArrayList<Integer>();

		while (iteratorKey2.hasNext()) {
			String key = iteratorKey2.next();
			int value = (int) client_map.get(key);
			client_value.add(value);
			System.out.println(key + "," + client_map.get(key));
		}

		Ajax = 0;
		Android = 0;
		C_plus = 0;
		C = 0;
		JSP = 0;
		Java = 0;
		Python = 0;
		Ruby = 0;
		Unity = 0;
		jQuery = 0;
		BootStrap = 0;
		CSS = 0;
		DreamWeaver = 0;
		HTML = 0;
		JavaScript = 0;
		PhotoShop = 0;
		Sketch = 0;
		Unity3d = 0;
		XML = 0;
		iOS = 0; // 변수 초기화(재활용)

		List<String> project_tech = new ArrayList<String>();
		project_tech = service.project_tech();
		String project_string = "";
		for (int i = 0; i < project_tech.size(); i++) {
			project_string += project_tech.get(i);
		} // 리스트를 하나의 string으로 변환
		String techarr3[] = project_string.split(",");// 한줄의 string 값을 "," 으로 쪼개기

		for (String b : techarr3) {// 쪼갠 값을 case 문으로 해당 값이 있을때마다 값 증가시키기
			if (b.equals("Ajax")) {
				Ajax++;
			}
			if (b.equals("Android")) {
				Android++;
			}
			if (b.equals("C++")) {
				C_plus++;
			}
			if (b.equals("C")) {
				C++;
			}
			if (b.equals("JSP")) {
				JSP++;
			}
			if (b.equals("Java")) {
				Java++;
			}
			if (b.equals("Python")) {
				Python++;
			}
			if (b.equals("Ruby")) {
				Ruby++;
			}
			if (b.equals("Unity")) {
				Unity++;
			}
			if (b.equals("jQuery")) {
				jQuery++;
			}
			// 개발쪽 파트 카운트 끝
			if (b.equals("BootStrap")) {
				BootStrap++;
			}
			if (b.equals("CSS")) {
				CSS++;
			}
			if (b.equals("DreamWeaver")) {
				DreamWeaver++;
			}
			if (b.equals("HTML")) {
				HTML++;
			}
			if (b.equals("JavaScript")) {
				JavaScript++;
			}
			if (b.equals("PhotoShop")) {
				PhotoShop++;
			}
			if (b.equals("Sketch")) {
				Sketch++;
			}
			if (b.equals("Unity3d")) {
				Unity3d++;
			}
			if (b.equals("XML")) {
				XML++;
			}
			if (b.equals("iOS")) {
				iOS++;
			}
			// 디자인 파트 카운트 끝!
		}
		TreeMap<String, Object> project_map = new TreeMap<String, Object>();// 보유기술 Map
		project_map.put("Ajax", Ajax);
		project_map.put("Android", Android);
		project_map.put("C_plus", C_plus);
		project_map.put("C", C);
		project_map.put("JSP", JSP);
		project_map.put("Java", Java);
		project_map.put("Python", Python);
		project_map.put("Ruby", Ruby);
		project_map.put("Unity", Unity);
		project_map.put("jQuery", jQuery);
		project_map.put("BootStrap", BootStrap);
		project_map.put("CSS", CSS);
		project_map.put("DreamWeaver", DreamWeaver);
		project_map.put("HTML", HTML);
		project_map.put("JavaScript", JavaScript);
		project_map.put("PhotoShop", PhotoShop);
		project_map.put("Sketch", Sketch);
		project_map.put("Unity3d", Unity3d);
		project_map.put("XML", XML);
		project_map.put("iOS", iOS);

		Iterator<String> iteratorKey3 = project_map.keySet().iterator();// 키값 오름차순 정렬(기본)
		List<Integer> project_value = new ArrayList<Integer>();

		while (iteratorKey3.hasNext()) {
			String key = iteratorKey3.next();
			int value = (int) project_map.get(key);
			project_value.add(value);
			System.out.println(key + "," + project_map.get(key));
		}

		long price_a = 500000;
		long price_b = 1000000;
		long price_c = 5000000;
		long price_d = 10000000;
		long price_e = 25000000;
		long price_f = 50000000;
		long price_g = 75000000;
		long price_h = 100000000;// 범위설정
		int price_a_cnt, price_b_cnt, price_c_cnt, price_d_cnt, price_e_cnt, price_f_cnt,price_g_cnt,price_h_cnt,price_i_cnt;// 카운트 값
		price_a_cnt = 0;
		price_b_cnt = 0;
		price_c_cnt = 0;
		price_d_cnt = 0;
		price_e_cnt = 0;
		price_f_cnt = 0;
		price_g_cnt = 0;
		price_h_cnt = 0;
		price_i_cnt = 0;// 변수 초기화
		List<String> board_price = new ArrayList<String>();// 뽑아온 String 형태의 가격 리스트
		List<Integer> price = new ArrayList<Integer>();// String --> Integer 형태로 가격비교 할 수 있게 형변환
		ArrayList<Integer> price_cnt = new ArrayList<Integer>();// 해당 금액 카운트 값 저장 리스트
		board_price = service.board_price();
		for (String a : board_price) {
			System.out.println(a);
			a = a.replaceAll(",", "");
			int b = Integer.parseInt(a);
			price.add(b);
		}
		for (int a : price) {// 금액별로 카운트 세기
			if (a > 0 && a < price_a) {
				price_a_cnt++;
			}
			;
			if (a >= price_a && a < price_b) {
				price_b_cnt++;
			}
			;
			if (a >= price_b && a < price_c) {
				price_c_cnt++;
			}
			;
			if (a >= price_c && a < price_d) {
				price_d_cnt++;
			}
			;
			if (a >= price_d && a < price_e) {
				price_e_cnt++;
			}
			;
			if (a >= price_e && a < price_f) {
				price_f_cnt++;
			}
			;
			if (a >= price_f && a < price_g) {
				price_g_cnt++;
			}
			;
			if (a >= price_g && a < price_h) {
				price_h_cnt++;
			}
			;
			if (a >= price_h) {
				price_i_cnt++;
			}
			;
		}
		price_cnt.add(price_a_cnt);
		price_cnt.add(price_b_cnt);
		price_cnt.add(price_c_cnt);
		price_cnt.add(price_d_cnt);
		price_cnt.add(price_e_cnt);
		price_cnt.add(price_f_cnt);
		price_cnt.add(price_g_cnt);
		price_cnt.add(price_h_cnt);
		price_cnt.add(price_i_cnt);// 카운트 값을 리스트에 넣어주자

		mav.addObject("user", user);
		mav.addObject("avguser", avguser);
		mav.addObject("avgclient", avgclient);
		mav.addObject("top5_key", top5_key);
		mav.addObject("top5_value", top5_value);
		mav.addObject("user_key", user_key);
		mav.addObject("user_value", user_value);
		mav.addObject("client_value", client_value);
		mav.addObject("project_value", project_value);
		mav.addObject("price_cnt", price_cnt);
		return mav;
	}

	private static List sortByValue(TreeMap<String, Object> map) {// map value 기준으로 역정렬 시키는 메서드
		List<String> list = new ArrayList<String>();
		list.addAll(map.keySet());
		Collections.sort(list, new Comparator<Object>() {
			public int compare(Object o1, Object o2) {
				Object v1 = map.get(o1);
				Object v2 = map.get(o2);
				return ((Comparable) v2).compareTo(v1);
			}
		});
//		Collections.reverse(list); // 주석시 오름차순
		return list;
	}

	@RequestMapping(value = "user/mypage_*")
	public ModelAndView mypage(String id, HttpSession session, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		User dbuser = service.select(id);
		System.out.println("maxcount" + dbuser.getMaxcount());
		User user = (User) session.getAttribute("loginUser");
		if (!dbuser.getUserid().equals(user.getUserid()) && user.getType() !=3) {
			throw new LoginException("본인정보만 조회 가능합니다", "../user/mypage_main.duck?id=" + user.getUserid());
		}
		mav.addObject("user", dbuser);
		return mav;
	}

	@RequestMapping(value = "user/mypage_project_finished2")
	public ModelAndView mypage_project_finished2(String id, Integer boardnum) {
		ModelAndView mav = new ModelAndView();
		return mav;
	}

	@RequestMapping(value = "user/update", method = RequestMethod.POST)
	public ModelAndView update(HttpSession session, User user, HttpServletRequest request)
			throws NoSuchAlgorithmException {
		ModelAndView mav = new ModelAndView("user/mypage_update");
		user.setFileurl(request.getParameter("file2"));
		User loginUser = (User)session.getAttribute("loginUser"); // 현재 로그인된 유저
		if (user.getType() == 2 && user.getCreditpass().length() == 4) {
			int count = service.creditchk(user.getCreditnum());
			if (count == 0) {
				String hashpass = service.getHashvalue(user.getCreditpass());
				user.setCreditpass(hashpass);
				service.userUpdate(user, request);
				if (loginUser.getType() != 3) { // 로그인한 유저의 타입이 관리자가 아닐때
					User user1 = service.select(user.getUserid());
					session.setAttribute("loginUser", user1);				
					mav.setViewName("redirect:mypage_main.duck?id=" + user1.getUserid());
				}else { // 로그인 유저가 관리자 일때
					mav.setViewName("redirect:../admin/list.duck?id=" + loginUser.getUserid());
				}
			} else if (count == 1 && user.getCreditpass().length() > 4) {// 중복이지만 이미 creditpass가 해쉬알고리즘 화 되어있는 경우
				service.userUpdate(user, request);
				if (loginUser.getType() != 3) { // 로그인한 유저의 타입이 관리자가 아닐때
					User user1 = service.select(user.getUserid());
					session.setAttribute("loginUser", user1);				
					mav.setViewName("redirect:mypage_main.duck?id=" + user1.getUserid());
				}else { // 로그인 유저가 관리자 일때
					mav.setViewName("redirect:../admin/list.duck?id=" + loginUser.getUserid());
				}
			} else if (count == 1 && user.getCreditpass().length() == 4) {// 중복이고 처음에 해쉬알고리즘 화 하기 전 pass 자리수가 4자리일 경우
				throw new LoginException("카드번호 중복입니다 확인해주세요", "../user/mypage_update.duck?id=" + user.getUserid());
			}

		} else {
			service.userUpdate(user, request);
			if (loginUser.getType() != 3) { // 로그인한 유저의 타입이 관리자가 아닐때
				User user1 = service.select(user.getUserid());
				session.setAttribute("loginUser", user1);				
				mav.setViewName("redirect:mypage_main.duck?id=" + user1.getUserid());
			}else { // 로그인 유저가 관리자 일때
				mav.setViewName("redirect:../admin/list.duck?id=" + loginUser.getUserid());
			}
		}

		return mav;
	}

	@RequestMapping(value = "user/payment*", method = RequestMethod.POST)
	public ModelAndView payment(HttpSession session, User user, HttpServletRequest request)
			throws NoSuchAlgorithmException {
		ModelAndView mav = new ModelAndView("user/mypage_itempay");
		int itemtype = Integer.parseInt(request.getParameter("itemtype"));
		User dbuser = service.select(user.getUserid());
		String hashpass = service.getHashvalue(user.getCreditpass());
		if (hashpass.equals(dbuser.getCreditpass())) {
			if (itemtype == 1) {
				dbuser.setMaxcount(10);
			} else if (itemtype == 2) {
				dbuser.setMaxcount(20);
			} else {
				dbuser.setMaxcount(30);
			}
			service.maxcountUpdate(dbuser);
			session.setAttribute("loginUser", dbuser);
			mav.setViewName("redirect:mypage_main.duck?id=" + dbuser.getUserid());
		} else {
			throw new LoginException("결제비밀번호 오류!",
					"../user/mypage_itempay.duck?id=" + user.getUserid() + "&itemtype=" + itemtype);
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

	@RequestMapping(value = "user/delete", method = RequestMethod.POST)
	public ModelAndView delete(String id, HttpSession session, String pass) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User) session.getAttribute("loginUser");// 현재로그인된유저
		System.out.println("session" + loginUser.getUserid());
		if (loginUser.getPass().equals(pass)) {
			try {
				service.userDelete(id);
				if (loginUser.getType() != 3) {
					session.invalidate();
					mav.setViewName("redirect:loginForm.duck");
				} else {// 관리자
					mav.setViewName("redirect:../admin/list.duck");
				}
			} catch (Exception e) {
				e.printStackTrace();
				throw new LoginException("관리자는 삭제불가", "../user/mypage_delete.duck?id=" + id);
			}
		} else {// 버번틀림
			throw new LoginException("비밀번호오류", "../user/mypage_delete.duck?id=" + id);
		}
		return mav;
	}

	@RequestMapping(value = "user/myduck")
	public ModelAndView list(Integer pageNum, String searchType, String searchContent, Integer type,
			HttpSession session, String id, Integer boardnum, Integer ducktype, Integer matching) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		ModelAndView mav = new ModelAndView();
		User user = service.select(id);
		mav.addObject("user", user);
		/*
		 * String dtype = ""; if(ducktype == 2) { dtype = "2,3,5"; }else { dtype =
		 * ducktype + ""; }
		 */
		int limit = 10; // 한페이지에 출력할 게시물 갯수
		// 총 게시물 건수
		int listcount = service.boardcount(searchType, searchContent, type, id, ducktype);
		// boardlist : 한페이지에 출력할 게시물 정보 저장
		List<Board> boardlist = service.boardlist(searchType, searchContent, pageNum, limit, type, id, ducktype);
		System.out.println("boardlist:" + boardlist);
		int maxpage = (int) ((double) listcount / limit + 0.95);
		int startpage = ((int) ((pageNum / 10.0 + 0.9) - 1)) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		int boardcnt = listcount - (pageNum - 1) * limit;
		mav.addObject("id", id);
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", listcount);
		mav.addObject("boardlist", boardlist);
		mav.addObject("boardcnt", boardcnt);
		mav.addObject("type", type);
		mav.addObject("ducktype", ducktype);
		return mav;
	}

	@RequestMapping(value = "user/supporterlist", method = RequestMethod.GET)
	public ModelAndView supporterlist(HttpSession session, Integer boardnum, String userid) {
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("loginUser");
		int matching = 1;
		int ducktype = 2;
		List<User> supporterlist = service.supporterlist(userid, matching, boardnum, ducktype);
		mav.addObject("user", user);
		mav.addObject("supporterlist", supporterlist);
		String projectcnt = service.projectcnt();
		System.out.println("projectcnt:" + projectcnt);
		mav.addObject("projectcnt", projectcnt);
		String projecttotalprice = service.projecttotalprice();
		mav.addObject("projecttotalprice", projecttotalprice);
		String usertotalcnt = service.usertotalcnt();
		mav.addObject("usertotalcnt", usertotalcnt);
		return mav;
	}

	@RequestMapping(value = "user/matchuser")
	public ModelAndView matchuser(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("loginUser"); // 현재 로그인유저
		Board board = (Board) session.getAttribute("clientboard"); // 현재 쓴 게시글
		String needtech = board.getUsetech(); // 현재 공고의 필요 기술
		String tech[] = needtech.split(",");
		List<User> matchinguserList = new ArrayList<User>();
		List<String> useridlist = new ArrayList<String>();
		try {
			for (int i = 0; i < tech.length; i++) {
				matchinguserList.addAll(service.matchinguserList(tech[i] + ",")); // 기술목록에 맞는 유저 리스트
			}
			for (int i = 0; i < matchinguserList.size(); i++) { // 여러개의 tech가 들어올시 중복값이 있는 list
				useridlist.add(matchinguserList.get(i).getUserid()); // 유저아이디만 저장
			}
			matchinguserList.clear(); // 중복요소잇는 리스트 비우기

			/*
			 * System.out.println("useridlist:"+useridlist); Map<String,Integer> test_map =
			 * new LinkedHashMap<String,Integer>(); for(int i =0;i<useridlist.size();i++) {
			 * if(test_map.get(useridlist.get(i)) == null) { test_map.put(useridlist.get(i),
			 * 1); } else { int c = test_map.get(useridlist.get(i));
			 * test_map.put(useridlist.get(i), c+1); } }
			 * System.out.println("test_map:"+test_map);
			 */
			// 반복값 뽑아내기

			TreeSet<String> arr1 = new TreeSet<String>(useridlist);
			System.out.println(useridlist);
			ArrayList<String> arr2 = new ArrayList<String>(arr1);
			String uid = "'" + arr2.get(0) + "',";
			for (int i = 1; i < arr2.size() - 1; i++) {
				uid += "'" + arr2.get(i) + "',";
				;
			}
			uid += "'" + arr2.get(arr2.size() - 1) + "'";
			System.out.println(uid);
			matchinguserList = service.userList(uid); // 중복없는 리스트 생성
			if (matchinguserList.size() > 3) {
				for (int i = matchinguserList.size(); i > 3; i--) {
					int ran = (int) (i * (Math.random() * 10)) / 10;
					System.out.println("사이즈:" + i + " 랜덤수:" + ran);
					matchinguserList.remove(ran);
				}
			}
			System.out.println("리스트:" + matchinguserList);
		} catch (Exception e) {// 기술목록에 해당하는 개발자가 없음
			e.printStackTrace();
			System.out.println("기술목록에 해당하는 개발자가 없음");
			mav.addObject("ON", 1);
//			boardlist.add(new Board());
//			model.addAttribute("ON", 1);
		}
		session.setAttribute("loginUser", user);
		mav.addObject("userlist", matchinguserList);
		mav.addObject("clientboard", board);
		String projectcnt = service.projectcnt();
		mav.addObject("projectcnt",projectcnt);
		String projecttotalprice = service.projecttotalprice();
		mav.addObject("projecttotalprice",projecttotalprice);
		String usertotalcnt = service.usertotalcnt();
		mav.addObject("usertotalcnt",usertotalcnt);
		return mav;
	}

	@RequestMapping(value = "user/fail")
	public ModelAndView fail(HttpSession session, Integer boardnum, String userid) {
		ModelAndView mav = new ModelAndView("user/supporterlist");
		User user = (User) session.getAttribute("loginUser");
		mav.addObject("user", user);
		String duckid = service.duckidselect(boardnum, userid); // boardnum값에 대한 duck테이블의 userid가져오기
		System.out.println("boardnum:" + boardnum);
		System.out.println("duckid:" + duckid);
		int ducktype = 2;
		int duckselect = service.duckselect(duckid, boardnum, ducktype);
		System.out.println("duckselect:" + duckselect);
		if (duckselect == 1) { // 해당 게시글에 해당아이디의 Duck이 없을때
			service.fail(duckid, boardnum);
			mav.setViewName("redirect:supporterlist.duck?userid=" + user.getUserid() + "&boardnum=" + boardnum);
		} else {// 해당 게시글에 해당 아이디의 Duck이 있을때
			// map.put("msg", "이미 승낙하셨습니다!");
		}
		return mav;
	}

	@RequestMapping(value = "user/accept")
	public ModelAndView accept(HttpSession session, Integer boardnum, String userid) {
		ModelAndView mav = new ModelAndView("user/supporterlist");
		//인원초과-----------
		Board bo = new Board();
		bo.setBoardnum(boardnum);
		bo.setBoardtype(3);
		bo = service.getBoard(bo);
		if(bo.getMaxperson() == bo.getNowperson()) 
			throw new LoginException("인원 초과", "../user/supporterlist.duck?boardnum="+boardnum+"&userid="+userid);
		//---------------
		User user = (User) session.getAttribute("loginUser");
		mav.addObject("user", user);
		String duckid = service.duckidselect(boardnum, userid); // boardnum값에 대한 duck테이블의 userid가져오기
		System.out.println("boardnum:" + boardnum);
		System.out.println("duckid:" + duckid);
		int ducktype = 2;
		int duckselect = service.duckselect(duckid, boardnum, ducktype);
		System.out.println("duckselect:" + duckselect);
		if (duckselect == 1) { // 해당 게시글에 해당아이디의 Duck이 있을때
			service.accept(duckid, boardnum);
			mav.setViewName("redirect:supporterlist.duck?userid=" + user.getUserid() + "&boardnum=" + boardnum);
		} else {// 해당 게시글에 해당 아이디의 Duck이 없을때
			// map.put("msg", "이미 승낙하셨습니다!");
		}
		return mav;
	}

	@RequestMapping(value = "user/mypage_ducklist")
	public ModelAndView ducklist(Integer pageNum, String searchType, String searchContent, HttpSession session,
			String id, Integer ducktype, Integer boardtype) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if (searchType == null || searchType.equals("")) {
			searchType = null;
		}
		if (searchContent == null || searchContent.equals("")) {
			searchContent = null;
		}
		ModelAndView mav = new ModelAndView();
		User user = service.select(id); // 현재 로그인한 유저의 정보
		mav.addObject("user", user);
		int limit = 10; // 한페이지에 출력할 게시물 갯수
		// 총 게시물 건수
		int listcount = service.myduckcount(searchType, searchContent, id, ducktype, boardtype);
		// boardlist : 한페이지에 출력할 게시물 정보 저장
		List<Board> boardlist = service.myducklist(searchType, searchContent, pageNum, limit, id, ducktype, boardtype);
		System.out.println("boardlist:" + boardlist);
		int maxpage = (int) ((double) listcount / limit + 0.95);
		int startpage = ((int) ((pageNum / 10.0 + 0.9) - 1)) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		int boardcnt = listcount - (pageNum - 1) * limit;
		mav.addObject("id", id);
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", listcount);
		mav.addObject("boardlist", boardlist);
		mav.addObject("boardcnt", boardcnt);
		mav.addObject("ducktype", ducktype);
		mav.addObject("type", 1);
		return mav;
	}

	@RequestMapping("user/mypage_suggestlist")
	public ModelAndView mypage_suggestlist(Integer pageNum, String searchType, String searchContent,
			HttpSession session, String id, Integer ducktype) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if (searchType == null || searchType.equals("")) {
			searchType = null;
		}
		if (searchContent == null || searchContent.equals("")) {
			searchContent = null;
		}
		ModelAndView mav = new ModelAndView();
		User user = service.select(id); // 현재 로그인한 유저의 정보
		mav.addObject("user", user);
		int limit = 10; // 한페이지에 출력할 게시물 갯수
		// 총 게시물 건수
		System.out.println("검색타입:" + searchType);
		System.out.println("검색내용:" + searchContent);
		System.out.println("아이디:" + id);
		System.out.println("덕타입:" + ducktype);
		int listcount = service.myduckcount(searchType, searchContent, id, ducktype);
		// boardlist : 한페이지에 출력할 게시물 정보 저장
		List<Board> boardlist = service.myducklist(searchType, searchContent, pageNum, limit, id, ducktype);
		System.out.println("boardlist:" + boardlist);
		int maxpage = (int) ((double) listcount / limit + 0.95);
		int startpage = ((int) ((pageNum / 10.0 + 0.9) - 1)) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		int boardcnt = listcount - (pageNum - 1) * limit;
		mav.addObject("id", id);
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", listcount);
		mav.addObject("boardlist", boardlist);
		mav.addObject("boardcnt", boardcnt);
		mav.addObject("ducktype", ducktype);
		mav.addObject("type", 6);
		return mav;
	}

	@RequestMapping("user/mypage_waitlist")
	public ModelAndView mypage_waitlist(Integer pageNum, String searchType, String searchContent, HttpSession session) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if (searchType == null || searchType.equals("")) {
			searchType = null;
		}
		if (searchContent == null || searchContent.equals("")) {
			searchContent = null;
		}
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("loginUser"); // 현재 로그인한 유저의 정보
		mav.addObject("user", user);
		int limit = 10; // 한페이지에 출력할 게시물 갯수
		// 총 게시물 건수
		System.out.println("검색타입:" + searchType);
		System.out.println("검색내용:" + searchContent);
		int waitlistcount = service.waitlistcount(searchType, searchContent, user.getUserid());
		// boardlist : 한페이지에 출력할 게시물 정보 저장
		List<Board> waitlist = service.waitlist(searchType, searchContent, pageNum, limit, user.getUserid());
		System.out.println("waitlist:" + waitlist);
		int maxpage = (int) ((double) waitlistcount / limit + 0.95);
		int startpage = ((int) ((pageNum / 10.0 + 0.9) - 1)) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		int boardcnt = waitlistcount - (pageNum - 1) * limit;
		mav.addObject("id", user.getUserid());
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", waitlistcount);
		mav.addObject("waitlist", waitlist);
		mav.addObject("boardcnt", boardcnt);
		return mav;
	}

	@RequestMapping("user/mypage_proceedlist")
	public ModelAndView mypage_proceedlist(Integer pageNum, String searchType, String searchContent,
			HttpSession session) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if (searchType == null || searchType.equals("")) {
			searchType = null;
		}
		if (searchContent == null || searchContent.equals("")) {
			searchContent = null;
		}
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("loginUser"); // 현재 로그인한 유저의 정보
		mav.addObject("user", user);
		int limit = 10; // 한페이지에 출력할 게시물 갯수
		// 총 게시물 건수
		System.out.println("검색타입:" + searchType);
		System.out.println("검색내용:" + searchContent);
		int proceedlistcnt = service.proceedlistcnt(searchType, searchContent, user.getUserid());
		// boardlist : 한페이지에 출력할 게시물 정보 저장
		List<Board> proceedlist = service.proceedlist(searchType, searchContent, pageNum, limit, user.getUserid());
		System.out.println("proceedlist:" + proceedlist);
		int maxpage = (int) ((double) proceedlistcnt / limit + 0.95);
		int startpage = ((int) ((pageNum / 10.0 + 0.9) - 1)) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		int boardcnt = proceedlistcnt - (pageNum - 1) * limit;
		mav.addObject("id", user.getUserid());
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", proceedlistcnt);
		mav.addObject("proceedlist", proceedlist);
		mav.addObject("boardcnt", boardcnt);
		return mav;
	}

	@RequestMapping("user/mypage_completelist")
	public ModelAndView mypage_completelist(Integer pageNum, String searchType, String searchContent,
			HttpSession session) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if (searchType == null || searchType.equals("")) {
			searchType = null;
		}
		if (searchContent == null || searchContent.equals("")) {
			searchContent = null;
		}
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("loginUser"); // 현재 로그인한 유저의 정보
		mav.addObject("user", user);
		int limit = 10; // 한페이지에 출력할 게시물 갯수
		// 총 게시물 건수
		System.out.println("검색타입:" + searchType);
		System.out.println("검색내용:" + searchContent);
		int completelistcnt = service.completelistcnt(searchType, searchContent, user.getUserid());
		// boardlist : 한페이지에 출력할 게시물 정보 저장
		List<Board> completelist = service.completelist(searchType, searchContent, pageNum, limit, user.getUserid());
		System.out.println("proceedlist:" + completelist);
		int maxpage = (int) ((double) completelistcnt / limit + 0.95);
		int startpage = ((int) ((pageNum / 10.0 + 0.9) - 1)) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		int boardcnt = completelistcnt - (pageNum - 1) * limit;
		mav.addObject("id", user.getUserid());
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", completelistcnt);
		mav.addObject("completelist", completelist);
		mav.addObject("boardcnt", boardcnt);
		return mav;
	}

	@RequestMapping("user/mypage_developcomplete")
	public ModelAndView mypage_developcomplete(Integer pageNum, String searchType, String searchContent,
			HttpSession session) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if (searchType == null || searchType.equals("")) {
			searchType = null;
		}
		if (searchContent == null || searchContent.equals("")) {
			searchContent = null;
		}
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("loginUser"); // 현재 로그인한 유저의 정보
		mav.addObject("user", user);
		int limit = 10; // 한페이지에 출력할 게시물 갯수
		// 총 게시물 건수
		System.out.println("검색타입:" + searchType);
		System.out.println("검색내용:" + searchContent);
		int developcompletecnt = service.developcompletecnt(searchType, searchContent, user.getUserid());
		// boardlist : 한페이지에 출력할 게시물 정보 저장
		List<Board> developcomplete = service.developcomplete(searchType, searchContent, pageNum, limit,
				user.getUserid());
		System.out.println("proceedlist:" + developcomplete);
		int maxpage = (int) ((double) developcompletecnt / limit + 0.95);
		int startpage = ((int) ((pageNum / 10.0 + 0.9) - 1)) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		int boardcnt = developcompletecnt - (pageNum - 1) * limit;
		mav.addObject("id", user.getUserid());
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", developcompletecnt);
		mav.addObject("developcomplete", developcomplete);
		mav.addObject("boardcnt", boardcnt);
		return mav;
	}

	@RequestMapping("user/mypage_recmdlist")
	public ModelAndView mypage_recmdlist(Integer pageNum, HttpSession session) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		ModelAndView mav = new ModelAndView();
		User loginUser = (User) session.getAttribute("loginUser");// 현재 로그인한 유저의 정보
		mav.addObject("user", loginUser);
		int limit = 10; // 한페이지에 출력할 게시물 갯수
		// 총 게시물 건수
		int personcnt = service.personcnt(loginUser.getUserid());// userid를 통해서 추천인재 목록수 가져오기
		// boardlist : 한페이지에 출력할 게시물 정보 저장
		List<User> recmdpersonlist = service.recmdpersonlist(loginUser.getUserid(), pageNum, limit);
		System.out.println("boardlist:" + recmdpersonlist);
		int maxpage = (int) ((double) personcnt / limit + 0.95);
		int startpage = ((int) ((pageNum / 10.0 + 0.9) - 1)) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		int boardcnt = personcnt - (pageNum - 1) * limit;
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("personcnt", personcnt);
		mav.addObject("recmdpersonlist", recmdpersonlist);
		mav.addObject("boardcnt", boardcnt);
		mav.addObject("type", 6);
		return mav;
	}

	// 개발자가 신청 승낙할때
	@RequestMapping(value = "user/userproaccept")
	public ModelAndView userproaccept(HttpSession session, String userid, Integer num) {
		ModelAndView mav = new ModelAndView("user/myduck");
		User user = (User) session.getAttribute("loginUser");
		//인원초과-----------
				Board bo = new Board();
				bo.setBoardnum(num);
				bo.setBoardtype(3);
				bo = service.getBoard(bo);
				if(bo.getMaxperson() == bo.getNowperson()) 
					throw new LoginException("인원 초과", "../user/myduck.duck?id="+userid+"&ducktype=3&type=3");
				//---------------
		mav.addObject("user", user);
		int duckselect2 = service.select(userid, num);
		System.out.println("boardnum:" + num);
		System.out.println("duckselect2:" + duckselect2);
		if (duckselect2 == 1) {// 해당 아이디에 Duck테이블의 값이 있을때 id/num/type=3
			service.duckdelete(userid, num); // 진행중으로 넘어갈때 ducktype이 3이아니면 다 삭제
			service.userproaccept(userid, num); // matching=2로 변경하여 서로 수락
			service.nowpersonupdate(num); // 현재프로젝트참여인원 + 1
			mav.setViewName("redirect: myduck.duck?id=" + user.getUserid() + "&ducktype=3&type=3");
		} else {// 해당 게시글에 해당 아이디의 Duck이 없을때
				// map.put("msg", "이미 승낙하셨습니다!");
		}
		return mav;
	}

	// 개발자가 거절&삭제 할때
	@RequestMapping(value = "user/userprodelete")
	public ModelAndView userprodelete(HttpSession session, String userid, Integer num, Integer ducktype, Integer type) {
		ModelAndView mav = new ModelAndView("user/myduck");
		User user = (User) session.getAttribute("loginUser");
		mav.addObject("user", user);
		/*
		 * String dtype = ""; if(ducktype == 2) { dtype = "2,3,5"; }else { dtype =
		 * ducktype + ""; }
		 */
		if (ducktype == 1) {
			service.userprodelete(userid, num, ducktype);
			service.duckcntremove(num);
		} else {
			service.userprodelete(userid, num, ducktype);
		}
		System.out.println("userid:" + userid);
		System.out.println("boardnum:" + num);
		System.out.println("ducktype:" + ducktype);
		mav.setViewName("redirect:myduck.duck?id=" + user.getUserid() + "&ducktype=" + ducktype + "&type=" + type);
		/*
		 * int duckselect3 = service.sel(userid); //id와/ducktype 2/3/5있는 프로젝트 찾기
		 * System.out.println("duckselect3:" + duckselect3); if (duckselect3 < 1)
		 * {//신청중이거나 수락받은/거절받은 프로젝트가 없을때 //service.usernullmatching(userid);
		 * //mav.setViewName("redirect:myduck.duck?id=" + user.getUserid() +
		 * "&ducktype="+ducktype+"&type=3&matching=1"); }else {// 신청/수락/거절중인 프로젝트가 있을때
		 * 거절&삭제
		 * 
		 * }
		 */
		return mav;
	}

	@RequestMapping("user/rating")
	public ModelAndView rating(int boardnum, float profess, float proaction, float prosatisfact, float prodate,
			float procommunicate, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		System.out.println("점수나오기! - " + profess + "\n" + proaction + "\n" + prosatisfact + "\n" + prodate + "\n"
				+ procommunicate + "\n");
		User user = (User) session.getAttribute("loginUser"); // 현재 로그인된 유저
		try {
			Board board = new Board();
			board.setBoardnum(boardnum);
			board.setBoardtype(4);
			board = service.getBoard(board); // 평가하고있는 게시물
			System.out.println("레이팅보드:" + board);
			User ratinguser = service.select(board.getUserid()); // 평가받을 유저
			int cnt = service.duck10cnt(board.getUserid()); // 해당 id가 쓴 게시글중에, ducktype이 10인 duck테이블 인스턴스의 개수
			System.out.println("평가받은갯수 : " + cnt);
			int nanum = 0;
			if (cnt < 1) {
				nanum = 1;
			} else {
				nanum = cnt + 1;
			}
			if (cnt == 0) {
				cnt = 1;
			}
			System.out.println(ratinguser);
			float profess2 = ((ratinguser.getProfess() * cnt) + profess) / nanum; // 점수 평균내기
			float proaction2 = ((ratinguser.getProaction() * cnt) + proaction) / nanum; // 점수 평균내기
			float prosatisfact2 = ((ratinguser.getProsatisfact() * cnt) + prosatisfact) / nanum; // 점수 평균내기
			float prodate2 = ((ratinguser.getProdate() * cnt) + prodate) / nanum; // 점수 평균내기
			float procommunicate2 = ((ratinguser.getProcommunicate() * cnt) + procommunicate) / nanum; // 점수 평균내기
			float rating = (profess2 + proaction2 + prosatisfact2 + prodate2 + procommunicate2) / 5; // 레이팅
			System.out.println(profess2 + "\n" + proaction2 + "\n" + prosatisfact2 + "\n" + prodate2 + "\n"
					+ procommunicate2 + "\n" + rating + "\n");
			service.setrating(board.getUserid(), profess2, proaction2, prosatisfact2, prodate2, procommunicate2,
					rating);
			// duck테이블에 평가하는유저id, 평가하고있는게시물, ducktype = 10으로 인서트
			service.add10duck(user.getUserid(), board.getBoardnum()); // 평가 성공
			mav.addObject("suggest_message", "평가에 성공하셨습니다.");
			mav.addObject("suggest_url", "../user/mypage_main.duck?id=" + user.getUserid());
		} catch (Exception e) {
			throw new LoginException("평가에 실패하셨습니다.", "../user/mypage_main.duck?id=" + user.getUserid());
		}
		return mav;
	}

	@RequestMapping("user/rating2")
	public ModelAndView rating2(int boardnum, float profess, float proaction, float prosatisfact, float prodate,
			float procommunicate, String userid, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		System.out.println("점수나오기! - " + profess + "\n" + proaction + "\n" + prosatisfact + "\n" + prodate + "\n"
				+ procommunicate + "\n");
		User user = (User) session.getAttribute("loginUser"); // 현재 로그인된 유저
		try {
			Board board = new Board();
			board.setBoardnum(boardnum);
			board.setBoardtype(4);
			board = service.getBoard(board); // 평가하고있는 게시물
			System.out.println("레이팅보드:" + board);
			User ratinguser = service.select(userid); // 평가받을 유저
			int cnt = service.duck20cnt(userid); // 해당 id가 평가받은 게시글중에, ducktype이 20인 duck테이블 인스턴스의 개수
			System.out.println("평가받은갯수 : " + cnt);
			int nanum = 0;
			if (cnt < 1) {
				nanum = 1;
			} else {
				nanum = cnt + 1;
			}
			if (cnt == 0) {
				cnt = 1;
			}
			System.out.println(ratinguser);
			float profess2 = ((ratinguser.getProfess() * cnt) + profess) / nanum; // 점수 평균내기
			float proaction2 = ((ratinguser.getProaction() * cnt) + proaction) / nanum; // 점수 평균내기
			float prosatisfact2 = ((ratinguser.getProsatisfact() * cnt) + prosatisfact) / nanum; // 점수 평균내기
			float prodate2 = ((ratinguser.getProdate() * cnt) + prodate) / nanum; // 점수 평균내기
			float procommunicate2 = ((ratinguser.getProcommunicate() * cnt) + procommunicate) / nanum; // 점수 평균내기
			float rating = (profess2 + proaction2 + prosatisfact2 + prodate2 + procommunicate2) / 5; // 레이팅
			System.out.println(profess2 + "\n" + proaction2 + "\n" + prosatisfact2 + "\n" + prodate2 + "\n"
					+ procommunicate2 + "\n" + rating + "\n");
			service.setrating(userid, profess2, proaction2, prosatisfact2, prodate2, procommunicate2, rating);
			// duck테이블에 평가하는유저id, 평가하고있는게시물, ducktype = 20으로 인서트
			service.add20duck(userid, board.getBoardnum()); // 평가 성공
			mav.addObject("suggest_message", "평가에 성공하셨습니다.");
			mav.addObject("suggest_url", "../user/mypage_main.duck?id=" + user.getUserid());
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("평가에 실패하셨습니다.", "../user/mypage_main.duck?id=" + user.getUserid());
		}
		return mav;
	}
}
