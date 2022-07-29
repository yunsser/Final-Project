package pet.main.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import pet.main.vo.CodeVO;
import pet.main.vo.Hp_VO;

@Mapper
public interface TestMapper {

	List<CodeVO> codeList();
	
	// 게시글 찜하기.
	int dibsOn(Map<String, Object> map);
	
	// 찜 한 게시글 확인. (중복저장 하지않기위해.)
	int dibsOnCancle(Map<String, Object> map);
	
	// 찜 한 게시글 수 가져오기.
	int dibsOnCnt(String uid);

	// 찜 한 여부 색상 보기 위한 데이터 가져오기.
	// 반환값이 null이 될 수 있기 때문에 반환 자료형 타입을 Integer로 변경. 
	String dibsOnPnum(Map<String, Object> map);

	List<Hp_VO> dibsOnUid(String uid);

}
