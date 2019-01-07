package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import logic.Duck;

@Repository
public class DuckDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.BoardMapper.";
	
	public int count(String searchType, String searchContent, Integer type) {
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("column", searchType);
		map.put("find", searchContent);
		map.put("type", type);
		return sqlSession.selectOne(NS + "count", map);
	}

	public List<Duck> list(String searchType, String searchContent, Integer pageNum, int limit, Integer type) {
		Map<String , Object> map = new HashMap<String, Object>();
		int startrow = (pageNum -1) * limit;
		map.put("column", searchType);
		map.put("find", searchContent);
		map.put("startrow", startrow);
		map.put("limit", limit);
		map.put("type", type);
		return sqlSession.selectList(NS + "select", map);
	}
	
	
}
