package pet.main.svc;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;

import pet.main.dao.replyDAO;
import pet.main.vo.BoardVO;
import pet.main.vo.PostVO;
import pet.main.vo.ReplyVO;

@Service
public class replyService {

	@Autowired
	private replyDAO dao;


	public BoardVO getBoardDetail(int i) {
		return dao.getBoardDetail(i);
	}

	public List<ReplyVO> getReplyList(int i) {
		return dao.getReplyList(i);
	}

	public boolean insertReply(ReplyVO reply) {
		return dao.insertReply(reply);
	}

	public boolean insertNestedRep(ReplyVO reply) {
		return dao.insertNestedRep(reply);
	}

	public String maxScreenOrder(int i) {
		return dao.maxScreenOrder(i);
	}

	public boolean screenOrderUpdate(ReplyVO reply) {
		return dao.screenOrderUpdate(reply);
	}

	public boolean deleteReply(int i) {
		return dao.deleteReply(i);
	}

	public boolean deleteReply2(int i) {
		return dao.deleteReply2(i);
	}

	public boolean updateReply(ReplyVO reply) {
		return dao.updateReply(reply);
	}

	public boolean updateViewCnt(int i) {
		return dao.updateViewCnt(i);
	}
	
	public boolean plusChildCnt(int parent) {
		return dao.plusChildCnt(parent);
	}

	public int getParentScreenOrder(int parent) {
		return dao.getParentScreenOrder(parent);
	}

	public int getReplyCnt(int num) {
		return dao.getReplyCnt(num);
	}
	
	public List<ReplyVO> getReplyListPage(int pageNum, int num) {
		PageHelper.startPage(pageNum,6);
		return dao.getReplyList(num);
	}

	public boolean minusChildCnt(int idx) {
		return dao.minusChildCnt(idx);
	}

}
