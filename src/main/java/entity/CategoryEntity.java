package entity;

public class CategoryEntity {

	int id;
	String main;
	String sub1;
	String sub2;
	String sub3;
	String sub4;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getMain() {
		return main;
	}
	public void setMain(String main) {
		this.main = main;
	}
	public String getSub1() {
		return sub1;
	}
	public void setSub1(String sub1) {
		this.sub1 = sub1;
	}
	public String getSub2() {
		return sub2;
	}
	public void setSub2(String sub2) {
		this.sub2 = sub2;
	}
	public String getSub3() {
		return sub3;
	}
	public void setSub3(String sub3) {
		this.sub3 = sub3;
	}
	public String getSub4() {
		return sub4;
	}
	public void setSub4(String sub4) {
		this.sub4 = sub4;
	}
	
	public CategoryEntity() {
		// TODO Auto-generated constructor stub
	}
	
	public CategoryEntity(int id, String main, String sub1, String sub2, String sub3, String sub4) {
		super();
		this.id = id;
		this.main = main;
		this.sub1 = sub1;
		this.sub2 = sub2;
		this.sub3 = sub3;
		this.sub4 = sub4;
	}
}
