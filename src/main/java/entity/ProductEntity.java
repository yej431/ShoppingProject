package entity;

public class ProductEntity {

	int productId;
	String productName;
	String mainCategory;
	String subCategory;
	int price;
	int quantity;
	String active;
	String file;
	int cnt;
	
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getMainCategory() {
		return mainCategory;
	}
	public void setMainCategory(String mainCategory) {
		this.mainCategory = mainCategory;
	}
	public String getSubCategory() {
		return subCategory;
	}
	public void setSubCategory(String subCategory) {
		this.subCategory = subCategory;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getActive() {
		return active;
	}
	public void setActive(String active) {
		this.active = active;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}		
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public ProductEntity() {
		// TODO Auto-generated constructor stub
	}
	public ProductEntity(String productName, int cnt) {
		super();
		this.productName = productName;
		this.cnt = cnt;
	}
	public ProductEntity(int productId, String productName, String mainCategory, String subCategory, int price,
			int quantity, String active, String file) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.mainCategory = mainCategory;
		this.subCategory = subCategory;
		this.price = price;
		this.quantity = quantity;
		this.active = active;
		this.file = file;
	}
}
