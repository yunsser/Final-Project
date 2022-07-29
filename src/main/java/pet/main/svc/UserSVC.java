package pet.main.svc;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;

import pet.main.dao.IUserDAO;
import pet.main.vo.PostVO;
import pet.main.vo.ProfileVO;
import pet.main.vo.ShareFcVO;
import pet.main.vo.UserVO;

@Service
public class UserSVC implements IUserSVC {

	@Autowired
	private IUserDAO dao;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	// 회원가입 처리 (유저정보 테이블에 저장)
	public boolean signup(UserVO user, @RequestParam(required = false) MultipartFile[] userImg,
			HttpServletRequest request) {
		// 시큐리티 패스워드 인코더
//		user.setUpw(passwordEncoder.encode(user.getUpw()));

		// 회원정보 가입 동시에 플래그 변수 생성
		boolean saved = false;
		saved = signup(user);

		// 프로필 uid 정보 저장하기 위해 userVO에서 추출
		String uid = user.getUid();

		// 만약 회원가입 실패시 저장 실패 출력 후 리턴
		if (!saved) {
			System.out.println("저장 실패");
			return false;
		}

		// 파일 저장할 경로 지정.
		ServletContext context = request.getServletContext();
		String savePath = context.getRealPath("/resources/userProfile");

		try {

			String fname = "";
			String newFilename = "";
			// 사용자가 프로필파일 지정하지 않을시 기본사진 저장하기 위한 변수에 기본이미지 파일이름 저장.
			if (userImg[0].isEmpty()) {
				newFilename = "seokgu.jpg";
			} else {
				fname = userImg[0].getOriginalFilename();
				// 확장자 저장하기 위한 변수 설정.
				String ext = fname.split("\\.")[1];

				// 파일이름 중복 방지를 위한 nanoTime시간대로 변경 후 저장.
				newFilename = System.nanoTime() + "." + ext;
			}

			// 프로필파일 지정한 유저만 지정폴더에 프로필 사진 저장.
			if (!userImg[0].isEmpty()) {
				userImg[0].transferTo(new File(savePath + "/" + newFilename));
			}

			// DB에 저장하기 위해 map에 넣은 후 전달.
			Map<String, Object> map = new HashMap<>();
			map.put("uid", uid);
			map.put("fname", newFilename);
			map.put("fsize", userImg[0].getSize());

			return saved = dao.userProfile(map);

		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return saved;
	}

	// 회원가입 처리 (유저정보 테이블에 저장)
	public boolean signup(UserVO user) {
		user.setUpw(passwordEncoder.encode(user.getUpw()));
		return dao.signup(user) > 0;
	}

	// 회원가입 처리 (유저정보 테이블에 저장)
	public void signupSNS(UserVO user) {
		user.setUpw(passwordEncoder.encode(user.getUpw()));
		Map<String, Object> map = new HashMap<>();
		map.put("uid", user.getUid());
		map.put("fname", "seokgu.jpg");
		map.put("fsize", null);
		dao.userProfile(map);
		dao.signupSNS(user);
	}

	// // 로그인시 회원정보 있는지 확인./ 회원정보 가져오기.
	public UserVO findByUser(String uid) {
		return dao.findByUser(uid);
	}

	// 아이디 중복체크
	@Override
	public boolean idCheck(String uid) {
		return dao.idCheck(uid) == null;
	}

	// 회원 프로필 사진이름 가져오기.
	@Override
	public String findByImg(String uid) {
		String fname = "";
		if (dao.findByImg(uid) == null) {
			fname = "seokgu.jpg";
		} else {
			fname = dao.findByImg(uid);
		}
		return fname;
	}

	// 회원정보 수정 및 프로필 수정.
	@Override
	public Boolean userUpdate(UserVO user, MultipartFile[] userImg, HttpServletRequest request) {
		// 회원정보 수정 동시에 플래그 변수 생성
		boolean updated = false;
		userUpdate(user);
		System.out.println("있나" + userImg);
		System.out.println(user);
		// 프로필 uid 정보 저장하기 위해 userVO에서 추출
		String uid = user.getUid();

		// 만약 회원가입 실패시 저장 실패 출력 후 리턴
		if (!updated) {
			System.out.println("수정 하지않았거나 프로필 사진만 변경!");
		}

		// 파일 수정할 경로 지정.
		ServletContext context = request.getServletContext();
		String savePath = context.getRealPath("/resources/userProfile");

		try {
			// 기존 회원프로필 파일 있다면 삭제.
			if (dao.findByImg(uid) != null) {
				File file = new File(savePath + "/" + dao.findByImg(uid));
				file.delete();
			}
			System.out.println("있나2" + userImg[0]);

			String fname = "";
			String newFilename = "";
			// 사용자가 프로필파일 지정하지 않을시 기본사진 저장하기 위한 변수에 기본이미지 파일이름 저장.
			if (userImg[0].isEmpty()) {
				newFilename = "seokgu.jpg";
			} else {
				fname = userImg[0].getOriginalFilename();
				// 확장자 저장하기 위한 변수 설정.
				String ext = fname.split("\\.")[1];

				// 파일이름 중복 방지를 위한 nanoTime시간대로 변경 후 저장.
				newFilename = System.nanoTime() + "." + ext;
			}

			// 프로필파일 지정한 유저만 지정폴더에 프로필 사진 저장.
			if (!userImg[0].isEmpty()) {
				userImg[0].transferTo(new File(savePath + "/" + newFilename));
			}

			// DB에 저장하기 위해 map에 넣은 후 전달.
			Map<String, Object> map = new HashMap<>();
			map.put("uid", uid);
			map.put("fname", newFilename);
			map.put("fsize", userImg[0].getSize());
			System.out.println(uid + newFilename + userImg[0].getSize());
			System.out.println();
			return updated = dao.profileUpdate(map);

		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return updated;
	}

	// 회원정보 수정.
	public Boolean userUpdate(UserVO user) {
		user.setUpw(passwordEncoder.encode(user.getUpw()));
		return dao.userUpdate(user) > 0;
	}

	// 회원탈퇴 요청.
	@Override
	public Boolean userDelete(String uid, HttpServletRequest request) {

		boolean deleted = false;

		// 파일삭제 위한 경로 지정.
		ServletContext context = request.getServletContext();
		String savePath = context.getRealPath("/resources/userProfile");

		// 파일있다면 삭제
		if (dao.findByImg(uid) != null) {
			File file = new File(savePath + "/" + dao.findByImg(uid));
			file.delete();
		}

		if (dao.userDelete(uid) > 0 && dao.profileDelete(uid) > 0) {
			deleted = true;
		}

		return deleted;
	}

	// 마이페이지 게시글 수 가져오기.
	@Override
	public int myBoardCnt(String uid) {
		return dao.myBoardCnt(uid);
	}

	// 마이페이지 작성한 공유게시글 가져오기.
	@Override
	public List<PostVO> postList(int pageNum, String uid) {
		PageHelper.startPage(pageNum, 3);
		List<PostVO> hlist = dao.hlist(uid);
		return hlist;
	}

	// 마이페이지 작성한 후기게시글 가져오기.
	@Override
	public List<ShareFcVO> shfcList(int pageNum, String uid) {
		PageHelper.startPage(pageNum, 3);
		List<ShareFcVO> slist = dao.slist(uid);
		return slist;
	}

	// 마이페이지 찜한 공유게시글 가져오기.
	@Override
	public List<PostVO> dibsOnpList(int pageNum, String uid) {
		PageHelper.startPage(pageNum, 3);
		return dao.dibsOnpList(uid);
	}

	// 마이페이지 찜한 후기게시글 가져오기.
	@Override
	public List<ShareFcVO> dibsOnsList(int pageNum, String uid) {
		PageHelper.startPage(pageNum, 3);
		return dao.dibsOnsList(uid);
	}

}
