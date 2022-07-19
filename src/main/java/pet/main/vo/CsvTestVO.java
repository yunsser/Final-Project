package pet.main.vo;

import java.util.Objects;

public class CsvTestVO {
	
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
	
	
//	public DataInfo(String MGTNO, String BPLCNM, String X, String Y, String SITETEL, String SITEWHLADDR, String RDNWHLADDR) {
//		this.MGTNO = MGTNO;
//		this.BPLCNM = BPLCNM;
//		this.X = X;
//		this.Y = Y;
//		this.SITETEL = SITETEL;
//		this.SITEWHLADDR = SITEWHLADDR;
//		this.RDNWHLADDR = RDNWHLADDR;
//	}



	public long getList_total_count() {
		return list_total_count;
	}
	
	
	
	
	
	public void setList_total_count(long list_total_count) {
		this.list_total_count = list_total_count;
	}
	


	public String getOPNSFTEAMCODE() {
		return OPNSFTEAMCODE;
	}









	public void setOPNSFTEAMCODE(String oPNSFTEAMCODE) {
		OPNSFTEAMCODE = oPNSFTEAMCODE;
	}





	public String getMGTNO() {
		return MGTNO;
	}





	public void setMGTNO(String mGTNO) {
		MGTNO = mGTNO;
	}





	public String getAPVPERMYMD() {
		return APVPERMYMD;
	}





	public void setAPVPERMYMD(String aPVPERMYMD) {
		APVPERMYMD = aPVPERMYMD;
	}





	public String getAPVCANCELYMD() {
		return APVCANCELYMD;
	}





	public void setAPVCANCELYMD(String aPVCANCELYMD) {
		APVCANCELYMD = aPVCANCELYMD;
	}





	public String getTRDSTATEGBN() {
		return TRDSTATEGBN;
	}





	public void setTRDSTATEGBN(String tRDSTATEGBN) {
		TRDSTATEGBN = tRDSTATEGBN;
	}





	public String getTRDSTATENM() {
		return TRDSTATENM;
	}





	public void setTRDSTATENM(String tRDSTATENM) {
		TRDSTATENM = tRDSTATENM;
	}





	public String getDTLSTATEGBN() {
		return DTLSTATEGBN;
	}





	public void setDTLSTATEGBN(String dTLSTATEGBN) {
		DTLSTATEGBN = dTLSTATEGBN;
	}





	public String getDTLSTATENM() {
		return DTLSTATENM;
	}





	public void setDTLSTATENM(String dTLSTATENM) {
		DTLSTATENM = dTLSTATENM;
	}





	public String getDCBYMD() {
		return DCBYMD;
	}





	public void setDCBYMD(String dCBYMD) {
		DCBYMD = dCBYMD;
	}





	public String getCLGSTDT() {
		return CLGSTDT;
	}





	public void setCLGSTDT(String cLGSTDT) {
		CLGSTDT = cLGSTDT;
	}





	public String getCLGENDDT() {
		return CLGENDDT;
	}





	public void setCLGENDDT(String cLGENDDT) {
		CLGENDDT = cLGENDDT;
	}





	public String getOPNYMD() {
		return OPNYMD;
	}





	public void setOPNYMD(String oPNYMD) {
		OPNYMD = oPNYMD;
	}





	public String getSITETEL() {
		return SITETEL;
	}





	public void setSITETEL(String sITETEL) {
		SITETEL = sITETEL;
	}





	public String getSITEAREA() {
		return SITEAREA;
	}





	public void setSITEAREA(String sITEAREA) {
		SITEAREA = sITEAREA;
	}





	public String getSITEPOSTNO() {
		return SITEPOSTNO;
	}





	public void setSITEPOSTNO(String sITEPOSTNO) {
		SITEPOSTNO = sITEPOSTNO;
	}





	public String getSITEWHLADDR() {
		return SITEWHLADDR;
	}





	public void setSITEWHLADDR(String sITEWHLADDR) {
		SITEWHLADDR = sITEWHLADDR;
	}





	public String getRDNWHLADDR() {
		return RDNWHLADDR;
	}





	public void setRDNWHLADDR(String rDNWHLADDR) {
		RDNWHLADDR = rDNWHLADDR;
	}





	public String getRDNPOSTNO() {
		return RDNPOSTNO;
	}





	public void setRDNPOSTNO(String rDNPOSTNO) {
		RDNPOSTNO = rDNPOSTNO;
	}





	public String getBPLCNM() {
		return BPLCNM;
	}





	public void setBPLCNM(String bPLCNM) {
		BPLCNM = bPLCNM;
	}





	public String getLASTMODTS() {
		return LASTMODTS;
	}





	public void setLASTMODTS(String lASTMODTS) {
		LASTMODTS = lASTMODTS;
	}





	public String getUPDATEGBN() {
		return UPDATEGBN;
	}





	public void setUPDATEGBN(String uPDATEGBN) {
		UPDATEGBN = uPDATEGBN;
	}





	public String getUPDATEDT() {
		return UPDATEDT;
	}





	public void setUPDATEDT(String uPDATEDT) {
		UPDATEDT = uPDATEDT;
	}





	public String getUPTAENM() {
		return UPTAENM;
	}





	public void setUPTAENM(String uPTAENM) {
		UPTAENM = uPTAENM;
	}





	public String getX() {
		return X;
	}





	public void setX(String x) {
		X = x;
	}





	public String getY() {
		return Y;
	}





	public void setY(String y) {
		Y = y;
	}





	public String getLINDJOBGBNNM() {
		return LINDJOBGBNNM;
	}





	public void setLINDJOBGBNNM(String lINDJOBGBNNM) {
		LINDJOBGBNNM = lINDJOBGBNNM;
	}





	public String getLINDPRCBGBNNM() {
		return LINDPRCBGBNNM;
	}





	public void setLINDPRCBGBNNM(String lINDPRCBGBNNM) {
		LINDPRCBGBNNM = lINDPRCBGBNNM;
	}





	public String getLINDSEQNO() {
		return LINDSEQNO;
	}





	public void setLINDSEQNO(String lINDSEQNO) {
		LINDSEQNO = lINDSEQNO;
	}





	public String getRGTMBDSNO() {
		return RGTMBDSNO;
	}





	public void setRGTMBDSNO(String rGTMBDSNO) {
		RGTMBDSNO = rGTMBDSNO;
	}





	public String getTOTEPNUM() {
		return TOTEPNUM;
	}





	public void setTOTEPNUM(String tOTEPNUM) {
		TOTEPNUM = tOTEPNUM;
	}





	@Override
	public int hashCode() {
		return Objects.hash(this.BPLCNM, this.RDNWHLADDR);
	}





	@Override
	public boolean equals(Object obj) {
		CsvTestVO vo = (CsvTestVO) obj;
		return this.OPNSFTEAMCODE.equals(vo.getOPNSFTEAMCODE());
	}

}
