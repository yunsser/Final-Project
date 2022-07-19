
package pet.main.controller;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import org.apache.tomcat.jni.Buffer;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.data.web.SpringDataWebProperties.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageInfo;

import pet.main.svc.TestSVC;
import pet.main.vo.CsvTestVO;
import pet.main.vo.PageVO;
import pet.main.vo.Seoul_hp_VO;

import java.io.BufferedReader;
import java.io.IOException;

@Controller
@RequestMapping("/test")
public class datatestController {
	
	@Autowired
	private TestSVC svc;
	
	@GetMapping("/search")
	public String search(PageVO vo, @RequestParam(required=false, defaultValue="1") int pageNum, @RequestParam(name="keyword", required=false, defaultValue="")String keyword, @RequestParam(name="gugunCD", required=false, defaultValue="")String gugunCD, @RequestParam(name="code", required=false, defaultValue="")String code, Model model) throws JsonProcessingException {
        ObjectMapper objm = new ObjectMapper();
        List list = svc.codeList();
        List codemap = svc.codeListMap();
        List gugunmap = svc.gugunListMap(code);
        String codeList = objm.writeValueAsString(list);
        model.addAttribute("codemap",codemap);
        model.addAttribute("gugunmap",gugunmap);
        model.addAttribute("codeList", codeList);
        model.addAttribute("gugunCD", gugunCD);
        model.addAttribute("code",code);
        model.addAttribute("keyword", keyword);
        
       return "api/searchpage";
	}
        

   @GetMapping("/pagelist")
   public String pagelist(PageVO vo, @RequestParam(required=false, defaultValue="1") int pageNum, @RequestParam(name="keyword", required=false, defaultValue="")String keyword, @RequestParam(name="gugunCD", required=false, defaultValue="")String gugunCD, @RequestParam(name="code", required=false, defaultValue="")String code, Model model) throws JsonProcessingException {
         ObjectMapper objm = new ObjectMapper();
         List list = svc.codeList();
         List codemap = svc.codeListMap();
         List gugunmap = svc.gugunListMap(code);
         String codeList = objm.writeValueAsString(list);
         model.addAttribute("codemap",codemap);
         model.addAttribute("gugunmap",gugunmap);
         model.addAttribute("codeList", codeList);
         model.addAttribute("gugunCD", gugunCD);
         model.addAttribute("code",code);
         model.addAttribute("keyword", keyword);
         
        if(code.equals("1")) {
        	
         int seoultotal = svc.countSeoulList(code, keyword, gugunCD);
         vo = new PageVO(seoultotal, pageNum, 10);
         model.addAttribute("page",vo);
         model.addAttribute("list", svc.selectSeoulList(vo, code, keyword, gugunCD));
         System.out.println(seoultotal);
        }
        
        else {
        	
         int csvtotal = svc.countCSVList(code, keyword, gugunCD);
         PageVO vo2 = new PageVO(csvtotal, pageNum, 10);
         model.addAttribute("page", vo2);
         model.addAttribute("list", svc.selectCsvList(vo2, code, keyword, gugunCD));
         System.out.println(csvtotal);
        }
        	 
   
         return "api/codepage";
    }
 
	
   @GetMapping("/detail")
   public String detail(@RequestParam String mgtno, Model model) {
      Seoul_hp_VO seouldetail = svc.detail(mgtno);
      CsvTestVO csvdetail = svc.csvdetail(mgtno);
      model.addAttribute("seouldetail", seouldetail);
      model.addAttribute("csvdetail", csvdetail);
      return "api/detail";
   }


	
	
	
}