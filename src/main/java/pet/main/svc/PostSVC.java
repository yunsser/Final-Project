package pet.main.svc;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

import pet.main.dao.PostDAO;
import pet.main.vo.PostVO;

@Service
public class PostSVC {

	@Autowired
	PostDAO dao;

	public boolean addBoard(PostVO post) {

		return dao.addBoard(post);
	}

	public boolean addBoard(MultipartFile[] mfiles, HttpServletRequest request, PostVO post) {
		boolean saved = addBoard(post); // 글 저장
		int num = post.getNum(); // 글 저장시 자동증가 필드
		// System.out.println(num + "확인");
		if (!saved) {
			System.out.println("글 저장 실패");
			return false;
		}

		return saved;

	}

}
