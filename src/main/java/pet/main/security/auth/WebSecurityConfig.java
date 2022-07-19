package pet.main.security.auth;

// 1. 코드받기(인증), 2. 엑세스토큰(권한), 3. 사용자 프로필 정보를 가져오기, 4-1. 그 정보를 토대로 회원가입을 자동으로 진행시키기도 한다.
// 4-2. 구글에는 (이메일, 전화번호, 이름, 아이디만 있다한다면) 우리 페이지에 -> (집주소) 추가적인 요소가 필요하다.
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import pet.main.security.handler.FailureHandler;
import pet.main.security.handler.SuccessHandler;
import pet.main.security.oauth.PrincipalOauth2UserService;

@Configuration
@EnableWebSecurity // 스프링 시큐리티 필터가 스프링 필터체인에 등록이 된다.
@EnableGlobalMethodSecurity(securedEnabled = true, prePostEnabled = true) // secured 어노테이션 활성화, preAuthorize, postAuthorize 어노테이션 활성화
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	// 해당 메서드의 리턴되는 오브젝트를 IoC로 등록해준다.
	@Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
	
	@Autowired
	public FailureHandler failureHandler;
	
	@Autowired
	public SuccessHandler successHandler;

	@Autowired
	private PrincipalOauth2UserService principalOauth2UserService;
	
	// passwordEncoder() 추가
	// 해당 메서드의 리턴되는 오브젝트를 IoC로 등록해준다.
	
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		// ssl을 사용하지 않으면 true로 사용
		http.csrf().disable();
		http.authorizeRequests()
				.antMatchers("/css/**", "/js/**", "/image/**", "/favicon.ico", "/error").permitAll()
				.antMatchers("/user/**").authenticated() // 인증만 되면 들어갈 수 있다.
//				.antMatchers("/user/**").access("hasAnyRole('ROLE_USER', 'ROLE_ADMIN')") // 권한설정
				.antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')") // 권한설정
				.anyRequest().permitAll()
				.and()
				.formLogin()
				.loginPage("/loginForm")
				.usernameParameter("uid")
				.passwordParameter("upw")
				.loginProcessingUrl("/login") //login 주소가 호출이 되면 시큐리티가 낚아채서 대신 로그인진행해준다.
//				.defaultSuccessUrl("/") // login이 성공되면 돌가는 페이지. 핸들러가 있다면 사용X.
				.successHandler(successHandler) // login 성공시 후처리.
				.failureHandler(failureHandler) // login 실패시 후처리.
				// oauth2 (구글,페이스북,네이버,카카오)로그인 설정.
				.and()
				.oauth2Login()
				.loginPage("/loginForm")
				.defaultSuccessUrl("/") // 로그인 성공 후 추가 정보 입력하기 위해 이동.
				.failureUrl("/loginForm") // 로그인 실패 시 /loginForm으로 이동.
				.userInfoEndpoint() // 로그인 성공 후 사용자정보를 가져온다.
				.userService(principalOauth2UserService); // 사용자정보 처리시 사용.
		
				http.logout()
				.logoutUrl("/logout") // default
				.logoutSuccessUrl("/")
				.permitAll();
	}	

}
	
	


