package controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
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
import logic.Duck;
import logic.DuckService;
import logic.User;

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
//		
//		Duck duck = new Duck();
//		if(type == 3) {//duck 이 아닌 스크랩 했을 경우
//		}
		int duckselect = service.duckselect(userid, num);
		if (duckselect < 1) { // 해당 게시글에 해당아이디의 Duck이 없을때
			if (!board.getUserid().equals(userid)) { // 자신의 게시물이 아닐때
				try {
					service.boardduck(board, userid);
					service.duckcntadd(num);
					if(type==1) {
						map.put("msg", "Duck 완료!");						
					}else if(type==3) {
						map.put("msg", "스크랩 완료!");
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {// 자신의 게시물일때
				map.put("msg", "본인 게시물입니다!");
			}
		} else {// 해당 게시글에 해당 아이디의 Duck이 있을때			
			if(type==1) {
				map.put("msg", "이미 Duck한 게시물입니다!");						
			}else if(type==3) {
				map.put("msg", "이미 스크랩한 게시물입니다!");
			}
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
			boardlist = service.boardlist(pageNum, limit, type);
			techlistcnt = service.boardcount(type);
		} else { // 체크박스에 항목이 있는 경우
			tech = chk.split(","); // 넘어온 기술목록을 / 기준으로 split
			System.out.println("기술목록 : " + chk);
			System.out.println("기술개수 : " + tech.length);
			try {
				for (int i = 0; i < tech.length; i++) {
					//테스트용 - pageNum : 1 , limit를 100으로 설정해놨음 <<밑에줄<<
					boardlist.addAll(service.boardlist(1, 100, type, tech[i]));// 이미 중복으로 쿼리결과가 들어가있는상태
				}
				for (int i = 0; i < boardlist.size(); i++) { // 여러개의 tech가 들어올시 중복값이 있는 list
					bonum.add(boardlist.get(i).getBoardnum()); // 게시글번호만 저장
				}
				boardlist.clear();// boardlist 전체삭제
				System.out.println("게시글번호list:" + bonum);
				TreeSet<Integer> arr1 = new TreeSet<Integer>(bonum);
				ArrayList<Integer> arr2 = new ArrayList<Integer>(arr1);
				System.out.println("중복제거:" + arr2);
				Collections.reverse(arr2);
				System.out.println("중복제거후내림차순:"+arr2);
				int startpage = pageNum * 10 -9;
				int endpage = startpage + 9;
				String num = arr2.get(startpage-1) + "";
				techlistcnt = arr2.size();
				if(techlistcnt < endpage) {
					endpage = arr2.size();
				}
				System.out.println("시작:"+startpage);
				System.out.println("끝:"+endpage);
				for (int i = startpage; i < endpage; i++) {
					num += "," + arr2.get(i);
				}
				System.out.println("가져올게시글번호문자열:"+num);
				System.out.println("페이지번호:"+pageNum);
				boardlist = service.boardlist(num);//넘겨줄 게시물리스트<<
			} catch (Exception e) {// 기술목록에 맞는 게시글이 없을경우
				System.out.println("기술목록에 해당하는 게시물이 없음");
				boardlist.add(new Board());
				model.addAttribute("ON", 1);
			}
		} // 중복제거
		int listcount = techlistcnt;
		int maxpage = (int) ((double) listcount / limit + 0.95);
		int startpage = ((int) ((pageNum / 10.0 + 0.9) - 1)) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		int boardcnt = listcount - (pageNum - 1) * limit;
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("maxpage", maxpage);
		model.addAttribute("startpage", startpage);
		model.addAttribute("endpage", endpage);
		model.addAttribute("boardlist", boardlist);
		model.addAttribute("tech", chk);
		model.addAttribute("listcount", techlistcnt);
		model.addAttribute("boardcnt", boardcnt);
		return "ajax/ajax_content";
	}
	
	@ResponseBody
	@RequestMapping("user/user_idchk")
	public Map<Object, Object> user_idchk(String userid) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		int count = 0;
		count = service.idchk(userid);
		/*
		 * count == 0  아이디 중복값 없고, 3자 이상 10자 이하인 경우
		 * count == 1  아이디 중복값인 경우
		 * count == 2 아이디 중복은 없는데 3자 이상 10자 이하를 충족 X
		 * count == 3 아이디 값이 null이 거나 빈칸인 경우
		 */
		
		if(count == 0) {
			if(userid.length() >=3 && userid.length() <11) {
				map.put("id_chk",0);
			}else if(userid.length() == 0 && userid.equals("")) {
				map.put("id_chk",3);
			}else {
				map.put("id_chk",2);
			}
			
		}else {
			map.put("id_chk", 1);
		}
		return map;
	}
}