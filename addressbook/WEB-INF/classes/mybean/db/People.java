package mybean.db;

public class People {
	private int idx; 
	private int group_idx;

	private String image;
	private String name;
	private String phone;
	private String email;
	private String affiliation;
	private String department;
	private String duty;
	private String birthday;
	private String address;
	private String homepage;
	private String sns;
	private String id;
	private String memo;
	
	
	// 선언된 멤버에 대한 getter / setter 메소드
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getGroup_idx() {
		return group_idx;
	}
	public void setGroup_idx(int group_idx) {
		this.group_idx = group_idx;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAffiliation() {
		return affiliation;
	}
	public void setAffiliation(String affiliation) {
		this.affiliation = affiliation;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getDuty() {
		return duty;
	}
	public void setDuty(String duty) {
		this.duty = duty;
	}
	public String getBirthday() {	//birthday가 입력되지 않은 0001-01-01일 경우 blank로 반환
		if(birthday.equals("0001-01-01"))
			return "";
		else
			return birthday;
	}
	public void setBirthday(String birthday) {	//birthday가 blank가 들어올 경우 date 형식인 0000-01-01으로 저장
		if(birthday.equals("")){
			this.birthday = "0000-01-01";
		}
		else{
			this.birthday = birthday;
		}
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getHomepage() {
		return homepage;
	}
	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}
	public String getSns() {
		return sns;
	}
	public void setSns(String sns) {
		this.sns = sns;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}


}
