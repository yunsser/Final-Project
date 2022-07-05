package pet.main.dao;

import pet.main.vo.UserVO;

public interface IUserDAO {

	// 회원가입 기본정보 user테이블에 저장
	public int signup(UserVO user);

	// 로그인시 유저 정보 있는지 확인
	public UserVO findByUserid(String uid);

	// 아이디 중복체크
	public String idCheck(String uid);

}
