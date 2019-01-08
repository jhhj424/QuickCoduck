package logic;

public class Duck {
	private String userid;
	private int boardnum;
	private int duckcnt;
	
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
	public int getDuckcnt() {
		return duckcnt;
	}
	public void setDuckcnt(int duckcnt) {
		this.duckcnt = duckcnt;
	}
	@Override
	public String toString() {
		return "Duck [userid=" + userid + ", boardnum=" + boardnum + ", duckcnt=" + duckcnt + "]";
	}
	
}
