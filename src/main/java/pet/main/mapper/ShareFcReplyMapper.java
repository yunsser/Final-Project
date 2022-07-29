package pet.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import pet.main.vo.BoardVO;
import pet.main.vo.ReplyVO;
import pet.main.vo.ShareFcReplyVO;

@Mapper
public interface ShareFcReplyMapper {
	
	BoardVO getBoardDetail(int i);

	List<ShareFcReplyVO> getReplyList(int i);

	int insertReply(ShareFcReplyVO reply);

	int insertNestedRep(ShareFcReplyVO reply);

	String maxScreenOrder(int i);

	int screenOrderUpdate(ShareFcReplyVO reply);

	int updateReply(ShareFcReplyVO reply);

	int updateViewCnt(int i);
	
	int deleteReply(int i);

	int deleteReply2(int i);

	int plusChildCnt(int parent);

	int getParentScreenOrder(int parent);

	int getReplyCnt(int num);

	int minusChildCnt(int idx);

}
