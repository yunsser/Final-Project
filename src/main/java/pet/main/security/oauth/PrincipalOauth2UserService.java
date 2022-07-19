package pet.main.security.oauth;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import pet.main.security.model.PrincipalDetails;
import pet.main.security.oauth.provider.FacebookUserInfo;
import pet.main.security.oauth.provider.GoogleUserInfo;
import pet.main.security.oauth.provider.KakaoUserInfo;
import pet.main.security.oauth.provider.NaverUserInfo;
import pet.main.security.oauth.provider.OAuth2UserInfo;
import pet.main.svc.IUserSVC;
import pet.main.vo.UserVO;

// 구글 로그인 후처리
@Service
public class PrincipalOauth2UserService extends DefaultOAuth2UserService{
	
	@Autowired
	private IUserSVC svc;
			
	// SNS로 부터 받은 userRequest 데이터에 대한 후처리되는 함수
	// 함수 종료시 @AuthenticationPrincipal 어노테이션이 만들어진다.
	
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
		System.out.println("getClientRegistration : " + userRequest.getClientRegistration());	// registrationId로 어떤 OAuth로 로그인 했는지 확인가능.
		System.out.println("getAccessToken : " + userRequest.getAccessToken().getTokenValue());
		
		OAuth2User oAuth2User = super.loadUser(userRequest);
		// 구글로그인 버튼 클릭 -> 구글로그인창 -> 로그인 완료 -> code를 리턴(OAuth-Client라이브러리) -> code를 통하여 AccessToken요청
		// 위에까지가 userRequest정보 -> loadUser함수를 호출 -> 구글로부터 회원프로필을 받는다
		System.out.println("getAttributes : " + oAuth2User.getAttributes());
		
		// 회원가입을 강제로 진행
		OAuth2UserInfo oAuth2UserInfo = null;
		if(userRequest.getClientRegistration().getClientName().equals("Google")) {
			System.out.println("구글 로그인 요청");
			oAuth2UserInfo = new GoogleUserInfo(oAuth2User.getAttributes());
		} else if(userRequest.getClientRegistration().getClientName().equals("Facebook")) {
			System.out.println("페이스북 로그인 요청");
			oAuth2UserInfo = new FacebookUserInfo(oAuth2User.getAttributes());
		} else if(userRequest.getClientRegistration().getClientName().equals("Naver")) {
			System.out.println("네이버 로그인 요청");
			oAuth2UserInfo = new NaverUserInfo((Map)oAuth2User.getAttributes().get("response"));
		} else if(userRequest.getClientRegistration().getClientName().equals("Kakao")) {
			System.out.println("카카오 로그인 요청");
			oAuth2UserInfo = new KakaoUserInfo((Map)oAuth2User.getAttributes());
		} else {
			System.out.println("우리는 구글과 페이스북과 네이버와 카카오만 지원");
		}
		
		// 각 소셜 providerID값과 provider 명칭이 다르기때문에 oAuth2UserInfo 인터페이스를 생성하여 사용한다.
		String provider = oAuth2UserInfo.getProvider();
		String providerId = oAuth2UserInfo.getProviderId();
		String uid = provider + "_" + providerId; // ex) google_118142911143373296445
		String upw = providerId;
		String name = oAuth2UserInfo.getName();
		String email = oAuth2UserInfo.getEmail();
		String role = "ROLE_USER";
		
		UserVO user = svc.findByUser(uid);
		if(user == null) {
			System.out.println("OAuth 로그인 처음 자동. 회원가입 진행.");
			user = UserVO.builder()
					.uid(uid)
					.upw(upw)
					.name(name)
					.email(email)
					.role(role)
					.provider(provider)
					.providerId(providerId)
					.build();
			svc.signupSNS(user);
		} else {
			System.out.println("이미 회원가입이 자동으로 되었습니다.");
		}
		
		return new PrincipalDetails(user, oAuth2User.getAttributes());
	}
}
