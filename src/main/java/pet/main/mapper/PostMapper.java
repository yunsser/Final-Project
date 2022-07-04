package pet.main.mapper;

import org.apache.ibatis.annotations.Mapper;

import pet.main.vo.PostVO;

@Mapper
public interface PostMapper {

	int addBoard(PostVO post);


}
