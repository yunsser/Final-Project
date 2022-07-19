package pet.main.svc;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

import pet.main.dao.PostDAO;
import pet.main.vo.AttachVO;
import pet.main.vo.PagingVO;
import pet.main.vo.PostVO;

@Service
public class PostSVC {

	@Autowired
	PostDAO dao;
	
	public int count() {
		return dao.count();
	}

	public List<PostVO> select(PagingVO vo) {
		return dao.select(vo);
	}
	
	// 글업로드
		public boolean board(PostVO post) {
			return dao.board(post);
		}

		public boolean board(MultipartFile[] mfiles, HttpServletRequest request, PostVO post) {
			boolean saved = board(post); // 글 저장
			int num = post.getNum(); // 글 저장시 자동증가 필드
			// System.out.println(num + "확인");
			// System.out.println(mfiles+"1");
			if (!saved) {
				System.out.println("글 저장 실패");
				return false;
			}

			ServletContext context = request.getServletContext();
			String savePath = context.getRealPath("/upload");
			int fileCnt = mfiles.length;
			int saveCnt = 0;
			boolean fSaved = false;

			if (!mfiles[0].isEmpty()) {
				try {
					for (int i = 0; i < mfiles.length; i++) {
						String filename = mfiles[i].getOriginalFilename();
						mfiles[i].transferTo(new File(savePath + "/" + System.currentTimeMillis() / 100000 + filename)); // 서버측
																															// 디스크
						AttachVO attach = new AttachVO();
						attach.setHos_num(num);
						attach.setFilename(System.currentTimeMillis() / 100000 + filename);
						attach.setFilesize((int) mfiles[i].getSize());
						fSaved = dao.fileInfo(attach); // attach 테이블에 파일정보 저장
						// System.out.println(mfiles+"2");
						if (fSaved)
							saveCnt++;
					}

				} catch (Exception e) {
					e.printStackTrace();
				}
				return fileCnt == saveCnt ? true : false;// 고치기
			}
			// System.out.println(mfiles+"3");
			return saved;
		}

		// 게시글디테일
		public PostVO detailNum(int num) {
			List<Map<String, Object>> list = dao.detailNum(num);
			PostVO post = new PostVO();
			int size = list.size();
			for (int i = 0; i < size; i++) {
				Map<String, Object> map = list.get(i);
				if (i == 0) {
					post.setNum((int) map.get("num")); // 글번호
					post.setCategory((String) map.get("category")); // 카테고리
					post.setTitle((String) map.get("title")); // 제목
					post.setAuthor((String) map.get("author")); // 작성자
					post.setSummernote((String) map.get("summernote")); // 글내용
					post.setDate((java.sql.Date) map.get("date")); // 날짜
					post.setCount((int)map.get("count")); // 조회수 or 좋아요수
				}
				Object obj = map.get("filename");
				if (obj != null) {
					AttachVO att = new AttachVO();
					att.setAtt_num((int) map.get("att_num"));
					/* att.setNotice_num((int) map.get("notice_num")); */
					att.setFilename((String) map.get("filename"));
					att.setFilesize((int) map.get("filesize"));
					post.attach.add(att);
				}
			}
			return post;
		}

		// 글업데이트
		public boolean updated(PostVO post) {
			return dao.updated(post);
		}

		public boolean updated(HttpServletRequest request, PostVO post, MultipartFile[] mfiles,
				List<String> delfiles) {
			boolean deleteFileInfo = deleteFileInfo(delfiles);
			
			boolean saved = updated(post); // 글 저장
			int hos_num = post.getNum(); // 글 저장시 자동증가 필드
			if (!saved) {
				System.out.println("글 저장 실패");
				return false;
			}
			ServletContext context = request.getServletContext();
			String savePath = context.getRealPath("/upload");
			int fileCnt = mfiles.length;
			int saveCnt = 0;
			boolean fSaved = false;

			if (!mfiles[0].isEmpty()) {
				try {
					for (int i = 0; i < mfiles.length; i++) {
						String filename = mfiles[i].getOriginalFilename();

						mfiles[i].transferTo(new File(savePath + "/" + System.currentTimeMillis() / 100000 + filename)); // 서버측
																															// 디스크
						AttachVO attach = new AttachVO();
						attach.setHos_num(hos_num);
						attach.setFilename(System.currentTimeMillis() / 100000 + filename);
						attach.setFilesize((int) mfiles[i].getSize());
						fSaved = dao.fileInfo(attach);
						if (fSaved)
							saveCnt++;
					}

				} catch (Exception e) {
					e.printStackTrace();
				}
				return fileCnt == saveCnt ? true : false;

			}

			return saved;
		}

		// 글삭제
		public boolean deleted(int num) {
			return dao.deleted(num);
		}

		// 파일삭제
		public boolean deleteFileInfo(List<String> delfiles) {
			List<Boolean> ret = new ArrayList<>();
			for (int i = 0; i < delfiles.size(); i++) {
				Boolean res = dao.deleteFileInfo(Integer.parseInt(delfiles.get(i)));
				if (res)
					ret.add(res);
			}
			return delfiles.size() == ret.size();
		}

		public String getFilename(int num) {
			return dao.getFilename(num);
		}

	
}
