package pet.main.vo;

import lombok.Data;

@Data
public class LikeDislikeVO {

	private int lnum;
	private String uid;
	private int hpnum;
	private int spnum;
	private int like;
	private int dislike;
	private int sumlike;
	private int sumdislike;
	
}
