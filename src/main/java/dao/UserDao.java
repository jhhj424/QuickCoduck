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


@Repository //(객체생성 : DB랑 연결된 객체임)
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
	//XML설정
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
	public void usermatchingupdate(String userid) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userid", userid);
		sqlSession.getMapper(UserMapper.class).usermatchingupdate(map);
	}
	public int personcnt(String userid) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("userid", userid);
		return sqlSession.getMapper(UserMapper.class).personcnt(map);
	}
	public List<User> recmdpersonlist(Integer pageNum, int limit, String userid) {
		Map<String , Object> map = new HashMap<String, Object>();
		int startrow = (pageNum -1) * limit;
		map.put("startrow", startrow);
		map.put("limit", limit);
		System.out.println("로그인유저:"+userid);
		map.put("userid", userid);
		return sqlSession.selectList(NS + "recmdpersonlist", map);
	}

	public void setrating(String userid, float profess, float proaction, float prosatisfact, float prodate,
			float procommunicate,float rating) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userid", userid);
		map.put("profess", profess);
		map.put("proaction", proaction);
		map.put("prosatisfact", prosatisfact);
		map.put("prodate", prodate);
		map.put("procommunicate", procommunicate);
		map.put("rating", rating);
		sqlSession.getMapper(UserMapper.class).setrating(map);
	}

	public void matching(String userid, Integer matching) {
		Map<String , Object> map = new HashMap<String, Object>();
		map.put("userid", userid);
		map.put("matching",matching);
		sqlSession.getMapper(UserMapper.class).matching(map);
		
	}
	public String usertotalcnt() {
		Map<String,Object> map = new HashMap<String,Object>();
		String col = sqlSession.selectOne(NS + "propro3", map);
		return col;
	}
	public List<User> alluser() {
		Map<String,Object> map = new HashMap<String,Object>();
		return sqlSession.selectList(NS + "alluser", map);
	}
	public List<User> allclient() {
		Map<String,Object> map = new HashMap<String,Object>();
		return sqlSession.selectList(NS + "allclient", map);
	}
	public List<String> user_tech() {
		Map<String,Object> map = new HashMap<String,Object>();
		return sqlSession.selectList(NS + "user_tech", map);
	}
	public List<String> client_tech() {
		Map<String,Object> map = new HashMap<String,Object>();
		return sqlSession.selectList(NS + "client_tech", map);
	}
	public List<String> all_tech() {
		Map<String,Object> map = new HashMap<String,Object>();
		return sqlSession.selectList(NS + "all_tech", map);
	}
	
}
