package dao.mapper;

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
			+ " creditnum = #{creditnum}, file1 = #{fileurl} where userid = #{userid}")
	void update(User user);

	@Delete("delete from user where userid=#{userid}")
	void delete(Map<String, String> map);

	@Select("SELECT COUNT(*) FROM user WHERE userid = #{userid}")
	int idchk(String userid);
}
