package pet.main.svc;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pet.main.dao.replyDAO;
import pet.main.vo.BoardVO;
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

	public boolean updateReply(ReplyVO reply) {
		return dao.updateReply(reply);
	}

	public boolean deleteReply2(int i) {
		return dao.deleteReply2(i);
	}
}