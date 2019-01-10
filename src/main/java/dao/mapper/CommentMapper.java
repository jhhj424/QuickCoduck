package dao.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Comment;

public interface CommentMapper  {

	@Select("select ifnull(max(num),0) from recomment ")
	int maxNum();
	
	@Insert("insert into recomment (num,userid,boardnum,content) "
		 	+ " values(#{num},#{userid},#{boardnum},#{content})")
	void insert(Comment comment);
	
	@Delete("delete from recomment where num = #{num}")
	void delete(Integer num);	
	
	@Update("update recomment set content = #{content} where num = #{num}")
	void update(String content);
	
}
