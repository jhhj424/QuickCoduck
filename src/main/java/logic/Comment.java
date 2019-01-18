package logic;

import java.util.Date;

import org.hibernate.validator.constraints.NotEmpty;

public class Comment {
	private int num; //기본값
	private String userid; //작성자-아이디
	private int boardnum; //게시판번호
	@NotEmpty(message="내용은 필수 입력사항 입니다.")
	private String content; //내용
	private Date regdate;
	private int recmd;
	private int ref;
	private int refstep;
	
	//getter setter toString
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getBoardnum() {
		return boardnum;
	}
	public void setBoardnum(int boardnum) {
		this.boardnum = boardnum;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getRecmd() {
		return recmd;
	}
	public void setRecmd(int recmd) {
		this.recmd = recmd;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getRefstep() {
		return refstep;
	}
	public void setRefstep(int refstep) {
		this.refstep = refstep;
	}
	@Override
	public String toString() {
		return "Comment [num=" + num + ", userid=" + userid + ", boardnum=" + boardnum + ", content=" + content
				+ ", regdate=" + regdate + ", recmd=" + recmd + ", ref=" + ref + ", refstep=" + refstep + "]";
	}
}