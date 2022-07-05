package pet.main.svc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import pet.main.dao.IUserDAO;
import pet.main.vo.UserVO;

@Service
public class UserSVC implements IUserSVC {

	@Autowired
	private IUserDAO dao;
	
	@Autowired
	private PasswordEncoder passwordEncoder; 
	
	// 회원가입 처리 (유저정보 테이블에 저장)
	public boolean signup(UserVO user) {
		user.setUpw(passwordEncoder.encode(user.getUpw()));
		return dao.signup(user) > 0;
	}
	
	// 로그인시 유저 정보 있는지 확인
	public UserVO findByUserid(String uid) {
		System.out.println(dao.findByUserid(uid));
		return dao.findByUserid(uid);
	}

	// 아이디 중복체크
	@Override
	public boolean idCheck(String uid) {
		return dao.idCheck(uid) == null;
	}
}
