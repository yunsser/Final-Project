package pet.main.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pet.main.mapper.ShareFcMapper;
import pet.main.vo.CodeVO;
import pet.main.vo.LikeDislikeVO;
import pet.main.vo.Sf_attachVO;
import pet.main.vo.ShareFcVO;

@Repository
public class ShareFcDAO {
	
	@Autowired
	ShareFcMapper Mapper;
	
	public List<ShareFcVO> ShareFcList(String cate, String sido, String gugun){
		return Mapper.ShareFcList(cate, sido, gugun);
	}
	
	public boolean addShareFc(ShareFcVO shareFc) {
		return Mapper.addShareFc(shareFc)>0;
	}
	
	public List<Map<String, Object>> detailSharefc(int num){
		return Mapper.detailSharefc(num);
	}
	
	public boolean addfile(Sf_attachVO shattach) {
		return Mapper.addfile(shattach)>0;
	}
	
	public boolean updateShareFc(ShareFcVO shareFc) {
		System.out.println(Mapper.updateShareFc(shareFc));
		return Mapper.updateShareFc(shareFc)>0;
	}
	
	public boolean deletefile(int num) {
		return Mapper.deletefile(num)>0;
	}
	
	public boolean deleteShareFc(int num) {
		return Mapper.deleteShareFc(num)>0;
	}
	
	public List<CodeVO> codeList() {
	     return Mapper.codeList();
	}
	
	public String getFilename(int num) {
	      return Mapper.getFilename(num);
	   }

	public List<ShareFcVO> sfsearch(String keyword){
		return Mapper.sfsearch(keyword);
	}
	
	public int sfsearchcount(String keyword) {
		return Mapper.sfsearchcount(keyword);
	}
	
	// 게시글 클릭시 조회수 증가.
		public int viewCnt(int num) {
			return Mapper.viewCnt(num);
		}

		// 게시글 추천하기.
		public int like(Map<String, Object> map) {
			return Mapper.like(map);
		}
		
		// 게시글 추천 최초 확인.
		public int likeCheck(Map<String, Object> map) {
			return Mapper.likeCheck(map);
		}
		
		// 추천 수 확인.
		public int likeCntCheck(Map<String, Object> map) {
			return Mapper.likeCntCheck(map);
		}
		
		// 게시글 추천 취소하기.
		public int likeCancle(Map<String, Object> map) {
			return Mapper.likeCancle(map);
		}
		
		// 추천 취소 후 다시 추천할 시 업데이트.
		public int relike(Map<String, Object> map) {
			return Mapper.relike(map);
		}
		
		// 게시글 비추천하기.
		public int dislike(Map<String, Object> map) {
			return Mapper.dislike(map);
		}
		
		// 게시글 비추천 최초 확인.
		public int dislikeCheck(Map<String, Object> map) {
			return Mapper.dislikeCheck(map);
		}
		
		// 비추천 수 확인.
		public int dislikeCntCheck(Map<String, Object> map) {
			return Mapper.dislikeCntCheck(map);
		}
		
		// 게시글 비추천 취소하기.
		public int dislikeCancle(Map<String, Object> map) {
			return Mapper.dislikeCancle(map);
		}
		
		// 비추천 취소 후 다시 추천할 시 업데이트.
		public int redislike(Map<String, Object> map) {
			return Mapper.redislike(map);
		}
		
		// 게시글 찜하기.
		public int dibsOn(Map<String, Object> map) {
			return Mapper.dibsOn(map);
		}

		// 찜 한 게시글 확인. (중복저장 하지않기위해.)
		public int dibsOnCancle(Map<String, Object> map) {
			return Mapper.dibsOnCancle(map);
		}

		// 찜 한 게시글 수 가져오기.
		public int dibsOnCnt(String uid) {
			return Mapper.dibsOnCnt(uid);
		}

		// 찜 한 여부 색상 보기 위한 데이터 가져오기.
		// 반환값이 null이 될 수 있기 때문에 반환 자료형 타입을 Integer로 변경. 
		public Integer dibsOnPnum(Map<String, Object> map) {
			return Mapper.dibsOnPnum(map);
		}

		// 추천 비추천 카운트 가져오기.
		public LikeDislikeVO likeDislikeCnt() {
			return Mapper.likeDislikeCnt();
		}

	
}
