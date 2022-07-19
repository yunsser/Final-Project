<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/jsp/layout/headerSearch.jsp"%>
<sec:authentication property="principal" var="user" />


<!-- include libraries(jQuery, bootstrap) -->
<!-- <link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> -->
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<!-- include summernote css/js-->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
<!-- include summernote-ko-KR -->
<script src="/resources/js/summernote-ko-KR.js"></script>
<style>
form {
	width: 70%;
	margin: auto;
}
</style>

<title>글쓰기</title>

<script>
	$(document).ready(function() {
		   $('#summernote').summernote({
		        // 에디터 높이
		        height: 300,
		        // 에디터 한글 설정
		        lang: "ko-KR",
		        // 에디터에 커서 이동 (input창의 autofocus라고 생각)
		        focus : true,
		        toolbar: [
		            // 글꼴 설정
		            ['fontname', ['fontname']],
		            // 글자 크기 설정
		            ['fontsize', ['fontsize']],
		            // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
		            ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
		            // 글자색
		            ['color', ['forecolor','color']],
		            // 표만들기
		            ['table', ['table']],
		            // 글머리 기호, 번호매기기, 문단정렬
		            ['para', ['ul', 'ol', 'paragraph']],
		            // 줄간격
		            ['height', ['height']],
		            // 코드보기, 확대해서보기, 도움말
		            ['view', ['codeview','fullscreen', 'help']]
		        ],
		        // 추가한 글꼴
		        fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
		        // 추가한 폰트사이즈
		        fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']

		    });
	})

	/* 폼값 넘겨주기 */
	function add() {

		if (!confirm('정말로 저장하시겠습니까?')) {
			alert('정상적으로 취소했습니다.');
			return false;
		}

		var formData = new FormData($("#form")[0]);

		$.ajax({
			url : '/post/board',
			method : 'post',
			enctype : 'multipart/form-data',
			cache : false,
			data : formData,
			processData : false,
			contentType : false,
			dataType : 'json',
			success : function(res) {
				if (res.added) {
					alert('저장 성공!');
				} else {
					alert('저장 실패');
				}
				location.href = "/post/list";
			},
			error : function(xhr, status, err) {
				alert('err' + err);
			}
		});
		//alert('데이터'+formData);
		return false;
	}

	function removeThum(img){
		//alert(img);
		$(img).remove();
		$("#image").val("");
	}

	function setThumbnail(event) {
	   for (var image of event.target.files) {
	      var reader = new FileReader();
	 
	      reader.onload = function(event) {
	         var img = document.createElement("img");
	         img.setAttribute("src", event.target.result);
	         img.setAttribute("style", "width:32%;height:width;");         
	         img.setAttribute('onclick', "removeThum(this)");
	         document.querySelector("div#image_container").appendChild(img);         
	 
	      };
	      
	      console.log(image);
	      reader.readAsDataURL(image);
	   }
	}
</script>


<div class="container">
	<div class="nav-scroller py-1 mb-2">
		<nav class="nav d-flex justify-content-between">
			<a class="p-2 link-secondary" href="#">병원게시판</a> <a
				class="p-2 link-secondary" href="#">공유게시판</a> <a
				class="p-2 link-secondary" href="#">유기동물게시판</a>
		</nav>
	</div>
</div>

<form name="addform" id="form" role="form" method="post" onsubmit="return add();" enctype="multipart/form-data">

	<div class="form-group row">
		<label for="select" class="col-sm-2 col-form-label"
			style="font-size: 19px;">구 선택</label>
		<div class="col-sm-10">
			<select class="form-select" id="category" name="category">
				<option>강남구</option>
				<option>강동구</option>
				<option>강북구</option>
				<option>강서구</option>
				<option>관악구</option>
				<option>광진구</option>
				<option>구로구</option>
				<option>금천구</option>
				<option>노원구</option>
				<option>도봉구</option>
				<option>동대문구</option>
				<option>동작구</option>
				<option>마포구</option>
				<option>서대문구</option>
				<option>서초구</option>
				<option>성동구</option>
				<option>성북구</option>
				<option>송파구</option>
				<option>양천구</option>
				<option>영등포구</option>
				<option>용산구</option>
				<option>은평구</option>
				<option>종로구</option>
				<option>중구</option>
				<option>중랑구</option>
			</select>
		</div>
	</div>

	<div class="form-group row">
		<label for="title" class="col-sm-2 col-form-label"
			style="font-size: 19px;">글내용</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="title" name="title">
		</div>
	</div>

	<div class="form-group row">
		<label for="author" class="col-sm-2 col-form-label"
			style="font-size: 19px;">작성자</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="author" name="author"
				placeholder="${uid}">
			<!-- readonly -->
		</div>
	</div>
	  
	<div class="form-group">
		<textarea class="form-control" id="summernote" name="summernote"></textarea>
	</div>
	  
	<div class="mb-3"><input type="file"
			class="form-control" aria-label="file example" name="mfiles"
			multiple="multiple" id="image" onchange="setThumbnail(event);" accept="image/*" >
		<div class="mb-3"
			style="width: 96%; margin-left: 2%; padding-top: 14px; padding-right: 24px;"
			id="image_container"></div>
	</div>

	<div id="count" name="count" style="display: none" placeholder="0"></div>

	<button type="submit" id="submit" name="submit"
		class="btn btn-outline-primary">글작성</button>
		
</form>


</body>
</html>