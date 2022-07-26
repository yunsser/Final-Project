package pet.main.vo;

import lombok.Data;

@Data
public class ReplyVO {
	private int idx;
	private int boardIdx;
	private String nickname;
	//@DateTimeFormat(pattern = "yyyy-MM-dd")
	//private Date wdate;
	private String date;
	private String content;
	private int depth;
	private int screenOrder;
}