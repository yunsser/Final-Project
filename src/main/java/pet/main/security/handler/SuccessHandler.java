package pet.main.security.handler;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;

@Component
public class SuccessHandler implements AuthenticationSuccessHandler {
	/**
	 * 로그인이 성공하고나서 로직
	 */

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request,
			HttpServletResponse response, Authentication authentication) throws IOException,
			ServletException {

		   //로그인이 성공하고나서 로직

	    	ObjectMapper om = new ObjectMapper();	//JSON 변경용
	    	
	    	Map<String, Object> map = new HashMap<String, Object>();
			map.put("success", true);
			map.put("returnUrl", getReturnUrl(request, response));

			// {"success" : true, "returnUrl" : "..."}
			String jsonString = om.writeValueAsString(map);

			
			request.setAttribute("uid",request.getParameter("uid"));
			
			OutputStream out = response.getOutputStream();
			out.write(jsonString.getBytes());
	}
			/**
			 * 로그인 하기 전의 요청했던 URL을 알아낸다.
			 * 
			 * @param request
			 * @param response
			 * @return
			 */
			private String getReturnUrl(HttpServletRequest request, HttpServletResponse response) {
				RequestCache requestCache = new HttpSessionRequestCache();
				SavedRequest savedRequest = requestCache.getRequest(request, response);
				if (savedRequest == null) {
					return request.getSession().getServletContext().getContextPath();
				}
				return savedRequest.getRedirectUrl();
			}
		
}

	

