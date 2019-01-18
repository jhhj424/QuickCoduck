package logic;

import java.util.Date;

import org.hibernate.validator.constraints.NotEmpty;

public class Comment {
	private int num; //�⺻��
	private String userid; //�ۼ���-���̵�
	private int boardnum; //�Խ��ǹ�ȣ
	@NotEmpty(message="������ �ʼ� �Է»��� �Դϴ�.")
	private String content; //����
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