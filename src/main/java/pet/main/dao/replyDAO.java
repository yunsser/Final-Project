package pet.main.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pet.main.vo.BoardVO;
import pet.main.vo.PostVO;
import pet.main.vo.ReplyVO;
import pet.main.mapper.replyMapper;


@Repository
public class replyDAO {

	@Autowired
	private replyMapper rMapper;

	public BoardVO getBoardDetail(int i) {
		return rMapper.getBoardDetail(i);
	}

	public List<ReplyVO> getReplyList(int i) {
		return rMapper.getReplyList(i);
	}

	public boolean insertReply(ReplyVO reply) {
		return rMapper.insertReply(reply)>0;
	}

	public boolean insertNestedRep(ReplyVO reply) {
		return rMapper.insertNestedRep(reply)>0;
	}

	public String maxScreenOrder(int i) {
		return rMapper.maxScreenOrder(i);
	}

	public boolean screenOrderUpdate(ReplyVO reply) {
		return rMapper.screenOrderUpdate(reply)>0;
	}

	public boolean deleteReply(int i) {
		return rMapper.deleteReply(i)>0;
	}

	public boolean updateReply(ReplyVO reply) {
		return rMapper.updateReply(reply)>0;
	}

	public boolean deleteReply2(int i) {
		return rMapper.deleteReply2(i)>0;
	}

	public boolean updateViewCnt(int i) {
		return rMapper.updateViewCnt(i)>0;
	}
}

