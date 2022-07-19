package pet.main.vo;

import java.sql.Date;

import lombok.Builder;
import lombok.Data;

@Data
public class UserVO {
	private int unum;
	private String uid;
	private String upw;
	private String name;
	private int birth;
	private String phone;
	private String email;
	private String zipcode;
	private String addr;
	private String detailAddr;
	private String pet;
	private String petsize;
	private String role;
	private java.sql.Date createDate;
	private String provider;
	private String providerId;
	
	// 인풋으로 값들이 들어오지 않아도 에러가 나지 않도록 생성자 오버로딩.

	public UserVO() {}
	
	@Builder
	public UserVO(int unum, String uid, String upw, String name, int birth, String phone, String email, String zipcode,
			String addr, String detailAddr, String pet, String petsize, String role, Date createDate, String provider, String providerId) {

		this.unum = unum;
		this.uid = uid;
		this.upw = upw;
		this.name = name;
		this.birth = birth;
		this.phone = phone;
		this.email = email;
		this.zipcode = zipcode;
		this.addr = addr;
		this.detailAddr = detailAddr;
		this.pet = pet;
		this.petsize = petsize;
		this.role = role;
		this.createDate = createDate;
		this.provider = provider;
		this.providerId = providerId;
	}
	
	
	
}
