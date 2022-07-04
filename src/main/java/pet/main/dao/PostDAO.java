package pet.main.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pet.main.mapper.PostMapper;
import pet.main.vo.PostVO;


@Repository
public class PostDAO {
	@Autowired PostMapper postmapper;

	public boolean addBoard(PostVO post) {
		return postmapper.addBoard(post) > 0;
	}
}
