package pet.main.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pet.main.mapper.PostMapper;
import pet.main.vo.AttachVO;
import pet.main.vo.PagingVO;
import pet.main.vo.PostVO;


@Repository
public class PostDAO {
	@Autowired PostMapper postmapper;
	
	public boolean board(PostVO post) {
		return postmapper.board(post) > 0;
	}

	public boolean updated(PostVO post) {
		return postmapper.updated(post)>0;
	}

	public boolean deleted(int num) {
		return postmapper.deleted(num) > 0;
	}

	public List<Map<String, Object>> detailNum(int num) {
		return postmapper.detailNum(num);
	}

	public Boolean deleteFileInfo(int num) {
		return postmapper.deleteFileInfo(num)>0;
	}

	public boolean fileInfo(AttachVO attach) {
		return postmapper.fileInfo(attach) > 0;
	}

	public List<Map<String, String>> getBoard() {
		return postmapper.getBoard();
	}

	public String getFilename(int num) {
		return postmapper.getFilename(num);
	}

	public int count() {
		return postmapper.count();
	}

	public List<PostVO> select(PagingVO vo) {
		return postmapper.select(vo);
	}

	
}
