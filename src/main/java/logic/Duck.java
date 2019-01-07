package logic;

public class Duck {
	private String userid;
	private int boardnum;
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
	@Override
	public String toString() {
		return "Duck [userid=" + userid + ", boardnum=" + boardnum + "]";
	}
}
