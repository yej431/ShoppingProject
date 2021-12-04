package entity;

import java.util.Date;

public class CommentEntity {

	private int id;
	private int boardId;
	private String userId;
	private Date commentDate;
	private String commentTitle;
	public String getCommentTitle() {
		return commentTitle;
	}
	public void setCommentTitle(String commentTitle) {
		this.commentTitle = commentTitle;
	}
	private String commentText;
	private int commentAvailable;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getBoardId() {
		return boardId;
	}
	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Date getCommentDate() {
		return commentDate;
	}
	public void setCommentDate(Date commentDate) {
		this.commentDate = commentDate;
	}
	public String getCommentText() {
		return commentText;
	}
	public void setCommentText(String commentText) {
		this.commentText = commentText;
	}
	public int getCommentAvailable() {
		return commentAvailable;
	}
	public void setCommentAvailable(int commentAvailable) {
		this.commentAvailable = commentAvailable;
	}
	public CommentEntity() {
		// TODO Auto-generated constructor stub
	}
	public CommentEntity(int id, int boardId, String userId, Date commentDate, String commentTitle, String commentText,
			int commentAvailable) {
		super();
		this.id = id;
		this.boardId = boardId;
		this.userId = userId;
		this.commentDate = commentDate;
		this.commentTitle = commentTitle;
		this.commentText = commentText;
		this.commentAvailable = commentAvailable;
	}
		
}
