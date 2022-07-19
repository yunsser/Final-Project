package pet.main.vo;

import lombok.Data;

@Data
public class CodeVO {
   
   private int tier;
   private String code;
   private String sidoNm;
   private String sidoCd;
   private String gugunNm;
   private String gugunCd;
   private String parent;
   
   @Override
   public String toString() {
      return "CodeVO [tier=" + tier + ", code=" + code + ", sidoNm=" + sidoNm + ", sidoCd=" + sidoCd + ", gugunNm=" + gugunNm
            + ", gugunCd=" + gugunCd + ", parent=" + parent + "]";
   }

public int getTier() {
	return tier;
}

public void setTier(int tier) {
	this.tier = tier;
}

public String getCode() {
	return code;
}

public void setCode(String code) {
	this.code = code;
}

public String getSidoNm() {
	return sidoNm;
}

public void setSidoNm(String sidoNm) {
	this.sidoNm = sidoNm;
}

public String getSidoCd() {
	return sidoCd;
}

public void setSidoCd(String sidoCd) {
	this.sidoCd = sidoCd;
}

public String getGugunNm() {
	return gugunNm;
}

public void setGugunNm(String gugunNm) {
	this.gugunNm = gugunNm;
}

public String getGugunCd() {
	return gugunCd;
}

public void setGugunCd(String gugunCd) {
	this.gugunCd = gugunCd;
}

public String getParent() {
	return parent;
}

public void setParent(String parent) {
	this.parent = parent;
}
   
   
   
   
}