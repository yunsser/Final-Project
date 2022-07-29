<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/jsp/layout/headerSearch.jsp"%>

<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal" var = "user" />
</sec:authorize>


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
#inform {
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
	   if($('input[name=sh_facCate]:radio:checked').length < 1){
		   alert('카테고리를 선택해 주세요');
		   return false;
	   }
	   else if($('#place_name').val() == ''){
		   alert('장소를 등록해 주세요');
		   return false;
	   } else if($('#title').val() == ''){
		   alert('제목을 입력해 주세요');
		   return false;
	   } else if($('#summernote').val() == ''){
		   alert('내용을 입력해 주세요')
		   return false;
	   } else if (!confirm('정말로 저장하시겠습니까?')) {
         alert('정상적으로 취소했습니다.');
         return false;
      }

      var formData = new FormData($("#inform")[0]);

      $.ajax({
         url : '/petmong/shfc/shfcboard',
         method : 'post',
         enctype : 'multipart/form-data',
         cache : false,
         data : formData,
         processData : false,
         contentType : false,
         dataType : 'json',
         success : function(res) {
            if (res.addShareFC) {
               alert('저장 성공!');
            } else {
               alert('저장 실패');
            }
            location.href = "/petmong/shfc/shfclist";
         },
         error : function(xhr, status, err) {
             alert("code:"+xhr.status+"\n"+"message:"+xhr.responseText+"\n"+"error:"+err);
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

<script type="text/javascript">
   var openWin;
   function showPopup() {            
      // window.name = "부모창 이름";            
       window.name = "parentForm";            
      // window.open("open할 window", "자식창 이름", "팝업창 옵션");            
      openWin = window.open("/petmong/shfc/fcsearch",                    
            "childForm", "width=500, height=350, resizable = no, scrollbars = no");
      //openWin.document.getElementById("cInput").value = document.getElementById("pInput").value;
           
   }   
                
   function setChildText(){            
      
   }    
</script>




<form name="inform" id="inform" role="form" method="post"
	onsubmit="return add();" enctype="multipart/form-data">

	<div class="form-group row">
		<label for="select" class="col-sm-2 col-form-label"
			style="font-size: 19px;">카테고리</label>
		<div class="btn-group" role="group"
			aria-label="Basic radio toggle button group"
			style="width: 200px; height: 40px;">
			<input type="radio" class="btn-check" name="sh_facCate"
				id="btnradio1" autocomplete="off" value="식당"> <label
				class="btn btn-outline-primary" for="btnradio1">식당</label> <input
				type="radio" class="btn-check" name="sh_facCate" id="btnradio2"
				autocomplete="off" value="카페"> <label
				class="btn btn-outline-primary" for="btnradio2">카페</label> <input
				type="radio" class="btn-check" name="sh_facCate" id="btnradio3"
				autocomplete="off" value="숙박"> <label
				class="btn btn-outline-primary" for="btnradio3">숙박</label>
		</div>
	</div>

	<div class="form-group row">
		<label for="select" class="col-sm-2 col-form-label"
			style="font-size: 19px;">장소</label>
		<div class="col-sm-10">

			<input type="text" class="form-control" id="place_name"
				name="sh_facNM" placeholder="장소 검색 버튼을 눌러 검색해주세요."
				onclick="showPopup();" readonly style="    width: 86.7%;
    float: left;"> <input type="hidden"
				class="form-control" id="road_address_name" name="sh_facRoadAdd">
			<input type="hidden" class="form-control" id="address_name"
				name="sh_facAdd"> <input type="hidden" class="form-control"
				id="phone" name="sh_facTel"> <input type="hidden"
				class="form-control" id="sido" name="sh_facSido"> <input
				type="hidden" class="form-control" id="gugun" name="sh_facGugun">

			<input id="newwin" name="newwin" type="button"
				class="btn btn-outline-primary" value="장소 검색" onclick="showPopup();">
		</div>
	</div>
<div style="clear: both;"></div>

	<div class="form-group row">
		<label for="title" class="col-sm-2 col-form-label"
			style="font-size: 19px;">글제목</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="title" name="sh_title">
		</div>
	</div>

	<div class="form-group row">
		<label for="author" class="col-sm-2 col-form-label"
			style="font-size: 19px;">작성자</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="nickname" name="sh_nickname"
				value="${user.user.name}" readonly>
			<!-- readonly -->
			<input type="hidden" class="form-control" id="name" name="sh_name"
				value="${user.user.uid}" readonly>
		</div>
	</div>
	  
	<div class="form-group">
		<textarea class="form-control" id="summernote" name="sh_content"></textarea>
	</div>
	  
	<div class="mb-3">
		<input type="file" class="form-control" aria-label="file example"
			name="mfiles" multiple="multiple" id="image"
			onchange="setThumbnail(event);" accept="image/*">
		<div class="mb-3"
			style="width: 96%; margin-left: 2%; padding-top: 14px; padding-right: 24px;"
			id="image_container"></div>
	</div>

	<div id="count" name="count" style="display: none" placeholder="0"></div>

	<button type="submit" id="submit" name="submit"
		class="btn btn-outline-primary" style="width: 100px;">글작성</button>

</form>


</body>
</html>