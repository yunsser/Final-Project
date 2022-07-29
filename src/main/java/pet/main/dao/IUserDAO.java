package pet.main.dao;

import java.util.List;
import java.util.Map;

import pet.main.vo.PostVO;
import pet.main.vo.ShareFcVO;
import pet.main.vo.UserVO;

public interface IUserDAO {

//	 회원가입 기본정보 user테이블에 저장
	public int signup(UserVO user);

	// 회원 프로필 파일정보 user_proflie테이블에 저장
	public boolean userProfile(Map<String, Object> map);

	// 소셜 로그인 회원가입 처리.
	public int signupSNS(UserVO user);

	// 로그인시 유저 정보 있는지 확인
	public UserVO findByUser(String uid);

	// 아이디 중복체크
	public String idCheck(String uid);

	// 회원 프로필 사진이름 가져오기.
	public String findByImg(String uid);

	// 회원 프로필 수정.
	public boolean profileUpdate(Map<String, Object> map);

	// 회원정보 수정.
	public int userUpdate(UserVO user);

	// 회원탈퇴 요청.
	public int userDelete(String uid);

	// 회원탈퇴시 회원프로필 삭제.
	public int profileDelete(String uid);

	// 마이페이지 게시글 수 가져오기.
	public int myBoardCnt(String uid);

	// 마이페이지 작성한 공유게시글 가져오기.
	public List<PostVO> hlist(String uid);

	// 마이페이지 작성한 후기게시글 가져오기.
	public List<ShareFcVO> slist(String uid);

	// 마이페이지 찜한 공유게시글 가져오기.
	public List<PostVO> dibsOnpList(String uid);

	// 마이페이지 찜한 후기게시글 가져오기.
	public List<ShareFcVO> dibsOnsList(String uid);

}
