package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.BoardMapper;
import dao.mapper.UserMapper;
import logic.Board;
import logic.Duck;

@Repository
public class BoardDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.BoardMapper.";
	
	public Board select(Integer num) {
		Map<String, Integer> map= new HashMap<String, Integer>();
		map.put("boardnum", num);
		return sqlSession.selectOne(NS + "select",map);
	}
	public Board select(Board board) {
		Map<String, Integer> map= new HashMap<String, Integer>();
		map.put("boardnum", board.getBoardnum());
		map.put("type", board.getBoardtype());
		Board bo = sqlSession.selectOne(NS + "select",map);
		System.out.println("bobo:"+bo);
		return sqlSession.selectOne(NS + "select",map);
	}
	public Duck select(Duck duck) {
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("boardnum", duck.getBoardnum());
		map.put("ducktype", duck.getDucktype());
		return sqlSession.selectOne(NS + "select2",map);
	}
	public int count(String searchType, String searchContent,Integer type) {
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("column", searchType);
		map.put("find", searchContent);
		map.put("type", type);
		return sqlSession.selectOne(NS + "count", map);
	}
	public int count(String searchType, String searchContent, String id, Integer ducktype) {
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("column", searchType);
		map.put("find", searchContent);
		map.put("ducktype", ducktype);
		map.put("userid", id);
		return sqlSession.selectOne(NS + "myduckcount", map);
	}
	
	public int count(String searchType, String searchContent,Integer type,String userid) {//나만의소스 카운트용
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("column", searchType);
		map.put("find", searchContent);
		map.put("type", type);
		map.put("userid", userid);//count용
		return sqlSession.selectOne(NS + "count", map);
	}
	public int count(Integer type) {
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("type", type);
		return sqlSession.selectOne(NS + "count", map);
	}
	public int count(String searchType, String searchContent,Integer type, String id, Integer ducktype) {
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("column", searchType);
		map.put("find", searchContent);
		map.put("type", type);
		map.put("userid", id);
		map.put("ducktype", ducktype);
		return sqlSession.selectOne(NS + "count", map);
	}
	public int count(String searchType, String searchContent,Integer type, String id, String ducktype) {
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("column", searchType);
		map.put("find", searchContent);
		map.put("type", type);
		map.put("userid", id);
		map.put("ducktype", ducktype);
		return sqlSession.selectOne(NS + "count", map);
	}
	public List<Board> list(String searchType, String searchContent, Integer pageNum, int limit,Integer type) {
		Map<String , Object> map = new HashMap<String, Object>();
		int startrow = (pageNum -1) * limit;
		map.put("column", searchType);
		map.put("find", searchContent);
		map.put("startrow", startrow);
		map.put("limit", limit);
		map.put("type", type);
		return sqlSession.selectList(NS + "select", map);
	}
	public int maxNum() {
		return sqlSession.getMapper(BoardMapper.class).maxNum();
	}
	public void insert(Board board) {
		sqlSession.getMapper(BoardMapper.class).insert(board);
	}
	public void readcntadd(Integer num) {
		Map<String , Integer> map = new HashMap<String, Integer>();
		map.put("boardnum", num);
		sqlSession.getMapper(BoardMapper.class).readcntadd(map);
	}
	public void refstep(Board board) {
		Map<String , Integer> map = new HashMap<String, Integer>();
		sqlSession.getMapper(BoardMapper.class).rsupdate(map);
	}
	public void update(Board board) {
		sqlSession.getMapper(BoardMapper.class).update(board);
	}
	public void delete(int boardnum) {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("boardnum", boardnum);
		sqlSession.getMapper(BoardMapper.class).delete(map);
	}
	public void recmd(Board board) {
		sqlSession.getMapper(BoardMapper.class).update(board);
	}
	public void recmdchk(Board board, String userid) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("boardnum", board.getBoardnum());
		map.put("userid", userid);
		sqlSession.getMapper(BoardMapper.class).recmdinsert(map);
	}
	public int recmdselect(String userid, Integer boardnum) {
		Map<String , Object> map = new HashMap<String, Object>();
		map.put("userid", userid);
		map.put("boardnum", boardnum);
		String select = sqlSession.getMapper(BoardMapper.class).recmdselect(map);
		int num = 0;
		if(select == null) {
			num = 0;
		}else {
			num = 1;
		}
		return num; 
	}
	public void duckinsert(Board board, String userid, Integer ducktype) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("boardnum", board.getBoardnum());
		map.put("userid", userid);
		map.put("ducktype", ducktype);
		sqlSession.getMapper(BoardMapper.class).duckinsert(map);
	}
	public List<Board> list(Integer pageNum, int limit, Integer type, String tech) {
		Map<String , Object> map = new HashMap<String, Object>();
		int startrow = (pageNum -1) * limit;
		map.put("startrow", startrow);
		map.put("limit", limit);
		map.put("type", type);
		map.put("tech", tech+",");
		return sqlSession.selectList(NS + "select", map);
	}
	public List<Board> list(Integer pageNum, int limit, Integer type) {
		Map<String , Object> map = new HashMap<String, Object>();
		int startrow = (pageNum -1) * limit;
		map.put("startrow", startrow);
		map.put("limit", limit);
		map.put("type", type);
		return sqlSession.selectList(NS + "select", map);
	}
	
	public List<Board> ducklist(String searchType, String searchContent, Integer pageNum, int limit, Integer type,
			String id, String ducktype) {
		Map<String , Object> map = new HashMap<String, Object>();
		int startrow = (pageNum -1) * limit;
		map.put("column", searchType);
		map.put("find", searchContent);
		map.put("startrow", startrow);
		map.put("limit", limit);
		map.put("type", type);
		map.put("userid", id);
		map.put("ducktype", ducktype);
		return sqlSession.selectList(NS + "ducklist", map);
	}
	public List<Board> ducklist(String searchType, String searchContent, Integer pageNum, int limit, Integer type,
			String id, Integer ducktype) {
		Map<String , Object> map = new HashMap<String, Object>();
		int startrow = (pageNum -1) * limit;
		map.put("column", searchType);
		map.put("find", searchContent);
		map.put("startrow", startrow);
		map.put("limit", limit);
		map.put("type", type);
		map.put("userid", id);
		map.put("ducktype", ducktype);
		return sqlSession.selectList(NS + "ducklist", map);
	}
	public List<Board> ducklist(String searchType, String searchContent, Integer pageNum, int limit, String id,
			Integer ducktype) {
		Map<String , Object> map = new HashMap<String, Object>();
		int startrow = (pageNum -1) * limit;
		map.put("column", searchType);
		map.put("find", searchContent);
		map.put("startrow", startrow);
		map.put("limit", limit);
		map.put("userid", id);
		map.put("ducktype", ducktype);
		return sqlSession.selectList(NS + "ducklist2", map);
	}
	public List<Board> ducklist(String searchType, String searchContent, Integer pageNum, int limit, Integer type, String userid) {
		Map<String , Object> map = new HashMap<String, Object>();
		int startrow = (pageNum -1) * limit;
		map.put("column", searchType);
		map.put("find", searchContent);
		map.put("startrow", startrow);
		map.put("limit", limit);
		map.put("type", type);
		map.put("userid", userid);
		return sqlSession.selectList(NS + "mylist", map);
	}
	
	public List<Board> list(String num) {
		Map<String , Object> map = new HashMap<String, Object>();
		map.put("num", num);
		return sqlSession.selectList(NS + "techboardlist", map);
	}
	public void duckcntadd(Integer num) {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("boardnum", num);
		sqlSession.getMapper(BoardMapper.class).duckcntadd(map);
	}
	public List<Board> mainlist(Integer boardnum) {
		Map<String , Object> map = new HashMap<String, Object>();
		map.put("boardnum", boardnum);
		return sqlSession.selectList(NS + "mainlist", map);
	}
	public List<Board> mainlist2(Integer boardnum) {
		Map<String , Object> map = new HashMap<String, Object>();
		map.put("boardnum", boardnum);
		return sqlSession.selectList(NS + "mainlist2", map);
	}
	public int duckselect(String userid, Integer boardnum, Integer ducktype) {
		Map<String , Object> map = new HashMap<String, Object>();
		map.put("userid", userid);
		map.put("boardnum", boardnum);
		map.put("ducktype", ducktype);
		String select = sqlSession.getMapper(BoardMapper.class).duckselect(map);
		int num = 0;
		if(select == null) {
			num = 0;
		}else {
			num = 1;
		}
		return num; 
	}
	public String duckidselect(Integer boardnum, String userid) { //boardnum으로만 userid찾기
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("boardnum",boardnum);
		map.put("userid",userid);
		return sqlSession.selectOne(NS + "duckid", map);
	}
	public void duckinsert(String userid, Integer boardnum, int ducktype) {
		Map<String , Object> map = new HashMap<String, Object>();
		map.put("userid", userid);
		map.put("boardnum", boardnum);
		map.put("ducktype", ducktype);
		sqlSession.getMapper(BoardMapper.class).matchduckinsert(map);
	}
	public void userprodelete(String userid, Integer num, Integer ducktype) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userid", userid);
		map.put("boardnum", num);
		map.put("ducktype", ducktype);
		sqlSession.getMapper(BoardMapper.class).userprodelete(map);
	}
	public int duckselect2(String duckid, Integer boardnum) { //id값과 dtype 2,3,5로 찾기
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userid",duckid);
		map.put("boardnum", boardnum);
		String select2 = sqlSession.getMapper(BoardMapper.class).duckselect2(map);
		int num = 0;
		if(select2 == null) {
			num = 0;
		}else {
			num = 1;
		}
		return num;
	}
	public int sel(String userid) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userid",userid);
		String select5 = sqlSession.getMapper(BoardMapper.class).sel(map);
		int xnum = 0;
		if(Integer.parseInt(select5) == 0) {
			xnum = 0;
		}else {
			xnum = 1;
		}
		return xnum;
	}
	public void userproaccept(String userid, Integer num) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userid", userid);
		map.put("boardnum", num);
		sqlSession.getMapper(BoardMapper.class).userproaccept(map);
	}
	public void duckupdate(String userid, Integer boardnum) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userid", userid);
		map.put("boardnum", boardnum);
		sqlSession.getMapper(BoardMapper.class).duckupdate(map);
	}
	public void nowpersonupdate(Integer boardnum) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("boardnum", boardnum);
		sqlSession.getMapper(BoardMapper.class).nowpersonupdate(boardnum);
	}
	public void suggest_refuse(String userid, Integer boardnum) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("boardnum", boardnum);
		map.put("userid", userid);
		sqlSession.getMapper(BoardMapper.class).suggest_refuse(map);
	}
	public void developdelete(String userid, Integer boardnum, Integer ducktype) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("boardnum", boardnum);
		map.put("userid", userid);
		map.put("ducktype", ducktype);
		sqlSession.getMapper(BoardMapper.class).developdelete(map);
	}
	public int waitlistcount(String userid) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userid", userid);
		return sqlSession.getMapper(BoardMapper.class).waitlistcount(map);
	}
	public List<Board> recmdpersonlist(String searchType, String searchContent, Integer pageNum, int limit,
			String userid) {
		Map<String,Object> map = new HashMap<String,Object>();
		int startrow = (pageNum -1) * limit;
		map.put("column", searchType);
		map.put("find", searchContent);
		map.put("startrow", startrow);
		map.put("limit", limit);
		map.put("userid", userid);
		return sqlSession.selectList(NS + "recmdpersonlist", map);
	}
	public int proceedlistcnt(String userid) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userid", userid);
		return sqlSession.getMapper(BoardMapper.class).proceedlistcnt(map);
	}
	public List<Board> proceedlist(String searchType, String searchContent, Integer pageNum, int limit, String userid) {
		Map<String,Object> map = new HashMap<String,Object>();
		int startrow = (pageNum -1) * limit;
		map.put("column", searchType);
		map.put("find", searchContent);
		map.put("startrow", startrow);
		map.put("limit", limit);
		map.put("userid", userid);
		return sqlSession.selectList(NS + "proceedlist", map);
	}
	public int completelistcnt(String searchType, String searchContent, String userid) {
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("column", searchType);
		map.put("find", searchContent);
		map.put("userid", userid);
		return sqlSession.selectOne(NS + "completelistcnt", map);
	}
	public List<Board> completelist(String searchType, String searchContent, Integer pageNum, int limit,
			String userid) {
		Map<String,Object> map = new HashMap<String,Object>();
		int startrow = (pageNum -1) * limit;
		map.put("column", searchType);
		map.put("find", searchContent);
		map.put("startrow", startrow);
		map.put("limit", limit);
		map.put("userid", userid);
		return sqlSession.selectList(NS + "completelist", map);
	}
	public int developcompletecnt(String searchType, String searchContent, String userid) {
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("column", searchType);
		map.put("find", searchContent);
		map.put("userid", userid);
		return sqlSession.selectOne(NS + "developcompletecnt", map);
	}
	public List<Board> developcomplete(String searchType, String searchContent, Integer pageNum, int limit,
			String userid) {
		Map<String,Object> map = new HashMap<String,Object>();
		int startrow = (pageNum -1) * limit;
		map.put("column", searchType);
		map.put("find", searchContent);
		map.put("startrow", startrow);
		map.put("limit", limit);
		map.put("userid", userid);
		return sqlSession.selectList(NS + "developcomplete", map);
	}
	public void complete(Integer boardnum) {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("boardnum", boardnum);
		sqlSession.getMapper(BoardMapper.class).complete(boardnum);
	}
	public void duck7update(Integer boardnum) {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("boardnum", boardnum);
		sqlSession.getMapper(BoardMapper.class).duck7update(boardnum);
	}
	public void duckdelete(String userid, Integer num) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("boardnum", num);
		map.put("userid", userid);
		sqlSession.getMapper(BoardMapper.class).duckdelete(map);
	}
	public int tenduck(String userid, Integer boardnum) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("boardnum", boardnum);
		map.put("userid", userid);
		return sqlSession.getMapper(BoardMapper.class).tenduck(map);
	}
	public int duck10cnt(String userid) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userid", userid);
		return sqlSession.getMapper(BoardMapper.class).duck10cnt(map);
	}
	public void add10duck(String userid, int boardnum) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userid", userid);
		map.put("boardnum", boardnum);
		sqlSession.getMapper(BoardMapper.class).add10duck(map);
	}
}