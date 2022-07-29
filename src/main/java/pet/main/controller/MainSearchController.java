package pet.main.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageInfo;

import pet.main.svc.MainSearchSVC;
import pet.main.svc.PostSVC;
import pet.main.svc.ShareFcSVC;
import pet.main.svc.TestSVC;
import pet.main.vo.Hp_VO;
import pet.main.vo.PageVO;
import pet.main.vo.PostVO;
import pet.main.vo.ShareFcVO;

@Controller
@RequestMapping("/petmong")
public class MainSearchController {
	
	@Autowired
	MainSearchSVC svc;
	
	@Autowired
	TestSVC testsvc;
	
	@Autowired
	ShareFcSVC sfsvc;
	
	@Autowired
	PostSVC postsvc;
   
   @GetMapping("/mainsearch")
   public String mainsearch(PageVO vo, 
		   @RequestParam(name="uid", required=false)String uid,
		   @RequestParam(required=false, defaultValue="1") int pageNum, 
		   @RequestParam String keyword, Model model) {
	   model.addAttribute("keyword", keyword);
	   
	   //System.out.println(uid);
	   List<Hp_VO> hplist = svc.hpSearchPage(vo, keyword);
	   int hptotal = svc.countSearchList(keyword);
	   //System.out.println(hptotal);
	   vo = new PageVO(hptotal, pageNum, 5);
	   model.addAttribute("hplist", hplist);
	   model.addAttribute("hptotal",hptotal);
	   model.addAttribute("hppage", vo);
	   List<String> hpnumList = new ArrayList<>();
		for(int i = 0; i < hplist.size(); i++ ){
			hpnumList.add(testsvc.dibsOnPnum(uid,hplist.get(i).getMGTNO()));
		};
		model.addAttribute("hpnumList", hpnumList);
	   //System.out.println("hpnumList" + hpnumList);
	   
	   List<ShareFcVO> sflist = svc.sfsearch(keyword);
	   PageInfo<ShareFcVO> pageInfo = svc.sfSearchPage(pageNum, keyword);
	   int sftotal = svc.countsfsearch(keyword);
	   model.addAttribute("sflist",sflist);
	   model.addAttribute("sftotal", sftotal);
	   model.addAttribute("sfpage",pageInfo);
	   List<Integer> sfnumList = new ArrayList<>();
		for(int i = 0; i < sflist.size(); i++ ){
			sfnumList.add(sfsvc.dibsOnPnum(uid,sflist.get(i).getSh_num()));
		};
		model.addAttribute("sfnumList", sfnumList);
		//System.out.println("sfnumList" + sfnumList);
		
	   List<PostVO> bdlist = svc.boardlist(keyword);
	   int bdtotal = svc.countboardlist(keyword);
	   model.addAttribute("bdlist", bdlist);
	   model.addAttribute("bdtotal", bdtotal);
	   List<Integer> bdnumList = new ArrayList<>();
		for(int i = 0; i < bdlist.size(); i++ ){
			bdnumList.add(postsvc.dibsOnPnum(uid,bdlist.get(i).getNum()));
		};
		model.addAttribute("bdnumList", bdnumList);
		//System.out.println("bdnumList" + bdnumList);
	   
      return "mainsearch/mainsearch";
   }
   
   @GetMapping("/hpsearch")
   public String hpsearch(PageVO vo, 
		   @RequestParam(name="uid", required =false) String uid,
		   @RequestParam(required=false, defaultValue="1") int pageNum, 
		   @RequestParam String keyword, Model model) {
	   model.addAttribute("keyword", keyword);

	   List<Hp_VO> hplist = svc.hpSearchPage(vo, keyword);
	   int hptotal = svc.countSearchList(keyword);
	   vo = new PageVO(hptotal, pageNum, 10);
	   model.addAttribute("hplist", hplist);
	   model.addAttribute("hppage", vo);
	   List<String> hpnumList = new ArrayList<>();
		for(int i = 0; i < hplist.size(); i++ ){
			hpnumList.add(testsvc.dibsOnPnum(uid,hplist.get(i).getMGTNO()));
		};
		model.addAttribute("hpnumList", hpnumList);
	   
      return "mainsearch/hpsearch";
   }
   
   @GetMapping("/sfsearch")
   public String sfsearch(PageVO vo, 
		   @RequestParam(name="uid", required =false) String uid,
		   @RequestParam(required=false, defaultValue="1") int pageNum, @RequestParam String keyword, Model model) {
	   model.addAttribute("keyword", keyword);
	   
	   List<ShareFcVO> sflist = svc.sfsearch(keyword);
	   PageInfo<ShareFcVO> pageInfo = svc.sfSearchPage(pageNum, keyword);
	   model.addAttribute("sflist",sflist);
	   model.addAttribute("sfpage",pageInfo);
	   List<Integer> sfnumList = new ArrayList<>();
		for(int i = 0; i < sflist.size(); i++ ){
			sfnumList.add(sfsvc.dibsOnPnum(uid,sflist.get(i).getSh_num()));
		};
		model.addAttribute("sfnumList", sfnumList);
	   
      return "mainsearch/sfsearch";
   }
   
   @GetMapping("/bdsearch")
   public String bdsearch(PageVO vo, 
		   @RequestParam(name="uid", required =false) String uid,
		   @RequestParam(required=false, defaultValue="1") int pageNum, @RequestParam String keyword, Model model) {
	   model.addAttribute("keyword", keyword);
	   
	   List<PostVO> bdlist = svc.boardlist(keyword);
	   int bdtotal = svc.countboardlist(keyword);
	   model.addAttribute("bdlist", bdlist);
	   model.addAttribute("bdtotal", bdtotal);
	   PageInfo<PostVO> pageInfo = svc.bdSearchPage(pageNum, keyword);
	   model.addAttribute("bdpage",pageInfo);
	   List<Integer> bdnumList = new ArrayList<>();
		for(int i = 0; i < bdlist.size(); i++ ){
			bdnumList.add(postsvc.dibsOnPnum(uid,bdlist.get(i).getNum()));
		};
		model.addAttribute("bdnumList", bdnumList);
	   
      return "mainsearch/bdsearch";
   }
   
  
   

}