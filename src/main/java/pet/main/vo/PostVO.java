package pet.main.vo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.Data;


@Data
public class PostVO {
	private int num;
	private String category;
	private String title;
	private String author;
	private String summernote;
	private Date date;
	private int count;
	
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
