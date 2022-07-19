package pet.main.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import pet.main.vo.AttachVO;
import pet.main.vo.PagingVO;
import pet.main.vo.PostVO;

@Mapper
public interface PostMapper {

	 int countNotice();

		List<PostVO> select(PagingVO vo);

		int board(PostVO post);

		int updated(PostVO post);

		int deleted(int num);

		List<Map<String, Object>> detailNum(int num);

		int deleteFileInfo(int num);

		int fileInfo(AttachVO attach);

		List<Map<String, String>> getBoard();

		String getFilename(int num);

		int count();
	
	/*
	int addBoard(PostVO post);
	
	String getFilename(int num);

	int addFileInfo(AttachVO attach);
*/
}
