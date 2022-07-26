package pet.main.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageInfo;

import pet.main.svc.ShareFcSVC;
import pet.main.svc.TestSVC;
import pet.main.svc.replyService;
import pet.main.vo.PostVO;
import pet.main.vo.ReplyVO;
import pet.main.vo.ShareFcVO;

@Controller
@RequestMapping("/")
@SessionAttributes("uid")
public class ShareFcController {
   
   @Autowired
   ShareFcSVC svc;
   
   @Autowired
   replyService rService;

   
   @Autowired
   ResourceLoader resourceLoader;
   
   // 반려동물 동반 가능 이용시설 공유 게시글 관련 컨트롤러
   
   // 게시판 리스트
   @GetMapping("/shfclist")
   public String boardlist(Model model,@RequestParam(required=false, defaultValue = "1")int pageNum, @RequestParam(name="cate", required = false, defaultValue ="")String cate, @RequestParam(name="sido", required = false, defaultValue ="")String sido, @RequestParam(name="gugun", required = false, defaultValue ="")String gugun) throws JsonProcessingException {
      ObjectMapper objm = new ObjectMapper();
       List codelist2 = svc.codeList();
       String codeList = objm.writeValueAsString(codelist2);
       model.addAttribute("codeList", codeList);
      List<ShareFcVO> list = svc.ShareFcList(cate, sido, gugun);
      model.addAttribute("cate",cate);
      model.addAttribute("list",list);
      PageInfo<ShareFcVO> pageInfo = svc.listpaging(pageNum, cate, sido, gugun);
      model.addAttribute("pageInfo",pageInfo);
      
        List codemap = svc.codeListMap();
        List gugunmap = svc.gugunListMap(sido);
        model.addAttribute("codemap", codemap);
        model.addAttribute("gugunmap", gugunmap);
      model.addAttribute("sido",sido);

      return "api/listplus";
   }
   
   // 글 등록 폼
   @GetMapping("/shfcboard")
   public String boardform(Model model, @SessionAttribute(name="uid", required=false) String uid) {
      return "api/boardplus";
   }
   
   // 글 등록 기능
   @PostMapping("/shfcboard")
   @ResponseBody
   public Map<String, Boolean> addShareFcList(@SessionAttribute(name = "uid", required = false) @RequestParam(name = "mfiles", required = false) MultipartFile[] mfiles,
         HttpServletRequest request, ShareFcVO shareFc) {
      //System.out.println(shareFc);
      boolean addShareFC = svc.addShareFc(mfiles, request, shareFc);
      Map<String, Boolean> map = new HashMap<>();
      map.put("addShareFC", addShareFC);
      return map;
   }
   
   // 글 디테일
   @GetMapping("/shfcdetail")
   public String boarddetail(@SessionAttribute(name = "uid", required = false) @RequestParam int num, Model model) {
      ShareFcVO detail = svc.detailSharefc(num);
      List<ReplyVO> replyList = rService.getReplyList(detail.getSh_num());
      model.addAttribute("replyList", replyList);
      model.addAttribute("detail",detail);
      return "api/detailplus";
   }
   
   
   // 장소검색팝업창
   @GetMapping("/fcsearch")
   public String restaurantsearch(String keyword, Model model) {
      model.addAttribute("keyword",keyword);
      return "api/fcsearchpopup";
   }
   
   // 글 수정폼
   @GetMapping("/shfcedit")
   public String editform(@SessionAttribute(name = "uid", required = false) @RequestParam int num,
   Model model) {
      ShareFcVO detail = svc.detailSharefc(num);
      model.addAttribute("detail",detail);
      return "api/editplus";
   }
   
   // 글 수정
   @PostMapping("/shfcedit/edit")
   @ResponseBody
   public Map<String, Boolean> updateShareFc(@SessionAttribute(name = "id", required = false) @RequestParam(name = "mfiles", required = false) MultipartFile[] mfiles,
   HttpServletRequest request, ShareFcVO shareFc, @RequestParam("delfiles") List<String> delfiles, Model model) {
      //System.out.println("컨트롤러"+shareFc);
      Map<String, Boolean> map = new HashMap<>();
      boolean updated = svc.updateShareFc(request, shareFc, mfiles, delfiles);
      map.put("updated", updated);
      return map;
   }
   
   // 글 삭제
   @PostMapping("/shfcedit/delete")
   @ResponseBody
   public Map<String, Boolean> deleteeShareFc(@RequestParam int num) {
      Map<String, Boolean> map = new HashMap<>();
      boolean deleted = svc.deleteShareFc(num);
      map.put("deleted", deleted);
      return map;
   }
   
   // 첨부파일 삭제
   @PostMapping("/shfcedit/filedelete")
   @ResponseBody
   public Map<String, Boolean> deleteFile(@RequestParam List<String> delfiles) {
      boolean deleteFileInfo = svc.deletefile(delfiles);
      Map<String, Boolean> map = new HashMap<>();
      map.put("deleteFileInfo", deleteFileInfo);
      return map;
   }
   
   // 첨부파일 다운로드
   @GetMapping("/shfcdetail/download/{num}")
   public ResponseEntity<Resource> fileDownload(@PathVariable int num, HttpServletRequest request) {
      // attach 테이블에서 att_num 번호를 이용하여 파일명을 구하여 위의 방법을 사용
      String filename = svc.getFilename(num);
      Resource resource = (Resource) resourceLoader.getResource("upload/" + filename);
      // System.out.println("파일명:"+resource.getFilename());
      String contentType = null;
      try {
         contentType = request.getServletContext().getMimeType(resource.getFile().getAbsolutePath());
      } catch (IOException e) {
         e.printStackTrace();
      }

      if (contentType == null) {
         contentType = "application/octet-stream";
      }

      return ResponseEntity.ok().contentType(MediaType.parseMediaType(contentType))
            .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
            .body(resource);
   }

   
   

}