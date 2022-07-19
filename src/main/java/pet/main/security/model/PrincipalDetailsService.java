package pet.main.security.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import pet.main.svc.IUserSVC;
import pet.main.vo.UserVO;

// 시큐리티 설정에서 loginProcessingUrl("/login");
// /login 요청이 오면 자동으로 UserDetailsService 타입으로 IoC되어있는 loadUserByUsername 함수가 실행
// 함수 종료시 @AuthenticationPrincipal 어노테이션이 만들어진다.

@Service
public class PrincipalDetailsService implements UserDetailsService {

	@Autowired
	private IUserSVC svc;
	
	
	// Security Session(내부 Authentication(내부 UserDetails))

	@Override
	public UserDetails loadUserByUsername(String uid) throws UsernameNotFoundException {
		System.out.println("uid : " + uid);
		// uid는 jsp name과 같아야 하며,Default는 username이다. 만약 파라미터이름 변경시, WebSecurityConfig의 usernameParameter를 사용할 이름으로 지정해준다.
		UserVO user = svc.findByUser(uid);
		if (user != null) {
			return new PrincipalDetails(user); 
		}
		return null;
	}

}
