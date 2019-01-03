package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.UserMapper;
import logic.User;


@Repository //(°´Ã¼»ý¼º : DB¶û ¿¬°áµÈ °´Ã¼ÀÓ)
public class UserDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.UserMapper.";
	
	public void insert(User user) {
		sqlSession.getMapper(UserMapper.class).insert(user);
	}
	public User userSelect(User user) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("userid", user.getUserid());
		return sqlSession.selectOne(NS + "list",map);
	}
	public User useridSelect(String id) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("userid", id);
		return sqlSession.selectOne(NS + "list", map);
	}
	public void userUpdate(User user) {
		sqlSession.getMapper(UserMapper.class).update(user);
	}
	public void userDelete(String id) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("userid", id);
		sqlSession.getMapper(UserMapper.class).delete(map);
	}
	public List<User> userList() {
		return sqlSession.selectList(NS + "list");
	}
	public List<User> list(String[] idchks) {
		/*
		String ids = "";
		for(int i=0; i<idchks.length; i++) {
			ids += "'" + idchks[i] + ((i==idchks.length-1)?"'":"',");
		}
		*/
		Map<String,String[]> map = new HashMap<String,String[]>();
		map.put("ids", idchks);
		return sqlSession.selectList(NS + "list", map);
	}
	//XML¼³Á¤
	public User select(String id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("userid", id);
		return sqlSession.selectOne(NS+"list",map);
	}
}
