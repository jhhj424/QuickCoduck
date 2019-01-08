package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import logic.Board;
import logic.DuckService;

@Controller
public class AjaxController {
	@Autowired
	private DuckService service;

	@ResponseBody // 뷰없이 값만 리턴
	@RequestMapping("board/recmd")
	public Map<Object, Object> recmd(Integer num, Integer type, String userid) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		Board board = new Board(); // board 껍데기 객체 생성
		board.setBoardnum(num);
		board.setBoardtype(type);
		board = service.getBoard(board); // 해당 num,type의 board객체 가져옴
		int recmdselect = service.recmdselect(userid, num);
		if (recmdselect < 1) { // 해당 게시글에 해당아이디의 추천이 없을때
			if (board.getUserid().equals(userid)) {// 본인 게시물일때
				map.put("recmd", board.getRecmd());
				map.put("msg", "본인게시물 추천 불가능!");
			} else {// 본인 게시물이 아닐때
				board.setRecmd(board.getRecmd() + 1);
				int recmd = service.recmd(board, userid);
				map.put("recmd", recmd);
				map.put("msg", "추천이 완료되었습니다!");
			}
		} else {
			map.put("recmd", board.getRecmd());
			map.put("msg", "중복추천 불가능!");
		}
		return map;
	}

	// user_signup
	@ResponseBody
	@RequestMapping("board/duck")
	public Map<Object, Object> duck(Integer num, Integer type, String userid) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		Board board = new Board(); // board 껍데기 객체 생성
		board.setBoardnum(num);
		board.setBoardtype(type);
		board = service.getBoard(board); // 해당 num,type의 board객체 가져옴
		int duckselect = service.duckselect(userid, num);
		if (duckselect < 1) { // 해당 게시글에 해당아이디의 Duck이 없을때
			if (!board.getUserid().equals(userid)) { // 자신의 게시물이 아닐때
				try {
					service.boardduck(board, userid);
					map.put("msg", "Duck 완료!");
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {// 자신의 게시물일때
				map.put("msg", "본인 게시물입니다!");
			}
		} else {// 해당 게시글에 해당 아이디의 Duck이 있을때
			map.put("msg", "이미 Duck한 게시물입니다!");
		}
		return map;
	}

	@ResponseBody
	@RequestMapping("board/techchk")
	public Map<Object, Object> techchk(String data) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("tech", data);
		return map;
	}

	@RequestMapping("board/ajax_content")
	public String list(String chk, Integer pageNum, Integer type, HttpSession session, Model model) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		int techlistcnt = 0;
		String tech[] = null; // 사용기술목록 배열
		List<Board> boardlist = new ArrayList<Board>(); // 기술에맞는 board리스트
		List<Integer> bonum = new ArrayList<Integer>();
		int limit = 10; // 한페이지에 출력할 게시물 갯수
		if (chk == "") {
			System.out.println("체크박스선택안함");
			boardlist.addAll(service.boardlist(pageNum, limit, type));
			System.out.println("노체크보드:"+boardlist);
		} else { // 체크박스에 항목이 있는 경우
			tech = chk.split(","); // 넘어온 기술목록을 / 기준으로 split
			System.out.println("기술목록 : " + chk);
			System.out.println("기술개수 : " + tech.length);
			try {
				for (int i = 0; i < tech.length; i++) {
					boardlist.addAll(service.boardlist(pageNum, limit, type, tech[i]));// 이미 중복으로 쿼리결과가 들어가있는상태
				}
				for (int i = 0; i < boardlist.size(); i++) { // 여러개의 tech가 들어올시 중복값이 있는 list
					bonum.add(boardlist.get(i).getBoardnum()); // 게시글번호만 저장
				}
				boardlist.clear();// boardlist 전체삭제
				System.out.println("게시글번호list:" + bonum);
				TreeSet<Integer> arr1 = new TreeSet<Integer>(bonum);
				ArrayList<Integer> arr2 = new ArrayList<Integer>(arr1);
				System.out.println("중복제거:" + arr2);
				String num = arr2.get(0) + "";
				techlistcnt = arr2.size();
				for (int i = 1; i < arr2.size(); i++) {
					num += "," + arr2.get(i);
				}
				boardlist = service.boardlist(pageNum, limit, num);
			} catch (Exception e) {// 기술목록에 맞는 게시글이 없을경우
				System.out.println("기술목록에 해당하는 게시물이 없음");
				boardlist.add(new Board());
				model.addAttribute("ON", 1);
			}
		} // 중복제거
		model.addAttribute("boardlist", boardlist);
		model.addAttribute("tech", chk);
		model.addAttribute("listcount", techlistcnt);
		return "ajax/ajax_content";
	}

	// 총 게시물 건수
	/*
	 * int listcount = service.boardcount(searchType, searchContent,type); //
	 * boardlist : 한페이지에 출력할 게시물 정보 저장 List<Board> boardlist =
	 * service.boardlist(searchType, searchContent, pageNum, limit,type); int
	 * maxpage = (int) ((double) listcount / limit + 0.95); int startpage = ((int)
	 * ((pageNum / 10.0 + 0.9) - 1)) * 10 + 1; int endpage = startpage + 9; if
	 * (endpage > maxpage) endpage = maxpage; int boardcnt = listcount - (pageNum -
	 * 1) * limit;
	 */

	@RequestMapping("user/signup_test")
	public Map<Object, Object> signup_test(String userid, String userEmail, String pass, String pass2) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		int count = 0;
		count = service.idchk(userid);

		if (count == 0) {
			map.put("id_chk", "사용가능한 id");
			map.put("id_color", "green");
		} else {
			map.put("id_chk", "중복");
			map.put("id_color", "red");
		}
		if (pass.equals(pass2)) {
			map.put("pass", pass);
			map.put("corpass_chk", "암호일치");
			map.put("pass_color", "green");
		} else {
			map.put("corpass_chk", "암호가 일치하지 않음");
			map.put("pass_color", "red");
		}

		return map;
	}
}