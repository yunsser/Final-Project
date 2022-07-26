package pet.main.svc;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import pet.main.dao.ReviewDAO;
import pet.main.dao.TestDAO;
import pet.main.vo.CodeVO;
import pet.main.vo.CsvTestVO;

import pet.main.vo.PageVO;
import pet.main.vo.ReviewVO;
import pet.main.vo.Seoul_hp_VO;

@Service
public class TestSVC {
	
	@Autowired
	TestDAO dao;
	@Autowired
	ReviewDAO reviewdao;
	
	
	//서울리스트 받아오기
   public List<Seoul_hp_VO> getSeoullist(){
      
        // 1. url 주소 만들기(끝)
        StringBuffer sbUrl = new StringBuffer();
     
        sbUrl.append("http://openapi.seoul.go.kr:8088/");
        sbUrl.append("71486858486c696d3234487a656748/");
        sbUrl.append("json/LOCALDATA_020301/1/1000/");


        // 2. 다운로드 받기(끝)
        try {
            // URL safe가 적용되어있음 -> 더이상 반영안함
            URL url = new URL(sbUrl.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection(); // 다운캐스팅해서 알아서 잡아라 (dip - 구체적인게 아니라 추상적인
                                                                               // 거에 의존한다) conn=socket
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8")); // 한글 안 깨지게
                                                                                                           // utf-8
            // 담는 것: 통신결과 모아두기
            StringBuffer result = new StringBuffer();
            String returnLine;
            List<Seoul_hp_VO> list = new ArrayList<>();
            Seoul_hp_VO vo = null;
            
            while((returnLine = br.readLine()) != null) {
               result.append(returnLine + "\n");
               
                JSONParser jsonParser = new JSONParser();
                JSONObject jsonObject = (JSONObject)jsonParser.parse(returnLine);
                JSONObject hospitalResult = (JSONObject)jsonObject.get("LOCALDATA_020301");      
                JSONArray rows = (JSONArray)hospitalResult.get("row");
                
                for(int i = 0; i<rows.size(); i++) {
                   vo = new Seoul_hp_VO();
                   JSONObject info = (JSONObject)rows.get(i);
                   vo.setOPNSFTEAMCODE((String) info.get("OPNSFTEAMCODE"));
                   vo.setTRDSTATEGBN((String) info.get("TRDSTATEGBN"));
                   vo.setTRDSTATENM((String) info.get("TRDSTATENM"));
                   vo.setBPLCNM((String) info.get("BPLCNM"));
                   vo.setMGTNO((String) info.get("MGTNO"));
                   vo.setSITETEL((String) info.get("SITETEL"));
                   vo.setSITEWHLADDR((String) info.get("SITEWHLADDR"));
                   vo.setRDNWHLADDR((String)info.get("RDNWHLADDR"));
                   vo.setlocX((String) info.get("X"));
                   vo.setlocY((String) info.get("Y"));

                    list.add(vo);
//	                    System.out.println(vo);
                }
                           
            }
//	            System.out.println("[list][get(0)]: " + list.get(0);
            br.close();
            conn.disconnect();
            return list;
        }catch (Exception e) {
           e.printStackTrace();
        }
        return null;
                
    }
   
   // 서울리스트 받아오기(행정코드,키워드,구군코드)
   public List<Seoul_hp_VO> getSeoullist(String code, String keyword, String gugunCD){
		
		List<Seoul_hp_VO> list = new ArrayList();
		//System.out.println("키워드:" + keyword);
		//System.out.println("코드:" + gugunCD);
		
		StringBuffer result = new StringBuffer();

		String urlstr = "http://openapi.seoul.go.kr:8088/"
				+ "5a516a7a63736e653130324d44456563/"  // 인증키
				+ "json/LOCALDATA_020301/1/1000/";    //json/데이터/시작번호/끝번호
		
		String urlstr2 = "http://openapi.seoul.go.kr:8088/"
				+ "5a516a7a63736e653130324d44456563/"  // 인증키
				+ "json/LOCALDATA_020301/1001/2000/";
		
		String urlstr3 = "http://openapi.seoul.go.kr:8088/"
				+ "5a516a7a63736e653130324d44456563/"  // 인증키
				+ "json/LOCALDATA_020301/2001/3000/";
		
		
		
		URL url, url2, url3;
		try {
			url = new URL(urlstr);
			url2 = new URL(urlstr2);
			url3 = new URL(urlstr3);
			
			HttpURLConnection urlConnection1 = (HttpURLConnection) url.openConnection();
			urlConnection1.setRequestMethod("GET");
			
			HttpURLConnection urlConnection2 = (HttpURLConnection) url2.openConnection();
			urlConnection2.setRequestMethod("GET");
			
			HttpURLConnection urlConnection3 = (HttpURLConnection) url3.openConnection();
			urlConnection3.setRequestMethod("GET");
			
			BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection1.getInputStream(), "UTF-8"));
			BufferedReader br2 = new BufferedReader(new InputStreamReader(urlConnection2.getInputStream(), "UTF-8"));
			BufferedReader br3 = new BufferedReader(new InputStreamReader(urlConnection3.getInputStream(), "UTF-8"));
			//System.out.println(br3.readLine());
			
			
			String returnLine;
			
			
			result.append("<xmp>");
			while((returnLine = br.readLine()) != null || (returnLine = br2.readLine()) !=null ||  (returnLine = br3.readLine()) !=null  ) {
				
				result.append(returnLine + "\n");
				

				JSONParser jsonParser = new JSONParser();
				JSONObject jsonObject = (JSONObject)jsonParser.parse(returnLine);
				JSONObject hospitalResult = (JSONObject)jsonObject.get("LOCALDATA_020301");
				//System.out.println(hospitalResult);
				long list_total_count = (long)hospitalResult.get("list_total_count");
				//JSONObject print_result = (JSONObject)hospitalResult.get("RESULT");
				System.out.println("전체데이터 수"+ list_total_count);
				
				JSONArray rows = (JSONArray)hospitalResult.get("row");

				if(code.equals("1")) {
					
					for(int i = 0; i<rows.size();i++) {
						JSONObject info = (JSONObject)rows.get(i);
						
						String MGTNO = (String) info.get("MGTNO");
						String OPNSFTEAMCODE = (String) info.get("OPNSFTEAMCODE");
						String TRDSTATEGBN = (String) info.get("TRDSTATEGBN");
						String TRDSTATENM = (String) info.get("TRDSTATENM");
						String BPLCNM = (String) info.get("BPLCNM");
						String STIETEL = (String) info.get("SITETEL");
						String SITEWHLADDR = (String) info.get("SITEWHLADDR");
						String RDNWHLADDR = (String) info.get("RDNWHLADDR");
						String X = (String) info.get("X");
						String Y = (String) info.get("Y");
						//System.out.println("서비스");
						
						
						if(TRDSTATEGBN.equals("01")) {
						
							if(gugunCD.length()!=0 && keyword.length()==0 && OPNSFTEAMCODE.equals(gugunCD)) {
								Seoul_hp_VO data = new Seoul_hp_VO();
								//System.out.println("시군구검색");
								//System.out.println("코드"+OPNSFTEAMCODE);
								data.setMGTNO(MGTNO);
								data.setList_total_count(list_total_count);
								data.setOPNSFTEAMCODE(OPNSFTEAMCODE);
								data.setTRDSTATEGBN(TRDSTATEGBN);
								data.setTRDSTATENM(TRDSTATENM);
								data.setBPLCNM(BPLCNM);
								data.setSITETEL(STIETEL);
								data.setSITEWHLADDR(SITEWHLADDR);
								data.setRDNWHLADDR(RDNWHLADDR);
								data.setlocX(X);
								data.setlocY(Y);
								
								list.add(data);
								//System.out.println(list.get(0).getBPLCNM());
								//System.out.println("코드검색 시 리스트"+list);
								//return list;
								
							}
							
							else if(gugunCD.equals("none") && (BPLCNM.contains(keyword)) ) {
									//System.out.println("gugunCD null");
									Seoul_hp_VO data2 = new Seoul_hp_VO();
									//System.out.println("키워드 검색");
									data2.setList_total_count(list_total_count);
									data2.setMGTNO(MGTNO);
									data2.setOPNSFTEAMCODE(OPNSFTEAMCODE);
									//System.out.println(OPNSFTEAMCODE);
									data2.setTRDSTATEGBN(TRDSTATEGBN);
									data2.setTRDSTATENM(TRDSTATENM);
									data2.setBPLCNM(BPLCNM);
									data2.setSITETEL(STIETEL);
									data2.setSITEWHLADDR(SITEWHLADDR);
									data2.setRDNWHLADDR(RDNWHLADDR);
									data2.setlocX(X);
									data2.setlocY(Y);
									
									list.add(data2);
									//System.out.println("키워드검색시 리스트" + list);
									//return list;
								
							}
							
							else if(gugunCD.length()==0 && keyword.length()==0){
								//System.out.println("둘다null");
								Seoul_hp_VO vo = new Seoul_hp_VO();
								vo.setMGTNO(MGTNO);
								vo.setList_total_count(list_total_count);
								vo.setOPNSFTEAMCODE(OPNSFTEAMCODE);
								vo.setTRDSTATEGBN(TRDSTATEGBN);
								vo.setTRDSTATENM(TRDSTATENM);
								vo.setBPLCNM(BPLCNM);
								vo.setSITETEL(STIETEL);
								vo.setSITEWHLADDR(SITEWHLADDR);
								vo.setRDNWHLADDR(RDNWHLADDR);
								vo.setlocX(X);
								vo.setlocY(Y);
								
								list.add(vo);
								
							}
							
							else if(OPNSFTEAMCODE.equals(gugunCD) && (BPLCNM.contains(keyword))) {
								Seoul_hp_VO data3 = new Seoul_hp_VO();
								data3.setMGTNO(MGTNO);
								data3.setList_total_count(list_total_count);
								data3.setOPNSFTEAMCODE(OPNSFTEAMCODE);
								data3.setTRDSTATEGBN(TRDSTATEGBN);
								data3.setTRDSTATENM(TRDSTATENM);
								data3.setBPLCNM(BPLCNM);
								data3.setSITETEL(STIETEL);
								data3.setSITEWHLADDR(SITEWHLADDR);
								data3.setRDNWHLADDR(RDNWHLADDR);
								data3.setlocX(X);
								data3.setlocY(Y);
								
								list.add(data3);
							}
						
						}
					}

					}
					
			}
			
			urlConnection1.disconnect();
			urlConnection2.disconnect();
			urlConnection3.disconnect();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println(list.get(0).getBPLCNM());
		//System.out.println("리스트출력 전" + list);
		return list;
   }
   
   //행정코드 리스트
   public List<CodeVO> codeList() {
	      return dao.codeList();
	      }
   
   //행정코드 리스트 맵
   public List<CodeVO> codeListMap(){
	   List<CodeVO> list = dao.codeList();
	   List<CodeVO> list2 = new ArrayList<>();
	   
	   for(int i=0;i<list.size();i++) {
		   
			Map<Object, Object> m = (Map<Object, Object>) list.get(i);
			String codestr = (String)m.get("code");
			
			if(codestr.length()<=2) {
				
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
   
   //구군코드 리스트 맵
   public List<CodeVO> gugunListMap(String code){
	   List<CodeVO> list = dao.codeList();
	   List<CodeVO> list2 = new ArrayList<>();
	   
	   for(int i=0;i<list.size();i++) {
		   
			Map<Object, Object> m = (Map<Object, Object>) list.get(i);
			
			String parent = (String)m.get("parent");
			
			if(code.equals(parent)) {
				
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
   
   // 서울리스트 갯수
   public int countSeoulList(String code, String keyword, String gugunCD) {
	      List<Seoul_hp_VO> list = getSeoullist(code, keyword, gugunCD);
	      int count = list.size();
	      return count;
	   }

   //서울리스트 페이징
   public List<Seoul_hp_VO> selectSeoulList(PageVO vo, String code, String keyword, String gugunCD){
      List<Seoul_hp_VO> list = getSeoullist(code, keyword, gugunCD);
      //System.out.println(list);
      List<Seoul_hp_VO> list2 = new ArrayList();
      //List<Map<Integer, Object>> list3 = new ArrayList();

         
      return list;
   }
   
   //csv리스트 갯수
   public int countCSVList(String code, String keyword, String gugunCD) {
	      List<CsvTestVO> list = csvList(code, keyword, gugunCD);
	      int count = list.size();
	      return count;
	   }
	
   //csv리스트 페이징
	public List<CsvTestVO> selectCsvList(PageVO vo, String code, String keyword, String gugunCD){
		List<CsvTestVO> list = csvList(code, keyword, gugunCD);
		vo = new PageVO();
	   //System.out.println(list);
	   //List<Map<Integer, Object>> list3 = new ArrayList();
	      
	   return list;
	}

   
   
   public List<Seoul_hp_VO> getCodelist(String teamcode){
	   List<Seoul_hp_VO> list = getSeoullist();
	   
	   for(int i = 0; i<list.size();i++) {
		   
			if(teamcode.equals(list.get(i).getOPNSFTEAMCODE())) {
				Seoul_hp_VO data = new Seoul_hp_VO();
				//System.out.println("시군구검색");
				//System.out.println("코드"+list.get(i).getOPNSFTEAMCODE());
				data.setOPNSFTEAMCODE(list.get(i).getOPNSFTEAMCODE());
				data.setTRDSTATEGBN(list.get(i).getTRDSTATEGBN());
				data.setTRDSTATENM(list.get(i).getTRDSTATENM());
				data.setBPLCNM(list.get(i).getBPLCNM());
				data.setSITETEL(list.get(i).getSITETEL());
				data.setSITEWHLADDR(list.get(i).getSITEWHLADDR());
				data.setRDNWHLADDR(list.get(i).getRDNWHLADDR());
				data.setlocX(list.get(i).getlocX());
				data.setlocY(list.get(i).getlocY());
				
				list.add(data);
				
			}
	   }
	   
	   
	   return list;
   }
   
   public List<Seoul_hp_VO> getKeywordlist(String keyword){
	   List<Seoul_hp_VO> list = getSeoullist();
	   
	   for(int i = 0; i<list.size();i++) {
		   
			if(list.get(i).getBPLCNM().contains(keyword)||list.get(i).getSITEWHLADDR().contains(keyword) || list.get(i).getSITETEL().contains(keyword) || list.get(i).getRDNWHLADDR().contains(keyword)) {
				Seoul_hp_VO data = new Seoul_hp_VO();
				//System.out.println("시군구검색");
				//System.out.println("코드"+list.get(i).getOPNSFTEAMCODE());
				data.setOPNSFTEAMCODE(list.get(i).getOPNSFTEAMCODE());
				data.setTRDSTATEGBN(list.get(i).getTRDSTATEGBN());
				data.setTRDSTATENM(list.get(i).getTRDSTATENM());
				data.setBPLCNM(list.get(i).getBPLCNM());
				data.setSITETEL(list.get(i).getSITETEL());
				data.setSITEWHLADDR(list.get(i).getSITEWHLADDR());
				data.setRDNWHLADDR(list.get(i).getRDNWHLADDR());
				data.setlocX(list.get(i).getlocX());
				data.setlocY(list.get(i).getlocY());
				
				list.add(data);
				
			}
	   }
	   
	   
	   return list;
   }
	
	
  	 // tag값의 정보를 가져오는 함수
	private static String getTagValue(String tag, Element eElement) {
	    NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
	    Node nValue = (Node) nlList.item(0);
	    if(nValue == null) 
	        return null;
	    return nValue.getNodeValue();
	}

	// 서울 디테일
	public Seoul_hp_VO detail(String mgtno){
       List<Seoul_hp_VO> list = new ArrayList();
      
       StringBuffer result = new StringBuffer();
       String urlstr = "http://openapi.seoul.go.kr:8088/"
             + "71486858486c696d3234487a656748/"  // 인증키
               + "json/LOCALDATA_020301/1/1000/";    //json/데이터/시작번호/끝번호
       
       String urlstr2 = "http://openapi.seoul.go.kr:8088/"
				+ "5a516a7a63736e653130324d44456563/"  // 인증키
				+ "json/LOCALDATA_020301/1001/2000/";
		
       String urlstr3 = "http://openapi.seoul.go.kr:8088/"
				+ "5a516a7a63736e653130324d44456563/"  // 인증키
				+ "json/LOCALDATA_020301/2001/3000/";
		
		
		
		URL url, url2, url3;
		try {
			url = new URL(urlstr);
			url2 = new URL(urlstr2);
			url3 = new URL(urlstr3);
			
			HttpURLConnection urlConnection1 = (HttpURLConnection) url.openConnection();
			urlConnection1.setRequestMethod("GET");
			
			HttpURLConnection urlConnection2 = (HttpURLConnection) url2.openConnection();
			urlConnection2.setRequestMethod("GET");
			
			HttpURLConnection urlConnection3 = (HttpURLConnection) url3.openConnection();
			urlConnection3.setRequestMethod("GET");
			
			BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection1.getInputStream(), "UTF-8"));
			BufferedReader br2 = new BufferedReader(new InputStreamReader(urlConnection2.getInputStream(), "UTF-8"));
			BufferedReader br3 = new BufferedReader(new InputStreamReader(urlConnection3.getInputStream(), "UTF-8"));
			//System.out.println(br3.readLine());
			           
           String returnLine;
            
            
           result.append("<xmp>");
           while((returnLine = br.readLine()) != null || (returnLine = br2.readLine()) !=null ||  (returnLine = br3.readLine()) !=null) {
              result.append(returnLine + "\n");
               
               JSONParser jsonParser = new JSONParser();
               JSONObject jsonObject = (JSONObject)jsonParser.parse(returnLine);
               JSONObject hospitalResult = (JSONObject)jsonObject.get("LOCALDATA_020301");

               
               JSONArray rows = (JSONArray)hospitalResult.get("row");
               
               for(int i = 0; i<rows.size();i++) {
                  JSONObject info = (JSONObject)rows.get(i);
                  
                   String OPNSFTEAMCODE = (String) info.get("OPNSFTEAMCODE");
                   String MGTNO = (String) info.get("MGTNO");                   
                   String TRDSTATEGBN = (String) info.get("TRDSTATEGBN");
                   String TRDSTATENM = (String) info.get("TRDSTATENM");
                   String BPLCNM = (String) info.get("BPLCNM");
                   String STIETEL = (String) info.get("SITETEL");
                   String SITEWHLADDR = (String) info.get("SITEWHLADDR");
                   String RDNWHLADDR = (String) info.get("RDNWHLADDR");
                   String X = (String) info.get("X");
                   String Y = (String) info.get("Y"); 
                   
                   if(MGTNO.equals(mgtno)) {
                      Seoul_hp_VO detail = new Seoul_hp_VO();
                      detail.setBPLCNM(BPLCNM);
                      detail.setMGTNO(MGTNO);
                      detail.setSITETEL(STIETEL);
                      detail.setSITEWHLADDR(SITEWHLADDR);
                      detail.setRDNWHLADDR(RDNWHLADDR);
                      detail.setlocX(X);
                      detail.setlocY(Y);
                      
                      return detail;
                   }
               }
           }
       }catch(Exception e) {
          e.printStackTrace();
       }
      return null;
   }
	
	// csv리스트
	public List<CsvTestVO> csvList(){
	      BufferedReader br = null;
	      try {
	         FileInputStream fis = new FileInputStream("C:/fulldata_02_03_01_P_동물병원.csv");
	         InputStreamReader isr = new InputStreamReader(fis, "UTF-8");
	         br = new BufferedReader(isr);
	         List<CsvTestVO> list = new ArrayList<>();
	         CsvTestVO vo = null;
	         String line = null;
	         br.readLine();
	         
		      while((line = br.readLine()) != null) {
			     String[] token = line.split("\\\",");
		         vo = new CsvTestVO();
		         vo.setOPNSFTEAMCODE(token[3].replace("\"", ""));
		         vo.setMGTNO(token[4].replace("\"", ""));
		         vo.setTRDSTATEGBN(token[7].replace("\"", ""));
		         vo.setSITETEL(token[15].replace("\"", ""));
		         vo.setSITEWHLADDR(token[18].replace("\"", ""));
		         vo.setRDNWHLADDR(token[19].replace("\"", ""));
		         vo.setBPLCNM(token[21].replace("\"", ""));
		         vo.setX(token[26].replace("\"", ""));
		         vo.setY(token[27].replace("\"", ""));
		         list.add(vo);
		      }
		      br.close();
		      return list;
	      }catch (Exception e) {
	         e.printStackTrace();
	      }
	      return null;
	   }
	
	// csv리스트(행정코드, 키워드, 구군코드)
	public List<CsvTestVO> csvList(String code, String keyword, String gugunCD){
	      BufferedReader br = null;
	      List<CsvTestVO> list = new ArrayList<>();
	      
	      if(!code.equals("1")) {
	    	  
	      List<CodeVO> codelist = gugunListMap(code);
	      String codename = codelist.get(0).getCode();
	      codename = codename.substring(0, 3);
	      
	      try {
	         FileInputStream fis = new FileInputStream("C:/fulldata_02_03_01_P_동물병원.csv");
	         InputStreamReader isr = new InputStreamReader(fis, "UTF-8");
	         br = new BufferedReader(isr);
	         CsvTestVO vo = null;
	         String line = null;
	         br.readLine();
	         
	      while((line = br.readLine()) != null) {
	         String[] token = line.split("\\\",");
	         
	         String OPNSFTEAMCODE = token[3].replace("\"", "");
	         String MGTNO = token[4].replace("\"", "");
	         String TRDSTATEGBN = token[7].replace("\"", "");
	         String SITETEL = token[15].replace("\"", "");
	         String SITEWHLADDR = token[18].replace("\"", "");
	         String RDNWHLADDR = token[19].replace("\"", "");
	         String BPLCNM = token[21].replace("\"", "");
	         String X = token[26].replace("\"", "");
	         String Y = token[27].replace("\"", "");
	         
	         if(TRDSTATEGBN.equals("01")){
	        	 
		         if(gugunCD.length()!=0 && keyword.length()==0 && OPNSFTEAMCODE.equals(gugunCD)) {
		        	    CsvTestVO data = new CsvTestVO();
	
						data.setMGTNO(MGTNO);
						data.setOPNSFTEAMCODE(OPNSFTEAMCODE);
						data.setTRDSTATEGBN(TRDSTATEGBN);
						data.setBPLCNM(BPLCNM);
						data.setSITETEL(SITETEL);
						data.setSITEWHLADDR(SITEWHLADDR);
						data.setRDNWHLADDR(RDNWHLADDR);
						
						list.add(data);
					
						
					}
					
					else if(SITEWHLADDR.contains(codename) && gugunCD.equals("none") && (BPLCNM.contains(keyword)) ) {
						
			        	    CsvTestVO data2 = new CsvTestVO();
	
							data2.setMGTNO(MGTNO);
							data2.setOPNSFTEAMCODE(OPNSFTEAMCODE);
							data2.setTRDSTATEGBN(TRDSTATEGBN);
							data2.setBPLCNM(BPLCNM);
							data2.setSITETEL(SITETEL);
							data2.setSITEWHLADDR(SITEWHLADDR);
							data2.setRDNWHLADDR(RDNWHLADDR);
						
							
							list.add(data2);
						
					}
					
					else if(gugunCD.length()==0 && keyword.length()==0){
						//System.out.println("둘다null");
		        	    CsvTestVO data3 = new CsvTestVO();
						//System.out.println("시군구검색");
						//System.out.println("코드"+OPNSFTEAMCODE);
						data3.setMGTNO(MGTNO);
						data3.setOPNSFTEAMCODE(OPNSFTEAMCODE);
						data3.setTRDSTATEGBN(TRDSTATEGBN);
						data3.setBPLCNM(BPLCNM);
						data3.setSITETEL(SITETEL);
						data3.setSITEWHLADDR(SITEWHLADDR);
						data3.setRDNWHLADDR(RDNWHLADDR);
					
						
						list.add(data3);
						
					}
					
					else if(OPNSFTEAMCODE.equals(gugunCD) && (BPLCNM.contains(keyword))) {
		        	    CsvTestVO data4 = new CsvTestVO();
	
						data4.setMGTNO(MGTNO);
						data4.setOPNSFTEAMCODE(OPNSFTEAMCODE);
						data4.setTRDSTATEGBN(TRDSTATEGBN);
						data4.setBPLCNM(BPLCNM);
						data4.setSITETEL(SITETEL);
						data4.setSITEWHLADDR(SITEWHLADDR);
						data4.setRDNWHLADDR(RDNWHLADDR);
					
						
						list.add(data4);
						
					}
	         }
	         
	      }
	      br.close();
	      
	      
	      Set set = new LinkedHashSet<>(list); // 리스트 중복제거를 위해 linkedhashset 변경
	      
	      List<CsvTestVO> newlist = new ArrayList<>(set);   // 다시 리시트로 변환
	      
	      return newlist;
	      
	      }catch (Exception e) {
	         e.printStackTrace();
	      }
	      }
	      return null;
	   }

	// csv 디테일
	public CsvTestVO csvdetail(String mgtno) {
	      
	      List<CsvTestVO> list = csvList();
	         
	         for(int i=0; i<list.size();i++) {
	        	 
		         if(list.get(i).getMGTNO().equals(mgtno)) {
		        	CsvTestVO csvdetail2 = new CsvTestVO();
		            System.out.println("디테일 확인");
			        csvdetail2.setMGTNO(list.get(i).getMGTNO());
		            csvdetail2.setSITETEL(list.get(i).getSITETEL());
		            csvdetail2.setSITEWHLADDR(list.get(i).getSITEWHLADDR());
		            csvdetail2.setRDNWHLADDR(list.get(i).getRDNWHLADDR());
		            csvdetail2.setBPLCNM(list.get(i).getBPLCNM());
		            return csvdetail2;
			         }
	        	 
	         }
	            
	      return null;
	   }
	
	// 병원 리뷰 리스트 출력
	public List<ReviewVO> getReviewList(String mgtno){
		List<ReviewVO> reviewlist = reviewdao.getReviewList(mgtno);
		return reviewlist;
	}
	
	
	// 병원 리뷰 등록
	public boolean addReview(ReviewVO review) {
		return reviewdao.addReview(review);
	}
	
	// 병원리뷰 갯수
	public int getReviewTotal(String mgtno) {
		return reviewdao.getReviewTotal(mgtno);
	}
	
	// 병원 리뷰 페이징
	public PageInfo<ReviewVO> reviewpaging(int pageNum, String mgtno){
		PageHelper.startPage(pageNum,5);
		PageInfo<ReviewVO> pageInfo = new PageInfo<>(reviewdao.getReviewList(mgtno),5);
		return pageInfo;
	}
	
	// 병원 리뷰 삭제
	public boolean deleteReview(int rv_num) {
		return reviewdao.deleteReview(rv_num);
	}
	
	// 병원 리뷰 수정
	public boolean updateReview(ReviewVO review) {
		return reviewdao.updateReview(review);
	}
	
	
}
