package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import dao.mapper.BoardMapper;
import logic.Board;

@Repository
public class BoardDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.BoardMapper.";
	
	public Board select(Integer num) {
		Map<String, Integer> map= new HashMap<String, Integer>();
		map.put("num", num);
		return sqlSession.selectOne(NS + "select",map);
	}
	public int count(String searchType, String searchContent) {
		Map<String, String> map= new HashMap<String, String>();
		map.put("column", searchType);
		map.put("find", searchContent);
		return sqlSession.selectOne(NS + "count", map);
	}
	public List<Board> list(String searchType, String searchContent, Integer pageNum, int limit) {
		// sql = " order by ref desc, refstep asc limit :startrow, :limit";
		Map<String , Object> map = new HashMap<String, Object>();
		int startrow = (pageNum -1) * limit;
		map.put("column", searchType);
		map.put("find", searchContent);
		map.put("startrow", startrow);
		map.put("limit", limit);
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
		map.put("num", num);
		sqlSession.getMapper(BoardMapper.class).readcntadd(map);
	}
	public void refstep(Board board) {
		Map<String , Integer> map = new HashMap<String, Integer>();
		map.put("ref", board.getRef());
		map.put("refstep", board.getRefstep());
		sqlSession.getMapper(BoardMapper.class).rsupdate(map);
	}
	public void update(Board board) {
		sqlSession.getMapper(BoardMapper.class).update(board);
	}
	public void delete(int num) {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("num", num);
		sqlSession.getMapper(BoardMapper.class).delete(map);
	}
}