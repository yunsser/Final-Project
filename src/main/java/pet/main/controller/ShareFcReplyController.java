package pet.main.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import pet.main.svc.ShareFcSVC;
import pet.main.vo.ShareFcReplyVO;

@Controller
@RequestMapping("/petmong/shfc")
@SessionAttributes("uid")
public class ShareFcReplyController {
	
	@Autowired
	private ShareFcSVC rService;
	
	@ResponseBody
	@PostMapping("/insertReply")
	//댓글 삽입
	public Map<String, Boolean> insertReply(ShareFcReplyVO reply) {
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
	public Map<String, Boolean> insertNestedRep(ShareFcReplyVO reply) {
		rService.screenOrderUpdate(reply); // 삽입할 댓글보다 밑의 순서에 올 댓글들의 screenOrder +1
		boolean parentCnt = rService.plusChildCnt(reply.getParent()); // 부모댓글의 childCnt컬럼 +1
		reply.setScreenOrder(rService.getParentScreenOrder(reply.getParent())); // 새로운 자식 댓글의 screenOrder설정
		reply.setDepth(reply.getDepth()+1);  // 자식댓글이므로 depth항목에 +1
		boolean inserted = rService.insertNestedRep(reply);
		Map<String, Boolean> map = new HashMap<>();
		map.put("inserted", inserted);
		return map;
	}

	@ResponseBody
	@PostMapping("/deleteReply")
	public Map<String, Boolean> deleteReply(@RequestParam int idx) {
		Map<String, Boolean> map = new HashMap<>(); 
		boolean subtracted = rService.minusChildCnt(idx); // idx의 부모댓글의 childCnt-1
		boolean deleted = rService.deleteReply(idx); // 댓글번호를 이용해 삭제(db에서 삭제)
		map.put("deleted", deleted);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/deleteReply2")
	public Map<String, Boolean> deleteReply2(@RequestParam int idx) {
		boolean deleted2 = rService.deleteReply2(idx); // 내용을 '삭제된 댓글'로 대체
		Map<String, Boolean> map = new HashMap<>(); 
		map.put("deleted", deleted2);
		return map;
	}

	@ResponseBody
	@PostMapping("/updateReply")
	public Map<String, Boolean> updateReply(ShareFcReplyVO reply) {
		boolean updated = rService.updateReply(reply);
		//System.out.println(reply.getContent());
		Map<String, Boolean> map = new HashMap<>();
		map.put("updated", updated);
		return map;
	}

}
