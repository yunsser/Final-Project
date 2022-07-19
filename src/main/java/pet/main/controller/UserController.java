package pet.main.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import pet.main.security.model.PrincipalDetails;
import pet.main.svc.IUserSVC;
import pet.main.vo.UserVO;

@Controller
//@RequestMapping("/petmong")
public class UserController {

	@Autowired
	private IUserSVC svc;
	
	// 인덱스 페이지 이동.
	@RequestMapping({"", "/"})
	public String index() {
		return "index";
	}
	
	// 게시글 작성 시 정보가 없다면, 추가정보 업데이트 페이지로 이동.
	@GetMapping("/addUserInfo")
	public String addUserInfo() {
		return "/addUserInfo";
	}
	
	// OAuth 로그인을 해도 PrincipalDetails
	// 일반 로그인을 해도 PrincipalDetails
	// 회원 페이지 넘어갈시.
	@GetMapping("/user")
	public String user(@AuthenticationPrincipal PrincipalDetails principalDetails) {
		System.out.println("principalDetails : " + principalDetails.getUser());
		return "index";
	}
	
	// 관리자 페이지 넘어갈시.
	@GetMapping("/admin")
	public @ResponseBody String admin() {
		return "admin";
	}
	
	// 스프링 시큐리티 해당주소를 낚아챈다. - WebSecurity 파일 생성 후 작동안함.
	@GetMapping("/loginForm")
	public String loginForm() {
		return "loginForm";
	}
	
	// 아이디 중복체크.
	@PostMapping("/idCheck")
	@ResponseBody
	public Map<String, Boolean> eCheck(@RequestParam("uid") String uid, Model m){
		Map<String, Boolean> map = new HashMap<>();
		map.put("idCheck", svc.idCheck(uid));
		return map;
	}
	
	// 회원가입 폼 이동.
	@GetMapping("/signupForm")
	public String signupForm() {
		return "signupForm";
	}
	
	// 회원가입요청받고 회원정보 db저장
	@Transactional(rollbackFor={Exception.class})
	@PostMapping("/signup")
	public @ResponseBody Map<String, Boolean> signup(UserVO user, 
											@RequestParam(required = false) MultipartFile[] userImg,
											HttpServletRequest request){
		Map<String, Boolean> map = new HashMap<>();
		map.put("signup", svc.signup(user, userImg, request));
		return map;
	}
	
		
	// 마이페이지 이동.
	@GetMapping("/user/mypage")
	public String mypage(@RequestParam(required = false) String uid,
							Model m) {
		m.addAttribute("imgName", svc.findByImg(uid));
		m.addAttribute("user", svc.findByUser(uid));
		return "/user/mypage";
	}
	
	// 회원정보수정 페이지 이동.
	@GetMapping("/user/userInfo")
	public String userInfo(@RequestParam(required = false) String uid,
							Model m) {
		m.addAttribute("imgName", svc.findByImg(uid));
		m.addAttribute("user", svc.findByUser(uid));
		return "/user/userInfo";
	}
	
	// 회원정보 수정
	@Transactional(rollbackFor={Exception.class})
	@PostMapping("/user/userUpdate")
	public @ResponseBody Map<String, Boolean> userEdit(UserVO user, 
			@RequestParam(required = false) MultipartFile[] userImg,
			HttpServletRequest request){
		Map<String, Boolean> map = new HashMap<>();
		map.put("updated", svc.userUpdate(user, userImg, request));
		return map;
	}
	
	// 회원탈퇴
	@Transactional(rollbackFor={Exception.class})
	@PostMapping("/user/delete")
	public @ResponseBody Map<String, Boolean> userDelete(@RequestParam(required = false) String uid,
												HttpServletRequest request) {
		Map<String, Boolean> map = new HashMap<>();
		map.put("deleted", svc.userDelete(uid, request));
		return map;
	}
	
	// 권한 페이지 설정시.
	@Secured("ROLE_ADMIN")
	@GetMapping("/info")
	public @ResponseBody String info() {
		return "개인정보";
	}
	
	// @PostAuthorize : data 메소드가 끝난 뒤에 실행된다.
	// @PreAuthorize : data 메소드가 실행 직전에 실행된다. 권한조건을 여러개 적용할 수 있다.
	@PreAuthorize("hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')")
	@GetMapping("/data")
	public @ResponseBody String data() {
		return "데이터 정보";
	}
}
