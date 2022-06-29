package pet.main.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import pet.main.svc.PostSVC;

@Controller
@RequestMapping("/post")
public class PostController {
	
	@Autowired PostSVC svc;
	
	@GetMapping("/uploaddd")
	public String upload() {
		return "post/post";
	}

}
