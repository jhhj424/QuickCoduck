package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.UserMapper;
import logic.Board;
import logic.Duck;
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
	public List<User> list(String userid) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("userid2", userid);
		return sqlSession.selectList(NS + "list", map);
	}
	//XML¼³Á¤
	public User select(String id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("userid", id);
		return sqlSession.selectOne(NS+"list",map);
	}
	public int idchk(String userid) {
		int result = sqlSession.getMapper(UserMapper.class).idchk(userid);
		return result;
	}
	public int creditchk(String creditnum) {
		int result = sqlSession.getMapper(UserMapper.class).creditchk(creditnum);
		return result;
	}
	public void supporting(String userid) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("userid", userid);
		sqlSession.getMapper(UserMapper.class).supporting(map);
	}
	public List<User> supporterlist(String userid, Integer matching, Integer boardnum, Integer ducktype) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userid", userid);
		map.put("matching", matching);
		map.put("boardnum", boardnum);
		map.put("ducktype", ducktype);
		return sqlSession.selectList(NS + "supporterlist", map);
	}
	public List<User> matchinguserList(String tech) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("usetech", tech);
		return sqlSession.selectList(NS + "list",map);
	}
	public void acceptmatching(String userid) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("userid", userid);
		sqlSession.getMapper(UserMapper.class).acceptmatching(map);
	}
	public void acceptducktype(String userid, Integer num) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userid", userid);
		map.put("boardnum", num);
		sqlSession.getMapper(UserMapper.class).acceptducktype(map);
	}
	public void failducktype(String duckid, Integer num) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userid", duckid);
		map.put("boardnum", num);
		sqlSession.getMapper(UserMapper.class).failducktype(map);
	}
	public int usercount() {
		return sqlSession.getMapper(UserMapper.class).usercount();
	}
	public void userproaccept(String userid) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userid", userid);
		sqlSession.getMapper(UserMapper.class).userproaccept(map);
	}
	public void usernullmatching(String userid) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userid", userid);
		sqlSession.getMapper(UserMapper.class).usernullmatching(map);
	}
	public void cntmaxcount(User dbuser) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userid", dbuser.getUserid());
		map.put("maxcount", dbuser.getMaxcount());
		sqlSession.getMapper(UserMapper.class).cntmaxcount(map);
		
	}
	
}
