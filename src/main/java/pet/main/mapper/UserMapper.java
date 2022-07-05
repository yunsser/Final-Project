package pet.main.mapper;

import org.apache.ibatis.annotations.Mapper;

import pet.main.vo.UserVO;

@Mapper
public interface UserMapper {
	
	// 회원가입 기본정보 user테이블에 저장
	int signup(UserVO user);
	
	// 로그인시 유저 정보 있는지 확인
	UserVO findByUserid(String uid);

	// 아이디 중복체크
	String idCheck(String uid);

}
