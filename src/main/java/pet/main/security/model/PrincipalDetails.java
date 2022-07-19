package pet.main.security.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

import org.springframework.context.annotation.Bean;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

import lombok.Data;
import pet.main.vo.UserVO;

// 시큐리티가 /login 주소 요청이 오면 낚아채서 로그인을 진행시킨다.
// 로그인 진행이 완료가 되면 시큐리티 session을 만들어준다.(Security ContextHolder 키값에 세션정보 저장)
// 시큐리티세션에 들어갈 수 있는 오브젝트 타입 => Authentication 타입 객체이여야 한다.
// Authentication 안에 User정보가 있어야 한다.
// Authentication안에 저장할 수 있는 오브젝트 타입은(User) => UserDetails 타입 객체이여야 한다.

// Security Session => Authentication => UserDetails(PrincipalDetails)

@Data
public class PrincipalDetails implements UserDetails, OAuth2User {

	private UserVO user; //컴포지션
	private Map<String, Object> attributes;
	
	// 일반 로그인
	public PrincipalDetails(UserVO user) {
		this.user = user;
	}
	
	// OAUth 로그인
	public PrincipalDetails(UserVO user, Map<String, Object> attributes) {
		this.user = user;
		this.attributes = attributes;
	}

	// 해당 User의 권한을 리턴하는 곳!
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Collection<GrantedAuthority> collect = new ArrayList<>();
		collect.add(new GrantedAuthority() {
			@Override
			public String getAuthority() {
				System.out.println(user.getRole());
				return user.getRole();
			}
		});
		return collect;
	}

	@Override
	public String getPassword() {
		return user.getUpw();
	}

	@Override
	public String getUsername() {
		return user.getUid();
	}

	@Override
	public boolean isAccountNonExpired() { // 계정만료됬는지.
		return true; // 아니다.
	}

	@Override
	public boolean isAccountNonLocked() { // 계정잠겼는지.
		return true; // 아니다.
	}

	@Override
	public boolean isCredentialsNonExpired() { // 비밀번호 안바꿔도 되겠는지.(오래사용하여서)
		return true;
	}

	@Override
	public boolean isEnabled() { // 계정 활성화 되있는지.
		// boolean lastlogin = false;
		// 사이트에 1년동안 회원이 로그인을 하지 않는다면,
		// 휴면 계정으로 하기로 함.
		// member.getLoginDate();
		// 현재시간 - 로그인시간 => 1년을 초과할시 return false;
		
		return true;
	}

	@Override
	public Map<String, Object> getAttributes() {
		return attributes;
	}

	@Override
	public String getName() {
		return null;
	}
	
}
