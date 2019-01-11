package logic;

import java.io.File;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.BoardDao;
import dao.CommentDao;
import dao.UserDao;
import exception.LoginException;

@Service // @Component + Service ��� (Controller �� Repository�� ������ �߰� ��ü)
public class DuckService {
	@Autowired
	private UserDao userDao;
	@Autowired
	private BoardDao boardDao;
	@Autowired
	private CommentDao commentDao;

	private void uploadFileCreate(MultipartFile picture, HttpServletRequest request, String path) {
		String uploadPath = request.getServletContext().getRealPath("/") + "/" + path + "/";
		// ������ �̸�.
		String orgFile = picture.getOriginalFilename();
		try {
			// transferTo : ������ ������ (uploadPath + orgFile)�� ���Ͽ� ����.
			picture.transferTo(new File(uploadPath + orgFile));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void userDelete(String id) {
		userDao.userDelete(id);
	}

	public Board getBoard(Board board) {
		return boardDao.select(board);
	}

	public Duck getDuck(Duck duck) {
		return boardDao.select(duck);
	}

	public Board getBoard(Integer num, HttpSession session) {
		return boardDao.select(num);
	}

	public int boardcount(String searchType, String searchContent, Integer type) {
		return boardDao.count(searchType, searchContent, type);
	}

	public int boardcount(String searchType, String searchContent, Integer type, String userid) {// �����Ǽҽ�ī��Ʈ��
		return boardDao.count(searchType, searchContent, type, userid);
	}

	public int boardcount(Integer type) {
		return boardDao.count(type);
	}

	public int boardcount(String searchType, String searchContent, Integer type, String id, Integer ducktype) {
		return boardDao.count(searchType, searchContent, type, id, ducktype);
	}

	public List<Board> boardlist(String searchType, String searchContent, Integer pageNum, int limit, Integer type) {
		return boardDao.list(searchType, searchContent, pageNum, limit, type);
	}

	public void boardadd(Board board, HttpServletRequest request) {
		if (board.getFile1() != null && !board.getFile1().isEmpty()) {
			uploadFileCreate(board.getFile1(), request, "file");
			board.setFileurl(board.getFile1().getOriginalFilename());
		}
		System.out.println("�۾���/������" + board);
		int max = boardDao.maxNum();
		board.setBoardnum(++max);
		boardDao.insert(board);
	}

	public void readcntadd(Integer num) {
		boardDao.readcntadd(num);
	}

	public void boardupdate(Board board, HttpServletRequest request) {
		if (board.getFile1() != null && !board.getFile1().isEmpty()) {
			uploadFileCreate(board.getFile1(), request, "file");
			board.setFileurl(board.getFile1().getOriginalFilename());
		}
		boardDao.update(board);
	}

	public void userUpdate(User user, HttpServletRequest request) {
		System.out.println("userfget" + user.getFile1());
		System.out.println(user.getFile1().getOriginalFilename());

		if (user.getFile1() != null && !user.getFile1().isEmpty()) {
			uploadFileCreate(user.getFile1(), request, "file");
			System.out.println("userfget" + user.getFile1());
			System.out.println(user.getFile1().getOriginalFilename());
			user.setFileurl(user.getFile1().getOriginalFilename());
		}
		userDao.userUpdate(user);
	}
	public void maxcountUpdate(User user) {
		userDao.userUpdate(user);
	}

	public void boarddelete(int boardnum) {
		boardDao.delete(boardnum);
	}

	public User userSelect(User user) {
		User dbuser = userDao.userSelect(user);
		return dbuser;
	}

	public void userCreate(User user, HttpServletRequest request) {
		userDao.insert(user);
	}

	public User select(String id) {
		return userDao.select(id);
	}

	public int recmd(Board board, String userid) {
		boardDao.recmd(board);// ��õ�� ����
		boardDao.recmdchk(board, userid);// recmd ���̺� ��õ���� ����
		Board bo = boardDao.select(board); // ��õ���� �����Ҷ� ������ ������ �Խ��ǰ�ü������
		return bo.getRecmd();
	}

	public int recmdselect(String userid, Integer boardnum) {
		return boardDao.recmdselect(userid, boardnum);// recmd���̺� �ش� ������ �ִ��� ��ȸ
	}

	public void boardduck(Board board, String userid, Integer ducktype) {
		boardDao.duckinsert(board, userid, ducktype);
	}

	public List<User> userList() {
		return userDao.userList();
	}

	public List<User> userList(String[] idchks) {
		return userDao.list(idchks);
	}
	public List<User> userList(String userid) {
		return userDao.list(userid);
	}

	public int idchk(String userid) {
		return userDao.idchk(userid);
	}

	public int creditchk(String creditnum) {
		return userDao.creditchk(creditnum);
	}

	public List<Board> boardlist(Integer pageNum, int limit, Integer type, String tech) {
		return boardDao.list(pageNum, limit, type, tech);
	}

	public List<Board> boardlist(Integer pageNum, int limit, Integer type) {
		return boardDao.list(pageNum, limit, type);
	}

	public List<Board> boardlist(String searchType, String searchContent, Integer pageNum, int limit, Integer type,
			String id, Integer ducktype) {
		return boardDao.ducklist(searchType, searchContent, pageNum, limit, type, id, ducktype);
	}

	public List<Board> boardlist(String searchType, String searchContent, Integer pageNum, int limit, Integer type,
			String userid) {
		return boardDao.ducklist(searchType, searchContent, pageNum, limit, type, userid);
	}// �����ǰԽ��Ǹ���Ʈ

	public List<Board> boardlist(String num) {
		return boardDao.list(num);
	}

	public void duckcntadd(Integer num) {
		boardDao.duckcntadd(num);
	}

	public List<Board> boardlist(Integer boardnum) {
		return boardDao.mainlist(boardnum);
	}

	public List<Board> boardlist2(Integer boardnum) {
		return boardDao.mainlist2(boardnum);
	}

	// ���
	public void commentadd(Comment comment, HttpServletRequest request, String userid, int rnum) {
		int max = commentDao.maxNum();
		comment.setNum(++max);
		comment.setUserid(userid);
		comment.setRef(rnum);
		comment.setContent(comment.getContent());
		comment.setBoardnum(Integer.parseInt(request.getParameter("num")));

		commentDao.insert(comment);
	}

	public int commentcount(Integer boardnum) {
		return commentDao.count(boardnum);
	}

	public List<Comment> commentlist(Integer boardnum) {
		return commentDao.list(boardnum);
	}

	public void upcomment(int num, String content) {
		commentDao.update(num, content);
	}

	public void delcomment(Integer num) {
		commentDao.delete(num);
	}

	public void supporting(String userid) {
		userDao.supporting(userid);
	}

	public List<User> supporterlist(String userid, Integer matching, Integer boardnum, Integer ducktype) {
		return userDao.supporterlist(userid, matching, boardnum, ducktype);
	}

	public int refnum() {
		return commentDao.refnum();
	}

	public void replyadd(String reply, String userid, Integer step, Integer boardnum, Integer ref) {
		int max = commentDao.maxNum();
		Comment comment = new Comment();
		comment.setNum(++max);
		comment.setUserid(userid);
		comment.setRefstep(step);
		comment.setContent(reply);
		comment.setBoardnum(boardnum);
		comment.setRef(ref);
		commentDao.insert(comment);
	}

	public Comment selectcomment(Integer num) {
		return commentDao.select(num);
	}

	public String getHashvalue(String password) throws NoSuchAlgorithmException {
		MessageDigest md;
		String hashvalue = "";
		try {
			md = MessageDigest.getInstance("SHA-256");
			byte[] plain = password.getBytes();
			byte[] hash = md.digest(plain);
			for (byte b : hash) {
				hashvalue += String.format("%02X", b);
			}
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			throw new LoginException("����ο� ��ȭ ���", "../mypage_update.duck");
		}

		return hashvalue;
	}

	public List<User> matchinguserList(String tech) {
		return userDao.matchinguserList(tech);
	}
	public void accept(String userid, Integer num) {
		//userDao.acceptmatching(userid); //�������� �³��ϸ� ��Ī ����
		userDao.acceptducktype(userid,num);
	}

	public void fail(String duckid, Integer num) {
		userDao.failducktype(duckid,num);
	}

	public int duckselect(String userid, Integer num, Integer ducktype) {
		return boardDao.duckselect(userid,num,ducktype);//duck���̺� �ش� ������ �ִ��� ��ȸ
	}

	public String duckidselect(Integer boardnum) {
		return boardDao.duckidselect(boardnum);
	}
}
