package pet.main.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

import pet.main.svc.PostSVC;
import pet.main.vo.PostVO;

@Controller
@RequestMapping("/post")
public class PostController {

	@Autowired
	PostSVC svc;

	@GetMapping("/upload")
	public String board() {
		return "post/post";

	}
	
	@PostMapping("/upload")
	@ResponseBody
	public Map<String, Boolean> add(
			@SessionAttribute(name = "id", required = false) @RequestParam(name = "files", required = false) MultipartFile[] mfiles,
			HttpServletRequest request, PostVO post) {
		Map<String, Boolean> map = new HashMap<>();
		boolean added = svc.addBoard(mfiles, request, post);
		map.put("added", added);
		return map;

	}

	@PostMapping(value="/uploadSummernoteImageFile", produces = "application/json")
	@ResponseBody
	public JsonObject uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) {
		
		JsonObject jsonObject = new JsonObject();
		
		String fileRoot = "C:\\Users\\user\\Desktop\\Final-Project\\imges\\";	//저장될 외부 파일 경로
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
				
		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		
		File targetFile = new File(fileRoot + savedFileName);	
		
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
			jsonObject.addProperty("url", "/summernoteImage/"+savedFileName);
			jsonObject.addProperty("responseCode", "success");
				
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		
		return jsonObject;
	}
	
//	// 썸머노트 이미지처리 ajax
//	@PostMapping("/summernoteImage")
//	@RequestMapping
//	// 썸머노트 이미지 처리
//	public String insertFormData2(@RequestParam(value = "file", required = false) MultipartFile file,
//			HttpSession session) {
//		Gson gson = new Gson();
//		Map<String, String> map = new HashMap<String, String>();
//		// 2) 웹 접근 경로(webPath) , 서버 저장 경로 (serverPath)
//		String WebPath = "/resources/images/summernoteImages/"; // DB에 저장되는 경로
//		String serverPath = session.getServletContext().getRealPath(WebPath);
//		String originalFileName = file.getOriginalFilename();
//		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
//		String savedFileName = UUID.randomUUID() + extension; // 저장될 파일 명
//		File targetFile = new File(serverPath + savedFileName);
//		try {
//			InputStream fileStream = file.getInputStream();
//			FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일 저장
//			// contextroot + resources + 저장할 내부 폴더명
//			map.put("url", WebPath + savedFileName);
//			map.put("responseCode", "success");
//		} catch (IOException e) {
//			FileUtils.deleteQuietly(targetFile); // 저장된 파일 삭제
//			map.put("responseCode", "error");
//			e.printStackTrace();
//		}
//		return gson.toJson(map);
//	}

}
