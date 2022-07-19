package pet.main.dao;

import java.util.Map;

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
	
	// 회원 프로필 파일정보 user_proflie테이블에 저장
	@Override
	public boolean userProfile(Map<String, Object> map) {
		return userMapper.userProfile(map) > 0;
	}

	// 소셜 로그인 회원가입 처리.
	@Override
	public int signupSNS(UserVO user) {
		return userMapper.signupSNS(user);
	}
	
	// 로그인시 유저 정보 있는지 확인
	@Override
	public UserVO findByUser(String uid) {
		return userMapper.findByUser(uid);
	}

	// 아이디 중복체크
	@Override
	public String idCheck(String uid) {
		return userMapper.idCheck(uid);
	}

	// 회원 프로필 사진이름 가져오기.
	@Override
	public String findByImg(String uid) {
		return userMapper.findByImg(uid);
	}

	// 회원 프로필 수정.
	@Override
	public boolean profileUpdate(Map<String, Object> map) {
		return userMapper.profileUpdate(map) > 0;
	}

	// 회원정보 수정.
	@Override
	public int userUpdate(UserVO user) {
		return userMapper.userUpdate(user);
	}

	// 회원탈퇴 요청.
	@Override
	public int userDelete(String uid) {
		return userMapper.userDelete(uid);
	}

	// 회원탈퇴시 회원프로필 삭제.
	@Override
	public int profileDelete(String uid) {
		return userMapper.profileDelete(uid);
	}




}
