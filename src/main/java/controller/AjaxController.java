package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import logic.Board;
import logic.DuckService;

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
	public String list(Integer pageNum, String searchType, String searchContent, Integer type, HttpSession session) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if(type==1)System.out.println("오픈소스게시판");
		if(type==3)System.out.println("프로젝트공고모집게시판");
		ModelAndView mav = new ModelAndView();
		int limit = 10; // 한페이지에 출력할 게시물 갯수
		// 총 게시물 건수
		int listcount = service.boardcount(searchType, searchContent,type);
		// boardlist : 한페이지에 출력할 게시물 정보 저장
		List<Board> boardlist = service.boardlist(searchType, searchContent, pageNum, limit,type);
		int maxpage = (int) ((double) listcount / limit + 0.95);
		int startpage = ((int) ((pageNum / 10.0 + 0.9) - 1)) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		int boardcnt = listcount - (pageNum - 1) * limit;
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", listcount);
		mav.addObject("boardlist", boardlist);
		mav.addObject("boardcnt", boardcnt);
		return "ajax/ajax_content";
	}
}