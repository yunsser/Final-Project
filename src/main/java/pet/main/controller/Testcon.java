package pet.main.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import pet.main.svc.HomeSVC;
import pet.main.vo.TestVO;

@Controller
@RequestMapping("/test")
public class Testcon {
	@Autowired HomeSVC svc;
	
	@GetMapping("/api")
	public String list(Model model) {
		List<TestVO> list = svc.list();
		model.addAttribute("list", list);
		return "index";
	}
	
}
