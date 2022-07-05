package pet.main.security.handler;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import pet.main.dao.UserDAO;

@Configuration
public class FailureHandler implements AuthenticationFailureHandler {
	

	// 로그인 실패시 로직
	@Override
	public void onAuthenticationFailure(HttpServletRequest request,
		HttpServletResponse response, AuthenticationException exception)
		throws IOException, ServletException {
		
		ObjectMapper om = new ObjectMapper();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", false);
		
		String uid = request.getParameter("uid");
		String errormsg = "";
		
		if (exception instanceof BadCredentialsException) { // 비밀번호불일치
			loginFailureCount(uid);
			errormsg = "비밀번호가 맞지 않습니다. 다시 확인해주세요.";
		} else if (exception instanceof UsernameNotFoundException) { //존재하지 않는 아이디일 경우 예외.
			errormsg = "존재하지 않는 사용자입니다.";
		} else if (exception instanceof InternalAuthenticationServiceException ) { // 시스템 문제로 내부 인증 관련 처리 요청을 할 수 없는 경우 예외.
			errormsg = "시스템 문제로 내부 인증 관련 처리 요청을 할 수 없습니다. 관리자에게 문의하세요.";
		} else if (exception instanceof DisabledException ) { // 계정 비활성화일 경우 예외.
			errormsg = "계정이 비활성화되었습니다. 관리자에게 문의하세요.";
		} else if (exception instanceof CredentialsExpiredException ) { // 비밀번호 유효 기간 만료일 경우 예외.
			errormsg = "비밀번호 유효기간이 만료 되었습니다. 관리자에게 문의하세요.";
		}
			
		request.setAttribute("uid", uid);
		map.put("message", errormsg);
		
		// {"success" : false, "message" : "..."}
		String jsonString = om.writeValueAsString(map);
		
		OutputStream out = response.getOutputStream();
		out.write(jsonString.getBytes());
	
	}

	
	// 비밀번호를 3번 이상 틀릴 시 계정 잠금 처리
	protected void loginFailureCount(String uid) {
//		// 틀린 횟수 업데이트
//		UserDAO.countFailure(uid);
		
		//틀린 횟수 조회
		//int cnt = userDao.checkFailureCount(username);
		//if (cnt ==3 ) {
			//계정 잠금 처리
		//	userDao.disabledUsername(username);
		//}
	}

}
