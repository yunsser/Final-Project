package pet.main.vo;

import lombok.Data;

@Data
public class ReplyVO {
	private int idx;
	private int boardIdx;
	private String nickname;
	private String name; // 이름
	//@DateTimeFormat(pattern = "yyyy-MM-dd")
	//private Date wdate;
	private String date;
	private String content;
	private int depth;
	private int screenOrder;
	private int parent;
	private int childCnt;
}