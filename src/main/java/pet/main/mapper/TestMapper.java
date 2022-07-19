package pet.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import pet.main.vo.CodeVO;

@Mapper
public interface TestMapper {

	List<CodeVO> codeList();

}
