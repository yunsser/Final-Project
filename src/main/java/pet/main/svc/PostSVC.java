package pet.main.svc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pet.main.dao.PostDAO;

@Service
public class PostSVC {
	
	@Autowired PostDAO dao;

}
