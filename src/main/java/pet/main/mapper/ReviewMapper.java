package pet.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import pet.main.vo.ReviewVO;

@Mapper
public interface ReviewMapper {
	
	List<ReviewVO> getReviewList(String mgtno);
	int addReview(ReviewVO review);
	int getReviewTotal(String mgtno);
	int deleteReview(int rv_num);
	int updateReview(ReviewVO review);

}
