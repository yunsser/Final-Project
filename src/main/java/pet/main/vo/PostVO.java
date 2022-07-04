package pet.main.vo;

import java.util.Date;

import lombok.Data;


@Data
public class PostVO {
	int num;
	String category;
	String title;
	String author;
	String summernote;
	Date date;
	int count;
}
