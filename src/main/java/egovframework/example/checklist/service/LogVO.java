package egovframework.example.checklist.service;

import java.sql.Timestamp;

public class LogVO {
	
	private int l_seq;
	private Timestamp l_readdate;
	private String u_id;
	private int b_seq;
	
	public int getL_seq() {
		return l_seq;
	}
	public void setL_seq(int l_seq) {
		this.l_seq = l_seq;
	}
	public Timestamp getL_readdate() {
		return l_readdate;
	}
	public void setL_readdate(Timestamp l_readdate) {
		this.l_readdate = l_readdate;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public int getB_seq() {
		return b_seq;
	}
	public void setB_seq(int b_seq) {
		this.b_seq = b_seq;
	}
}
