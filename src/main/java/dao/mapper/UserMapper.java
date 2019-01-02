package dao.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Update;

import logic.User;

public interface UserMapper  {
	
	@Insert("insert into user (userid,pass,email,type) "
		 	+ " values(#{userid},#{pass},#{email},#{type})")
	void insert(User user);
	
	@Update("update user set username=#{userName}, phoneno=#{phoneNo}, postcode=#{postcode},"
			+ " address=#{address}, email=#{email}, birthday=#{birthDay} where userid = #{userId}")
	void update(User user);

	@Delete("delete from user where userid=#{userId}")
	void delete(Map<String, String> map);
}
