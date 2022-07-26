
package pet.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageInfo;

import pet.main.svc.TestSVC;
import pet.main.svc.replyService;
import pet.main.vo.CsvTestVO;
import pet.main.vo.PageVO;
import pet.main.vo.ReplyVO;
import pet.main.vo.ReviewVO;
import pet.main.vo.Seoul_hp_VO;

@Controller
@RequestMapping("/")
@SessionAttributes("uid")
public class datatestController {
	
	@Autowired
	private TestSVC svc;
	@Autowired
	private replyService rService;
	
	// 동물병원 검색창
	@GetMapping("/search")
	public String search(PageVO vo, @RequestParam(required=false, defaultValue="1") int pageNum, @RequestParam(name="keyword", required=false, defaultValue="")String keyword, @RequestParam(name="gugunCD", required=false, defaultValue="")String gugunCD, @RequestParam(name="code", required=false, defaultValue="")String code, Model model) throws JsonProcessingException {
        ObjectMapper objm = new ObjectMapper();
        List list = svc.codeList();
        List codemap = svc.codeListMap();
        List gugunmap = svc.gugunListMap(code);
        String codeList = objm.writeValueAsString(list);
        model.addAttribute("codemap",codemap);
        model.addAttribute("gugunmap",gugunmap);
        model.addAttribute("codeList", codeList);
        model.addAttribute("gugunCD", gugunCD);
        model.addAttribute("code",code);
        model.addAttribute("keyword", keyword);
        
       return "api/searchpage";
	}
        

	// 동물병원 리스트
	@GetMapping("/pagelist")
	public String pagelist(PageVO vo, @RequestParam(required=false, defaultValue="1") int pageNum, @RequestParam(name="keyword", required=false, defaultValue="")String keyword, @RequestParam(name="gugunCD", required=false, defaultValue="")String gugunCD, @RequestParam(name="code", required=false, defaultValue="")String code, Model model) throws JsonProcessingException {
         ObjectMapper objm = new ObjectMapper();
         List list = svc.codeList();
         List codemap = svc.codeListMap();
         List gugunmap = svc.gugunListMap(code);
         String codeList = objm.writeValueAsString(list);
         model.addAttribute("codemap",codemap);
         model.addAttribute("gugunmap",gugunmap);
         model.addAttribute("codeList", codeList);
         model.addAttribute("gugunCD", gugunCD);
         model.addAttribute("code",code);
         model.addAttribute("keyword", keyword);
         
        if(code.equals("1")) {
        	
         int seoultotal = svc.countSeoulList(code, keyword, gugunCD);
         vo = new PageVO(seoultotal, pageNum, 10);
         model.addAttribute("page",vo);
         model.addAttribute("list", svc.selectSeoulList(vo, code, keyword, gugunCD));
         System.out.println(seoultotal);
        }
        
        else {
        	
         int csvtotal = svc.countCSVList(code, keyword, gugunCD);
         PageVO vo2 = new PageVO(csvtotal, pageNum, 10);
         model.addAttribute("page", vo2);
         model.addAttribute("list", svc.selectCsvList(vo2, code, keyword, gugunCD));
         System.out.println(csvtotal);
        }
        	 
   
         return "api/codepage";
    }
 
	// 동물병원 상세보기
	@GetMapping("/detail")
	public String detail(@RequestParam(required=false, defaultValue = "1")int pageNum, @RequestParam String mgtno, Model model, @SessionAttribute(name="uid", required=false) String uid) {
      Seoul_hp_VO seouldetail = svc.detail(mgtno);
      CsvTestVO csvdetail = svc.csvdetail(mgtno);
      model.addAttribute("seouldetail", seouldetail);
      model.addAttribute("csvdetail", csvdetail);
      model.addAttribute("mgtno",mgtno);
      List<ReviewVO> reviewlist = svc.getReviewList(mgtno);
      model.addAttribute("reviewlist", reviewlist);
//      List<ReplyVO> replyList = rService.getReplyList(mgtno);
      //System.out.println(replyList);
//      model.addAttribute("replyList", replyList);
      PageInfo<ReviewVO> pageInfo = svc.reviewpaging(pageNum, mgtno);
      model.addAttribute("pageInfo",pageInfo);
      return "api/detail";
   }
	
	@PostMapping("/detail")
	@ResponseBody
	public Map<String, Boolean> addReview(String mgtno, Model model, @SessionAttribute(name="uid", required=false) String uid, ReviewVO review){
		boolean addReview = svc.addReview(review);
		model.addAttribute("mgtno",mgtno);
		Map<String, Boolean> map = new HashMap<>();
		map.put("addReview", addReview);
		//System.out.println("저장");
		return map;
	}
	
	@PostMapping("/detail/delete")
	@ResponseBody
	public Map<String, Boolean> deleteReview(@SessionAttribute(name="uid", required=false) String uid, @RequestParam int rv_num){
		boolean deleteReview = svc.deleteReview(rv_num);
		Map<String, Boolean> map = new HashMap<>();
		map.put("deleteReview", deleteReview);
		return map;
	}
	
	@PostMapping("/detail/update")
	@ResponseBody
	public Map<String, Boolean> updateReview(@SessionAttribute(name="uid", required=false) String uid, ReviewVO review){
		boolean updateReview = svc.updateReview(review);
		Map<String, Boolean> map = new HashMap<>();
		map.put("updateReview", updateReview);
		return map;
	}
	




	
	
	
}