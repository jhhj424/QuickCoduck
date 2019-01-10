package logic;

public class Duck {
	private String userid;
	private int boardnum;
	private int ducktype;
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
	public int getDucktype() {
		return ducktype;
	}
	public void setDucktype(int ducktype) {
		this.ducktype = ducktype;
	}
	@Override
	public String toString() {
		return "Duck [userid=" + userid + ", boardnum=" + boardnum + ", ducktype=" + ducktype + "]";
	}
}
