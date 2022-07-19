package pet.main.svc;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import pet.main.vo.TestVO;

@Service
public class HomeSVC {
	public static String getTagValue(String tag, Element eElement) {

		// 결과를 저장할 result 변수 선언
		String result = "";

		NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();

		result = nlList.item(0).getTextContent();

		return result;
	}

	public List<TestVO> list() {

		List<TestVO> list = new ArrayList();

		StringBuffer result = new StringBuffer();
		String urlstr = "http://openapi.seoul.go.kr:8088/" + "6e6e7175586c7975313233456c584e71/"
				+ "json/TbAdpWaitAnimalPhotoView/" + "2/6/";
		
		String urlstr2 = "http://openapi.seoul.go.kr:8088/" + "6e6e7175586c7975313233456c584e71/"
				+ "json/TbAdpWaitAnimalPhotoView/" + "11/16/";
		
		

		URL url, url2;
		try {
			url = new URL(urlstr);
			url2 = new URL(urlstr2);

			HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
			urlConnection.setRequestMethod("GET");
			
			HttpURLConnection urlConnection2 = (HttpURLConnection) url2.openConnection();
			urlConnection2.setRequestMethod("GET");

			BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream(), "UTF-8"));
			BufferedReader br2 = new BufferedReader(new InputStreamReader(urlConnection2.getInputStream(), "UTF-8"));

			String returnLine;

			result.append("<xmp>");
			while ((returnLine = br.readLine()) != null || (returnLine = br2.readLine()) != null) {
				result.append(returnLine + "\n");

				// System.out.println(returnLine);

				JSONParser jsonParser = new JSONParser();
				JSONObject jsonObject = (JSONObject) jsonParser.parse(returnLine);
				JSONObject petresult = (JSONObject) jsonObject.get("TbAdpWaitAnimalPhotoView");
				// System.out.println(hospitalResult);
				long list_total_count = (long) petresult.get("list_total_count");
				// JSONObject print_result = (JSONObject)hospitalResult.get("RESULT");
				System.out.println("전체데이터 수" + list_total_count);

				JSONArray rows = (JSONArray) petresult.get("row");


				for (int i = 0; i < rows.size(); i++) {
					JSONObject info = (JSONObject)rows.get(i);

					String ANIMAL_NO = String.valueOf(info.get("ANIMAL_NO"));
					String PHOTO_KND = (String) info.get("PHOTO_KND");
					String PHOTO_NO = String.valueOf(info.get("PHOTO_NO"));
					String PHOTO_URL = (String) info.get("PHOTO_URL");
					TestVO data = new TestVO();
					// System.out.println("키워드있을 때");
					data.setANIMAL_NO(ANIMAL_NO.replace(".0", ""));
					data.setPHOTO_KND(PHOTO_KND);
					data.setPHOTO_NO(PHOTO_NO.replace(".0", ""));
					data.setPHOTO_URL(PHOTO_URL);

					list.add(data);
					System.out.println(list);
				}

			}

			urlConnection.disconnect();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return list;
	}
}
