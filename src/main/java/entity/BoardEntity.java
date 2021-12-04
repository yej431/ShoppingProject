package entity;

import java.util.Date;

public class BoardEntity {
	int id;
	String title;
	String userid;
	String content;
	Date regdate;
	int hit;
	String file;
	
	
	public BoardEntity(int id, String title, String userid, String content, Date regdate, int hit, String file) {
		super();
		this.id = id;
		this.title = title;
		this.userid = userid;
		this.content = content;
		this.regdate = regdate;
		this.hit = hit;
		this.file = file;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getFiles() {
		return file;
	}
	public void setFiles(String file) {
		this.file = file;
	}
	public BoardEntity() {
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "BoardEntity [id=" + id + ", title=" + title + ", userid=" + userid + ", content=" + content
				+ ", regdate=" + regdate + ", files=" + file + "]";
	}
	
	
}
