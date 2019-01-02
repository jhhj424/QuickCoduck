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

@Service // @Component + Service 기능 (Controller 와 Repository의 사이의 중간 객체)
public class ShopService {
	@Autowired
	private UserDao userDao;
	@Autowired
	private BoardDao boardDao;
	private void uploadFileCreate(MultipartFile picture, HttpServletRequest request, String path) {
		String uploadPath = request.getServletContext().getRealPath("/") + "/" + path + "/";
		// 파일의 이름.
		String orgFile = picture.getOriginalFilename();
		try {
			// transferTo : 파일의 내용을 (uploadPath + orgFile)인 파일에 저장.
			picture.transferTo(new File(uploadPath + orgFile));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void userCreate(User user) {// 회원가입 - insert() : DB에 등록
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
		Board b1 = boardDao.select(board.getNum()); // 원글정보
		int max = boardDao.maxNum();
		board.setNum(++max);
		board.setRef(b1.getRef());
		board.setReflevel(b1.getReflevel() + 1);
		board.setRefstep(b1.getRefstep() + 1);
		boardDao.refstep(b1); // => 작업 전 기존의 원글의 refstep 보다 큰 모든 레코드들을 refstep+1로 수정하기
		boardDao.insert(board); // 답글 등록
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
