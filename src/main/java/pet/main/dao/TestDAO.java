package pet.main.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pet.main.mapper.TestMapper;
import pet.main.vo.CodeVO;
import pet.main.vo.Hp_VO;

@Repository
public class TestDAO {

	@Autowired
	TestMapper mapper;

	public List<CodeVO> codeList() {
		return mapper.codeList();
	}

	// 게시글 찜하기.
	public int dibsOn(Map<String, Object> map) {
		return mapper.dibsOn(map);
	}

	// 찜 한 게시글 확인. (중복저장 하지않기위해.)
	public int dibsOnCancle(Map<String, Object> map) {
		return mapper.dibsOnCancle(map);
	}

	// 찜 한 게시글 수 가져오기.
	public int dibsOnCnt(String uid) {
		return mapper.dibsOnCnt(uid);
	}

	// 찜 한 여부 색상 보기 위한 데이터 가져오기.
	// 반환값이 null이 될 수 있기 때문에 반환 자료형 타입을 Integer로 변경.
	public String dibsOnPnum(Map<String, Object> map) {
		return mapper.dibsOnPnum(map);
	}

	// 찜한 동물병원리스트
	public List<Hp_VO> dibsOnUid(String uid) {
		return mapper.dibsOnUid(uid);
	}
}
