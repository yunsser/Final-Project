package pet.main.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageInfo;

import pet.main.dao.PostDAO;
import pet.main.svc.PostSVC;
import pet.main.svc.ShareFcSVC;
import pet.main.svc.TestSVC;
import pet.main.vo.PageVO;
import pet.main.svc.replyService;
import pet.main.vo.PagingVO;
import pet.main.vo.PostVO;
import pet.main.vo.ReplyVO;
import pet.main.vo.ShareFcVO;

@Controller
@SessionAttributes("uid")
@RequestMapping("/petmong/post")
public class PostController {

	@Autowired
	PostSVC svc;

	@Autowired
	private ShareFcSVC codesvc;

	@Autowired
	PostDAO dao;

	@Autowired
	ResourceLoader resourceLoader;

	@Autowired
	private replyService rService;

//	게시판 리스트 + 페이징
	@GetMapping("/list")
	public String list(Model model,
			@RequestParam(required = false) String uid,
			@RequestParam(required = false, defaultValue = "1") int pageNum,
			@RequestParam(name = "sido", required = false, defaultValue = "") String sido,
			@RequestParam(name = "gugun", required = false, defaultValue = "") String gugun)
			throws JsonProcessingException {

		ObjectMapper objm = new ObjectMapper();
		List codelist2 = codesvc.codeList();
		String codeList = objm.writeValueAsString(codelist2);
		model.addAttribute("codeList", codeList);
		List<PostVO> list = svc.ShareFcList(sido, gugun);
		model.addAttribute("list", list);
		PageInfo<PostVO> pageInfo = svc.listpaging(pageNum, sido, gugun);
		model.addAttribute("pageInfo", pageInfo);
		//System.out.println(pageInfo.getList().get(0).getNum());
		
		List<Integer> hpnumList = new ArrayList<>();
		for(int i = 0; i < pageInfo.getList().size(); i++ ){
			hpnumList.add(svc.dibsOnPnum(uid, pageInfo.getList().get(i).getNum()));
		}
		//System.out.println(hpnumList.get(0));
		model.addAttribute("hpnumList", hpnumList);

		List codemap = codesvc.codeListMap();
		List gugunmap = codesvc.gugunListMap(sido);
		model.addAttribute("codemap", codemap);
		model.addAttribute("gugunmap", gugunmap);
		model.addAttribute("sido", sido);
		model.addAttribute("gugun", gugun);
		return "post/list";
		/* } */

	}

//	게시판 글쓰기
	@GetMapping("/board")
	public String board(Model model, @RequestParam(name = "sido", required = false, defaultValue = "") String sido,
			@RequestParam(name = "gugun", required = false, defaultValue = "") String gugun)
			throws JsonProcessingException {
		ObjectMapper objm = new ObjectMapper();
		List codelist2 = codesvc.codeList();
		String codeList = objm.writeValueAsString(codelist2);
		model.addAttribute("codeList", codeList);

		List codemap = codesvc.codeListMap();
		List gugunmap = codesvc.gugunListMap(sido);
		model.addAttribute("codemap", codemap);
		model.addAttribute("gugunmap", gugunmap);
		model.addAttribute("sido", sido);
		model.addAttribute("gugun", gugun);

		return "post/board";

	}

	@PostMapping("/board")
	@ResponseBody
	public Map<String, Boolean> board(@RequestParam(name = "mfiles", required = false) MultipartFile[] mfiles,
			HttpServletRequest request, PostVO post) {
		Map<String, Boolean> map = new HashMap<>();
		boolean added = svc.board(mfiles, request, post);
		System.out.println(mfiles);
		map.put("added", added);
		return map;

	}

//	파일 다운로드
	@GetMapping("/download/{filename}")
	public ResponseEntity<Resource> download(HttpServletRequest request, @PathVariable String filename) {
		Resource resource = (Resource) resourceLoader.getResource("upload/" + filename);
		System.out.println("파일명:" + resource.getFilename());
		String contentType = null;
		try {
			contentType = request.getServletContext().getMimeType(resource.getFile().getAbsolutePath());
		} catch (IOException e) {
			e.printStackTrace();
		}

		if (contentType == null) {
			contentType = "application/octet-stream";
		}

		return ResponseEntity.ok().contentType(MediaType.parseMediaType(contentType))
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
				.body(resource);
	}

	@GetMapping("/file/download/{num}")
	public ResponseEntity<Resource> fileDownload(@PathVariable int num, HttpServletRequest request) {
		// attach 테이블에서 att_num 번호를 이용하여 파일명을 구하여 위의 방법을 사용
		String filename = svc.getFilename(num);
		Resource resource = (Resource) resourceLoader.getResource("upload/" + filename);
		// System.out.println("파일명:"+resource.getFilename());
		String contentType = null;
		try {
			contentType = request.getServletContext().getMimeType(resource.getFile().getAbsolutePath());
		} catch (IOException e) {
			e.printStackTrace();
		}

		if (contentType == null) {
			contentType = "application/octet-stream";
		}

		return ResponseEntity.ok().contentType(MediaType.parseMediaType(contentType))
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
				.body(resource);
	}

//	게시판 자세한 화면보기
	@GetMapping("/detail")
	public String detailBoard(@RequestParam(required = false)String uid, @RequestParam(required = false) int num,
			@RequestParam(required=false, defaultValue = "1")int pageNum,
			Model model) { // 일치시켜주면 // 들어감
		svc.viewCnt(num);
		PostVO post = svc.detailNum(num);
		model.addAttribute("replyList", rService.getReplyList(num));
		model.addAttribute("hpnum", svc.dibsOnPnum(uid,num));
		model.addAttribute("post", post);
		model.addAttribute("likeDislikeCnt", svc.likeDislikeCnt());
		model.addAttribute("replyCnt", rService.getReplyCnt(num));
		
		PageInfo<ReplyVO> pageInfo = new PageInfo<>(rService.getReplyListPage(pageNum, num));
		model.addAttribute("pageInfo", pageInfo);
		return "post/detail";
	}

	@GetMapping("/edit")
	public String detailedit(@RequestParam int num, Model model,
			@RequestParam(name = "sido", required = false, defaultValue = "") String sido,
			@RequestParam(name = "gugun", required = false, defaultValue = "") String gugun)
			throws JsonProcessingException {
		PostVO post = svc.detailNum(num);
		model.addAttribute("post", post);

		ObjectMapper objm = new ObjectMapper();
		List codelist2 = codesvc.codeList();
		String codeList = objm.writeValueAsString(codelist2);
		model.addAttribute("codeList", codeList);

		List codemap = codesvc.codeListMap();
		List gugunmap = codesvc.gugunListMap(sido);
		model.addAttribute("codemap", codemap);
		model.addAttribute("gugunmap", gugunmap);
		model.addAttribute("sido", sido);
		model.addAttribute("gugun", gugun);

		return "post/edit";
	}

//	게시판 수정하기
	@PostMapping("/update")
	@ResponseBody
	public Map<String, Boolean> updateBoard(@RequestParam(name = "mfiles", required = false) MultipartFile[] mfiles,
			HttpServletRequest request, PostVO post, Model model) {
		Map<String, Boolean> map = new HashMap<>();
		boolean updated = svc.updated(request, post, mfiles);
		map.put("updated", updated);
		return map;
	}

//	게시판 삭제
	@PostMapping("/delete")
	@ResponseBody
	public Map<String, Boolean> deleted(@RequestParam int num) {
		Map<String, Boolean> map = new HashMap<>();
		map.put("deleted", svc.deleted(num));
		return map;
	}

	@PostMapping("/file/delete")
	@ResponseBody
	public Map<String, Boolean> deleteFileInfo(@RequestParam List<String> delfiles) {
		boolean deleteFileInfo = svc.deleteFileInfo(delfiles);
		Map<String, Boolean> map = new HashMap<>();
		map.put("deleteFileInfo", deleteFileInfo);
		return map;
	}

	// 게시글 추천하기.
	@Transactional(rollbackFor = { Exception.class })
	@PostMapping("/like")
	public @ResponseBody Map<String, Boolean> like(@RequestParam(required = false) String uid,
			@RequestParam(required = false) int hpnum, @RequestParam(required = false) String sido) {
		Map<String, Boolean> map = new HashMap<>();
		// System.out.println(sido);
		map.put("like", svc.like(uid, hpnum, sido));
		return map;
	}

	// 게시글 비추천하기.
	@Transactional(rollbackFor = { Exception.class })
	@PostMapping("/dislike")
	public @ResponseBody Map<String, Boolean> dislike(@RequestParam(required = false) String uid,
			@RequestParam(required = false) int hpnum, @RequestParam(required = false) String sido) {
		Map<String, Boolean> map = new HashMap<>();
		map.put("dislike", svc.dislike(uid, hpnum, sido));
		return map;
	}

	// 게시글 찜하기.
	@Transactional(rollbackFor = { Exception.class })
	@PostMapping("/dibsOn")
	public @ResponseBody Map<String, Boolean> dibsOn(@RequestParam(required = false) String uid,
			@RequestParam(required = false) int hpnum, @RequestParam(required = false) String sido) {
		Map<String, Boolean> map = new HashMap<>();
		map.put("dibsOn", svc.dibsOn(uid, hpnum, sido));
		return map;
	}
}
