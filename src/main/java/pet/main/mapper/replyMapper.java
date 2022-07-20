package pet.main.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import pet.main.vo.BoardVO;
import pet.main.vo.PostVO;
import pet.main.vo.ReplyVO;

@Mapper
public interface replyMapper {
	
	BoardVO getBoardDetail(int i);
	
	List<ReplyVO> getReplyList(int i);
	
	int insertReply(ReplyVO reply);

	int insertNestedRep(ReplyVO reply);
	
	String maxScreenOrder(int i);
	
	int screenOrderUpdate(ReplyVO reply);

	int deleteReply(int i);

	int updateReply(ReplyVO reply);

	int deleteReply2(int i);

	int updateViewCnt(int i);

}
