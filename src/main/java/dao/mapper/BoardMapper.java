package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Board;
import logic.User;
public interface BoardMapper  {

	@Select("select ifnull(max(boardnum),0) from board ")
	int maxNum();
	
	@Insert("insert into board (boardnum,userid,boardtype,subject,content,file1,pic, regdate, readcnt, usetech, price, schedule, maxperson) "
			+ " values(#{boardnum},#{userid},#{boardtype},#{subject},#{content},#{fileurl},#{pic}, now(), 0, #{usetech}, #{price}, #{schedule}, #{maxperson})")
	void insert(Board board);

	@Update("update board set readcnt = readcnt+1 where boardnum = #{boardnum}")
	void readcntadd(Map<String, Integer> map);

	@Update("update board set userid=#{userid}, subject=#{subject}, content=#{content}, file1=#{fileurl}, recmd=#{recmd}, usetech=#{usetech}, price=#{price}, schedule=#{schedule} where boardnum = #{boardnum}")
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
	
	@Insert("insert into duck (boardnum,userid,ducktype) values(#{boardnum},#{userid},#{ducktype})")
	void duckinsert(Map<String, Object> map);

	@Update("update board set duckcnt = duckcnt+1 where boardnum = #{boardnum}")
	void duckcntadd(Map<String, Integer> map);

	@Select("select userid from duck where boardnum=#{boardnum}")
	void duckidselect(Map<Integer, String> map);
	
	@Insert("insert into duck (userid,boardnum,ducktype) values(#{userid},#{boardnum},#{ducktype})")
	void matchduckinsert(Map<String, Object> map);

	@Delete("delete from duck where userid=#{userid} and boardnum=#{boardnum} and ducktype = #{ducktype}")
	void userprodelete(Map<String, Object> map);

	@Select("select * from duck where userid=#{userid} and boardnum=#{boardnum} and ducktype=3")
	String duckselect2(Map<String, Object> map);

	@Select("select count(*) from duck where userid=#{userid} and ducktype in (2,3,5)")
	String sel(Map<String, Object> map);

	@Update("update duck set ducktype=4 where userid=#{userid} and boardnum=#{boardnum} and ducktype=3")
	void userproaccept(Map<String, Object> map);
	
	@Update("update duck set ducktype=4 where userid=#{userid} and boardnum=#{boardnum} and ducktype=6")
	void duckupdate(Map<String, Object> map);

	@Update("update board set nowperson = nowperson+1 where boardnum=#{boardnum}")
	void nowpersonupdate(Integer boardnum);

	@Update("update duck set ducktype=8 where userid=#{userid} and boardnum=#{boardnum} and ducktype=6")
	void suggest_refuse(Map<String, Object> map);

	@Delete("delete from duck where userid=#{userid} and boardnum=#{boardnum} and ducktype = #{ducktype}")
	void developdelete(Map<String, Object> map);

	@Select("select count(*) from board where userid = #{userid} and maxperson != nowperson and boardtype=3")
	int waitlistcount(Map<String, Object> map);

	@Select("select count(*) from board where boardtype=3 and userid = #{userid} and maxperson = nowperson and boardnum in (select boardnum from duck where ducktype=4)")
	int proceedlistcnt(Map<String, Object> map);

	@Update("update board set boardtype = 4 where boardnum = #{boardnum}")
	void complete(Integer boardnum);

	@Update("update duck set ducktype = 7 where boardnum = #{boardnum}")
	void duck7update(Integer boardnum);
	
	@Delete("delete from duck where userid=#{userid} and boardnum=#{boardnum} and ducktype != 3")
	void duckdelete(Map<String, Object> map);

	@Select("select count(*) from duck where userid=#{userid} and boardnum=#{boardnum} and ducktype=10")
	int tenduck(Map<String, Object> map);

	@Select("select count(*) from duck where ducktype=10 and boardnum in (select boardnum from board where userid = #{userid} and boardtype in (3,4))")
	int duck10cnt(Map<String, Object> map);

	@Insert("insert into duck (userid,boardnum,ducktype) values(#{userid},#{boardnum},10)")
	void add10duck(Map<String, Object> map);
	
	@Select("select userid,pass,email,tel,birth,type,usetech,file1 fileurl,pic,creditnum,creditpass,rating,matching,maxcount,profess,proaction,prosatisfact,prodate,procommunicate from user where userid in (select DISTINCT userid from duck where boardnum = #{boardnum} and ducktype = 7)")
	List<User> completeuserlist(Map<String, Object> map);

	@Select("select count(*) from duck where userid=#{userid} and boardnum=#{boardnum} and ducktype=20")
	int twenduck(Map<String, Object> map);

	@Select("select count(*) from duck where ducktype=20 and userid = #{userid}")
	int duck20cnt(Map<String, Object> map);

	@Insert("insert into duck (userid,boardnum,ducktype) values(#{userid},#{boardnum},20)")
	void add20duck(Map<String, Object> map);
}
