<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/jsp/layout/headerSearch.jsp"%>
<sec:authentication property="principal" var="user" />

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



function del_board(num) {

	if (!confirm('정말 삭제 하시겠습니까?')) {
		return;
	}

	var obj = {};
	obj.num = num;
	/* alert(obj.uid); */

	$.ajax({
		url: '/petmong/post/file/delete',
		method: 'post',
		cache: false,
		data: obj,
		dataType: 'json',
		success: function(res) {
			alert(res.deleted ? '삭제 성공' : '삭제 실패!');
			location.reload();
		},
		error: function(xhr, status, err) {
			alert('에러 : ' + err);
		}
	});
}

var delfiles = new Array();

function del_file(fnum) {
	//alert('fnum'+fnum);
	delfiles.push(fnum);
	$('#'+fnum).remove();
}

function updateBoard() {

	//alert('del'+del_files)
	if (!confirm('정말로 저장하시겠습니까?')) {
		alert('정상적으로 취소했습니다.');
		return false;
	}
	var formData = new FormData($("#updateForm")[0]);
	//formData.append("delfiles", delfiles);
	
	$.ajax({
		url: '/petmong/post/update',
		method: 'post',
		enctype: 'multipart/form-data',
		cache: false,
		data: formData,
		processData: false,
		contentType: false,
		dataType: 'json',
		success: function(res) {
			if (res.updated) {
				alert('저장 성공!');
			} else {
				alert('저장 실패');
			}
			location.href = "/petmong/post/list?uid=${user.user.uid }";
		},
		error: function(xhr, status, err) {
			alert('err' + err);
		}
	});
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


<title>수정</title>


<article>
	<div class="container" role="main">
		<form id="updateForm" enctype="multipart/form-data"
			onsubmit="return updateBoard();">

			<input type="hidden" id="num" name="num" value="${post.num}">
			<p>
			<div name="addForm" id="form">

				<div class="search">
					<p></p>
					<input type="hidden" id="cateCodeA" name="cateCodeA" class="data">
					<p></p>
					<input type="hidden" id="pageNum" name="pageNum" value="${pageNum}">
					<label for="select" class="col-sm-2 col-form-label"
						style="font-size: 19px; float: left;">구 선택</label>
					<!-- <div class="cate_wrap" style="display: inline-block;"> -->
						<select class="form-select" name="sido" id="code"
							style="width: 133px; height: 40px; float: left; margin-right: 5px;">
							<option selected value="none">${post.sido}</option>
							<c:forEach var="codemap" items="${codemap}">
								<option value="${codemap.sidoCd}"
									${sido == codemap.sidoCd ? "selected":""}>
									${codemap.sidoNm}</option>
								<!-- 값 -->
							</c:forEach>
						</select> <select class="form-select" name="gugun"
							style="width: 133px; height: 40px;" id="gugunCD">
							<option value='none'>${post.gugun}</option>
							<c:forEach var="gugunmap" items="${gugunmap}">
								<option value="${gugunmap.gugunNm}"
									${gugun == gugunmap.gugunNm ? "selected":""}>
									${gugunmap.gugunNm}</option>
								<!-- 값 -->
							</c:forEach>
							</select>
					<!-- </div> -->
				</div>

				<div style="clear: both;"></div>


				<div class="form-group row">
					<label for="title" class="col-sm-2 col-form-label"
						style="font-size: 19px;">제목</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="title" name="title"
							value="${post.title}">
					</div>
				</div>

				<div class="form-group row">
					<label for="author" class="col-sm-2 col-form-label"
						style="font-size: 19px;">작성자</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="name" name="name"
							value="${post.name}" readonly>
						<!-- readonly -->
					</div>
				</div>


				<input type="hidden" id="author" name="author" value="${post.author}">


				<div class="form-group">
					<label for="content">내용</label>
					<textarea class="form-control" id="summernote" name="summernote">${post.summernote}</textarea>
				</div>

				<div>
					<!-- class="form-control" -->
					<label for="content">파일</label> <input type="file" id="mfiles"
						name="mfiles" class="form-control" accept="image/*"
						onchange="setThumbnail(event);">
					<c:choose>
						<c:when test="${fn:length(post.attach)>0}">
							<c:forEach var="f" items="${post.attach}">
								<fmt:formatNumber var="kilo" value="${f.filesize/1024}"
									maxFractionDigits="0" />
								<div id="${f.att_num}">
									<span class="form-control"> <a
										href="/petmong/post/file/download/${f.att_num}">${f.filename}</a>
										[${kilo}kb] <img src="/upload/${f.filename}" width="100px"
										height="100px" alt="" class="thumb" /> <a class="link_del"
										href="javascript:del_file(${f.att_num});">삭제</a></span>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<!-- 첨부파일 없음 -->
						</c:otherwise>
					</c:choose>
				</div>
				<div class="mb-3"
					style="width: 96%; margin-left: 2%; padding-top: 14px; padding-right: 24px;"
					id="image_container"></div>


			</div>

			<div id="count" name="count" style="display: none" placeholder="0"></div>

			<!-- 수정 목록 버튼 -->
			<div class="btlistsav">
				<button type="submit" class="btn btn-sm btn-primary">완료</button>
				<button type="button" class="btn btn-sm btn-primary"
					onclick="location.href='/petmong/post/list?uid=${user.user.uid}'">목록</button>
			</div>

		</form>


	</div>
</article>

<script>
let codeList = JSON.parse('${codeList}');

let cate1Array = new Array();
let cate2Array = new Array();
let cate1Obj = new Object();
let cate2Obj = new Object();

let cateSelect1 = $("#code");      
let cateSelect2 = $("#gugunCD");

/* 카테고리 배열 초기화 메서드 */


function makeCateArray(obj,array,codeList, tier){
for(let i = 0; i < codeList.length; i++){
   if(codeList[i].tier == tier){
      
      obj = new Object();
      
      obj.code = codeList[i].code;
      obj.sidoNm = codeList[i].sidoNm;
      obj.gugunNm = codeList[i].gugunNm;
      obj.parent = codeList[i].parent;
      obj.gugunCd = codeList[i].gugunCd;
      
      array.push(obj);            
      
   }
}   
}
 

$(document).ready(function(){
   console.log(cate1Array);
   
});

/* 배열 초기화 */

makeCateArray(cate1Obj,cate1Array,codeList,1);
makeCateArray(cate2Obj,cate2Array,codeList,2);

$(document).ready(function(){
   console.log(cate1Array);
   console.log(cate2Array);
});

/* 대분류 <option> 태그 */
for(let i = 0; i < cate1Array.length; i++){
   //cateSelect1.append("<option value='"+cate1Array[i].sidoCd+"'>" + cate1Array[i].sidoNm + "</option>");
}

/* 중분류 <option> 태그 */
$(cateSelect1).on("change",function(){
   let selectVal1 = $(this).find("option:selected").val();
   
   cateSelect2.children().remove();

   cateSelect2.append("<option value='none'>군/구 선택</option>");

   for(let i = 0; i < cate2Array.length; i++){
      if(selectVal1 == cate2Array[i].parent){
         cateSelect2.append("<option value='"+cate2Array[i].gugunNm+"'>" + cate2Array[i].gugunNm + "</option>")
            
         //cateSelect2.append("<option value='"+cate2Array[i].gugunCd+"'>" + cate2Array[i].gugunNm + "</option>")
         //location.href = "/test/code?gugunCD="+cate2Array[i].gugunCd;
      }
   }      
});

$(cateSelect2).on("change",function(){
      let selectVal2 = $(this).find("option:selected").val();
      
 });   
</script>
</body>
</html>