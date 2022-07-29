package pet.main.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pet.main.mapper.ShareFcReplyMapper;
import pet.main.vo.BoardVO;
import pet.main.vo.ReplyVO;
import pet.main.vo.ShareFcReplyVO;

@Repository
public class ShareFcReplyDAO {
	
	@Autowired
	ShareFcReplyMapper Mapper;
	
	public BoardVO getBoardDetail(int i) {
		return Mapper.getBoardDetail(i);
	}

	public List<ShareFcReplyVO> getReplyList(int i) {
		return Mapper.getReplyList(i);
	}

	public boolean insertReply(ShareFcReplyVO reply) {
		return Mapper.insertReply(reply)>0;
	}

	public boolean insertNestedRep(ShareFcReplyVO reply) {
		return Mapper.insertNestedRep(reply)>0;
	}

	public String maxScreenOrder(int i) {
		return Mapper.maxScreenOrder(i);
	}

	public boolean screenOrderUpdate(ShareFcReplyVO reply) {
		return Mapper.screenOrderUpdate(reply)>0;
	}


	public boolean updateReply(ShareFcReplyVO reply) {
		return Mapper.updateReply(reply)>0;
	}

	public boolean updateViewCnt(int i) {
		return Mapper.updateViewCnt(i)>0;
	}
	
	public boolean deleteReply(int i) {
		return Mapper.deleteReply(i)>0;
	}

	public boolean deleteReply2(int i) {
		return Mapper.deleteReply2(i)>0;
	}
	
	public boolean plusChildCnt(int parent) {
		return Mapper.plusChildCnt(parent)>0;
	}

	public int getParentScreenOrder(int parent) {
		return Mapper.getParentScreenOrder(parent);
	}

	public int getReplyCnt(int num) {
		return Mapper.getReplyCnt(num);
	}

	public boolean minusChildCnt(int idx) {
		return Mapper.minusChildCnt(idx)>0;
	}

}
