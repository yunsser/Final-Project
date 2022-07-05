package pet.main.svc;

import pet.main.vo.UserVO;

public interface IUserSVC {
	
	// 회원가입 처리 (유저정보 테이블에 저장)
	public boolean signup(UserVO user);

	// 로그인시 유저 정보 있는지 확인
	public UserVO findByUserid(String uid);

	// 아이디 중복체크
	public boolean idCheck(String uid);
}
