package com.tech.blog.entities;

public class Like {
	private int lid;
	private int uid;
	private int pid;
	
	public Like(int lid, int uid, int pid) {
		super();
		this.lid = lid;
		this.uid = uid;
		this.pid = pid;
	}

	public Like() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getLid() {
		return lid;
	}

	public void setLid(int lid) {
		this.lid = lid;
	}

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}
	
	
}
