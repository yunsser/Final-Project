package pet.main.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pet.main.mapper.ShareFcMapper;
import pet.main.vo.CodeVO;
import pet.main.vo.Sf_attachVO;
import pet.main.vo.ShareFcVO;

@Repository
public class ShareFcDAO {
	
	@Autowired
	ShareFcMapper Mapper;
	
	public List<ShareFcVO> ShareFcList(String cate, String sido, String gugun){
		return Mapper.ShareFcList(cate, sido, gugun);
	}
	
	public boolean addShareFc(ShareFcVO shareFc) {
		return Mapper.addShareFc(shareFc)>0;
	}
	
	public List<Map<String, Object>> detailSharefc(int num){
		return Mapper.detailSharefc(num);
	}
	
	public boolean addfile(Sf_attachVO shattach) {
		return Mapper.addfile(shattach)>0;
	}
	
	public boolean updateShareFc(ShareFcVO shareFc) {
		System.out.println(Mapper.updateShareFc(shareFc));
		return Mapper.updateShareFc(shareFc)>0;
	}
	
	public boolean deletefile(int num) {
		return Mapper.deletefile(num)>0;
	}
	
	public boolean deleteShareFc(int num) {
		return Mapper.deleteShareFc(num)>0;
	}
	
	public List<CodeVO> codeList() {
	     return Mapper.codeList();
	}
	
	public String getFilename(int num) {
	      return Mapper.getFilename(num);
	   }
	
	
}
