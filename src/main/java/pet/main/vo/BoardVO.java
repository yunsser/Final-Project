package pet.main.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Component
public class BoardVO {
	private int idx;
	  private String name;
	  private String title;
	  private String content;
	  private String date;
	  private String pwd;
	  private int readnum ;
	  private int replyNum;
}
