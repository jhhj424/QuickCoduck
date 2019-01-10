package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.CommentMapper;
import logic.Board;
import logic.Comment;

@Repository
public class CommentDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.CommentMapper.";

	public void insert(Comment comment) {
		sqlSession.getMapper(CommentMapper.class).insert(comment);
	}

	public int maxNum() {
		return sqlSession.getMapper(CommentMapper.class).maxNum();
	}

	public int count(Integer boardnum) {
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("boardnum", boardnum);
		return sqlSession.selectOne(NS + "count", map);
	}

	public List<Comment> list(Integer boardnum) {
		Map<String , Object> map = new HashMap<String, Object>();
		map.put("boardnum", boardnum);
		return sqlSession.selectList(NS + "list", map);
	}

	public void update(int num, String content) {
		sqlSession.getMapper(CommentMapper.class).update(content);
	}
	public void delete(Integer num) {
		sqlSession.getMapper(CommentMapper.class).delete(num);
	}

	public int refnum() {		
		String refnum = sqlSession.getMapper(CommentMapper.class).refnum();
		int rnum = 0;
		if(refnum==null) {
			rnum = 1;
		}else {
			rnum = Integer.parseInt(refnum) + 1;
		}
		return rnum;
	}

	public Comment select(Integer num) {
		Map<String , Object> map = new HashMap<String, Object>();
		map.put("num", num);
		return sqlSession.selectOne(NS + "select", map);
	}

}
