package pet.main.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import pet.main.vo.CodeVO;
import pet.main.vo.LikeDislikeVO;
import pet.main.vo.Sf_attachVO;
import pet.main.vo.ShareFcVO;

@Mapper
public interface ShareFcMapper {
	
	List<ShareFcVO> ShareFcList(String cate, String sido, String gugun);
	
	int addShareFc(ShareFcVO shareFc);
	
	List<Map<String, Object>> detailSharefc(int num);
	
	int addfile(Sf_attachVO shattach);
	
	int updateShareFc(ShareFcVO shareFc);
	
	int deletefile(int num);
	
	int deleteShareFc(int num);
	
	List<CodeVO> codeList();

	String getFilename(int num);
	
	List<ShareFcVO> sfsearch(String keyword);
	
	int sfsearchcount(String kewyord);
	
	
	// 게시글 클릭시 조회수 증가.
	int viewCnt(int num);

	// 게시글 추천하기.
	int like(Map<String, Object> map);
	
	// 게시글 추천 최초 확인.
	int likeCheck(Map<String, Object> map);
	
	// 추천 수 확인.
	int likeCntCheck(Map<String, Object> map);
	
	// 게시글 추천 취소하기.
	int likeCancle(Map<String, Object> map);
	
	// 추천 취소 후 다시 추천할 시 업데이트.
	int relike(Map<String, Object> map);

	// 게시글 비추천하기.
	int dislike(Map<String, Object> map);
	
	// 게시글 비추천 최초 확인.
	int dislikeCheck(Map<String, Object> map);
	
	// 비추천 수 확인.
	int dislikeCntCheck(Map<String, Object> map);
	
	// 게시글 비추천 취소하기.
	int dislikeCancle(Map<String, Object> map);
	
	// 비추천 취소 후 다시 추천할 시 업데이트.
	int redislike(Map<String, Object> map);
	
	
	// 게시글 찜하기.
	int dibsOn(Map<String, Object> map);

	// 찜 한 게시글 확인. (중복저장 하지않기위해.)
	int dibsOnCancle(Map<String, Object> map);

	// 찜 한 게시글 수 가져오기.
	int dibsOnCnt(String uid);

	// 찜 한 여부 색상 보기 위한 데이터 가져오기.
	// 반환값이 null이 될 수 있기 때문에 반환 자료형 타입을 Integer로 변경. 
	Integer dibsOnPnum(Map<String, Object> map);

	// 추천 비추천 카운트 가져오기.
	LikeDislikeVO likeDislikeCnt();
	
}
