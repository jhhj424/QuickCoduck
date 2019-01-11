package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.User;

public interface UserMapper  {
	
	@Insert("insert into user (userid,pass,email,type) "
		 	+ " values(#{userid},#{pass},#{email},#{type})")
	void insert(User user);
	
	@Update("update user set email = #{email}, tel = #{tel}, birth = #{birth}, "
			+ " usetech = #{usetech}, rating = #{rating}, businessnum = #{businessnum}, "
			+ " creditnum = #{creditnum}, creditpass = #{creditpass}, file1 = #{fileurl}, maxcount= #{maxcount} where userid = #{userid}")
	void update(User user);

	@Delete("delete from user where userid=#{userid}")
	void delete(Map<String, String> map);

	@Select("SELECT COUNT(*) FROM user WHERE userid = #{userid}")
	int idchk(String userid);
	
	@Select("select count(*) from user where creditnum = #{creditnum}")
	int creditchk(String creditnum);
	
	@Update("update user set matching = 1 where userid = #{userid}")
	void supporting(Map<String, String> map);

	@Update("update user set matching = 2 where userid = #{userid}")
	void acceptmatching(Map<String, String> map);

	@Update("update duck set ducktype = 3 where userid=#{userid} and boardnum=#{boardnum} and ducktype=2")
	void acceptducktype(Map<String, Object> map);

	@Update("update duck set ducktype = 5 where userid=#{userid} and boardnum=#{boardnum} and ducktype=2")
	void failducktype(Map<String, Object> map);
}
