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
 * 1. ȸ�� ����/������ �̸����� ��ȣȭ �Ͽ� db�� �����ϱ�
 * 2. ��ȸ�� ��ȣȭ �Ͽ� ȭ�� ���.
 * 	    ȸ�� ��ȸ.
 * 	    ȸ�� ���. 
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
		// boardlist : ���������� ����� �Խù� ���� ����
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
			throw new LoginException("���̵� �ߺ��Դϴ�", "../user/start.duck");
		} else {
			if (pass.equals(pass2) && !(pass.length() < 4 || pass.length() > 12)) {
				service.userCreate(user, request);
				mav.addObject("user", user);
				mav.setViewName("redirect:start.duck");
			} else {

				throw new LoginException("��й�ȣ�� ��ġ���� �ʽ��ϴ�.", "../user/start.duck");

			}
		}
		return mav;
	}

	@RequestMapping("user/start_login")
	public ModelAndView start_login(User user, HttpSession session) {
		// @Valid : ��ȿ�� ����. Item Ŭ������ ���ǵ� �������� ������ ��.
		ModelAndView mav = new ModelAndView();

		User dbuser = service.userSelect(user);
		if (dbuser == null) {// ���̵� �������� �ʴ°��
			throw new LoginException("���̵� ���� X", "../user/start.duck");
		}
		if (user.getPass().equals(dbuser.getPass())) { // ��й�ȣ�� ��ġ
			session.setAttribute("loginUser", dbuser);
			mav.setViewName("redirect:main.duck");

		} else {// ��й�ȣ ����ġ
			if (user.getPass().length() < 4 || user.getPass().length() > 12) { // ��й�ȣ �ڸ��� ����
				throw new LoginException("��й�ȣ�� 4~12�ڸ� �� ����", "../user/start.duck");
			} else {
				throw new LoginException("��й�ȣ�� ��ġ���� �ʽ��ϴ�.", "../user/start.duck");
			}
		}

		return mav;
	}

	@RequestMapping("user/login")
	public ModelAndView login(User user, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User dbuser = service.userSelect(user);
		if (dbuser == null) {// ���̵� �������� �ʴ°��
			throw new LoginException("���̵� ���� X", "../user/loginForm.duck");
		}
		if (user.getPass().equals(dbuser.getPass())) { // ��й�ȣ�� ��ġ
			session.setAttribute("loginUser", dbuser);
			mav.setViewName("redirect:main.duck");
		} else {// ��й�ȣ ����ġ
			if (user.getPass().length() < 4 || user.getPass().length() > 12) { // ��й�ȣ �ڸ��� ����
				throw new LoginException("��й�ȣ�� 4~12�ڸ� �� ����", "../user/loginForm.duck");
			} else {
				throw new LoginException("��й�ȣ�� ��ġ���� �ʽ��ϴ�.", "../user/loginForm.duck");
			}
		}
		return mav;
	}

	@RequestMapping("user/userEntry")
	public ModelAndView userEntry(User user, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); // a �Է��ϸ� a.jsp�� �̵���.
		String pass1 = request.getParameter("pass");
		String pass2 = request.getParameter("pass2");

		int count = service.idchk(user.getUserid());

		if (count != 0) {
			throw new LoginException("���̵� �ߺ��Դϴ�", "../user/loginForm.duck");
		} else {
			if (pass1.equals(pass2) && !(pass1.length() < 4 || pass1.length() > 12)) { // ��й�ȣ ��ġ
				service.userCreate(user, request);
				mav.addObject("user", user);
				mav.setViewName("redirect:loginForm.duck");
			} else {
				throw new LoginException("��й�ȣ�� Ȯ�����ּ���", "../user/loginForm.duck");
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

	// ���̹� �α��� ������ callbackȣ�� �޼ҵ�
	@RequestMapping(value = "/user/callback", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView callback(Model model, @RequestParam String code, @RequestParam String state,
			HttpSession session) throws IOException {
		ModelAndView mav = new ModelAndView("user/naverSuccess");
		System.out.println("����� callback");
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		// �α��� ����� ������ �о�´�.
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
		// ��� ���� ������ ��������

		List<User> alluser = service.alluser();// ���� �߿��� rating �ִ� ����� �� / �������
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

		User avguser = new User();// ��� ���� ��ü�� session ���ٰ� addObject ���ֱ�
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
		// ���� �ʱ�ȭ �ؼ� ����

		List<User> allclient = service.allcliet();// client �߿��� rating �ִ� ����� / �������
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

		User avgclient = new User();// avgclient ��ü�� session�� addObject() ���ֱ�
		avgclient.setProfess(profess);
		avgclient.setProaction(proaction);
		avgclient.setProsatisfact(prosatisfact);
		avgclient.setProdate(prodate);
		avgclient.setProcommunicate(procommunicate);

		List<String> all_tech = new ArrayList<String>();
		all_tech = service.all_tech();

		String all_string = "";

		int Ajax = 0, Android = 0, C_plus = 0, C = 0, JSP = 0, Java = 0, Python = 0, Ruby = 0, Unity = 0, jQuery = 0;// ����
																														// ����(������)

		int BootStrap = 0, CSS = 0, DreamWeaver = 0, HTML = 0, JavaScript = 0, PhotoShop = 0, Sketch = 0, Unity3d = 0,
				XML = 0, iOS = 0;// ���� ����(��������)

		for (int i = 0; i < all_tech.size(); i++) {
			all_string += all_tech.get(i);
		} // ����Ʈ�� �ϳ��� string���� ��ȯ
		String allarr[] = all_string.split(",");// ������ string ���� "," ���� �ɰ���

		for (String b : allarr) {// �ɰ� ���� case ������ �ش� ���� ���������� �� ������Ű��
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
			// ������ ��Ʈ ī��Ʈ ��
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
			// ������ ��Ʈ ī��Ʈ ��!
		}

		TreeMap<String, Object> map = new TreeMap<String, Object>();// ������� Map
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

		Iterator raking = sortByValue(map).iterator();// Iterator ���·� �ؼ� sort�� �������� ����
		int cnt = 0;// Ƚ�� ���ѿ� ����
		List<String> top5_key = new ArrayList<String>();
		List<Integer> top5_value = new ArrayList<Integer>();
		System.out.println("------------sort �� -------------");
		while (raking.hasNext()) {
			String key = (String) raking.next();
			int value = (int) map.get(key);
			top5_key.add(key);
			top5_value.add(value);
			cnt++;
			if (cnt > 4)
				break;
		} // top5 �̾Ƴ��� while ����
		cnt = 0;// ��Ȱ�� ����

		Iterator<String> iteratorKey = map.keySet().iterator();// Ű�� �������� ����(�⺻)
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
		iOS = 0; // ���� �ʱ�ȭ(��Ȱ��)

		List<String> client_tech = new ArrayList<String>();
		client_tech = service.client_tech();
		String client_string = "";
		for (int i = 0; i < client_tech.size(); i++) {
			client_string += client_tech.get(i);
		} // ����Ʈ�� �ϳ��� string���� ��ȯ
		String techarr2[] = client_string.split(",");// ������ string ���� "," ���� �ɰ���

		for (String b : techarr2) {// �ɰ� ���� case ������ �ش� ���� ���������� �� ������Ű��
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
			// ������ ��Ʈ ī��Ʈ ��
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
			// ������ ��Ʈ ī��Ʈ ��!
		}
		TreeMap<String, Object> client_map = new TreeMap<String, Object>();// ������� Map
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

		Iterator<String> iteratorKey2 = client_map.keySet().iterator();// Ű�� �������� ����(�⺻)
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
		iOS = 0; // ���� �ʱ�ȭ(��Ȱ��)

		List<String> project_tech = new ArrayList<String>();
		project_tech = service.project_tech();
		String project_string = "";
		for (int i = 0; i < project_tech.size(); i++) {
			project_string += project_tech.get(i);
		} // ����Ʈ�� �ϳ��� string���� ��ȯ
		String techarr3[] = project_string.split(",");// ������ string ���� "," ���� �ɰ���

		for (String b : techarr3) {// �ɰ� ���� case ������ �ش� ���� ���������� �� ������Ű��
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
			// ������ ��Ʈ ī��Ʈ ��
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
			// ������ ��Ʈ ī��Ʈ ��!
		}
		TreeMap<String, Object> project_map = new TreeMap<String, Object>();// ������� Map
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

		Iterator<String> iteratorKey3 = project_map.keySet().iterator();// Ű�� �������� ����(�⺻)
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
		long price_h = 100000000;// ��������
		int price_a_cnt, price_b_cnt, price_c_cnt, price_d_cnt, price_e_cnt, price_f_cnt,price_g_cnt,price_h_cnt,price_i_cnt;// ī��Ʈ ��
		price_a_cnt = 0;
		price_b_cnt = 0;
		price_c_cnt = 0;
		price_d_cnt = 0;
		price_e_cnt = 0;
		price_f_cnt = 0;
		price_g_cnt = 0;
		price_h_cnt = 0;
		price_i_cnt = 0;// ���� �ʱ�ȭ
		List<String> board_price = new ArrayList<String>();// �̾ƿ� String ������ ���� ����Ʈ
		List<Integer> price = new ArrayList<Integer>();// String --> Integer ���·� ���ݺ� �� �� �ְ� ����ȯ
		ArrayList<Integer> price_cnt = new ArrayList<Integer>();// �ش� �ݾ� ī��Ʈ �� ���� ����Ʈ
		board_price = service.board_price();
		for (String a : board_price) {
			System.out.println(a);
			a = a.replaceAll(",", "");
			int b = Integer.parseInt(a);
			price.add(b);
		}
		for (int a : price) {// �ݾ׺��� ī��Ʈ ����
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
		price_cnt.add(price_i_cnt);// ī��Ʈ ���� ����Ʈ�� �־�����

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

	private static List sortByValue(TreeMap<String, Object> map) {// map value �������� ������ ��Ű�� �޼���
		List<String> list = new ArrayList<String>();
		list.addAll(map.keySet());
		Collections.sort(list, new Comparator<Object>() {
			public int compare(Object o1, Object o2) {
				Object v1 = map.get(o1);
				Object v2 = map.get(o2);
				return ((Comparable) v2).compareTo(v1);
			}
		});
//		Collections.reverse(list); // �ּ��� ��������
		return list;
	}

	@RequestMapping(value = "user/mypage_*")
	public ModelAndView mypage(String id, HttpSession session, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		User dbuser = service.select(id);
		System.out.println("maxcount" + dbuser.getMaxcount());
		User user = (User) session.getAttribute("loginUser");
		if (!dbuser.getUserid().equals(user.getUserid()) && user.getType() !=3) {
			throw new LoginException("���������� ��ȸ �����մϴ�", "../user/mypage_main.duck?id=" + user.getUserid());
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
		User loginUser = (User)session.getAttribute("loginUser"); // ���� �α��ε� ����
		if (user.getType() == 2 && user.getCreditpass().length() == 4) {
			int count = service.creditchk(user.getCreditnum());
			if (count == 0) {
				String hashpass = service.getHashvalue(user.getCreditpass());
				user.setCreditpass(hashpass);
				service.userUpdate(user, request);
				if (loginUser.getType() != 3) { // �α����� ������ Ÿ���� �����ڰ� �ƴҶ�
					User user1 = service.select(user.getUserid());
					session.setAttribute("loginUser", user1);				
					mav.setViewName("redirect:mypage_main.duck?id=" + user1.getUserid());
				}else { // �α��� ������ ������ �϶�
					mav.setViewName("redirect:../admin/list.duck?id=" + loginUser.getUserid());
				}
			} else if (count == 1 && user.getCreditpass().length() > 4) {// �ߺ������� �̹� creditpass�� �ؽ��˰��� ȭ �Ǿ��ִ� ���
				service.userUpdate(user, request);
				if (loginUser.getType() != 3) { // �α����� ������ Ÿ���� �����ڰ� �ƴҶ�
					User user1 = service.select(user.getUserid());
					session.setAttribute("loginUser", user1);				
					mav.setViewName("redirect:mypage_main.duck?id=" + user1.getUserid());
				}else { // �α��� ������ ������ �϶�
					mav.setViewName("redirect:../admin/list.duck?id=" + loginUser.getUserid());
				}
			} else if (count == 1 && user.getCreditpass().length() == 4) {// �ߺ��̰� ó���� �ؽ��˰��� ȭ �ϱ� �� pass �ڸ����� 4�ڸ��� ���
				throw new LoginException("ī���ȣ �ߺ��Դϴ� Ȯ�����ּ���", "../user/mypage_update.duck?id=" + user.getUserid());
			}

		} else {
			service.userUpdate(user, request);
			if (loginUser.getType() != 3) { // �α����� ������ Ÿ���� �����ڰ� �ƴҶ�
				User user1 = service.select(user.getUserid());
				session.setAttribute("loginUser", user1);				
				mav.setViewName("redirect:mypage_main.duck?id=" + user1.getUserid());
			}else { // �α��� ������ ������ �϶�
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
			throw new LoginException("������й�ȣ ����!",
					"../user/mypage_itempay.duck?id=" + user.getUserid() + "&itemtype=" + itemtype);
		}
		return mav;
	}

	@InitBinder // �Ķ���� �� ����ȯ�� ���� �޼���
	public void initBinder(WebDataBinder binder) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		/*
		 * Date.class : �Ķ���Ͱ��� DateŸ������ ����ȯ ��. User ��ü�� Date �� ������ Ÿ���̾�� ��. new
		 * CustomDateEditor : �Ķ���� ����ȯ. ������ dateFormat�� ����. true : ���Է� ���. false : �ݵ��
		 * �Է�.
		 * 
		 * ������ Ʋ����� : typeMismatch.�Ķ�����̸� �ڵ带 ������ �����.
		 */
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); // false:�ʼ��Է� true:�����Է�
	}

	@RequestMapping(value = "user/delete", method = RequestMethod.POST)
	public ModelAndView delete(String id, HttpSession session, String pass) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User) session.getAttribute("loginUser");// ����α��ε�����
		System.out.println("session" + loginUser.getUserid());
		if (loginUser.getPass().equals(pass)) {
			try {
				service.userDelete(id);
				if (loginUser.getType() != 3) {
					session.invalidate();
					mav.setViewName("redirect:loginForm.duck");
				} else {// ������
					mav.setViewName("redirect:../admin/list.duck");
				}
			} catch (Exception e) {
				e.printStackTrace();
				throw new LoginException("�����ڴ� �����Ұ�", "../user/mypage_delete.duck?id=" + id);
			}
		} else {// ����Ʋ��
			throw new LoginException("��й�ȣ����", "../user/mypage_delete.duck?id=" + id);
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
		int limit = 10; // ���������� ����� �Խù� ����
		// �� �Խù� �Ǽ�
		int listcount = service.boardcount(searchType, searchContent, type, id, ducktype);
		// boardlist : ���������� ����� �Խù� ���� ����
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
		User user = (User) session.getAttribute("loginUser"); // ���� �α�������
		Board board = (Board) session.getAttribute("clientboard"); // ���� �� �Խñ�
		String needtech = board.getUsetech(); // ���� ������ �ʿ� ���
		String tech[] = needtech.split(",");
		List<User> matchinguserList = new ArrayList<User>();
		List<String> useridlist = new ArrayList<String>();
		try {
			for (int i = 0; i < tech.length; i++) {
				matchinguserList.addAll(service.matchinguserList(tech[i] + ",")); // �����Ͽ� �´� ���� ����Ʈ
			}
			for (int i = 0; i < matchinguserList.size(); i++) { // �������� tech�� ���ý� �ߺ����� �ִ� list
				useridlist.add(matchinguserList.get(i).getUserid()); // �������̵� ����
			}
			matchinguserList.clear(); // �ߺ�����մ� ����Ʈ ����

			/*
			 * System.out.println("useridlist:"+useridlist); Map<String,Integer> test_map =
			 * new LinkedHashMap<String,Integer>(); for(int i =0;i<useridlist.size();i++) {
			 * if(test_map.get(useridlist.get(i)) == null) { test_map.put(useridlist.get(i),
			 * 1); } else { int c = test_map.get(useridlist.get(i));
			 * test_map.put(useridlist.get(i), c+1); } }
			 * System.out.println("test_map:"+test_map);
			 */
			// �ݺ��� �̾Ƴ���

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
			matchinguserList = service.userList(uid); // �ߺ����� ����Ʈ ����
			if (matchinguserList.size() > 3) {
				for (int i = matchinguserList.size(); i > 3; i--) {
					int ran = (int) (i * (Math.random() * 10)) / 10;
					System.out.println("������:" + i + " ������:" + ran);
					matchinguserList.remove(ran);
				}
			}
			System.out.println("����Ʈ:" + matchinguserList);
		} catch (Exception e) {// �����Ͽ� �ش��ϴ� �����ڰ� ����
			e.printStackTrace();
			System.out.println("�����Ͽ� �ش��ϴ� �����ڰ� ����");
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
		String duckid = service.duckidselect(boardnum, userid); // boardnum���� ���� duck���̺��� userid��������
		System.out.println("boardnum:" + boardnum);
		System.out.println("duckid:" + duckid);
		int ducktype = 2;
		int duckselect = service.duckselect(duckid, boardnum, ducktype);
		System.out.println("duckselect:" + duckselect);
		if (duckselect == 1) { // �ش� �Խñۿ� �ش���̵��� Duck�� ������
			service.fail(duckid, boardnum);
			mav.setViewName("redirect:supporterlist.duck?userid=" + user.getUserid() + "&boardnum=" + boardnum);
		} else {// �ش� �Խñۿ� �ش� ���̵��� Duck�� ������
			// map.put("msg", "�̹� �³��ϼ̽��ϴ�!");
		}
		return mav;
	}

	@RequestMapping(value = "user/accept")
	public ModelAndView accept(HttpSession session, Integer boardnum, String userid) {
		ModelAndView mav = new ModelAndView("user/supporterlist");
		//�ο��ʰ�-----------
		Board bo = new Board();
		bo.setBoardnum(boardnum);
		bo.setBoardtype(3);
		bo = service.getBoard(bo);
		if(bo.getMaxperson() == bo.getNowperson()) 
			throw new LoginException("�ο� �ʰ�", "../user/supporterlist.duck?boardnum="+boardnum+"&userid="+userid);
		//---------------
		User user = (User) session.getAttribute("loginUser");
		mav.addObject("user", user);
		String duckid = service.duckidselect(boardnum, userid); // boardnum���� ���� duck���̺��� userid��������
		System.out.println("boardnum:" + boardnum);
		System.out.println("duckid:" + duckid);
		int ducktype = 2;
		int duckselect = service.duckselect(duckid, boardnum, ducktype);
		System.out.println("duckselect:" + duckselect);
		if (duckselect == 1) { // �ش� �Խñۿ� �ش���̵��� Duck�� ������
			service.accept(duckid, boardnum);
			mav.setViewName("redirect:supporterlist.duck?userid=" + user.getUserid() + "&boardnum=" + boardnum);
		} else {// �ش� �Խñۿ� �ش� ���̵��� Duck�� ������
			// map.put("msg", "�̹� �³��ϼ̽��ϴ�!");
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
		User user = service.select(id); // ���� �α����� ������ ����
		mav.addObject("user", user);
		int limit = 10; // ���������� ����� �Խù� ����
		// �� �Խù� �Ǽ�
		int listcount = service.myduckcount(searchType, searchContent, id, ducktype, boardtype);
		// boardlist : ���������� ����� �Խù� ���� ����
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
		User user = service.select(id); // ���� �α����� ������ ����
		mav.addObject("user", user);
		int limit = 10; // ���������� ����� �Խù� ����
		// �� �Խù� �Ǽ�
		System.out.println("�˻�Ÿ��:" + searchType);
		System.out.println("�˻�����:" + searchContent);
		System.out.println("���̵�:" + id);
		System.out.println("��Ÿ��:" + ducktype);
		int listcount = service.myduckcount(searchType, searchContent, id, ducktype);
		// boardlist : ���������� ����� �Խù� ���� ����
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
		User user = (User) session.getAttribute("loginUser"); // ���� �α����� ������ ����
		mav.addObject("user", user);
		int limit = 10; // ���������� ����� �Խù� ����
		// �� �Խù� �Ǽ�
		System.out.println("�˻�Ÿ��:" + searchType);
		System.out.println("�˻�����:" + searchContent);
		int waitlistcount = service.waitlistcount(searchType, searchContent, user.getUserid());
		// boardlist : ���������� ����� �Խù� ���� ����
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
		User user = (User) session.getAttribute("loginUser"); // ���� �α����� ������ ����
		mav.addObject("user", user);
		int limit = 10; // ���������� ����� �Խù� ����
		// �� �Խù� �Ǽ�
		System.out.println("�˻�Ÿ��:" + searchType);
		System.out.println("�˻�����:" + searchContent);
		int proceedlistcnt = service.proceedlistcnt(searchType, searchContent, user.getUserid());
		// boardlist : ���������� ����� �Խù� ���� ����
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
		User user = (User) session.getAttribute("loginUser"); // ���� �α����� ������ ����
		mav.addObject("user", user);
		int limit = 10; // ���������� ����� �Խù� ����
		// �� �Խù� �Ǽ�
		System.out.println("�˻�Ÿ��:" + searchType);
		System.out.println("�˻�����:" + searchContent);
		int completelistcnt = service.completelistcnt(searchType, searchContent, user.getUserid());
		// boardlist : ���������� ����� �Խù� ���� ����
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
		User user = (User) session.getAttribute("loginUser"); // ���� �α����� ������ ����
		mav.addObject("user", user);
		int limit = 10; // ���������� ����� �Խù� ����
		// �� �Խù� �Ǽ�
		System.out.println("�˻�Ÿ��:" + searchType);
		System.out.println("�˻�����:" + searchContent);
		int developcompletecnt = service.developcompletecnt(searchType, searchContent, user.getUserid());
		// boardlist : ���������� ����� �Խù� ���� ����
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
		User loginUser = (User) session.getAttribute("loginUser");// ���� �α����� ������ ����
		mav.addObject("user", loginUser);
		int limit = 10; // ���������� ����� �Խù� ����
		// �� �Խù� �Ǽ�
		int personcnt = service.personcnt(loginUser.getUserid());// userid�� ���ؼ� ��õ���� ��ϼ� ��������
		// boardlist : ���������� ����� �Խù� ���� ����
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

	// �����ڰ� ��û �³��Ҷ�
	@RequestMapping(value = "user/userproaccept")
	public ModelAndView userproaccept(HttpSession session, String userid, Integer num) {
		ModelAndView mav = new ModelAndView("user/myduck");
		User user = (User) session.getAttribute("loginUser");
		//�ο��ʰ�-----------
				Board bo = new Board();
				bo.setBoardnum(num);
				bo.setBoardtype(3);
				bo = service.getBoard(bo);
				if(bo.getMaxperson() == bo.getNowperson()) 
					throw new LoginException("�ο� �ʰ�", "../user/myduck.duck?id="+userid+"&ducktype=3&type=3");
				//---------------
		mav.addObject("user", user);
		int duckselect2 = service.select(userid, num);
		System.out.println("boardnum:" + num);
		System.out.println("duckselect2:" + duckselect2);
		if (duckselect2 == 1) {// �ش� ���̵� Duck���̺��� ���� ������ id/num/type=3
			service.duckdelete(userid, num); // ���������� �Ѿ�� ducktype�� 3�̾ƴϸ� �� ����
			service.userproaccept(userid, num); // matching=2�� �����Ͽ� ���� ����
			service.nowpersonupdate(num); // ����������Ʈ�����ο� + 1
			mav.setViewName("redirect: myduck.duck?id=" + user.getUserid() + "&ducktype=3&type=3");
		} else {// �ش� �Խñۿ� �ش� ���̵��� Duck�� ������
				// map.put("msg", "�̹� �³��ϼ̽��ϴ�!");
		}
		return mav;
	}

	// �����ڰ� ����&���� �Ҷ�
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
		 * int duckselect3 = service.sel(userid); //id��/ducktype 2/3/5�ִ� ������Ʈ ã��
		 * System.out.println("duckselect3:" + duckselect3); if (duckselect3 < 1)
		 * {//��û���̰ų� ��������/�������� ������Ʈ�� ������ //service.usernullmatching(userid);
		 * //mav.setViewName("redirect:myduck.duck?id=" + user.getUserid() +
		 * "&ducktype="+ducktype+"&type=3&matching=1"); }else {// ��û/����/�������� ������Ʈ�� ������
		 * ����&����
		 * 
		 * }
		 */
		return mav;
	}

	@RequestMapping("user/rating")
	public ModelAndView rating(int boardnum, float profess, float proaction, float prosatisfact, float prodate,
			float procommunicate, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		System.out.println("����������! - " + profess + "\n" + proaction + "\n" + prosatisfact + "\n" + prodate + "\n"
				+ procommunicate + "\n");
		User user = (User) session.getAttribute("loginUser"); // ���� �α��ε� ����
		try {
			Board board = new Board();
			board.setBoardnum(boardnum);
			board.setBoardtype(4);
			board = service.getBoard(board); // ���ϰ��ִ� �Խù�
			System.out.println("�����ú���:" + board);
			User ratinguser = service.select(board.getUserid()); // �򰡹��� ����
			int cnt = service.duck10cnt(board.getUserid()); // �ش� id�� �� �Խñ��߿�, ducktype�� 10�� duck���̺� �ν��Ͻ��� ����
			System.out.println("�򰡹������� : " + cnt);
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
			float profess2 = ((ratinguser.getProfess() * cnt) + profess) / nanum; // ���� ��ճ���
			float proaction2 = ((ratinguser.getProaction() * cnt) + proaction) / nanum; // ���� ��ճ���
			float prosatisfact2 = ((ratinguser.getProsatisfact() * cnt) + prosatisfact) / nanum; // ���� ��ճ���
			float prodate2 = ((ratinguser.getProdate() * cnt) + prodate) / nanum; // ���� ��ճ���
			float procommunicate2 = ((ratinguser.getProcommunicate() * cnt) + procommunicate) / nanum; // ���� ��ճ���
			float rating = (profess2 + proaction2 + prosatisfact2 + prodate2 + procommunicate2) / 5; // ������
			System.out.println(profess2 + "\n" + proaction2 + "\n" + prosatisfact2 + "\n" + prodate2 + "\n"
					+ procommunicate2 + "\n" + rating + "\n");
			service.setrating(board.getUserid(), profess2, proaction2, prosatisfact2, prodate2, procommunicate2,
					rating);
			// duck���̺� ���ϴ�����id, ���ϰ��ִ°Խù�, ducktype = 10���� �μ�Ʈ
			service.add10duck(user.getUserid(), board.getBoardnum()); // �� ����
			mav.addObject("suggest_message", "�򰡿� �����ϼ̽��ϴ�.");
			mav.addObject("suggest_url", "../user/mypage_main.duck?id=" + user.getUserid());
		} catch (Exception e) {
			throw new LoginException("�򰡿� �����ϼ̽��ϴ�.", "../user/mypage_main.duck?id=" + user.getUserid());
		}
		return mav;
	}

	@RequestMapping("user/rating2")
	public ModelAndView rating2(int boardnum, float profess, float proaction, float prosatisfact, float prodate,
			float procommunicate, String userid, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		System.out.println("����������! - " + profess + "\n" + proaction + "\n" + prosatisfact + "\n" + prodate + "\n"
				+ procommunicate + "\n");
		User user = (User) session.getAttribute("loginUser"); // ���� �α��ε� ����
		try {
			Board board = new Board();
			board.setBoardnum(boardnum);
			board.setBoardtype(4);
			board = service.getBoard(board); // ���ϰ��ִ� �Խù�
			System.out.println("�����ú���:" + board);
			User ratinguser = service.select(userid); // �򰡹��� ����
			int cnt = service.duck20cnt(userid); // �ش� id�� �򰡹��� �Խñ��߿�, ducktype�� 20�� duck���̺� �ν��Ͻ��� ����
			System.out.println("�򰡹������� : " + cnt);
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
			float profess2 = ((ratinguser.getProfess() * cnt) + profess) / nanum; // ���� ��ճ���
			float proaction2 = ((ratinguser.getProaction() * cnt) + proaction) / nanum; // ���� ��ճ���
			float prosatisfact2 = ((ratinguser.getProsatisfact() * cnt) + prosatisfact) / nanum; // ���� ��ճ���
			float prodate2 = ((ratinguser.getProdate() * cnt) + prodate) / nanum; // ���� ��ճ���
			float procommunicate2 = ((ratinguser.getProcommunicate() * cnt) + procommunicate) / nanum; // ���� ��ճ���
			float rating = (profess2 + proaction2 + prosatisfact2 + prodate2 + procommunicate2) / 5; // ������
			System.out.println(profess2 + "\n" + proaction2 + "\n" + prosatisfact2 + "\n" + prodate2 + "\n"
					+ procommunicate2 + "\n" + rating + "\n");
			service.setrating(userid, profess2, proaction2, prosatisfact2, prodate2, procommunicate2, rating);
			// duck���̺� ���ϴ�����id, ���ϰ��ִ°Խù�, ducktype = 20���� �μ�Ʈ
			service.add20duck(userid, board.getBoardnum()); // �� ����
			mav.addObject("suggest_message", "�򰡿� �����ϼ̽��ϴ�.");
			mav.addObject("suggest_url", "../user/mypage_main.duck?id=" + user.getUserid());
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("�򰡿� �����ϼ̽��ϴ�.", "../user/mypage_main.duck?id=" + user.getUserid());
		}
		return mav;
	}
}
