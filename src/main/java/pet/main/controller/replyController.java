package pet.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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

import pet.main.svc.replyService;
import pet.main.vo.BoardVO;
import pet.main.vo.ReplyVO;


@Controller
@RequestMapping("/")
@SessionAttributes("uid")
public class replyController {

	@Autowired
	private replyService rService;

	@GetMapping("/bDetail")
	public String boardDetail(Model model, @SessionAttribute(name="uid", required=false) String uid) {
		BoardVO board = rService.getBoardDetail(3); //게시판의 내용을 불러온다

		// 게시판 조회수증가
		// bService.updateViewCnt(board);

		//로그인 체크
		/*boolean authorCheck = false;
		  if(uid==null) {
			return "redirect:/login/loginForm";
		} */


		List<ReplyVO> replyList = rService.getReplyList(3); // 해당 게시판의 댓글리스트를 불러온다
		model.addAttribute("uid", uid); // 현재 접속자의 uid 
		model.addAttribute("board", board); // 게시판 글 정보
		model.addAttribute("replyList", replyList); // 댓글리스트
		return "board";
	}

	@ResponseBody
	@PostMapping("/insertReply")
	//댓글 삽입
	public Map<String, Boolean> insertReply(ReplyVO reply) {
		String screenOrder = rService.maxScreenOrder(reply.getBoardIdx());  //3번 게시물의 가장 높은 댓글 순서 번호를 문자열로 가져온다
//		String screenOrder = rService.maxScreenOrder(reply.getBoardIdx());  //게시물의 가장 높은 댓글 순서 번호를 문자열로 가져온다8
		int sOrder = 0;  // 새 댓글을 넣을때 screenOrder를 설정해 줄 변수
		if(screenOrder != null) sOrder = Integer.parseInt(screenOrder) + 1; //null이 아니면 screenOrder의 최댓값 +1
		reply.setScreenOrder(sOrder);
		boolean inserted = rService.insertReply(reply); // 댓글내용 삽입
		Map<String, Boolean> map = new HashMap<>();
		map.put("inserted", inserted);
		return map;
	}

	@ResponseBody
	@PostMapping("/insertNestedRep")
	//대댓글 삽입
	public Map<String, Boolean> insertNestedRep(ReplyVO reply) {
		rService.screenOrderUpdate(reply); // 삽입할 댓글보다 밑의 순서에 올 댓글들의 screenOrder +1
		reply.setDepth(reply.getDepth()+1);  // 자식댓글이므로 depth항목에 +1
		reply.setScreenOrder(reply.getScreenOrder()+1); 
		boolean inserted = rService.insertNestedRep(reply);
		Map<String, Boolean> map = new HashMap<>();
		map.put("inserted", inserted);
		return map;
	}

	@ResponseBody
	@PostMapping("/deleteReply")
	public Map<String, Boolean> deleteReply(@RequestParam int idx) {
		//boolean deleted = rService.deleteReply(idx); // 댓글번호를 이용해 삭제(db에서 삭제)
		boolean deleted2 = rService.deleteReply2(idx); // 내용을 '삭제된 댓글'로 대체
		Map<String, Boolean> map = new HashMap<>(); 
		map.put("deleted", deleted2);
		return map;
	}

	@ResponseBody
	@PostMapping("/updateReply")
	public Map<String, Boolean> updateReply(ReplyVO reply) {
		boolean updated = rService.updateReply(reply);
		//System.out.println(reply.getContent());
		Map<String, Boolean> map = new HashMap<>();
		map.put("updated", updated);
		return map;
	}

}