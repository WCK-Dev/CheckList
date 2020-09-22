package egovframework.example.checklist.service;

import java.sql.Timestamp;

public class AnswerVO {
	
	private String a_checked;
	private Timestamp a_regdate;
	private String a_modifier;
	private Timestamp a_modifydate;
	private String u_id;
	private int c_seq;
	
	private String answer_id;
	
	public String getA_checked() {
		return a_checked;
	}
	public void setA_checked(String a_checked) {
		this.a_checked = a_checked;
	}
	public Timestamp getA_regdate() {
		return a_regdate;
	}
	public void setA_regdate(Timestamp a_regdate) {
		this.a_regdate = a_regdate;
	}
	public String getA_modifier() {
		return a_modifier;
	}
	public void setA_modifier(String a_modifier) {
		this.a_modifier = a_modifier;
	}
	public Timestamp getA_modifydate() {
		return a_modifydate;
	}
	public void setA_modifydate(Timestamp a_modifydate) {
		this.a_modifydate = a_modifydate;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public int getC_seq() {
		return c_seq;
	}
	public void setC_seq(int c_seq) {
		this.c_seq = c_seq;
	}
	
	
	
	public String getAnswer_id() {
		return answer_id;
	}
	public void setAnswer_id(String answer_id) {
		this.answer_id = answer_id;
	}
	
}
