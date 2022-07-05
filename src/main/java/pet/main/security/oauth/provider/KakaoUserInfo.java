package pet.main.security.oauth.provider;

import java.util.HashMap;
import java.util.Map;

public class KakaoUserInfo implements OAuth2UserInfo{

	private Map<String,Map<String, Object>> attributes; // getAttributes (oAuth2User.getAttributes())
	
	public KakaoUserInfo(Map<String,Map<String, Object>> attributes) {
		this.attributes = attributes;
	}
	
	
	@Override
	public String getProviderId() {
		Map<String, Object> map = new HashMap<>();
		map.put("id", attributes.get("id"));
		return String.valueOf(map.get("id"));
	}

	@Override
	public String getProvider() {
		return "Kakao";
	}

	@Override
	public String getEmail() {
		return (String) attributes.get("kakao_account").get("email");
	}

	@Override
	public String getName() {
		return (String) attributes.get("properties").get("nickname");
	}

}
