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
import org.springframework.web.servlet.ModelAndView;

import exception.LoginException;
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
	public Map<Object, Object> duck(Integer num, Integer type, String userid, Integer ducktype) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		Board board = new Board(); // board 껍데기 객체 생성
		board.setBoardnum(num);
		board.setBoardtype(type);
		board = service.getBoard(board); // 해당 num,type의 board객체 가져옴
		int duckselect = service.duckselect(userid, num, ducktype);
		if (duckselect < 1) { // 해당 게시글에 해당아이디의 Duck이 없을때
			if (!board.getUserid().equals(userid)) { // 자신의 게시물이 아닐때
				try {
					service.boardduck(board, userid, ducktype); //덕이랑 스크랩할때만 사용!					
					service.duckcntadd(num); //덕, 스크랩 한 횟수만 적용.
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
	
	@ResponseBody
	@RequestMapping("board/tech_select")
	public Map<Object, Object> tech_select(String tech) {
		System.out.println(tech);
		Map<Object, Object> map = new HashMap<Object, Object>();
		String techarr[] = null; // 사용기술목록 배열
		List<String> techlist = new ArrayList<String>(); // 기술목록 리스트
		techarr = tech.split(","); // 넘어온 기술목록을 / 기준으로 split
		for(int i=0;i<techarr.length;i++) {
			techlist.add(techarr[i]+",");
		}
		System.out.println("techarr:"+techarr);
		TreeSet<String> arr1 = new TreeSet<String>(techlist);
		ArrayList<String> arr2 = new ArrayList<String>(arr1);
		tech = "";
		for(int i=0;i<arr2.size();i++) {
			tech += arr2.get(i);
		}
		System.out.println("기술넘기기:"+tech);
		map.put("tech", tech);
		return map;
	}

	@RequestMapping("board/ajax_content")
	public String list(String chk, Integer pageNum, Integer type, HttpSession session, String searchType, String searchContent, Model model) {
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		User user = (User)session.getAttribute("loginUser");
		int techlistcnt = 0;
		int mycount = 0; //나만의 게시물 총게시물 개수
		String tech[] = null; // 사용기술목록 배열
		List<Board> boardlist = new ArrayList<Board>(); // 기술에맞는 board리스트
		List<Integer> bonum = new ArrayList<Integer>();
		List<Board> mylist = new ArrayList<Board>();//나만의 게시글
		int limit = 10; // 한페이지에 출력할 게시물 갯수
		if (chk == "") {
			boardlist = service.boardlist(pageNum, limit, type);
			techlistcnt = service.boardcount(type);
			if(type==5) {
				for(int i=0; i<boardlist.size();i++) {
					if(boardlist.get(i).getUserid().equals(user.getUserid())) {
						mylist.add(boardlist.get(i));
					}
					mycount = mylist.size();
				}
			}
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
				//나만의소스보기-------------------------------------
				System.out.println("타입은???"+type);
				if(type==5) {
					for(int i=0; i<boardlist.size();i++) {
						if(boardlist.get(i).getUserid().equals(user.getUserid())) {
							mylist.add(boardlist.get(i));
						}
						mycount = mylist.size();
					}
				}

				//나만의소스보기-------------------------------------
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
		model.addAttribute("mylist", mylist);
		model.addAttribute("tech", chk);
		model.addAttribute("listcount", techlistcnt);
		model.addAttribute("mycount", mycount);
		model.addAttribute("boardcnt", boardcnt);
		model.addAttribute("type", type);
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
	//댓글삭제
    @RequestMapping("board/delcomment")
    @ResponseBody
    public Map<Object,Object> delcomment(Integer num) {
    	Map<Object,Object> map = new HashMap<Object,Object>();
    	service.delcomment(num);
    	map.put("msg", "OK");
//    	System.out.println("원글번호:"+boardnum);
//    	System.out.println("댓글번호:"+num);
        return map;
   }

    @RequestMapping("board/developdelete")
    @ResponseBody
    public Map<Object,Object> developdelete(String userid, Integer boardnum, Integer ducktype) {
    	Map<Object,Object> map = new HashMap<Object,Object>();
    	service.developdelete(userid,boardnum,ducktype);
    	map.put("msg", "OK");
        return map;
   }
    @RequestMapping("board/complete")
    @ResponseBody
    public Map<Object,Object> complete(Integer boardnum) {
    	System.out.println("컴플릿보드넘:"+boardnum);
    	Map<Object,Object> map = new HashMap<Object,Object>();
    	try {
    		// 프로젝트 완료해버리기~ => 해당 boardnum 게시물 boardtype 4로변경
        	service.complete(boardnum); 
        	//duck테이블의 해당 boardnum에 해당하는 모든 인스턴스의 ducktype을 7로 변경
        	service.duck7update(boardnum);
        	service.matchingto1(boardnum); // 완료된 유저의 매칭타입을 2에서 1로 변경
        	map.put("msg", "OK");
    	}catch (Exception e) {
			e.printStackTrace();
		}
        return map;
   }
    @RequestMapping("user/evaluation")
    @ResponseBody
    public Map<Object,Object> evaluation(Integer boardnum, String userid) {
    	System.out.println("evaluation보드넘:"+boardnum);
    	Map<Object,Object> map = new HashMap<Object,Object>();
    	try {
    		//평가 내역이 있는지 조회 -> 덕테이블 // userid=#{userid},boardnum=#{boardnum},ducktype=10
    		int tenduck = service.tenduck(userid,boardnum); // 덕테이블에서 해당 boardnum, 해당 user, 덕타입이 10인값을 가져옴
    		if(tenduck == 0) { // 평가내역이 없으면.
    			map.put("msg", "평가페이지로 이동합니다."); 
    			map.put("ok", "ok");
    		}else { //평가내역이 있으면
    			map.put("msg", "이미 평가가 완료된 프로젝트입니다.");
    		}
    	}catch (Exception e) {
			e.printStackTrace();
		}
        return map;
   }
    @RequestMapping("user/userevaluation")
    @ResponseBody
    public Map<Object,Object> userevaluation(Integer boardnum, String userid) {
    	System.out.println("userevaluation보드넘:"+boardnum);
    	Map<Object,Object> map = new HashMap<Object,Object>();
    	try {
    		//평가 내역이 있는지 조회 -> 덕테이블 // userid=#{userid},boardnum=#{boardnum},ducktype=20
    		int tenduck = service.twenduck(userid,boardnum); // 덕테이블에서 해당 boardnum, 해당 user, 덕타입이 20인값을 가져옴
    		if(tenduck == 0) { // 평가내역이 없으면.
    			map.put("msg", "평가페이지로 이동합니다."); 
    			map.put("ok", "ok");
    		}else { //평가내역이 있으면
    			map.put("msg", "이미 평가가 완료된 개발자입니다.");
    		}
    	}catch (Exception e) {
			e.printStackTrace();
		}
        return map;
   }
    @RequestMapping("user/completeuserlist")
    public String userevaluation(Integer boardnum, Model model) {
    	System.out.println("evaluation보드넘:"+boardnum);
    	try {
    		List<User> userlist = service.completeuserlist(boardnum); 
    		model.addAttribute("userlist",userlist);
    		model.addAttribute("boardnum", boardnum);
    	}catch (Exception e) {
			e.printStackTrace();
		}
		return "ajax/ajax_userlist";
   }
	
	// user_signup
	@ResponseBody
	@RequestMapping("board/pro")
	public Map<Object, Object> pro(Integer num, Integer type, String userid, Integer ducktype) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		Board board = new Board(); // board 껍데기 객체 생성
		board.setBoardnum(num);
		board.setBoardtype(type);
		board = service.getBoard(board); // 해당 num,type의 board객체 가져옴
		User user = service.select(userid); //로그인된 유저의 정보
		int duckselect = service.duckselect(userid, num, ducktype);
		if (duckselect < 1) { // 해당 게시글에 해당아이디의 Duck이 없을때
			if (!board.getUserid().equals(userid)) { // 자신의 게시물이 아닐때
				try {
					if(board.getMaxperson()>board.getNowperson()) { //현재 게시물의 max인원보다 매칭된 유저가 적을때
						if(user.getType()==1){ //개발자일때
							if(user.getMatching()==2) { //이미 신청한 공고가있을경우
								map.put("msg", "이미 진행중인 프로젝트가 있습니다.");
							}else {//프로젝트공고 신청가능
								service.boardduck(board, userid, ducktype); //덕이랑 스크랩할때만 사용!//매칭에도사용됨.				
								//service.duckcntadd(num); //덕, 스크랩 한 횟수만 적용.
								map.put("msg", "신청 완료!");
								//service.supporting(userid);
								board.setRecmd(board.getRecmd() + 1);
								int recmd = service.recmd(board, userid);
								map.put("recmd", recmd);
							}
						}else {//개발자가 아닐떄
							map.put("msg", "개발자만 신청 가능합니다!");
						}
						}else {
							map.put("msg", "신청인원 초과!");
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {// 자신의 게시물일때
				map.put("msg", "본인 게시물입니다!");
			}
		} else {// 해당 게시글에 해당 아이디의 Duck이 있을때
			map.put("msg", "이미 신청하셨습니다!");
		}
		return map;
	}
	@ResponseBody
	@RequestMapping("user/checkbox")
	public Map<Object, Object> checkbox(String userid, Integer matching, HttpSession session) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		try {
			User dbuser = (User)session.getAttribute("loginUser");
			if(dbuser.getMatching() != 2) {
				service.matching(userid,matching);
				User user = service.select(userid);
				session.setAttribute("loginUser", user);
				if(user.getMatching()==1) {
					map.put("msg", "인재등록이 활성화되었습니다.");
				}else if(user.getMatching() == 0) {
					map.put("msg", "인재등록이 비활성화되었습니다.");
				}
			}else {
				map.put("msg", "현재 진행중인 프로젝트가 있습니다.");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}		
		return map;
	}
	
}