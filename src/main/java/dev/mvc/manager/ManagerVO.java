package dev.mvc.manager;

public class ManagerVO {
	private int managerno;
	private String id;
	private String pw;
	private String mname;
	private String mdate;
	private int grade;
	
	public int getManagerno() {
		return managerno;
	}
	public void setManagerno(int managerno) {
		this.managerno = managerno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getMdate() {
		return mdate;
	}
	public void setMdate(String mdate) {
		this.mdate = mdate;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	
	@Override
	public String toString() {
		return "ManagerVO [managerno=" + managerno + ", id=" + id + ", pw=" + pw + ", mname=" + mname + ", mdate="
				+ mdate + ", grade=" + grade + "]";
	}
	
	
	

}
