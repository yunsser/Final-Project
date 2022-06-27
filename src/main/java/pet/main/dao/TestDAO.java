package pet.main.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pet.main.mapper.TestMapper;
import pet.main.vo.TestVO;

@Repository
public class TestDAO {
	
	@Autowired TestMapper mapper;

	public boolean memberJoin(TestVO test) {
		return mapper.memberJoin(test)>0;
	}

	public Boolean idCheck(String uid) {
		return (mapper.getUid(uid)==null);
	}

}
