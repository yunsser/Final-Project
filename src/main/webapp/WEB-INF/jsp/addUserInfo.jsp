<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "layout/headerBasic.jsp" %>
<style type="text/css">

      .form-control{
      	margin-top: 0.5em;
      }

	  .title {
	  	display : inline-block;
	  	text-align: center;
	  	margin-top : 0.5em;
	  }
	  
	  #idcheckbts, #postbts {
	  	margin-left : 0.5em;
	  }
</style>

    		<!-- 본문 들어가는 부분 -->	
<form id = "addInfoForm" class="container" onsubmit = "return addInfo()">
  <fieldset>
    <legend class ="title">추가정보 입력</legend>
   
	<div class="input-group">
		<label for="birth" class="col-sm-2 col-form-label">생년월일</label>
		<div class="col-sm-8">
			<input type="text" class="form-control" id="birth" name = "birth" placeholder="ex) 20220623" />
		</div>
	</div>
	<p />
	<div class="input-group">
		<label for="phone" class="col-sm-2 col-form-label">전화번호</label>
		<div class="col-sm-8">
			<input type="text" class="form-control" id="phone" name = "phone" placeholder=" - 제외 ex) 01011112222" />
		</div>
	</div>
	<p />

	<div class="input-group">
      <label for="zipcode" class="col-sm-2 col-form-label">우편번호</label>
      <div class="col-sm-3">
        <input type="text" class="form-control" id="zipcode" name = "zipecode" placeholder="우편번호" />
      </div>
      <div class="input-group-addon input-group-button">
        <button id = "postbts" type="button" 
        		class="btn btn-outline-secondary form-control"
        		onclick="kakaopost();">검색하기</button>      
      </div>
    </div>
	<div class="input-group">
		<label for="address" class="col-sm-2 col-form-label">주소</label>
		<div class="col-sm-8">
			<input type="text" class="form-control" id="addr" name = "addr" placeholder="주소를 입력해주세요." />
		</div>
	</div>
		<div class="input-group">
		<label for="detailAddr" class="col-sm-2 col-form-label">상세주소</label>
		<div class="col-sm-8">
			<input type="text" class="form-control" id="detailAddr" name = "detailAddr" placeholder="상세주소를 입력해주세요." />
		</div>
	</div>
	<p />
	<div class="input-group">
		<label for="pet" class="col-sm-2 col-form-label">반려동물</label>
	<fieldset class="form-group">
      <div class="form-check">
        <input class="form-check-input" type="radio" id="pet" name = "pet" value="Y" >
          있다
      </div>
      <div class="form-check">
        <input class="form-check-input" type="radio" id="pet" name = "pet" value="N" >
          없다
      </div>
    </fieldset>
	</div>
	<p />
	<div class="input-group">
		<label for="petsize" class="col-sm-2 col-form-label">반려동물 크기</label>
	<fieldset class="form-group">
      <div class="form-check">
        <input class="form-check-input" type="radio" id="petsize" name = "petsize" value="s" >
          소형견
      </div>
      <div class="form-check">
        <input class="form-check-input" type="radio" id="petsize" name = "petsize" value="m" >
          중형견
      </div>
      <div class="form-check">
        <input class="form-check-input" type="radio" id="petsize" name = "petsize" value="l" >
          대형견
      </div>
    </fieldset>
	</div>
	<p />
	<p />
	<input type = "hidden" name = "role" value = "ROLE_USER" />
  </fieldset>
	<div class="form-row text-center">
    <div class="col-12">
		    <button type="submit" class="btn btn-outline-primary">저장</button>
		    <button type="button" class="btn btn-outline-danger">취소</button>
	</div>
	</div>

</form>
			<!-- 본문 들어가는 부분 끝 -->
			
<!-- 주소 api 시작 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function kakaopost() {
    new daum.Postcode({
        oncomplete: function(data) {
           document.querySelector("#zipcode").value = data.zonecode;
           document.querySelector("#addr").value =  data.address
        }
    }).open();
}
</script>
<!-- 주소 api 끝 -->

<!-- 추가정보 폼 전송 시작 -->
<script type="text/javascript">

	 
	function addInfo(){
		
		// 입력항목 체크 변수 선언.

		 var birth = $('#birth').val();
		 var phone = $('#phone').val();
		 var zipcode = $('#zipcode').val();
		 var addr = $('#addr').val();
		 var detailAddr = $('#detailAddr').val();
		 // 정규표현식
		 
		 var birthRegExp = /^[0-9]{8}$/;
		 var phoneRegExp = /^[0-9]{10,11}$/;
		
		 		
 		if (!birthRegExp.test(birth)) {
 			alert('생년월일 양식을 확인해주세요.');
 			return false;
 		}
 		if(birth =='') {
 			alert('생년월일은 필수입력 항목입니다.');
 			return false;
 		}
 		
 		if (!phoneRegExp.test(phone)) {
 			alert('휴대폰 번호 양식을 확인해주세요.');
 			return false;
 		}
 		if(phone =='') {
 			alert('휴대폰번호는 필수입력 항목입니다.');
 			return false;
 		}
 		
 		if(zipcode =='') {
 			alert('우편번호는 필수입력 항목입니다.');
 			return false;
 		}
 		
 		if(addr =='') {
 			alert('주소는 필수입력 항목입니다.');
 			return false;
 		}
 		
 		if(detailAddr =='') {
 			alert('상세주소는 필수입력 항목입니다.');
 			return false;
 		}
		 
 		
		var serData = $('#addInfoForm').serialize();
		
		$.ajax({
			url : '/addInfo',
			method : 'post',
			cache : false,
			data : serData, 
			dataType : 'json',
			success : function(res){
				alert(res.addInfo ? '추가정보 저장 완료' : '실패!');
					if(res.addInfo) location.href = '/';
			},
			error : function(xhr, status, err) {
				alert('에러 : ' + xhr + status + err);
			}
		});
		return false;
	}
<!-- 추가정보 폼 전송 끝 -->

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>
