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
	
	@ResponseBody //����� ���� ����
	@RequestMapping("board/recmd")
	public Map<Object, Object> recmd(Integer num, Integer type, String userid) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		Board board = new Board(); //board ������ ��ü ����
		board.setBoardnum(num);
		board.setBoardtype(type);
		board = service.getBoard(board); //�ش� num,type�� board��ü ������
		int recmdselect = service.recmdselect(userid,num);
		if(recmdselect<1) { // �ش� �Խñۿ� �ش���̵��� ��õ�� ������
			if(board.getUserid().equals(userid)) {//���� �Խù��϶�
				map.put("recmd", board.getRecmd());
				map.put("msg", "���ΰԽù� ��õ �Ұ���!");		
			}else {//���� �Խù��� �ƴҶ�
				board.setRecmd(board.getRecmd()+1);		
				int recmd = service.recmd(board,userid);
				map.put("recmd", recmd);
				map.put("msg", "��õ�� �Ϸ�Ǿ����ϴ�!");
			}
		}else {
			map.put("recmd", board.getRecmd());
			map.put("msg", "�ߺ���õ �Ұ���!");			
		}
		return map;
	}
	@ResponseBody
	@RequestMapping("board/duck")
	public Map<Object, Object> duck(Integer num, Integer type, String userid) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		Board board = new Board(); //board ������ ��ü ����
		board.setBoardnum(num);
		board.setBoardtype(type);
		board = service.getBoard(board); //�ش� num,type�� board��ü ������
		int duckselect = service.duckselect(userid,num);
		if(duckselect<1) { // �ش� �Խñۿ� �ش���̵��� Duck�� ������
			if(!board.getUserid().equals(userid)) { //�ڽ��� �Խù��� �ƴҶ�
				try {
					service.boardduck(board,userid);
					map.put("msg", "Duck �Ϸ�!");	
				}catch (Exception e) {
					e.printStackTrace();
				}				
			}else {//�ڽ��� �Խù��϶�
				map.put("msg", "���� �Խù��Դϴ�!");
			}
		}else {//�ش� �Խñۿ� �ش� ���̵��� Duck�� ������
			map.put("msg", "�̹� Duck�� �Խù��Դϴ�!");			
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
		if(type==1)System.out.println("���¼ҽ��Խ���");
		if(type==3)System.out.println("������Ʈ��������Խ���");
		ModelAndView mav = new ModelAndView();
		int limit = 10; // ���������� ����� �Խù� ����
		// �� �Խù� �Ǽ�
		int listcount = service.boardcount(searchType, searchContent,type);
		// boardlist : ���������� ����� �Խù� ���� ����
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