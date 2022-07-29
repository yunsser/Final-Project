package pet.main.vo;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class ShareFcVO {
	
	private int sh_num;
	private String sh_name; // id
	private String sh_nickname; // 이름
	private String sh_title;
	private String sh_content;
	private java.sql.Date sh_date;
	private String sh_facSido; // 이용시설 시도
	private String sh_facGugun; // 이용시설 구군
	private String sh_facNM; // 이용시설 이름
	private String sh_facRoadAdd; // 이용시설 도로명주소
	private String sh_facAdd; // 이용시설 주소
	private String sh_facTel; // 이용시설 전화번호
	private String sh_facCate; // 이용시설 카테고리(식당/카페/숙박)
	private int sh_viewCnt; // 조회수
	private int spnum;
	private int sumlike;
	private int sumdislike;
	
	public List<Sf_attachVO> attach = new ArrayList<>();
	
	public ShareFcVO() {}
	
	public ShareFcVO(int num) {
		this.setSh_num(num);
	}

}
