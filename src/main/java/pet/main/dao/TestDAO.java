package pet.main.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pet.main.mapper.TestMapper;
import pet.main.vo.CodeVO;

@Repository
public class TestDAO {
	
	@Autowired TestMapper mapper;

   public List<CodeVO> codeList() {
	      return mapper.codeList();
   }


}
