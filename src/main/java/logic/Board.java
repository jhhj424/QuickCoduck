package logic;

import java.util.Date;

import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.Range;
import org.springframework.web.multipart.MultipartFile;

public class Board {
	private int boardnum; // �⺻��
	@NotEmpty(message = "�ۼ��ڴ� �ʼ� �Է»��� �Դϴ�.")
	private String userid; // �ۼ���-���̵�
	private int boardtype; // �Խ���Ÿ��
	@NotEmpty(message = "������ �ʼ� �Է»��� �Դϴ�.")
	private String subject; // ����
	@NotEmpty(message = "������ �ʼ� �Է»��� �Դϴ�.")
	private String content; // ����
	private MultipartFile file1; // ÷������
	private String fileurl; // ���� �ּ�
	private String pic; // ����
	private Date regdate; // �ۼ���
	private int readcnt; // ��ȸ��
	private int recmd; // ��õ��
	private String usetech; // �����
//	@NotEmpty(message = "������ �ʼ� �Է»��� �Դϴ�.")
	private String price; // ����
//	@Range(min=1,max=365,message="�ּ� 1�� ~ �ִ� 365�� ���� ���� �����մϴ�.")
	private int schedule; // �Ⱓ (��)=
	private int duckcnt; // �� ���� Ƚ��
	private int maxperson;// ���� �ο�����
	

	public int getMaxperson() {
		return maxperson;
	}

	public void setMaxperson(int maxperson) {
		this.maxperson = maxperson;
	}

	public int getBoardnum() {
		return boardnum;
	}

	public void setBoardnum(int boardnum) {
		this.boardnum = boardnum;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public int getBoardtype() {
		return boardtype;
	}

	public void setBoardtype(int type) {
		this.boardtype = type;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public MultipartFile getFile1() {
		return file1;
	}

	public void setFile1(MultipartFile file1) {
		this.file1 = file1;
	}

	public void setFile1(String file1) {
		this.fileurl = file1;
	}

	public String getFileurl() {
		return fileurl;
	}

	public void setFileurl(String fileurl) {
		this.fileurl = fileurl;
	}

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public int getReadcnt() {
		return readcnt;
	}

	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}

	public int getRecmd() {
		return recmd;
	}

	public void setRecmd(int recmd) {
		this.recmd = recmd;
	}

	public String getUsetech() {
		return usetech;
	}

	public void setUsetech(String usetech) {
		this.usetech = usetech;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public int getSchedule() {
		return schedule;
	}

	public void setSchedule(int schedule) {
		this.schedule = schedule;
	}

	public int getDuckcnt() {
		return duckcnt;
	}

	public void setDuckcnt(int duckcnt) {
		this.duckcnt = duckcnt;
	}

	@Override
	public String toString() {
		return "Board [boardnum=" + boardnum + ", userid=" + userid + ", boardtype=" + boardtype + ", subject="
				+ subject + ", content=" + content + ", file1=" + file1 + ", fileurl=" + fileurl + ", pic=" + pic
				+ ", regdate=" + regdate + ", readcnt=" + readcnt + ", recmd=" + recmd + ", usetech=" + usetech
				+ ", price=" + price + ", schedule=" + schedule + ", duckcnt=" + duckcnt + ", maxperson=" + maxperson
				+ "]";
	}

}