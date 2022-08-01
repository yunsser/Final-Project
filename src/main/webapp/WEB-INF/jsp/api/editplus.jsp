<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

function del_board(num) {

   if (!confirm('정말 삭제 하시겠습니까?')) {
      return;
   }

   var obj = {};
   obj.num = num;
   /* alert(obj.uid); */

   $.ajax({
      url: '/petmong/shfc/shfcedit/filedelete',
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
   if (!confirm('파일을 삭제 하시겠습니까?')) {
      return;
   }
   
   delfiles.push(fnum);
   $('#'+fnum).remove();
}

function updateSharefc() {

   if (!confirm('정말로 수정하시겠습니까?')) {
      alert('정상적으로 취소했습니다.');
      return false;
   }
   //var formData = new FormData();
   var formData = new FormData($("#inform")[0]);
   formData.append("delfiles", delfiles);
   
   $.ajax({
      url: '/petmong/shfc/shfcedit/edit',
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
         location.href = "/petmong/shfc/shfclist?uid=${user.user.uid }";
      },
      error: function(xhr, status, err) {
          alert("code:"+xhr.status+"\n"+"message:"+xhr.responseText+"\n"+"error:"+err);
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

<script type="text/javascript">
   var openWin;
   function showPopup() {            
      // window.name = "부모창 이름";            
       window.name = "parentForm";            
      // window.open("open할 window", "자식창 이름", "팝업창 옵션");            
      openWin = window.open("/petmong/shfc/fcsearch",                    
            "childForm", "width=570, height=350, resizable = no, scrollbars = no");
      //openWin.document.getElementById("cInput").value = document.getElementById("pInput").value;
           
   }   
                
   function setChildText(){            
      
   }    
</script>



<form name="inform" id="inform" role="form" method="post" onsubmit="return updateSharefc();" enctype="multipart/form-data">
<input type="hidden" name="sh_num" id="sh_num" value="${detail.sh_num}">
   <div class="form-group row">
      <label for="select" class="col-sm-2 col-form-label"
         style="font-size: 19px;">카테고리</label>
         <div class="btn-group" role="group" aria-label="Basic radio toggle button group" style="width:200px; height:40px;">
        <input type="radio" class="btn-check" name="sh_facCate" id="btnradio1" autocomplete="off" ${detail.sh_facCate== "식당" ? "checked":""} value="식당">
        <label class="btn btn-outline-primary" for="btnradio1">식당</label>
        <input type="radio" class="btn-check" name="sh_facCate" id="btnradio2" autocomplete="off" ${detail.sh_facCate== "카페" ? "checked":""} value="카페">
        <label class="btn btn-outline-primary" for="btnradio2">카페</label>
        <input type="radio" class="btn-check" name="sh_facCate" id="btnradio3" autocomplete="off" ${detail.sh_facCate== "숙박" ? "checked":""} value="숙박">
        <label class="btn btn-outline-primary" for="btnradio3">숙박</label>
      </div>
        

   <div class="form-group row">
      <label for="select" class="col-sm-2 col-form-label"
         style="font-size: 19px;">장소</label>
      <div class="col-sm-10">
      <input type="text" class="form-control" id="place_name" name="sh_facNM" placeholder="장소 검색 버튼을 눌러 검색해주세요." 
      value="${detail.sh_facNM}" onclick="showPopup();" style="width: 86%;
    float: left;" readonly>

      <input type="hidden" class="form-control" id="road_address_name" name="sh_facRoadAdd" value="${detail.sh_facRoadAdd}">
      <input type="hidden" class="form-control" id="address_name" name="sh_facAdd" value="${detail.sh_facAdd}">
      <input type="hidden" class="form-control" id="phone" name="sh_facTel" value="${detail.sh_facTel}">
      <input type="hidden"  class="form-control" id="sido" name="sh_facSido" value="${detail.sh_facSido}">
      <input type="hidden"  class="form-control" id="gugun" name="sh_facGugun" value="${detail.sh_facGugun}">

      <input id="newwin" name="newwin" type="button" class="btn btn-outline-primary" value="장소 검색" onclick="showPopup();">
      </div>
   </div>

    <div style="clear: both;"></div>

   <div class="form-group row">
      <label for="title" class="col-sm-2 col-form-label"
         style="font-size: 19px;">글내용</label>
      <div class="col-sm-10">
         <input type="text" class="form-control" id="sh_title" name="sh_title" value="${detail.sh_title}" }>
      </div>
   </div>

   <div class="form-group row">
      <label for="author" class="col-sm-2 col-form-label"
         style="font-size: 19px;">작성자</label>
      <div class="col-sm-10">
         <input type="text" class="form-control" id="sh_nickname" name="sh_nickname" value="${detail.sh_nickname}" readonly>
          <input type="hidden" class="form-control" id="sh_name" name="sh_name" value="${detail.sh_name}" readonly>
      </div>
   </div>
     
   <div class="form-group">
   <label for="content">내용</label>
      <textarea class="form-control" id="summernote" name="sh_content">${detail.sh_content}</textarea>
   </div>
            <div>
               <!-- class="form-control" -->
               <label for="content">파일</label> <input type="file" id="mfiles"
                  name="mfiles" class="form-control" accept="image/*"
                  onchange="setThumbnail(event);">
               <c:choose>
                  <c:when test="${fn:length(detail.attach)>0}">
                     <c:forEach var="f" items="${detail.attach}">
                        <fmt:formatNumber var="kilo" value="${f.filesize/1024}"
                           maxFractionDigits="0" />
                        <div id="${f.att_num}">
                           <span class="form-control"> <a
                              href="/petmong/shfc/shfcdetail/file/download/${f.att_num}">${f.filename}</a>
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
               onclick="location.href='/petmong/shfc/shfclist?uid=${user.user.uid }'">목록</button>
         </div>

      
</form>


</body>
</html>