package logic;

import java.io.File;
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
public class DuckService {
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

	public void userUpdate(User user) {
		userDao.userUpdate(user);
	}

	public void userDelete(String id) {
		userDao.userDelete(id);
	}
	public Board getBoard(Board board) {
		return boardDao.select(board);
	}

	public Board getBoard(Integer num, HttpSession session) {
		return boardDao.select(num);
	}

	public int boardcount(String searchType, String searchContent,Integer type) {
		return boardDao.count(searchType, searchContent,type);
	}

	public List<Board> boardlist(String searchType, String searchContent, Integer pageNum, int limit,Integer type) {
		return boardDao.list(searchType, searchContent, pageNum, limit,type);
	}

	public void boardadd(Board board, HttpServletRequest request) {
		if (board.getFile1() != null && !board.getFile1().isEmpty()) {
			uploadFileCreate(board.getFile1(), request, "file");
			board.setFileurl(board.getFile1().getOriginalFilename());
		}
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

	public void boarddelete(int num) {
		boardDao.delete(num);
	}

	public User userSelect(User user) {
		User dbuser = userDao.userSelect(user);
		return dbuser;
	}
	
	public void userCreate(User user, HttpServletRequest request) {
		userDao.insert(user);
	}
}
