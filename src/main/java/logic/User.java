package logic;

import java.util.Date;

import javax.validation.constraints.Past;
import javax.validation.constraints.Size;

public class User {
	@Size(min=3, max=10, message="아이디는 3자이상 10자 이하로 입력하세요")
	private String userid;
	@Size(min=4, max=12, message="비밀번호는 4자이상 12자 이하로 입력하세요")
	private String pass;
	private String email;
	private String tel;
	@Past(message="생일은 과거 날짜만 가능합니다.")
	private Date birth;
	private String type;
	private String businessnum;
	private String usertech;
	private String creditnum;
	private String creditpass;
	private Integer rating;
	private Integer matching;

	//getter,setter,toString
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getemail() {
		return email;
	}
	public void setemail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getBusinessnum() {
		return businessnum;
	}
	public void setBusinessnum(String businessnum) {
		this.businessnum = businessnum;
	}
	public String getUsertech() {
		return usertech;
	}
	public void setUsertech(String usertech) {
		this.usertech = usertech;
	}
	public String getCreditnum() {
		return creditnum;
	}
	public void setCreditnum(String creditnum) {
		this.creditnum = creditnum;
	}
	public String getCreditpass() {
		return creditpass;
	}
	public void setCreditpass(String creditpass) {
		this.creditpass = creditpass;
	}
	public Integer getRating() {
		return rating;
	}
	public void setRating(Integer rating) {
		this.rating = rating;
	}
	public Integer getMatching() {
		return matching;
	}
	public void setMatching(Integer matching) {
		this.matching = matching;
	}
	@Override
	public String toString() {
		return "User [userid=" + userid + ", pass=" + pass + ", email=" + email + ", tel=" + tel + ", birth="
				+ birth + ", type=" + type + ", businessnum=" + businessnum + ", usertech=" + usertech + ", creditnum="
				+ creditnum + ", creditpass=" + creditpass + ", rating=" + rating + ", matching=" + matching + "]";
	}
	
}
