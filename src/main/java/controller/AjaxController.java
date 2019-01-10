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

	@ResponseBody // ����� ���� ����
	@RequestMapping("board/recmd")
	public Map<Object, Object> recmd(Integer num, Integer type, String userid) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		Board board = new Board(); // board ������ ��ü ����
		board.setBoardnum(num);
		board.setBoardtype(type);
		board = service.getBoard(board); // �ش� num,type�� board��ü ������
		int recmdselect = service.recmdselect(userid, num);
		if (recmdselect < 1) { // �ش� �Խñۿ� �ش���̵��� ��õ�� ������
			if (board.getUserid().equals(userid)) {// ���� �Խù��϶�
				map.put("recmd", board.getRecmd());
				map.put("msg", "���ΰԽù� ��õ �Ұ���!");
			} else {// ���� �Խù��� �ƴҶ�
				board.setRecmd(board.getRecmd() + 1);
				int recmd = service.recmd(board, userid);
				map.put("recmd", recmd);
				map.put("msg", "��õ�� �Ϸ�Ǿ����ϴ�!");
			}
		} else {
			map.put("recmd", board.getRecmd());
			map.put("msg", "�ߺ���õ �Ұ���!");
		}
		return map;
	}

	// user_signup
	@ResponseBody
	@RequestMapping("board/duck")
	public Map<Object, Object> duck(Integer num, Integer type, String userid) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		Board board = new Board(); // board ������ ��ü ����
		board.setBoardnum(num);
		board.setBoardtype(type);
		board = service.getBoard(board); // �ش� num,type�� board��ü ������
//		
//		Duck duck = new Duck();
//		if(type == 3) {//duck �� �ƴ� ��ũ�� ���� ���
//		}
		int duckselect = service.duckselect(userid, num);
		if (duckselect < 1) { // �ش� �Խñۿ� �ش���̵��� Duck�� ������
			if (!board.getUserid().equals(userid)) { // �ڽ��� �Խù��� �ƴҶ�
				try {
					service.boardduck(board, userid);
					service.duckcntadd(num);
					if(type==1) {
						map.put("msg", "Duck �Ϸ�!");						
					}else if(type==3) {
						map.put("msg", "��ũ�� �Ϸ�!");
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {// �ڽ��� �Խù��϶�
				map.put("msg", "���� �Խù��Դϴ�!");
			}
		} else {// �ش� �Խñۿ� �ش� ���̵��� Duck�� ������			
			if(type==1) {
				map.put("msg", "�̹� Duck�� �Խù��Դϴ�!");						
			}else if(type==3) {
				map.put("msg", "�̹� ��ũ���� �Խù��Դϴ�!");
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
		String tech[] = null; // �������� �迭
		List<Board> boardlist = new ArrayList<Board>(); // ������´� board����Ʈ
		List<Integer> bonum = new ArrayList<Integer>();
		int limit = 10; // ���������� ����� �Խù� ����
		if (chk == "") {
			boardlist = service.boardlist(pageNum, limit, type);
			techlistcnt = service.boardcount(type);
		} else { // üũ�ڽ��� �׸��� �ִ� ���
			tech = chk.split(","); // �Ѿ�� �������� / �������� split
			System.out.println("������ : " + chk);
			System.out.println("������� : " + tech.length);
			try {
				for (int i = 0; i < tech.length; i++) {
					//�׽�Ʈ�� - pageNum : 1 , limit�� 100���� �����س��� <<�ؿ���<<
					boardlist.addAll(service.boardlist(1, 100, type, tech[i]));// �̹� �ߺ����� ��������� ���ִ»���
				}
				for (int i = 0; i < boardlist.size(); i++) { // �������� tech�� ���ý� �ߺ����� �ִ� list
					bonum.add(boardlist.get(i).getBoardnum()); // �Խñ۹�ȣ�� ����
				}
				boardlist.clear();// boardlist ��ü����
				System.out.println("�Խñ۹�ȣlist:" + bonum);
				TreeSet<Integer> arr1 = new TreeSet<Integer>(bonum);
				ArrayList<Integer> arr2 = new ArrayList<Integer>(arr1);
				System.out.println("�ߺ�����:" + arr2);
				Collections.reverse(arr2);
				System.out.println("�ߺ������ĳ�������:"+arr2);
				int startpage = pageNum * 10 -9;
				int endpage = startpage + 9;
				String num = arr2.get(startpage-1) + "";
				techlistcnt = arr2.size();
				if(techlistcnt < endpage) {
					endpage = arr2.size();
				}
				System.out.println("����:"+startpage);
				System.out.println("��:"+endpage);
				for (int i = startpage; i < endpage; i++) {
					num += "," + arr2.get(i);
				}
				System.out.println("�����ðԽñ۹�ȣ���ڿ�:"+num);
				System.out.println("��������ȣ:"+pageNum);
				boardlist = service.boardlist(num);//�Ѱ��� �Խù�����Ʈ<<
			} catch (Exception e) {// �����Ͽ� �´� �Խñ��� �������
				System.out.println("�����Ͽ� �ش��ϴ� �Խù��� ����");
				boardlist.add(new Board());
				model.addAttribute("ON", 1);
			}
		} // �ߺ�����
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
		 * count == 0  ���̵� �ߺ��� ����, 3�� �̻� 10�� ������ ���
		 * count == 1  ���̵� �ߺ����� ���
		 * count == 2 ���̵� �ߺ��� ���µ� 3�� �̻� 10�� ���ϸ� ���� X
		 * count == 3 ���̵� ���� null�� �ų� ��ĭ�� ���
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