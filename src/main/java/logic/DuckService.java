package logic;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	
	public int boardcount(String searchType, String searchContent,Integer type, String id) {
		return boardDao.count(searchType, searchContent,type, id);
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
		System.out.println("maxNum:"+max);
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

	public int recmd(Board board,String userid) {
		boardDao.recmd(board);// 추천수 증가
		boardDao.recmdchk(board,userid);//recmd 테이블에 추천정보 저장
		Board bo = boardDao.select(board); //추천갱신 리턴할때 쓰려고 증가후 게시판객체가져옴
		return bo.getRecmd();
	}

	public int recmdselect(String userid,Integer boardnum) {
		return boardDao.recmdselect(userid,boardnum);//recmd테이블에 해당 데이터 있는지 조회
	}

	public int duckselect(String userid, Integer boardnum) {
		return boardDao.duckselect(userid,boardnum);//duck테이블에 해당 데이터 있는지 조회
	}

	public void boardduck(Board board, String userid) {
		boardDao.duckinsert(board,userid);
	}
		
	public List<User> userList() {
		return userDao.userList();
	}
	public List<User> userList(String[] idchks) {
		return userDao.list(idchks);
	}

	public int idchk(String userid) {
		return userDao.idchk(userid);
	}

	public List<Board> boardlist(Integer pageNum, int limit, Integer type, String tech) {
		return boardDao.list(pageNum, limit,type,tech);
	}

	public List<Board> boardlist(Integer pageNum, int limit, Integer type) {
		return boardDao.list(pageNum, limit,type);
	}
	public List<Board> boardlist(String searchType, String searchContent, Integer pageNum, int limit, Integer type, String id) {
		return boardDao.ducklist(searchType, searchContent, pageNum, limit, type, id);
	}

	public List<Board> boardlist(Integer pageNum, int limit,String num) {
		return boardDao.list(pageNum,limit,num);
	}
}
