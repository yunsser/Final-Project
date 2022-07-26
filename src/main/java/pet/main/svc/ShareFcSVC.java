package pet.main.svc;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import pet.main.dao.ShareFcDAO;
import pet.main.dao.TestDAO;
import pet.main.vo.CodeVO;
import pet.main.vo.Sf_attachVO;
import pet.main.vo.ShareFcVO;

@Service
public class ShareFcSVC {
   
   @Autowired
   ShareFcDAO dao;
   
   
   // 반려견동반이용시설 리스트
   public List<ShareFcVO> ShareFcList(String cate, String sido, String gugun){
      return dao.ShareFcList(cate, sido, gugun);
   }
   // 리스트 페이징
   public PageInfo<ShareFcVO> listpaging(int pageNum, String cate, String sido, String gugun){
      PageHelper.startPage(pageNum,15);
      PageInfo<ShareFcVO> pageInfo = new PageInfo<>(dao.ShareFcList(cate, sido, gugun),5);
      return pageInfo;
   }
   
   // 게시글 등록
   public boolean addShareFc(ShareFcVO shareFc) {
      return dao.addShareFc(shareFc);
   }

   // 게시글 등록(첨부파일포함)
   @Transactional(rollbackFor={Exception.class})
   public boolean addShareFc(MultipartFile[] mfiles, HttpServletRequest request, ShareFcVO shareFc) {
      boolean saved = addShareFc(shareFc);
      int num = shareFc.getSh_num();
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
               Sf_attachVO attach = new Sf_attachVO();
               attach.setShfc_num(num);
               attach.setFilename(System.currentTimeMillis() / 100000 + filename);
               attach.setFilesize((int) mfiles[i].getSize());
               fSaved = dao.addfile(attach); 
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
   
   // 게시글 디테일
   public ShareFcVO detailSharefc(int num) {
      List<Map<String, Object>> list = dao.detailSharefc(num);
      ShareFcVO vo = new ShareFcVO();
      for(int i=0; i<list.size(); i++) {
         Map<String, Object> map = list.get(i);
         if(i == 0) {
            vo.setSh_num((int)map.get("sh_num"));
            vo.setSh_facCate((String)map.get("sh_facCate"));
            vo.setSh_content((String)map.get("sh_content"));
            vo.setSh_title((String)map.get("sh_title"));
            vo.setSh_date((java.sql.Date)map.get("sh_date"));
            vo.setSh_facNM((String)map.get("sh_facNM"));
            vo.setSh_facSido((String)map.get("sh_facSido"));
            vo.setSh_facGugun((String)map.get("sh_facGugun"));
            vo.setSh_facAdd((String)map.get("sh_facAdd"));
            vo.setSh_facRoadAdd((String)map.get("sh_facRoadAdd"));
            vo.setSh_facTel((String)map.get("sh_facTel"));
            vo.setSh_name((String)map.get("sh_name"));
            vo.setSh_count((int)map.get("sh_count"));
         }
         Object obj = map.get("filename");
         if(obj != null) {
            Sf_attachVO att = new Sf_attachVO();
            att.setAtt_num((int)map.get("att_num"));
            att.setFilename((String)map.get("filename"));
            att.setFilesize((int)map.get("filesize"));
            vo.attach.add(att);
         }
      }
      
      return vo;
   }
   
   // 게시글 수정
   public boolean updateShareFc(ShareFcVO shareFc) {
      System.out.println(dao.updateShareFc(shareFc));
      return dao.updateShareFc(shareFc);
   }
   
   public boolean updateShareFc(HttpServletRequest request, ShareFcVO shareFc, MultipartFile[] mfiles,
         List<String> delfiles) {
      boolean deletefile = deletefile(delfiles);
      
      boolean saved = updateShareFc(shareFc); // 글 저장
      System.out.println(shareFc);
      int num = shareFc.getSh_num(); // 글 저장시 자동증가 필드
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
               Sf_attachVO attach = new Sf_attachVO();
               attach.setShfc_num(num);
               attach.setFilename(System.currentTimeMillis() / 100000 + filename);
               attach.setFilesize((int) mfiles[i].getSize());
               fSaved = dao.addfile(attach); 
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
   
   // 첨부파일 삭제
   public boolean deletefile(List<String> delfiles) {
      List<Boolean> ret = new ArrayList<>();
      for (int i = 0; i < delfiles.size(); i++) {
         Boolean res = dao.deletefile(Integer.parseInt(delfiles.get(i)));
         if (res)
            ret.add(res);
      }
      return delfiles.size() == ret.size();
   }
   
   // 게시글 삭제
   public boolean deleteShareFc(int num) {
      return dao.deleteShareFc(num);
   }
   
   
   public String getFilename(int num) {
      return dao.getFilename(num);
   }
   
   public List<CodeVO> codeList() {
            return dao.codeList();
      }
   
      public List<CodeVO> codeListMap(){
         List<CodeVO> list = dao.codeList();
         List<CodeVO> list2 = new ArrayList<>();
         System.out.println(list);
         for(int i=0;i<list.size();i++) {
            
            Map<Object, Object> m = (Map<Object, Object>) list.get(i);
            String codestr = (String)m.get("sidoCd");
            //System.out.println(codestr);
            if(codestr != null) {
               
               CodeVO vo = new CodeVO();
               vo.setTier((int)m.get("tier"));
               vo.setCode((String)m.get("code"));
               vo.setGugunCd((String)m.get("gugunCd"));
               vo.setGugunNm((String)m.get("gugunNm"));
               vo.setParent((String)m.get("parent"));
               vo.setSidoCd((String)m.get("sidoCd"));
               vo.setSidoNm((String)m.get("sidoNm"));
               
               list2.add(vo);
            }
            
         }      
         
         return list2;
      }
   

      public List<CodeVO> gugunListMap(String sido){
         List<CodeVO> list = dao.codeList();
         List<CodeVO> list2 = new ArrayList<>();
         
         for(int i=0;i<list.size();i++) {
            
            Map<Object, Object> m = (Map<Object, Object>) list.get(i);
            
            String parent = (String)m.get("parent");
            
            if(sido.equals(parent)) {
               
               CodeVO vo = new CodeVO();
               vo.setTier((int)m.get("tier"));
               vo.setCode((String)m.get("code"));
               vo.setGugunCd((String)m.get("gugunCd"));
               vo.setGugunNm((String)m.get("gugunNm"));
               vo.setParent((String)m.get("parent"));
               vo.setSidoCd((String)m.get("sidoCd"));
               vo.setSidoNm((String)m.get("sidoNm"));
               
               list2.add(vo);
            }
               
         }      

         return list2;
      } 
      
      
      
}