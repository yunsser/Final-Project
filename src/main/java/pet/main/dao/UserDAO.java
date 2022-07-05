package pet.main.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pet.main.mapper.UserMapper;
import pet.main.vo.UserVO;

@Repository
public class UserDAO implements IUserDAO{
	
	@Autowired
	private UserMapper userMapper;
	
	// 회원가입 기본정보 user테이블에 저장
	@Override
	public int signup(UserVO user) {
		return userMapper.signup(user);
	}

	// 로그인시 유저 정보 있는지 확인
	@Override
	public UserVO findByUserid(String uid) {
		return userMapper.findByUserid(uid);
	}

	// 아이디 중복체크
	@Override
	public String idCheck(String uid) {
		return userMapper.idCheck(uid);
	}

}
