package pet.main.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pet.main.mapper.PostMapper;


@Repository
public class PostDAO {
	@Autowired PostMapper mapper;
}
