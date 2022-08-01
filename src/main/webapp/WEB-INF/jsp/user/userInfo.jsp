<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../layout/headerMypage.jsp"%>
<style>
#info {
	margin-top: 15px;
}

.form-control {
	margin-top: 0.5em;
}

.title {
	display: inline-block;
	text-align: center;
	margin-top: 0.5em;
}

#idcheckbts, #postbts {
	margin-left: 0.5em;
}

.box {
	width: 150px;
	height: 150px;
	border-radius: 45%;
	overflow: hidden;
	border: solid 1px;
	color: black;
}

.img {
	width: 100%;
	height: 100%;
}

#profile {
	padding-top: 90px;
}
</style>
<!-- 본문 시작 -->
<div id="info" class="container">
	<div id="article">
		<form id="updateForm" class="container" onsubmit="return update()"
			enctype="multipart/form-data">
			<fieldset>
				<legend class="title">개인정보수정</legend>

				<div class="input-group">
					<label for="userImg" id="profile" class="col-sm-2 col-form-label"
						style="">프로필 사진</label>
					<div class="col-sm-8" style="text-align: center;">
						<div class="box"
							style="display: inline-block; text-align: center;">
							<img id="img" class="img" onerror="this.src='/image/seokgu.jpg'"
								src="/resources/userProfile/${imgName}" />
						</div>
						<div style="font-size: 12px; color: gray;">※ 설정하지 않을시 기본이미지로
							적용됩니다. ※</div>
						<input id="userImg" class="form-control" name="userImg"
							type="file" accept=".jpg, .jpeg, .png" style="display: none;"
							multiple /> <br />
						<button type="button" id="select"
							class="btn btn-outline-secondary" style="width: 108px">사진선택</button>
						<button type="button" class="btn btn-outline-secondary"
							style="width: 108px" onclick="defaultImg()">기본이미지</button>
					</div>
				</div>
				<p />
				<div class="input-group">
					<label for="uid" class="col-sm-2 col-form-label">아이디</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="uid" name="uid"
							value="${u.uid}" disabled="disabled" />
					</div>
				</div>
				<p />
				<div class="col-md-6 offset-md-3">
					<span id="checkId"></span>
				</div>
				<p />

				<c:choose>
					<c:when test="${u.provider != null}">
						<div class="input-group">
							<label for="upw" class="col-sm-2 col-form-label">새 비밀번호</label>
							<div class="col-sm-8">
								<input type="password" class="form-control" id="upw" name="upw"
									value="${u.upw}"
									placeholder="최소 8 자, 하나 이상의 문자, 하나의 숫자 및 하나의 특수 문자"
									readonly="readonly" />
							</div>
						</div>
						<p />
						<div class="col-md-6 offset-md-3">
							<span id="checkUpw"></span>
						</div>
						<p />

						<div class="input-group">
							<label for="confirmUpw" class="col-sm-2 col-form-label">새
								비밀번호 확인</label>
							<div class="col-sm-8">
								<input type="password" class="form-control" id="confirmUpw"
									value="${u.upw}" placeholder="비밀번호를 한번 더 입력해 주세요."
									readonly="readonly" />
							</div>
						</div>
						<p />
						<div class="col-md-6 offset-md-3">
							<span id="checkUpw2"></span>
						</div>
						<p />
					</c:when>
					<c:otherwise>
						<div class="input-group">
							<label for="upw" class="col-sm-2 col-form-label">새 비밀번호</label>
							<div class="col-sm-8">
								<input type="password" class="form-control" id="upw" name="upw"
									value="${u.upw}"
									placeholder="최소 8 자, 하나 이상의 문자, 하나의 숫자 및 하나의 특수 문자" />
							</div>
						</div>
						<p />
						<div class="col-md-6 offset-md-3">
							<span id="checkUpw"></span>
						</div>
						<p />

						<div class="input-group">
							<label for="confirmUpw" class="col-sm-2 col-form-label">새
								비밀번호 확인</label>
							<div class="col-sm-8">
								<input type="password" class="form-control" id="confirmUpw"
									value="${u.upw}" placeholder="비밀번호를 한번 더 입력해 주세요." />
							</div>
						</div>
						<p />
						<div class="col-md-6 offset-md-3">
							<span id="checkUpw2"></span>
						</div>
						<p />
					</c:otherwise>
				</c:choose>


				<div class="input-group">
					<label for="name" class="col-sm-2 col-form-label">이름</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="name" name="name"
							value="${u.name}" disabled="disabled" />
					</div>
				</div>
				<p />

				<div class="input-group">
					<label for="birth" class="col-sm-2 col-form-label">생년월일</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="birth" name="birth"
							value="${u.birth}" />
					</div>
				</div>
				<p />

				<div class="input-group">
					<label for="phone" class="col-sm-2 col-form-label">전화번호</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="phone" name="phone"
							value="${u.phone }" placeholder=" - 제외 ex) 01011112222" />
					</div>
				</div>
				<p />

				<div class="input-group">
					<label for="email" class="col-sm-2 col-form-label">email</label>
					<div class="col-sm-8">
						<input type="email" class="form-control" id="email" name="email"
							value="${u.email}" placeholder="ex) example@abc.com" />
					</div>
				</div>
				<p />

				<div class="input-group">
					<label for="zipcode" class="col-sm-2 col-form-label">우편번호</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" id="zipcode"
							name="zipcode" value="${u.zipcode}" placeholder="우편번호" />
					</div>
					<div class="input-group-addon input-group-button">
						<button id="postbts" type="button"
							class="btn btn-outline-secondary form-control"
							onclick="kakaopost();">검색하기</button>
					</div>
				</div>
				<p />

				<div class="input-group">
					<label for="address" class="col-sm-2 col-form-label">주소</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="addr" name="addr"
							value="${u.addr}" placeholder="주소를 입력해주세요." />
					</div>
				</div>
				<p />

				<div class="input-group">
					<label for="detailAddr" class="col-sm-2 col-form-label">상세주소</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="detailAddr"
							name="detailAddr" value="${u.detailAddr}"
							placeholder="상세주소를 입력해주세요." />
					</div>
				</div>
				<p />
				<div class="input-group">
					<label for="pet" class="col-sm-2 col-form-label">반려동물</label>
					<fieldset class="form-group">
						<div class="form-check">
							<input class="form-check-input" type="radio" id="pet" name="pet"
								value="Y" <c:if test="${u.pet eq 'Y'}"> checked</c:if> /> 있다
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio" id="pet" name="pet"
								value="N" <c:if test="${u.pet eq 'N'}"> checked</c:if> /> 없다
						</div>
					</fieldset>
				</div>
				<p />

				<div class="input-group">
					<label for="petsize" class="col-sm-2 col-form-label">반려동물
						크기</label>
					<fieldset class="form-group">
						<div class="form-check">
							<input class="form-check-input" type="radio" id="petsize"
								name="petsize" value="s"
								<c:if test="${u.petsize eq 's'}"> checked</c:if> /> 소형견
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio" id="petsize"
								name="petsize" value="m"
								<c:if test="${u.petsize eq 'm'}"> checked</c:if> /> 중형견
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio" id="petsize"
								name="petsize" value="l"
								<c:if test="${u.petsize eq 'l'}"> checked</c:if> /> 대형견
						</div>
					</fieldset>
				</div>
				<p />

				<input type="hidden" name="role" value="ROLE_USER" />
			</fieldset>
			<div class="form-row text-center">
				<div class="col-12">
					<button type="submit" class="btn btn-outline-success">수정</button>
					<button type="button" class="btn btn-outline-primary"
						onclick="location.reload();">취소</button>

				</div>
				<p />
				<div class="col-12">
					<button type="button" class="btn btn-outline-danger"
						onclick="return deleted()">회원탈퇴</button>
				</div>
			</div>
			<p />
		</form>
		<!-- 푸터 시작 -->
		<%@ include file="../layout/footer.jsp"%>
		<!-- 푸터 끝 -->
	</div>
</div>
</div>
<!-- 본문 들어가는 부분 끝 -->

<!-- 주소 api 시작 -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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

<script type="text/javascript">

	// 프로필 사진 업로드 버튼 실행
	$(function () {
		$('#select').click(function (e) {
			e.preventDefault();
			$('#userImg').click();
		});
	});
	
	// 기본이미지 설정
	function defaultImg() {
      document.getElementById("img").src = "/image/seokgu.jpg";
      $('#userImg').val('');
    }
	
	// 이미지 미리보기
	// 이벤트를 바인딩해서 input에 파일이 올라올때 (input에 change를 트리거할때) 위의 함수를 this context로 실행합니다.
	$("#userImg").change(function(){
		preview(this);
	});
	 
	function preview(userImg) {
		 if (userImg.files && userImg.files[0]) {
		  var reader = new FileReader();
		  
		  reader.onload = function (e) {
		   $('#img').attr('src', e.target.result);  
		  }
		  reader.readAsDataURL(userImg.files[0]);
		  }
		}
	
<!-- 회원정보 업데이트 폼 전송 시작 -->
	function update(){

		$("#uid").removeAttr("disabled");
		$("#name").removeAttr("disabled");
		
		
		if(!confirm('정말 수정 하시겠습니까?')){
			return;
		}
		
		// 입력항목 체크 변수 선언.
		 var upw = $('#upw').val();
		 var confirmUpw = $('#confirmUpw').val();
		 var birth = $('#birth').val();
		 var phone = $('#phone').val();
		 var email = $('#email').val();
		 var zipcode = $('#zipcode').val();
		 var addr = $('#addr').val();
		 var detailAddr = $('#detailAddr').val();
		 // 정규표현식
		 var upwRegExp = /^[a-zA-Z\\d`~!@#$%^&*()-_=+]{8,}$/;
		 var birthRegExp = /^[0-9]{8}$/;
		 var phoneRegExp = /^[0-9]{10,11}$/;
		 var emailRegExp = /^[0-9a-zA-Z]([-_￦.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_￦.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
		
		if (!upwRegExp.test(upw)) {
 			alert('비밀번호 양식을 확인해주세요.');
 			return false;
 		}
 		if(upw =='') {
 			alert('비밀번호는 필수입력 항목입니다.');
 			return false;
 		}
 		if(upw != confirmUpw) {
 			alert('비밀번호와 일치하지 않습니다.');
 			return false;
 		}
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
 		if (!emailRegExp.test(email)) {
 			alert('이메일 양식을 확인해주세요.');
 			return false;
 		}
 		if(email =='') {
 			alert('이메일은 필수입력 항목입니다.');
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
 		
		var formData = new FormData($("#updateForm")[0]);
		$.ajax({
			url : '/petmong/user/userUpdate',
			method : 'post',
			enctype: 'multipart/form-data',
			processData: false,
		    contentType: false,
			cache : false,
			data : formData, 
			dataType : 'json',
			success : function(res){
				alert(res.updated ? '회원정보 수정완료' : '실패!');
					if(res.updated) location.href = '/petmong/user/mypage?uid=${user.user.uid}';
			},
			error : function(xhr, status, err) {
				alert('에러 : ' + xhr + status + err);
			}
		});
		return false;
	}
<!-- 회원정보 수정 폼 전송 끝 -->

	
	// 비밀번호 재확인 메시지 출력

	$("#confirmUpw").keyup(function(){
	    
	    if($("#upw").val() == '' || $("#upw").val() == null && confirmUpw.length > 0){
	    	$("#checkUpw2").text("비밀번호를 먼저 작성해주세요.")
			.css("color", "red");
	        $("#confirmUpw").val(""); // 비밀번호 확인에 입력한 값 삭제
	    } else {
	    	if (upw.length == 0 || confirmUpw.length == 0){
				$("#checkUpw2").text("");
			} else if ($(this).val() != $("#upw").val()) {
				$("#checkUpw2").text("비밀번호가 불일치합니다.")
           	 	.css("color", "red");
			} else if ($(this).val() == $("#upw").val()){
            	$("#checkUpw2").text("비밀번호가 일치합니다.")
				.css("color", "green");
			}
	    }
	});

	function deleted() {
		
		$("#uid").removeAttr("disabled");
		
		if(!confirm('정말 탈퇴 하시겠습니까?')){
			return;
		}
		
		var uid = $('#uid').val();
		
		var obj = {};
		obj.uid = uid
		
		$.ajax({
			url : '/user/delete',
			method : 'post',
			cache : false,
			data : obj,
			dataType : 'json',
			success : function(res) {
				alert(res.deleted ? '이용해주셔서 감사합니다.' : '실패!');
				if(res.deleted) location.href = "/logout";
			},
			error : function(xhr, status, err) {
				alert('에러 : ' + xhr + status + err);
			}
		});
		return false;
	}
	
</script>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
</body>
</html>