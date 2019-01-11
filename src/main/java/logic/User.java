package logic;

import java.util.Date;

import javax.validation.constraints.Past;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

public class User {
	@Size(min = 3, max = 10, message = "���̵�� 3���̻� 10�� ���Ϸ� �Է��ϼ���")
	private String userid;
	@Size(min = 4, max = 12, message = "��й�ȣ�� 4���̻� 12�� ���Ϸ� �Է��ϼ���")
	private String pass;
	private String email;
	private String tel;
	@Past(message = "������ ���� ��¥�� �����մϴ�.")
	private Date birth;
	private int type;
	private String businessnum;
	private String usetech;
	private String creditnum;
	private String creditpass;
	private Integer rating;
	private Integer matching;
	private MultipartFile file1;// ÷������
	private String fileurl;// �����ּ�
	private String pic;// ����
	private int maxcount;
	// getter,setter,toString
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
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
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getBusinessnum() {
		return businessnum;
	}
	public void setBusinessnum(String businessnum) {
		this.businessnum = businessnum;
	}
	public String getUsetech() {
		return usetech;
	}
	public void setUsetech(String usetech) {
		this.usetech = usetech;
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
	public int getMaxcount() {
		return maxcount;
	}
	public void setMaxcount(int maxcount) {
		this.maxcount = maxcount;
	}
	@Override
	public String toString() {
		return "User [userid=" + userid + ", pass=" + pass + ", email=" + email + ", tel=" + tel + ", birth=" + birth
				+ ", type=" + type + ", businessnum=" + businessnum + ", usetech=" + usetech + ", creditnum="
				+ creditnum + ", creditpass=" + creditpass + ", rating=" + rating + ", matching=" + matching
				+ ", file1=" + file1 + ", fileurl=" + fileurl + ", pic=" + pic + ", maxcount=" + maxcount + "]";
	}
	

}
