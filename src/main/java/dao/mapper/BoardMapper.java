package dao.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Board;
public interface BoardMapper  {

	@Select("select ifnull(max(boardnum),0) from board ")
	int maxNum();
	
	@Insert("insert into board (boardnum,userid,boardtype,subject,content,file1,pic, regdate, readcnt, usetech, price, schedule) "
			+ " values(#{boardnum},#{userid},#{boardtype},#{subject},#{content},#{fileurl},#{pic}, now(), 0, #{usetech}, #{price}, #{schedule})")
	void insert(Board board);

	@Update("update board set readcnt = readcnt+1 where boardnum = #{boardnum}")
	void readcntadd(Map<String, Integer> map);

	@Update("update board set userid=#{userid}, subject=#{subject}, content=#{content}, file1=#{fileurl}, recmd=#{recmd} where boardnum = #{boardnum}")
	void update(Board board);

	@Update("update board set refstep = refstep+1 where ref= #{ref} and refstep > #{refstep}")
	void rsupdate(Map<String, Integer> map);

	@Delete("delete from board where boardnum=#{boardnum}")
	void delete(Map<String, Integer> map);
	
	@Insert("insert into recmd (boardnum,userid) values(#{boardnum},#{userid})")
	void recmdinsert(Map<String, Object> map);
	
	@Select("select boardnum from recmd where userid=#{userid} and boardnum=#{boardnum}")
	String recmdselect(Map<String, Object> map);

	@Select("select boardnum from duck where userid=#{userid} and boardnum=#{boardnum} and ducktype=#{ducktype}")
	String duckselect(Map<String, Object> map);

	@Insert("insert into duck (boardnum,userid,ducktype) values(#{boardnum},#{userid},1)")
	void duckinsert(Map<String, Object> map);

	@Update("update board set duckcnt = duckcnt+1 where boardnum = #{boardnum}")
	void duckcntadd(Map<String, Integer> map);

}
