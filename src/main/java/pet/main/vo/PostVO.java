package pet.main.vo;

import java.util.Date;

import lombok.Data;


@Data
public class PostVO {
	int id;
	String subject;
	String cintent;
	Date regDate;
}
