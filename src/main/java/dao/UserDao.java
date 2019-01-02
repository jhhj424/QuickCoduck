package dao;

import java.util.ArrayList;
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

import dao.mapper.UserMapper;
import logic.User;


@Repository //(按眉积己 : DB尔 楷搬等 按眉烙)
public class UserDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.UserMapper.";
	
	public void insert(User user) {
		sqlSession.getMapper(UserMapper.class).insert(user);
	}
	public User userSelect(User user) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("userId", user.getUserid());
		return sqlSession.selectOne(NS + "list",map);
	}
	public User useridSelect(String id) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("userId", id);
		return sqlSession.selectOne(NS + "list", map);
	}
	public void userUpdate(User user) {
		sqlSession.getMapper(UserMapper.class).update(user);
	}
	public void userDelete(String id) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("userId", id);
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
}
