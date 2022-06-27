package pet.main.mapper;

import org.apache.ibatis.annotations.Mapper;

import pet.main.vo.TestVO;

@Mapper
public interface TestMapper {

	int memberJoin(TestVO test);
	TestVO getUid(String uid);

}
