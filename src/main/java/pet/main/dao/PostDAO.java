package pet.main.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pet.main.mapper.PostMapper;
import pet.main.vo.AttachVO;
import pet.main.vo.CodeVO;
import pet.main.vo.LikeDislikeVO;
import pet.main.vo.PagingVO;
import pet.main.vo.PostVO;

@Repository
public class PostDAO {
	@Autowired
	PostMapper postmapper;

	public boolean board(PostVO post) {
		return postmapper.board(post) > 0;
	}

	public boolean updated(PostVO post) {
		return postmapper.updated(post) > 0;
	}

	public boolean deleted(int num) {
		return postmapper.deleted(num) > 0;
	}

	public List<Map<String, Object>> detailNum(int num) {
		return postmapper.detailNum(num);
	}

	public Boolean deleteFileInfo(int num) {
		return postmapper.deleteFileInfo(num) > 0;
	}

	public boolean fileInfo(AttachVO attach) {
		return postmapper.fileInfo(attach) > 0;
	}

	public List<Map<String, String>> getBoard() {
		return postmapper.getBoard();
	}

	public String getFilename(int num) {
		return postmapper.getFilename(num);
	}

	public int count() {
		return postmapper.count();
	}

	public List<PostVO> select(PagingVO vo) {
		return postmapper.select(vo);
	}

// =====================================================
	public List<CodeVO> codeList() {
		return postmapper.codeList();
	}

	public List<PostVO> ShareFcList(String sido, String gugun) {
		return postmapper.ShareFcList(sido, gugun);
	}

	// 게시글 클릭시 조회수 증가.
	public int viewCnt(int num) {
		return postmapper.viewCnt(num);
	}

	// 게시글 추천하기.
	public int like(Map<String, Object> map) {
		return postmapper.like(map);
	}

	// 게시글 추천 최초 확인.
	public int likeCheck(Map<String, Object> map) {
		return postmapper.likeCheck(map);
	}

	// 추천 수 확인.
	public int likeCntCheck(Map<String, Object> map) {
		return postmapper.likeCntCheck(map);
	}

	// 게시글 추천 취소하기.
	public int likeCancle(Map<String, Object> map) {
		return postmapper.likeCancle(map);
	}

	// 추천 취소 후 다시 추천할 시 업데이트.
	public int relike(Map<String, Object> map) {
		return postmapper.relike(map);
	}

	// 게시글 비추천하기.
	public int dislike(Map<String, Object> map) {
		return postmapper.dislike(map);
	}

	// 게시글 비추천 최초 확인.
	public int dislikeCheck(Map<String, Object> map) {
		return postmapper.dislikeCheck(map);
	}

	// 비추천 수 확인.
	public int dislikeCntCheck(Map<String, Object> map) {
		return postmapper.dislikeCntCheck(map);
	}

	// 게시글 비추천 취소하기.
	public int dislikeCancle(Map<String, Object> map) {
		return postmapper.dislikeCancle(map);
	}

	// 비추천 취소 후 다시 추천할 시 업데이트.
	public int redislike(Map<String, Object> map) {
		return postmapper.redislike(map);
	}

	// 게시글 찜하기.
	public int dibsOn(Map<String, Object> map) {
		return postmapper.dibsOn(map);
	}

	// 찜 한 게시글 확인. (중복저장 하지않기위해.)
	public int dibsOnCancle(Map<String, Object> map) {
		return postmapper.dibsOnCancle(map);
	}

	// 찜 한 게시글 수 가져오기.
	public int dibsOnCnt(String uid) {
		return postmapper.dibsOnCnt(uid);
	}

	// 찜 한 여부 색상 보기 위한 데이터 가져오기.
	// 반환값이 null이 될 수 있기 때문에 반환 자료형 타입을 Integer로 변경.
	public Integer dibsOnPnum(Map<String, Object> map) {
		return postmapper.dibsOnPnum(map);
	}

	// 추천 비추천 카운트 가져오기.
	public LikeDislikeVO likeDislikeCnt() {
		return postmapper.likeDislikeCnt();
	}

	// 메인 검색기능
	public List<PostVO> boardlist(String keyword) {
		return postmapper.boardlist(keyword);
	}

	// 메인 검색기능(카운트)
	public int countboardlist(String keyword) {
		return postmapper.countboardlist(keyword);

	}



}
