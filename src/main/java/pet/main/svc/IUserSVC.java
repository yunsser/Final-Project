package pet.main.svc;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import pet.main.vo.PostVO;
import pet.main.vo.ProfileVO;
import pet.main.vo.ShareFcVO;
import pet.main.vo.UserVO;

public interface IUserSVC {

	// 회원가입 처리 (유저정보 테이블에 저장).
	public boolean signup(UserVO user, MultipartFile[] userImg, HttpServletRequest request);

	// 일반 회원가입 오버로드 처리.
	public boolean signup(UserVO user);

	// 소셜 로그인 회원가입 처리.
	public void signupSNS(UserVO user);

	// 로그인시 회원 정보 있는지 확인./ 회원정보 가져오기.
	public UserVO findByUser(String uid);

	// 아이디 중복체크.
	public boolean idCheck(String uid);

	// 회원 프로필 사진이름 가져오기.
	public String findByImg(String uid);

	// 회원정보 수정.
	public Boolean userUpdate(UserVO user, MultipartFile[] userImg, HttpServletRequest request);

	// 회원탈퇴 요청.
	public Boolean userDelete(String uid, HttpServletRequest request);

	// 마이페이지 게시글 수 가져오기.
	public int myBoardCnt(String uid);

	// 마이페이지 작성한 공유게시글 가져오기.
	public List<PostVO> postList(int pageNum, String uid);

	// 마이페이지 작성한 후기게시글 가져오기.
	public List<ShareFcVO> shfcList(int pageNum, String uid);

	// 마이페이지 찜한 공유게시글 가져오기.
	public List<PostVO> dibsOnpList(int pageNum, String uid);

	// 마이페이지 찜한 후기게시글 가져오기.
	public List<ShareFcVO> dibsOnsList(int pageNum, String uid);

}
