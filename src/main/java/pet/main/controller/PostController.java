package pet.main.controller;

import java.io.IOException;
import java.sql.SQLException;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import pet.main.dao.PostDAO;
import pet.main.svc.PostSVC;
import pet.main.svc.TestSVC;
import pet.main.vo.PageVO;
import pet.main.vo.PagingVO;
import pet.main.vo.PostVO;

@Controller
@RequestMapping("/post")
public class PostController {

	@Autowired
	PostSVC svc;
	
	@Autowired
	private TestSVC codesvc;
	
	@Autowired
	PostDAO dao;
	
	@Autowired
	ResourceLoader resourceLoader;

	
//	공지사항 게시판 리스트 + 페이징
	@GetMapping("/list")
	public String noticeList(/*@SessionAttribute(name = "id", required = false)String id,*/  PagingVO vo, Model model,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage) {

		/*
		 * if (id == null) { return "redirect:/post/home"; } else {
		 */
			int total = svc.count();
			if (nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "15";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if (cntPerPage == null) {
				cntPerPage = "15";
			}
			List<Map<String, String>> list = dao.getBoard();
			model.addAttribute("list", list);
			vo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			model.addAttribute("paging", vo);
			model.addAttribute("viewAll", svc.select(vo));
			return "post/list";
			/* } */

	}

//	게시판 글쓰기
	@GetMapping("/board")
	public String board(@RequestParam(name="gugunCD", required=false, defaultValue="")String gugunCD,
			@RequestParam(name="code", required=false, defaultValue="")String code,
			@RequestParam(name="sidoNm", required=false, defaultValue="")String sidoNm,
			@RequestParam(name="gugunNm", required=false, defaultValue="")String gugunNm,
			Model model) throws JsonProcessingException {
		ObjectMapper objm = new ObjectMapper();
		List list = codesvc.codeList();
		List codemap = codesvc.codeListMap();
		List gugunmap = codesvc.gugunListMap(code);
        String codeList = objm.writeValueAsString(list);
        model.addAttribute("codemap",codemap);
        model.addAttribute("gugunmap",gugunmap);
        model.addAttribute("codeList", codeList);
        model.addAttribute("gugunCD", gugunCD);
        model.addAttribute("code",code);
        model.addAttribute("sidoNm", sidoNm);
        model.addAttribute("gugunNm", gugunNm);
		return "post/board";

	}

	@PostMapping("/board")
	@ResponseBody
	public Map<String, Boolean> board(
			@SessionAttribute(name = "id", required = false) @RequestParam(name = "mfiles", required = false) MultipartFile[] mfiles,
			HttpServletRequest request, PostVO post){        
		Map<String, Boolean> map = new HashMap<>();
		boolean added = svc.board(mfiles, request, post);
		// System.out.println(mfiles);
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

//	게시판 수정화면보기
	
	@GetMapping("/detail")
	public String detailBoard(@SessionAttribute(name = "id", required = false) @RequestParam int num,
			Model model) { // 일치시켜주면 // 들어감
		PostVO post = svc.detailNum(num);
		model.addAttribute("post", post);
		return "post/detail";
	}

	@GetMapping("/edit")
	public String detailedit(@SessionAttribute(name = "id", required = false) @RequestParam int num,
			Model model) {
		PostVO post = svc.detailNum(num);
		model.addAttribute("post", post);
		return "post/edit";
	}

//	게시판 수정하기
	@PostMapping("/update")
	@ResponseBody
	public Map<String, Boolean> updateBoard(
			@SessionAttribute(name = "id", required = false) @RequestParam(name = "mfiles", required = false) MultipartFile[] mfiles,
			HttpServletRequest request, PostVO post, List<String> delfiles, Model model) {
		Map<String, Boolean> map = new HashMap<>();
		boolean updated = svc.updated(request, post, mfiles, delfiles);
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
}
