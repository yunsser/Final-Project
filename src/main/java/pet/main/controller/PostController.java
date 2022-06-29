package pet.main.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import pet.main.svc.PostSVC;

@Controller
@RequestMapping("/post")
public class PostController {

	@Autowired
	PostSVC postsvc;

	@GetMapping("/upload")
	public String upload() {
		return "post/post";
	}
	

	@PostMapping("/image")
	public String image() {
		return "";
	}

	
	
}
