package pet.main.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import pet.main.vo.PostVO;
import pet.main.vo.ShareFcVO;
import pet.main.vo.UserVO;

@Mapper
public interface UserMapper {

	// 회원가입 기본정보 user테이블에 저장
	int signup(UserVO user);

	// 유저 프로필 저장
	int userProfile(Map<String, Object> map);

	// 소셜 로그인 회원가입 처리.
	int signupSNS(UserVO user);

	// 로그인시 유저 정보 있는지 확인
	UserVO findByUser(String uid);

	// 아이디 중복체크
	String idCheck(String uid);

	// 회원 프로필 사진이름 가져오기.
	String findByImg(String uid);

	// 회원 프로필 수정.
	int profileUpdate(Map<String, Object> map);

	// 회원정보 수정.
	int userUpdate(UserVO user);

	// 회원탈퇴 요청.
	int userDelete(String uid);

	// 회원탈퇴시 회원프로필 삭제.
	int profileDelete(String uid);

	// 마이페이지 게시글 수 가져오기.
	int myBoardCnt(String uid);

	// 마이페이지 작성한 공유게시글 가져오기.
	List<PostVO> hlist(String uid);

	// 마이페이지 작성한 후기게시글 가져오기.
	List<ShareFcVO> slist(String uid);

	// 마이페이지 찜한 공유게시글 가져오기.
	List<PostVO> dibsOnpList(String uid);

	// 마이페이지 찜한 후기게시글 가져오기.
	List<ShareFcVO> dibsOnsList(String uid);

}
