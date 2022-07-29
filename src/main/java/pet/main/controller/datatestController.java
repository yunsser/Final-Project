
package pet.main.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
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
@RequestMapping("/petmong/hp")
//@SessionAttributes("uid")
public class datatestController {

	@Autowired
	private TestSVC svc;
	@Autowired
	private replyService rService;

	// 동물병원 검색창
	@GetMapping("/search")
	public String search(PageVO vo, @RequestParam(required = false, defaultValue = "1") int pageNum,
			@RequestParam(name = "keyword", required = false, defaultValue = "") String keyword,
			@RequestParam(name = "gugunCD", required = false, defaultValue = "") String gugunCD,
			@RequestParam(name = "code", required = false, defaultValue = "") String code,
			@RequestParam(name = "uid", required = false, defaultValue = "") String uid, Model model)
			throws JsonProcessingException {
		ObjectMapper objm = new ObjectMapper();
		List list = svc.codeList();
		List codemap = svc.codeListMap();
		List gugunmap = svc.gugunListMap(code);
		String codeList = objm.writeValueAsString(list);
		model.addAttribute("codemap", codemap);
		model.addAttribute("gugunmap", gugunmap);
		model.addAttribute("codeList", codeList);
		model.addAttribute("gugunCD", gugunCD);
		model.addAttribute("code", code);
		model.addAttribute("keyword", keyword);
		model.addAttribute("uid",uid);

		return "api/searchpage";
	}

	// 동물병원 리스트
	@GetMapping("/pagelist")
	public String pagelist(PageVO vo, @RequestParam(required = false, defaultValue = "1") int pageNum,
			@RequestParam(name = "keyword", required = false, defaultValue = "") String keyword,
			@RequestParam(name = "gugunCD", required = false, defaultValue = "") String gugunCD,
			@RequestParam(name = "code", required = false, defaultValue = "") String code,
			@RequestParam(name = "uid", required = false) String uid, Model model)
			throws JsonProcessingException {
		ObjectMapper objm = new ObjectMapper();
		List list = svc.codeList();
		List codemap = svc.codeListMap();
		List gugunmap = svc.gugunListMap(code);
		String codeList = objm.writeValueAsString(list);
		model.addAttribute("codemap", codemap);
		model.addAttribute("gugunmap", gugunmap);
		model.addAttribute("codeList", codeList);
		model.addAttribute("gugunCD", gugunCD);
		model.addAttribute("code", code);
		model.addAttribute("keyword", keyword);
		//System.out.println("리스트"+uid);


		if (code.equals("1")) {

			int seoultotal = svc.countSeoulList(code, keyword, gugunCD);
			vo = new PageVO(seoultotal, pageNum, 10);
			List<Seoul_hp_VO> listpage =  svc.selectSeoulList(vo, code, keyword, gugunCD);
			model.addAttribute("page", vo);
			model.addAttribute("list", listpage);
			//System.out.println(seoultotal);
			
			List<String> spnumList = new ArrayList<>();
			for(int i = 0; i < listpage.size(); i++ ){
				spnumList.add(svc.dibsOnPnum(uid,listpage.get(i).getMGTNO()));
			};
			model.addAttribute("spnumList", spnumList);
			
		}

		else {

			int csvtotal = svc.countCSVList(code, keyword, gugunCD);
			PageVO vo2 = new PageVO(csvtotal, pageNum, 10);
			List<CsvTestVO> listpage = svc.selectCsvList(vo2, code, keyword, gugunCD);
			model.addAttribute("page", vo2);
			model.addAttribute("list", listpage);
			//System.out.println(csvtotal);
			
			List<String> spnumList = new ArrayList<>();
			for(int i = 0; i < listpage.size(); i++ ){
				spnumList.add(svc.dibsOnPnum(uid,listpage.get(i).getMGTNO()));
			};
			model.addAttribute("spnumList", spnumList);
		}

		return "api/codepage";
	}

	// 동물병원 상세보기
	@GetMapping("/detail")
	public String detail(@RequestParam(required = false, defaultValue = "1") int pageNum, @RequestParam String mgtno,
			Model model, @RequestParam(name="uid",required = false) String uid) {
		Seoul_hp_VO seouldetail = svc.detail(mgtno);
		CsvTestVO csvdetail = svc.csvdetail(mgtno);
		//uid = "Kakao_2363238007";
		model.addAttribute("seouldetail", seouldetail);
		model.addAttribute("csvdetail", csvdetail);
		model.addAttribute("mgtno", mgtno);
		List<ReviewVO> reviewlist = svc.getReviewList(mgtno);
		model.addAttribute("reviewlist", reviewlist);
		model.addAttribute("hp_mgtno",svc.dibsOnPnum(uid, mgtno));
		//System.out.println("uid+mgtno: " + svc.dibsOnPnum(uid, mgtno));
		//System.out.println("uid: " + uid);
		//System.out.println("mgtno: " + mgtno);
//      List<ReplyVO> replyList = rService.getReplyList(mgtno);
		// System.out.println(replyList);
//      model.addAttribute("replyList", replyList);
		PageInfo<ReviewVO> pageInfo = svc.reviewpaging(pageNum, mgtno);
		model.addAttribute("pageInfo", pageInfo);
		return "api/detail";
	}
	
	// 동물병원 상세보기
	@GetMapping("/detailrv")
	public String detailrv(@RequestParam(required = false, defaultValue = "1") int pageNum, @RequestParam String mgtno,
			Model model, @SessionAttribute(name = "uid", required = false) String uid) {
		Seoul_hp_VO seouldetail = svc.detail(mgtno);
		CsvTestVO csvdetail = svc.csvdetail(mgtno);
		model.addAttribute("seouldetail", seouldetail);
		model.addAttribute("csvdetail", csvdetail);
		model.addAttribute("mgtno", mgtno);
		List<ReviewVO> reviewlist = svc.getReviewList(mgtno);
		model.addAttribute("reviewlist", reviewlist);
		model.addAttribute("hp_mgtno",svc.dibsOnPnum(uid, mgtno));
//      List<ReplyVO> replyList = rService.getReplyList(mgtno);
		// System.out.println(replyList);
//      model.addAttribute("replyList", replyList);
		PageInfo<ReviewVO> pageInfo = svc.reviewpaging(pageNum, mgtno);
		model.addAttribute("pageInfo", pageInfo);
		return "api/detailrv";
	}
	

	@PostMapping("/detail")
	@ResponseBody
	public Map<String, Boolean> addReview(String mgtno, Model model,
			@SessionAttribute(name = "uid", required = false) String uid, ReviewVO review) {
		boolean addReview = svc.addReview(review);
		model.addAttribute("mgtno", mgtno);
		Map<String, Boolean> map = new HashMap<>();
		map.put("addReview", addReview);
		// System.out.println("저장");
		return map;
	}

	@PostMapping("/detail/delete")
	@ResponseBody
	public Map<String, Boolean> deleteReview(@SessionAttribute(name = "uid", required = false) String uid,
			@RequestParam int rv_num) {
		boolean deleteReview = svc.deleteReview(rv_num);
		Map<String, Boolean> map = new HashMap<>();
		map.put("deleteReview", deleteReview);
		return map;
	}

	@PostMapping("/detail/update")
	@ResponseBody
	public Map<String, Boolean> updateReview(@SessionAttribute(name = "uid", required = false) String uid,
			ReviewVO review) {
		boolean updateReview = svc.updateReview(review);
		Map<String, Boolean> map = new HashMap<>();
		map.put("updateReview", updateReview);
		return map;
	}
	
	// 병원 찜하기.
	@Transactional(rollbackFor={Exception.class})
	@PostMapping("/dibsOn")
	public @ResponseBody Map<String, Boolean> dibsOn(@RequestParam(required = false) String uid,
													@RequestParam(required = false) String hp_mgtno,
													@RequestParam(required = false) String hp_name,
													@RequestParam(required = false) String hp_tel,
													@RequestParam(required = false) String hp_roadadd,
													@RequestParam(required = false) String hp_add,
													@RequestParam(required = false) String hp_sido,
													@RequestParam(required = false) String hp_gugun){
		Map<String, Boolean> map = new HashMap<>();
		map.put("dibsOn", svc.dibsOn(uid, hp_mgtno, hp_name, hp_tel, hp_roadadd, hp_add, hp_sido, hp_gugun));
		return map;
	}

}