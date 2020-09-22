package egovframework.example.checklist.service;

import java.sql.Timestamp;

public class BoardVO {

	private int b_seq;
	private String b_title;
	private String b_comment;
	private Timestamp b_regdate;
	private String b_writer;
	private String b_topYN;
	private String b_modifier;
	private Timestamp b_modifydate;
	
	private String c_name;
	
	public int getB_seq() {
		return b_seq;
	}
	public void setB_seq(int b_seq) {
		this.b_seq = b_seq;
	}
	public String getB_title() {
		return b_title;
	}
	public void setB_title(String b_title) {
		this.b_title = b_title;
	}
	public String getB_comment() {
		return b_comment;
	}
	public void setB_comment(String b_comment) {
		this.b_comment = b_comment;
	}
	public Timestamp getB_regdate() {
		return b_regdate;
	}
	public void setB_regdate(Timestamp b_regdate) {
		this.b_regdate = b_regdate;
	}
	public String getB_writer() {
		return b_writer;
	}
	public void setB_writer(String b_writer) {
		this.b_writer = b_writer;
	}
	public String getB_topYN() {
		return b_topYN;
	}
	public void setB_topYN(String b_topYN) {
		this.b_topYN = b_topYN;
	}
	public String getB_modifier() {
		return b_modifier;
	}
	public void setB_modifier(String b_modifier) {
		this.b_modifier = b_modifier;
	}
	public Timestamp getB_modifydate() {
		return b_modifydate;
	}
	public void setB_modifydate(Timestamp b_modifydate) {
		this.b_modifydate = b_modifydate;
	}
	
	public String getC_name() {
		return c_name;
	}
	public void setC_name(String c_name) {
		this.c_name = c_name;
	}
	
}
