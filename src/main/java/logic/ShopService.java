package logic;

import java.io.File;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.BoardDao;
import dao.UserDao;
import util.CipherUtil;

@Service // @Component + Service ��� (Controller �� Repository�� ������ �߰� ��ü)
public class ShopService {
	@Autowired
	private UserDao userDao;
	@Autowired
	private BoardDao boardDao;
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

	public void userCreate(User user) {// ȸ������ - insert() : DB�� ���
		user.setEmail(CipherUtil.encrypt(user.getEmail(), user.getUserId()));
		userDao.insert(user);
	}

	public User userSelect(User user) {
		User dbuser = userDao.userSelect(user);
		dbuser.setEmail(CipherUtil.decrypt(dbuser.getEmail(), dbuser.getUserId()));
		return dbuser;
	}

	public User userSelect(String id) {
		User dbuser = userDao.useridSelect(id);
		dbuser.setEmail(CipherUtil.decrypt(dbuser.getEmail(), dbuser.getUserId()));
		return dbuser;
	}

	public void userUpdate(User user) {
		userDao.userUpdate(user);
	}

	public void userDelete(String id) {
		userDao.userDelete(id);
	}

	public List<User> userList() {
		List<User> list = userDao.userList();
		for (User u : list) {
			u.setEmail(CipherUtil.decrypt(u.getEmail(), u.getUserId()));
		}
		return list;
	}

	public List<User> userList(String[] idchks) {
		List<User> list = userDao.list(idchks);
		for (User u : list) {
			u.setEmail(CipherUtil.decrypt(u.getEmail(), u.getUserId()));
		}
		return list;
	}

	public Board getBoard(Integer num) {
		return boardDao.select(num);
	}

	public Board getBoard(Integer num, HttpSession session) {
		return boardDao.select(num);
	}

	public int boardcount(String searchType, String searchContent) {
		return boardDao.count(searchType, searchContent);
	}

	public List<Board> boardlist(String searchType, String searchContent, Integer pageNum, int limit) {
		return boardDao.list(searchType, searchContent, pageNum, limit);
	}

	public void boardadd(Board board, HttpServletRequest request) {
		if (board.getFile1() != null && !board.getFile1().isEmpty()) {
			uploadFileCreate(board.getFile1(), request, "file");
			board.setFileurl(board.getFile1().getOriginalFilename());
		}
		int max = boardDao.maxNum();
		board.setNum(++max);
		board.setRef(max);
		boardDao.insert(board);
	}

	public void readcntadd(Integer num) {
		boardDao.readcntadd(num);
	}

	public void replyadd(Board board) {
		Board b1 = boardDao.select(board.getNum()); // ��������
		int max = boardDao.maxNum();
		board.setNum(++max);
		board.setRef(b1.getRef());
		board.setReflevel(b1.getReflevel() + 1);
		board.setRefstep(b1.getRefstep() + 1);
		boardDao.refstep(b1); // => �۾� �� ������ ������ refstep ���� ū ��� ���ڵ���� refstep+1�� �����ϱ�
		boardDao.insert(board); // ��� ���
	}

	public void boardupdate(Board board, HttpServletRequest request) {
		if (board.getFile1() != null && !board.getFile1().isEmpty()) {
			uploadFileCreate(board.getFile1(), request, "file");
			board.setFileurl(board.getFile1().getOriginalFilename());
		}
		boardDao.update(board);
	}

	public void boarddelete(int num) {
		boardDao.delete(num);
	}
}
