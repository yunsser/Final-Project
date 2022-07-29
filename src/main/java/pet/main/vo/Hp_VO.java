package pet.main.vo;

import lombok.Data;

@Data
public class Hp_VO {
	
	private long list_total_count;
	private String OPNSFTEAMCODE; //개방자치단체코드
	private String MGTNO;    //관리번호
	private String APVPERMYMD;     //인허가일자
	private String APVCANCELYMD;   //인허가취소일자
	private String TRDSTATEGBN; //영업상태코드
	private String TRDSTATENM; // 영업상태명
	private String DTLSTATEGBN;	//상세영업상태코드
	private String DTLSTATENM;	//상세영업상태명
	private String DCBYMD;	//폐업일자
	private String CLGSTDT; //휴업시작일자
	private String CLGENDDT;	//휴업종료일자
	private String OPNYMD;	//재개업일자
	private String SITETEL; //전화번호
	private String SITEAREA; //소재지면적
	private String SITEPOSTNO;	//소재지우편번호
	private String SITEWHLADDR;  //지번주소
	private String RDNWHLADDR;  //도로명주소
	private String RDNPOSTNO;	//도로명우편번호
	private String BPLCNM;     //사업장명
	private String LASTMODTS;	//최종수정일자
	private String UPDATEGBN;	//데이터갱신구분
	private String UPDATEDT;	//데이터갱신일자
	private String UPTAENM;	//업태구분명
	private String X;   // x좌표정보
	private String Y; // y좌표정보
	private String LINDJOBGBNNM; //축산업무구분명
	private String LINDPRCBGBNNM;	//축산물가공업구분명
	private String LINDSEQNO;	//축산일련번호
	private String RGTMBDSNO;	//권리주체일련번호
	private String TOTEPNUM;	//총인원

}
