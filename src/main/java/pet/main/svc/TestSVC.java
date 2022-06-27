package pet.main.svc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pet.main.dao.TestDAO;
import pet.main.vo.TestVO;

@Service
public class TestSVC {
	
	@Autowired TestDAO dao;

	public boolean memberJoin(TestVO test) {
		return dao.memberJoin(test);
	}
	
	public boolean idCheck(String uid) {
		return dao.idCheck(uid);
	}

}
