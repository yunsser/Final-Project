package pet.main.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Component
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
