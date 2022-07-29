package pet.main.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageInfo;

import pet.main.dao.PostDAO;
import pet.main.security.model.PrincipalDetails;
import pet.main.svc.HomeSVC;
import pet.main.svc.IUserSVC;
import pet.main.svc.MainSearchSVC;
import pet.main.svc.PostSVC;
import pet.main.svc.ShareFcSVC;
import pet.main.svc.TestSVC;
import pet.main.vo.HomeVO;
import pet.main.vo.Hp_VO;
import pet.main.vo.PageVO;
import pet.main.vo.PagingVO;
import pet.main.vo.PostVO;
import pet.main.vo.ShareFcVO;
import pet.main.vo.UserVO;

@Controller
@RequestMapping("/petmong")
public class UserController {

	@Autowired
	private IUserSVC svc;

	@Autowired
	private HomeSVC homesvc;

	@Autowired
	private PostDAO postdao;

	@Autowired
	private ShareFcSVC codesvc;

	@Autowired
	private PostSVC postsvc;

	@Autowired
	MainSearchSVC hpsvc;

	@Autowired
	TestSVC testsvc;

	// 인덱스 페이지 이동.
	@RequestMapping({ "", "/" })
	public String index(Model model, @RequestParam(required = false, defaultValue = "1") int pageNum,
			@RequestParam(name = "cate", required = false, defaultValue = "") String cate,
			@RequestParam(name = "sido", required = false, defaultValue = "") String sido,
			@RequestParam(name = "gugun", required = false, defaultValue = "") String gugun)
			throws JsonProcessingException {

		List<HomeVO> list = homesvc.list();
		model.addAttribute("list", list); // 유기동물 사진

		ObjectMapper objm = new ObjectMapper();
		List codelist2 = codesvc.codeList();
		String codeList = objm.writeValueAsString(codelist2);
		model.addAttribute("codeList", codeList);

		List<PostVO> list2 = postsvc.ShareFcList(sido, gugun);
		model.addAttribute("list2", list2); // 공유게시판
		PageInfo<PostVO> pageInfo = postsvc.listpaging2(pageNum, sido, gugun);
		model.addAttribute("pageInfo", pageInfo);

		List<ShareFcVO> list3 = codesvc.ShareFcList(sido, cate, gugun);
		model.addAttribute("list3", list3); // 후기게시판
		PageInfo<ShareFcVO> pageInfo2 = codesvc.listpaging2(pageNum, cate, sido, gugun);
		model.addAttribute("pageInfo2", pageInfo2);

		List codemap = codesvc.codeListMap();
		List gugunmap = codesvc.gugunListMap(sido);
		model.addAttribute("codemap", codemap);
		model.addAttribute("gugunmap", gugunmap);
		model.addAttribute("sido", sido);

		return "index";
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
	public Map<String, Boolean> eCheck(@RequestParam("uid") String uid, Model m) {
		Map<String, Boolean> map = new HashMap<>();
		map.put("idCheck", svc.idCheck(uid));
		return map;
	}

	// 회원가입 폼 이동.
	@GetMapping("/signupForm")
	public String signupForm() {
		return "signupForm";
	}

	// 회원가입 요청받고 회원정보 db저장.
	@Transactional(rollbackFor = { Exception.class })
	@PostMapping("/signup")
	public @ResponseBody Map<String, Boolean> signup(UserVO user,
			@RequestParam(required = false) MultipartFile[] userImg, HttpServletRequest request) {
		Map<String, Boolean> map = new HashMap<>();
		map.put("signup", svc.signup(user, userImg, request));
		return map;
	}

	// 마이페이지 이동.
	@GetMapping("/user/mypage")
	public String mypage(@RequestParam(required = false) String uid, Model m) {
		System.out.println(uid);
		m.addAttribute("imgName", svc.findByImg(uid));
//			m.addAttribute("user", svc.findByUser(uid));
		m.addAttribute("dibsOnCnt", postdao.dibsOnCnt(uid));
		m.addAttribute("myBoardCnt", svc.myBoardCnt(uid));
		return "/user/mypage";
	}

	// 회원정보수정 페이지 이동.
	@GetMapping("/user/userInfo")
	public String userInfo(@RequestParam(required = false) String uid, Model m) {
		m.addAttribute("imgName", svc.findByImg(uid));
		m.addAttribute("u", svc.findByUser(uid));
		return "/user/userInfo";
	}

	// 회원정보 수정
	@Transactional(rollbackFor = { Exception.class })
	@PostMapping("/user/userUpdate")
	public @ResponseBody Map<String, Boolean> userEdit(UserVO user,
			@RequestParam(required = false) MultipartFile[] userImg, HttpServletRequest request) {
		Map<String, Boolean> map = new HashMap<>();
		map.put("updated", svc.userUpdate(user, userImg, request));
		return map;
	}

	// 회원탈퇴
	@Transactional(rollbackFor = { Exception.class })
	@PostMapping("/user/delete")
	public @ResponseBody Map<String, Boolean> userDelete(@RequestParam(required = false) String uid,
			HttpServletRequest request) {
		Map<String, Boolean> map = new HashMap<>();
		map.put("deleted", svc.userDelete(uid, request));
		return map;
	}

	// 게시글 작성 시 정보가 없다면, 추가정보 업데이트 페이지로 이동.
	@GetMapping("/user/addUserInfo")
	public String addUserInfo() {
		return "/user/addUserInfo";
	}

	// 회원정보 추가 업데이트.
	@Transactional(rollbackFor = { Exception.class })
	@PostMapping("/user/addInfo")
	public @ResponseBody Map<String, Boolean> addInfo(UserVO user,
			@RequestParam(required = false) MultipartFile[] userImg, HttpServletRequest request, HttpSession session) {
		Map<String, Boolean> map = new HashMap<>();
		// SNS 회원로그인 글 작성시 추가정보 입력 후 글 작성가능한지 판별하기 위해 세션저장.
		session.setAttribute("phone", user.getPhone());
		map.put("addInfo", svc.userUpdate(user, userImg, request));
		return map;
	}

	// 작성한 게시글 페이지 이동.
	@GetMapping("/user/myBoard")
	public String myBoard(Model m, @RequestParam(required = false) String uid,
			@RequestParam(required = false, defaultValue = "1") int pageNum) {
		// 공유게시판 가져오기.
		PageInfo<PostVO> hpageInfo = new PageInfo<>(svc.postList(pageNum, uid));
		m.addAttribute("hpageInfo", hpageInfo);

		List<Integer> hpnumList = new ArrayList<>();
		for (int i = 0; i < svc.postList(pageNum, uid).size(); i++) {
			hpnumList.add(postsvc.dibsOnPnum(uid, svc.postList(pageNum, uid).get(i).getNum()));
		}
		m.addAttribute("hpnumList", hpnumList);

		// 후기게시판 가져오기.
		PageInfo<ShareFcVO> spageInfo = new PageInfo<>(svc.shfcList(pageNum, uid));
		m.addAttribute("spageInfo", spageInfo);
		List<Integer> spnumList = new ArrayList<>();
		for (int i = 0; i < svc.shfcList(pageNum, uid).size(); i++) {
			spnumList.add(codesvc.dibsOnPnum(uid, svc.shfcList(pageNum, uid).get(i).getSh_num()));
		}
		m.addAttribute("spnumList", spnumList);

		return "user/myBoard";
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

	// 찜한 게시글 페이지 이동.
	@GetMapping("/user/dibsOnBoard")
	public String dibsOnBoard(PageVO vo, Model m, @RequestParam(required = false) String uid,
			@RequestParam(required = false, defaultValue = "1") int pageNum) {
		// 병원게시판 가져오기.
		PageInfo<Hp_VO> hospageInfo = hpsvc.hosSearchPage(pageNum, uid);
		int hptotal = hpsvc.hoscountSearchList(uid);

		vo = new PageVO(hptotal, pageNum, 5);
		m.addAttribute("hplist", hospageInfo);
		m.addAttribute("hptotal", hptotal);

		// 공유게시판 가져오기.
		PageInfo<PostVO> hpageInfo = new PageInfo<>(svc.dibsOnpList(pageNum, uid));
		m.addAttribute("hpageInfo", hpageInfo);
		System.out.println(hpageInfo);
		List<Integer> hpnumList = new ArrayList<>();
		for (int i = 0; i < svc.dibsOnpList(pageNum, uid).size(); i++) {
			hpnumList.add(postsvc.dibsOnPnum(uid, svc.dibsOnpList(pageNum, uid).get(i).getNum()));
		}
		m.addAttribute("hpnumList", hpnumList);

		// 후기게시판 가져오기.
		PageInfo<ShareFcVO> spageInfo = new PageInfo<>(svc.dibsOnsList(pageNum, uid));
		m.addAttribute("spageInfo", spageInfo);
		List<Integer> spnumList = new ArrayList<>();
		for (int i = 0; i < svc.dibsOnsList(pageNum, uid).size(); i++) {
			spnumList.add(codesvc.dibsOnPnum(uid, svc.dibsOnsList(pageNum, uid).get(i).getSh_num()));
		}
		m.addAttribute("spnumList", spnumList);

		return "user/dibsOnBoard";

	}

}
