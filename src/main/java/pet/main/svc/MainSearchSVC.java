package pet.main.svc;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import pet.main.dao.PostDAO;
import pet.main.dao.ShareFcDAO;
import pet.main.dao.TestDAO;
import pet.main.vo.CsvTestVO;
import pet.main.vo.Hp_VO;
import pet.main.vo.PageVO;
import pet.main.vo.PostVO;
import pet.main.vo.Seoul_hp_VO;
import pet.main.vo.ShareFcVO;

@Repository
public class MainSearchSVC {
	
	@Autowired
	private TestSVC svc;
	
	@Autowired
	private TestDAO testdao;
	
   @Autowired
   ShareFcDAO dao;
   
   @Autowired
   PostDAO postdao;
	
	public List<Hp_VO> hpsearch(String keyword){
		List<Seoul_hp_VO> seoullist = svc.getSeoullist();
		List<CsvTestVO> csvlist = svc.csvList();
		
		List<Hp_VO> list = new ArrayList<>();
		List<Hp_VO> list2 = new ArrayList<>();
		
		for(int i=0; i<seoullist.size();i++) {
			
			String MGTNO = (String) seoullist.get(i).getMGTNO();
			String OPNSFTEAMCODE = (String) seoullist.get(i).getOPNSFTEAMCODE();
			String TRDSTATEGBN = (String) seoullist.get(i).getTRDSTATEGBN();
			String TRDSTATENM = (String) seoullist.get(i).getTRDSTATENM();
			String BPLCNM = (String) seoullist.get(i).getBPLCNM();
			String SITETEL = (String) seoullist.get(i).getSITETEL();
			String SITEWHLADDR = (String) seoullist.get(i).getSITEWHLADDR();
			String RDNWHLADDR = (String) seoullist.get(i).getRDNWHLADDR();
			
			if(TRDSTATEGBN.equals("01")) {
				Hp_VO data = new Hp_VO();
				data.setMGTNO(MGTNO);
				data.setOPNSFTEAMCODE(OPNSFTEAMCODE);
				data.setTRDSTATEGBN(TRDSTATEGBN);
				data.setTRDSTATENM(TRDSTATENM);
				data.setBPLCNM(BPLCNM);
				data.setSITETEL(SITETEL);
				data.setSITEWHLADDR(SITEWHLADDR);
				data.setRDNWHLADDR(RDNWHLADDR);		
				
				list.add(data);
				
			}
			

			
		}
		
		for(int i=0; i<csvlist.size();i++) {
			
			String MGTNO = (String) csvlist.get(i).getMGTNO();
			String OPNSFTEAMCODE = (String) csvlist.get(i).getOPNSFTEAMCODE();
			String TRDSTATEGBN = (String) csvlist.get(i).getTRDSTATEGBN();
			String TRDSTATENM = (String) csvlist.get(i).getTRDSTATENM();
			String BPLCNM = (String) csvlist.get(i).getBPLCNM();
			String SITETEL = (String) csvlist.get(i).getSITETEL();
			String SITEWHLADDR = (String) csvlist.get(i).getSITEWHLADDR();
			String RDNWHLADDR = (String) csvlist.get(i).getRDNWHLADDR();
			
			if(TRDSTATEGBN.equals("01") && OPNSFTEAMCODE.length()!=0) {
				
				Hp_VO data = new Hp_VO();
				data.setMGTNO(MGTNO);
				data.setOPNSFTEAMCODE(OPNSFTEAMCODE);
				data.setTRDSTATEGBN(TRDSTATEGBN);
				data.setTRDSTATENM(TRDSTATENM);
				data.setBPLCNM(BPLCNM);
				data.setSITETEL(SITETEL);
				data.setSITEWHLADDR(SITEWHLADDR);
				data.setRDNWHLADDR(RDNWHLADDR);		
				
				list.add(data);
				
			}
		
			
		}
		
		for(int j=0; j<list.size();j++) {
			//System.out.println(list.get(j).getRDNWHLADDR().contains(keyword));
			
			if(list.get(j).getBPLCNM().contains(keyword) || list.get(j).getRDNWHLADDR().contains(keyword) || list.get(j).getSITEWHLADDR().contains(keyword)) {
				//System.out.println("키워드"+keyword);
				//System.out.println(list.get(j).getRDNWHLADDR());
			
				Hp_VO data2 = new Hp_VO();
				
				data2.setMGTNO(list.get(j).getMGTNO());
				data2.setOPNSFTEAMCODE(list.get(j).getOPNSFTEAMCODE());
				data2.setTRDSTATEGBN(list.get(j).getTRDSTATEGBN());
				data2.setTRDSTATENM(list.get(j).getTRDSTATENM());
				data2.setBPLCNM(list.get(j).getBPLCNM());
				data2.setSITETEL(list.get(j).getSITETEL());
				data2.setSITEWHLADDR(list.get(j).getSITEWHLADDR());
				data2.setRDNWHLADDR(list.get(j).getRDNWHLADDR());	
				
				list2.add(data2);
			}
			
		}
			
		return list2;
	}
	
	
	
   // 동물병원 갯수
   public int countSearchList(String keyword) {
	      List<Hp_VO> list = hpsearch(keyword);
	      int count = list.size();
	      return count;
	   }

   // 동물병원 검색 페이징
   public List<Hp_VO> hpSearchPage(PageVO vo, String keyword){
      List<Hp_VO> list = hpsearch(keyword);

      return list;
   }
   
   // 식당/카페 리스트
   public List<ShareFcVO> sfsearch(String keyword){
	   return dao.sfsearch(keyword);
   }
   
   // 식당/카페 페이징
   public PageInfo<ShareFcVO> sfSearchPage(int pageNum, String keyword){
	      PageHelper.startPage(pageNum,15);
	      PageInfo<ShareFcVO> pageInfo = new PageInfo<>(dao.sfsearch(keyword),5);
	      return pageInfo;
	   }
   
   public int countsfsearch(String keyword) {
	   return dao.sfsearchcount(keyword);
   }
   
   // 공유게시판 검색 기능
   public List<PostVO> boardlist(String keyword){
	   return postdao.boardlist(keyword);
   }
   
   // 공유게시판 검색 카운트
   public int countboardlist(String keyword) {
	   return postdao.countboardlist(keyword);
   }
   
   // 공유게시판 페이징
   public PageInfo<PostVO> bdSearchPage(int pageNum, String keyword){
	      PageHelper.startPage(pageNum,15);
	      PageInfo<PostVO> pageInfo = new PageInfo<>(postdao.boardlist(keyword),5);
	      return pageInfo;
	   }
   
   // 찜한 동물병원 리스트
   public List<Hp_VO> hossearch(String uid){
      return testdao.dibsOnUid(uid);
   }
   
   
   // 동물병원 찜 갯수
   public int hoscountSearchList(String uid) {
         List<Hp_VO> list = hossearch(uid);
         int count = list.size();
         return count;
      }

   // 동물병원 찜 페이징
   public PageInfo<Hp_VO> hosSearchPage(int pageNum, String uid){
      PageHelper.startPage(pageNum,5);
      PageInfo<Hp_VO> pageInfo = new PageInfo<>(testdao.dibsOnUid(uid),5);
      return pageInfo;
   }

}
