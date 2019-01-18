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
	public Map<Object, Object> duck(Integer num, Integer type, String userid, Integer ducktype) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		Board board = new Board(); // board ������ ��ü ����
		board.setBoardnum(num);
		board.setBoardtype(type);
		board = service.getBoard(board); // �ش� num,type�� board��ü ������
		int duckselect = service.duckselect(userid, num, ducktype);
		if (duckselect < 1) { // �ش� �Խñۿ� �ش���̵��� Duck�� ������
			if (!board.getUserid().equals(userid)) { // �ڽ��� �Խù��� �ƴҶ�
				try {
					service.boardduck(board, userid, ducktype); //���̶� ��ũ���Ҷ��� ���!					
					service.duckcntadd(num); //��, ��ũ�� �� Ƚ���� ����.
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
	
	@ResponseBody
	@RequestMapping("board/tech_select")
	public Map<Object, Object> tech_select(String tech) {
		System.out.println(tech);
		Map<Object, Object> map = new HashMap<Object, Object>();
		String techarr[] = null; // �������� �迭
		List<String> techlist = new ArrayList<String>(); // ������ ����Ʈ
		techarr = tech.split(","); // �Ѿ�� �������� / �������� split
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
		System.out.println("����ѱ��:"+tech);
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
		int mycount = 0; //������ �Խù� �ѰԽù� ����
		String tech[] = null; // �������� �迭
		List<Board> boardlist = new ArrayList<Board>(); // ������´� board����Ʈ
		List<Integer> bonum = new ArrayList<Integer>();
		List<Board> mylist = new ArrayList<Board>();//������ �Խñ�
		int limit = 10; // ���������� ����� �Խù� ����
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
				//�����Ǽҽ�����-------------------------------------
				System.out.println("Ÿ����???"+type);
				if(type==5) {
					for(int i=0; i<boardlist.size();i++) {
						if(boardlist.get(i).getUserid().equals(user.getUserid())) {
							mylist.add(boardlist.get(i));
						}
						mycount = mylist.size();
					}
				}

				//�����Ǽҽ�����-------------------------------------
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
	//��ۻ���
    @RequestMapping("board/delcomment")
    @ResponseBody
    public Map<Object,Object> delcomment(Integer num) {
    	Map<Object,Object> map = new HashMap<Object,Object>();
    	service.delcomment(num);
    	map.put("msg", "OK");
//    	System.out.println("���۹�ȣ:"+boardnum);
//    	System.out.println("��۹�ȣ:"+num);
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
    	System.out.println("���ø������:"+boardnum);
    	Map<Object,Object> map = new HashMap<Object,Object>();
    	try {
    		// ������Ʈ �Ϸ��ع�����~ => �ش� boardnum �Խù� boardtype 4�κ���
        	service.complete(boardnum); 
        	//duck���̺��� �ش� boardnum�� �ش��ϴ� ��� �ν��Ͻ��� ducktype�� 7�� ����
        	service.duck7update(boardnum);
        	service.matchingto1(boardnum); // �Ϸ�� ������ ��ĪŸ���� 2���� 1�� ����
        	map.put("msg", "OK");
    	}catch (Exception e) {
			e.printStackTrace();
		}
        return map;
   }
    @RequestMapping("user/evaluation")
    @ResponseBody
    public Map<Object,Object> evaluation(Integer boardnum, String userid) {
    	System.out.println("evaluation�����:"+boardnum);
    	Map<Object,Object> map = new HashMap<Object,Object>();
    	try {
    		//�� ������ �ִ��� ��ȸ -> �����̺� // userid=#{userid},boardnum=#{boardnum},ducktype=10
    		int tenduck = service.tenduck(userid,boardnum); // �����̺��� �ش� boardnum, �ش� user, ��Ÿ���� 10�ΰ��� ������
    		if(tenduck == 0) { // �򰡳����� ������.
    			map.put("msg", "���������� �̵��մϴ�."); 
    			map.put("ok", "ok");
    		}else { //�򰡳����� ������
    			map.put("msg", "�̹� �򰡰� �Ϸ�� ������Ʈ�Դϴ�.");
    		}
    	}catch (Exception e) {
			e.printStackTrace();
		}
        return map;
   }
    @RequestMapping("user/userevaluation")
    @ResponseBody
    public Map<Object,Object> userevaluation(Integer boardnum, String userid) {
    	System.out.println("userevaluation�����:"+boardnum);
    	Map<Object,Object> map = new HashMap<Object,Object>();
    	try {
    		//�� ������ �ִ��� ��ȸ -> �����̺� // userid=#{userid},boardnum=#{boardnum},ducktype=20
    		int tenduck = service.twenduck(userid,boardnum); // �����̺��� �ش� boardnum, �ش� user, ��Ÿ���� 20�ΰ��� ������
    		if(tenduck == 0) { // �򰡳����� ������.
    			map.put("msg", "���������� �̵��մϴ�."); 
    			map.put("ok", "ok");
    		}else { //�򰡳����� ������
    			map.put("msg", "�̹� �򰡰� �Ϸ�� �������Դϴ�.");
    		}
    	}catch (Exception e) {
			e.printStackTrace();
		}
        return map;
   }
    @RequestMapping("user/completeuserlist")
    public String userevaluation(Integer boardnum, Model model) {
    	System.out.println("evaluation�����:"+boardnum);
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
		Board board = new Board(); // board ������ ��ü ����
		board.setBoardnum(num);
		board.setBoardtype(type);
		board = service.getBoard(board); // �ش� num,type�� board��ü ������
		User user = service.select(userid); //�α��ε� ������ ����
		int duckselect = service.duckselect(userid, num, ducktype);
		if (duckselect < 1) { // �ش� �Խñۿ� �ش���̵��� Duck�� ������
			if (!board.getUserid().equals(userid)) { // �ڽ��� �Խù��� �ƴҶ�
				try {
					if(board.getMaxperson()>board.getNowperson()) { //���� �Խù��� max�ο����� ��Ī�� ������ ������
						if(user.getType()==1){ //�������϶�
							if(user.getMatching()==2) { //�̹� ��û�� �����������
								map.put("msg", "�̹� �������� ������Ʈ�� �ֽ��ϴ�.");
							}else {//������Ʈ���� ��û����
								service.boardduck(board, userid, ducktype); //���̶� ��ũ���Ҷ��� ���!//��Ī��������.				
								//service.duckcntadd(num); //��, ��ũ�� �� Ƚ���� ����.
								map.put("msg", "��û �Ϸ�!");
								//service.supporting(userid);
								board.setRecmd(board.getRecmd() + 1);
								int recmd = service.recmd(board, userid);
								map.put("recmd", recmd);
							}
						}else {//�����ڰ� �ƴҋ�
							map.put("msg", "�����ڸ� ��û �����մϴ�!");
						}
						}else {
							map.put("msg", "��û�ο� �ʰ�!");
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {// �ڽ��� �Խù��϶�
				map.put("msg", "���� �Խù��Դϴ�!");
			}
		} else {// �ش� �Խñۿ� �ش� ���̵��� Duck�� ������
			map.put("msg", "�̹� ��û�ϼ̽��ϴ�!");
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
					map.put("msg", "�������� Ȱ��ȭ�Ǿ����ϴ�.");
				}else if(user.getMatching() == 0) {
					map.put("msg", "�������� ��Ȱ��ȭ�Ǿ����ϴ�.");
				}
			}else {
				map.put("msg", "���� �������� ������Ʈ�� �ֽ��ϴ�.");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}		
		return map;
	}
	
}