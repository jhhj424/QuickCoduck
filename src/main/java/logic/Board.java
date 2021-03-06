package logic;

import java.util.Date;

import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.Range;
import org.springframework.web.multipart.MultipartFile;

public class Board {
	private int boardnum; // 기본값
	@NotEmpty(message = "작성자는 필수 입력사항 입니다.")
	private String userid; // 작성자-아이디
	private int boardtype; // 게시판타입
	@NotEmpty(message = "제목은 필수 입력사항 입니다.")
	private String subject; // 제목
	@NotEmpty(message = "내용은 필수 입력사항 입니다.")
	private String content; // 내용
	private MultipartFile file1; // 첨부파일
	private String fileurl; // 파일 주소
	private String pic; // 사진
	private Date regdate; // 작성일
	private int readcnt; // 조회수
	private int recmd; // 추천수
	private String usetech; // 사용기술
//	@NotEmpty(message = "가격은 필수 입력사항 입니다.")
	private String price; // 가격
//	@Range(min=1,max=365,message="최소 1일 ~ 최대 365일 까지 지정 가능합니다.")
	private int schedule; // 기간 (일)=
	private int duckcnt; // 덕 당한 횟수
	private int maxperson;// 공고 인원제한
	private int nowperson;// 공고 현재인원
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
	public void setBoardtype(int boardtype) {
		this.boardtype = boardtype;
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
	public int getMaxperson() {
		return maxperson;
	}
	public void setMaxperson(int maxperson) {
		this.maxperson = maxperson;
	}
	public int getNowperson() {
		return nowperson;
	}
	public void setNowperson(int nowperson) {
		this.nowperson = nowperson;
	}
	@Override
	public String toString() {
		return "Board [boardnum=" + boardnum + ", userid=" + userid + ", boardtype=" + boardtype + ", subject="
				+ subject + ", content=" + content + ", file1=" + file1 + ", fileurl=" + fileurl + ", pic=" + pic
				+ ", regdate=" + regdate + ", readcnt=" + readcnt + ", recmd=" + recmd + ", usetech=" + usetech
				+ ", price=" + price + ", schedule=" + schedule + ", duckcnt=" + duckcnt + ", maxperson=" + maxperson
				+ ", nowperson=" + nowperson + "]";
	}	
}