package pet.main.vo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.Data;


@Data
public class PostVO {
	private int num;
	private String sido;
	private String gugun;
	private String title;
	private String author; // id
	private String name; // 이름
	private String summernote;
	private Date date;
	private int viewCnt;
	private int hpnum;
	private int sumlike;
	private int sumdislike;
	
	
	public List<AttachVO> attach = new ArrayList<>();
	
	public PostVO() {}

	public PostVO(int num_no) { // 글번호만 있어도 객체생성 가능
		this.setNum(num_no);
	}
	
	public List<AttachVO> getNotice_attach() {
		return attach;
	}

	public void setNotice_attach(List<AttachVO> attach) {
		this.attach = attach;
	}
}
