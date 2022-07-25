package pet.main.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pet.main.mapper.ReviewMapper;
import pet.main.vo.ReviewVO;

@Repository
public class ReviewDAO {
	
	@Autowired
	ReviewMapper Mapper;
	
	public List<ReviewVO> getReviewList(String mgtno){
		return Mapper.getReviewList(mgtno);
	}
	
	public boolean addReview(ReviewVO review) {
		return Mapper.addReview(review)>0;
	}

	public int getReviewTotal(String mgtno) {
		return Mapper.getReviewTotal(mgtno);
	}
	
	public boolean deleteReview(int rv_num) {
		return Mapper.deleteReview(rv_num)>0;
	}

	public boolean updateReview(ReviewVO review) {
		return Mapper.updateReview(review)>0;
	}
}
