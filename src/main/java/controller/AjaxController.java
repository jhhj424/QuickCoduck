package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import logic.Board;
import logic.DuckService;
import logic.User;

@Controller
public class AjaxController {
	@Autowired
	private DuckService service;
	
	@ResponseBody //뷰없이 값만 리턴
	@RequestMapping("board/recmd")
	public Map<Object, Object> recmd(Integer num, Integer type, String userid) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		Board board = new Board(); //board 껍데기 객체 생성
		board.setBoardnum(num);
		board.setBoardtype(type);
		board = service.getBoard(board); //해당 num,type의 board객체 가져옴
		int recmdselect = service.recmdselect(userid,num);
		if(recmdselect<1) { // 해당 게시글에 해당아이디의 추천이 없을때
			if(board.getUserid().equals(userid)) {//본인 게시물일때
				map.put("recmd", board.getRecmd());
				map.put("msg", "본인게시물 추천 불가능!");		
			}else {//본인 게시물이 아닐때
				board.setRecmd(board.getRecmd()+1);		
				int recmd = service.recmd(board,userid);
				map.put("recmd", recmd);
				map.put("msg", "추천이 완료되었습니다!");
			}
		}else {
			map.put("recmd", board.getRecmd());
			map.put("msg", "중복추천 불가능!");			
		}
		return map;
	}
	//user_signup
	@ResponseBody
	@RequestMapping("board/duck")
	public Map<Object, Object> duck(Integer num, Integer type, String userid) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		Board board = new Board(); //board 껍데기 객체 생성
		board.setBoardnum(num);
		board.setBoardtype(type);
		board = service.getBoard(board); //해당 num,type의 board객체 가져옴
		int duckselect = service.duckselect(userid,num);
		if(duckselect<1) { // 해당 게시글에 해당아이디의 Duck이 없을때
			if(!board.getUserid().equals(userid)) { //자신의 게시물이 아닐때
				try {
					service.boardduck(board,userid);
					map.put("msg", "Duck 완료!");	
				}catch (Exception e) {
					e.printStackTrace();
				}				
			}else {//자신의 게시물일때
				map.put("msg", "본인 게시물입니다!");
			}
		}else {//해당 게시글에 해당 아이디의 Duck이 있을때
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
	public String list(String chk,Integer pageNum, Integer type, HttpSession session, Model model) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		String tech[] = null; //사용기술목록 배열
		List<Board> boardlist = new ArrayList<Board>(); //기술에맞는 board리스트
		int limit = 10; // 한페이지에 출력할 게시물 갯수
		if(chk=="") {
			boardlist = service.boardlist(pageNum, limit,type);
		}else {
			tech = chk.split("/"); //넘어온 기술목록을 / 기준으로 split
			for(int i=0; i<tech.length;i++) {
				System.out.println(tech[i]); //기술목록
				boardlist.addAll(service.boardlist(pageNum, limit,type,tech[i]));
			}
		}
		// 총 게시물 건수
		/*int listcount = service.boardcount(searchType, searchContent,type);
		// boardlist : 한페이지에 출력할 게시물 정보 저장
		List<Board> boardlist = service.boardlist(searchType, searchContent, pageNum, limit,type);
		int maxpage = (int) ((double) listcount / limit + 0.95);
		int startpage = ((int) ((pageNum / 10.0 + 0.9) - 1)) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		int boardcnt = listcount - (pageNum - 1) * limit;*/
		model.addAttribute("boardlist", boardlist);
		model.addAttribute("tech",chk);
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