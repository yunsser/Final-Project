package pet.main.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import pet.main.vo.CodeVO;
import pet.main.vo.Sf_attachVO;
import pet.main.vo.ShareFcVO;

@Mapper
public interface ShareFcMapper {
	
	List<ShareFcVO> ShareFcList(String cate, String sido, String gugun);
	
	int addShareFc(ShareFcVO shareFc);
	
	List<Map<String, Object>> detailSharefc(int num);
	
	int addfile(Sf_attachVO shattach);
	
	int updateShareFc(ShareFcVO shareFc);
	
	int deletefile(int num);
	
	int deleteShareFc(int num);
	
	List<CodeVO> codeList();

	String getFilename(int num);
}
