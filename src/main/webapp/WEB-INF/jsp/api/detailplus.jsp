<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/jsp/layout/headerSearch.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	h3 { width:fit-content; margin:1em auto;}
	table {border-radius:30px; width:fit-content; border:1px solid lightblue; border-spacing: 0; margin:0 auto;}
	th {background-color:#eeeeee;}
	th,td { padding:1px; /* border-bottom:1px dashed black; border-top:1px dashed black; */}
	/* tr:last-child>th {border-bottom:none; }
	tr:last-child>td {border-bottom:none; } */
	th { border-right: 1px solid lightblue; } 
	/* tr:last-child>th { border-right: none; }  */
	/* table#replyList {position: relative;} */
  </style>
<script>
function setThumbnail(event) {
	   for (var image of event.target.files) {
	      var reader = new FileReader();
	 
	      reader.onload = function(event) {
	         var img = document.createElement("img");
	         img.setAttribute("src", event.target.result);
	         img.setAttribute("style", "width:50%;height:width;");               
	         document.querySelector("span#form-control").appendChild(img);         
	 
	      };
	      
	      console.log(image);
	      reader.readAsDataURL(image);
	   }
	}


	function del_board(num) {

		if (!confirm('정말 삭제 하시겠습니까?')) {
			return;
		}

		var obj = {};
		obj.num = num;

		$.ajax({
			url: '/shfcedit/delete',
			method: 'post',
			cache: false,
			data: obj,
			dataType: 'json',
			success: function(res) {
				alert(res.deleted ? '삭제 성공' : '삭제 실패!');
				location.href = "/shfclist";
			},
			error: function(xhr, status, err) {
				alert('에러 : ' + err);
			}
		}); 
	}
</script>

 <script>
  	/* 댓글 입력 */
  	function insertReply() {
  		
  		var serData = $('#re').serialize();
  		var content = $('#content').val();
  		
  		if(content == "") {
  			alert("내용을 입력하시오.");
  			conForm.content.focus();
  			return false;
  		}
  		
  		$.ajax({
  			url:"/insertReply",
  			method:'post',
  			cache:false,
  			data:serData,
  			dataType:'json',
  			success:function(res){
  				alert(res.inserted ? '댓글이 달렸습니다.':'댓글을 달 수 없습니다.');
  				location.reload();
  			},
  			error:function(xhr,status,err){
  				alert('에러:'+err);
  			}
  		});
  	}

  	/* 댓글 삭제 */
  	function deleteReply(idx) {
  		if(!confirm("댓글을 삭제할까요?")) {
  			return false;
  		}
  		
  		var query = {idx : idx}
  		$.ajax({
  			url:"/deleteReply",
  			method:'post',
  			cache:false,
  			data:query,
  			dataType:'json',
  			success:function(res){
  				alert(res.deleted ? '삭제 성공':'삭제 실패');
  				location.reload();
  			},
  			error:function(xhr,status,err){
  				alert('에러:'+err);
  			}
  		});
  	}
  	
  	/* 댓글 수정 폼 출력*/
  	function updateReplyForm(idx,content,nickname) {
		var updateReply = "";
		updateReply += "<div>";
		updateReply += "<label for='content'>수정</label> &nbsp;";
		updateReply += "<input type='hidden' name='nickname' value="+nickname+" size='2' readonly/>";
		updateReply += "<textarea rows='1' class='form-control' id='content"+idx+"' name='content'>"+content+"</textarea>";
		updateReply += "</div>";
		updateReply += "<input type='button' class='btn btn-dark' value='수정하기' onclick='updateRep("+idx+", )'/>";
		updateReply += "<input type='button' class='btn btn-dark' value='취소' onclick='cancleUpdateRep("+idx+")'/>";
  		$("#updateReplyBox"+idx).slideDown(500);
  		$("#updateReplyBox"+idx).html(updateReply); 
  	}
  	
  	function cancleUpdateRep(idx){
  		$("#updateReplyBox"+idx).slideUp(500);
  	}
  	
  	/* 댓글 수정 */
  	function updateRep(idx){
  		var content = document.getElementById("content"+idx).value;
  		var query = {
  						content  : content,
  						idx : idx}
  		
  		$.ajax({
  			url:"/updateReply",
  			method:'post',
  			cache:false,
  			data:query,
  			dataType:'json',
  			success:function(res){
  				alert(res.updated ? '수정 성공':'수정 실패');
  				location.reload();
  			},
  			error:function(xhr,status,err){
  				alert('에러:'+err);
  			}
  		});
  	} 
  	
  	/* 대댓글 입력폼 출력 */
  	function insertNestedRepForm(idx,depth,screenOrder,nickname) {
  		var insReply = "";
  		insReply += "<table style='width:210%'>";
  		insReply += "<tr>";
  		insReply += "<td style='border:none;width:85%;text-align:right;padding:0px;' class='reply_cont'>";
  		insReply += "<div class='form-group'>";
  		insReply += "<label for='content' style='float:left;'>답글</label> &nbsp;";
  		insReply += "<input type='hidden' style='float:left;' name='nickname' value="+nickname+" readonly/>";
  		insReply += "<textarea rows='2' class='form-control' id='content"+idx+"' name='content'></textarea>"; //@"+nickname+"\n
  		insReply += "</div>";
  		insReply += "</td>";
  		insReply += "</tr>";
  		insReply += "<tr>";
  		insReply += "<td style='border:none;width:15%;text-align:left;padding:0px;' class='reply_cont'>";
  		insReply += "<input type='button' class='btn btn-dark' value='댓글 달기' onclick='insertNestedRep("+idx+","+depth+","+screenOrder+")'/>";
  		insReply += "<input type='button' class='btn btn-dark' value='취소' id='closeReply"+idx+"' onclick='closeReply("+idx+")'/>";
  		insReply += "</td>";
  		insReply += "</tr>";
  		
  		insReply += "</table>";
  		insReply += "<hr style='margin:0px;'/>";
  		
  		$("#openReply"+idx).hide();    // '답글'버튼 가리기
  		$("#closeReply"+idx).show();   // '닫기'버튼 보이기
  		$("#replyBox"+idx).slideDown(500);
  		$("#replyBox"+idx).html(insReply);
  	}
  	
  	/* 대댓글입력 */
  	function insertNestedRep(idx,depth,screenOrder) {
  		
  		var boardIdx = "${detail.sh_num}";
		var nickname = "";
		nickname += "<sec:authorize access='isAuthenticated()'>";
		nickname += "${user.user.uid}";
		nickname += "</sec:authorize>";
		
		
  		var content = document.getElementById("content"+idx).value;
  		
  		
  		if(content == "") {
  			alert("내용을 입력하시오.");
  			return false;
  		}
  		else {
  			var query = {
  					boardIdx : boardIdx,
  					nickname : nickname,
  					content  : content,
  					depth    : depth,
  					screenOrder : screenOrder
  			}
  			
  			$.ajax({
  	  			url:"/insertNestedRep",
  	  			method:'post',
  	  			cache:false,
  	  			data:query,
  	  			dataType:'json',
  	  			success:function(res){
  	  				alert(res.inserted ? '댓글 성공':'댓글 실패');
  	  				location.reload();
  	  			},
  	  			error:function(xhr,status,err){
  	  				alert('에러:'+err);
  	  			}
  	  		});
  		}
  	}
  	
    /* 댓글보기, 댓글숨기기 */
    $(document).ready(function(){
    	$("#reply").show();         // 댓글 출력
    	$("#showReply").hide();  // 댓글보기 버튼 감춘다
    	
    	$("#showReply").click(function(){  // 댓글 보기 버튼을 클릭하면
    		$("#reply").slideDown(500);       // 댓글 출력
    		$("#showReply").hide();    // 댓글보기 버튼 안보이게 한다
    		$("#hideReply").show();  // 댓글숨기기 버튼을 보이게 한다
    	});
    	$("#hideReply").click(function(){  // 댓글 숨기기를 클릭하면
    		$("#reply").slideUp(500);           // 댓글을 안 보이게 한다
    		$("#showReply").show();    // 댓글보기 버튼은 보이게 한다
    		$("#hideReply").hide();  // 댓글숨기기 버튼을 안보이게 한다
    	});
    });
  	
	/* 댓글 취소 버튼 */
  	function closeReply(idx) {
  		$("#openReply"+idx).slideDown(500);    
  		$("#closeReply"+idx).hide();   
  		$("#replyBox"+idx).slideUp(500);     
  	}  	
  	
  	
 </script>





<!-- <script>
var newText = text.replace(/(<([^>]+)>)/ig,"");
</script> -->

<title>상세보기</title>
</head>
<body>

<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal" var = "user" />
</sec:authorize>


<article>
		<div class="container" role="main">

			<p>
			<div name="addForm" id="form">
				<div class="mb-3">
					<label for="title">제목</label> <span type="text"
						class="form-control">${detail.sh_title}</span>
				</div>


				<div class="mb-3">
					<label for="author">작성자</label> <span class="form-control"
						name="reg_id" id="reg_id"><input type="hidden"
						name="author" value="${detail.sh_name}"
						style="border: none; color: gray;" readonly>${detail.sh_name}</span>
				</div>


				<div class="mb-3">
					<label for="category">카테고리</label>
					<span class="form-control">${detail.sh_facCate}</span>
				</div>
				
				<div class="mb-3">
					<label for="title">내용</label>
					<span class="form-control">${detail.sh_content}</span>
				</div>
				
				<div class="mb-3">
					<label for="map">지도</label> 
					<div id="map" style="width:100%;height:350px;"></div>
				</div>

				<div>
					<!-- class="form-control" -->
					<label for="content">파일</label>

					<c:choose>
						<c:when test="${fn:length(detail.attach)>0}">
							<c:forEach var="f" items="${detail.attach}">
								<fmt:formatNumber var="kilo" value="${f.filesize/1024}"
									maxFractionDigits="0" />
								<div>
									<span class="form-control">
									<a href="/post/file/download/${f.att_num}"><img src="/upload/${f.filename}" width="30%" alt="" class="thumb" style="display: block; margin: auto;"/></a>
									</span>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<span class="form-control">첨부파일 없음</span>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			
			
			<!-- 수정 목록 버튼 -->
				<sec:authorize access="isAuthenticated()">
			<div class="btlistsav">
			<c:if test ="${user.user.uid == detail.sh_name}">
					<button type="button" class="btn btn-sm btn-primary"
						onclick="location.href='/shfcedit?num=${detail.sh_num}'">수정</button>
					<button type="button" class="btn btn-sm btn-primary"
						onclick="location.href=del_board('${detail.sh_num}')">삭제</button>
			</c:if>
				<button type="button" class="btn btn-sm btn-primary"
					onclick="location.href='/shfclist'">목록</button>
			</div>
</sec:authorize>
			
			
<!-- 댓글 출력 -->
<div class="container">
	<div>
	<input type="button" class='btn btn-dark' value="댓글보기" id="showReply">
    <input type="button" class='btn btn-dark' value="댓글숨기기" id="hideReply">
	</div>
<br/>
	<div id="reply">
	<table id="replyList" style="width:600px; /*  border-radius:30px; */">
		<tr>
        	<th style="text-align: center; width:150px;">작성자</th>
       	 	<th style="text-align: center;">내용</th>
       		<th style="text-align: center;">작성시간</th>
        	<th style="text-align: center; width:80px;">답글달기</th>
      	</tr>

      <!-- 닉네임과 들여쓰기 처리 -->
      <c:forEach var="reply" items="${replyList}">  
			<c:if test="${reply.depth > 0}">  <!-- 대댓글의 경우 하늘색으로 출력 -->
				<tr style="background-color:#c9dee2;text-align:left;">
			</c:if>
        	<c:if test="${reply.depth <= 0}">
	     	   <tr style="background-color:#eee;text-align:left;">
       		</c:if>
          	<c:if test="${reply.depth > 0}">  <!-- 대댓글의 경우 들여쓰기 -->
            	<td style="text-align:left;">
              	<c:forEach var="i" begin="1" end="${reply.depth}">&nbsp;&nbsp; </c:forEach>
					└ ${reply.nickname} 
          	</c:if>
         	<c:if test="${reply.depth <= 0}">
            	<td style="text-align:left;">
             	 ${reply.nickname} 
          	</c:if>
          	<sec:authorize access="isAuthenticated()">
          	<c:if test="${reply.content != '삭제된 댓글' && reply.nickname == user.user.uid}">
            	<a href="javascript:updateReplyForm(${reply.idx}, '${reply.content}', '${reply.nickname}')">수정<i class="glyphicon glyphicon-erase"></i></a>
          		<a href="javascript:deleteReply(${reply.idx})">삭제<i class="glyphicon glyphicon-remove" style="color:#a35f65;"></i></a>
          	</c:if>
</sec:authorize>




	          <!-- 댓글내용 -->
	          <td style="text-align:left;">${reply.content}
	        	  <div id="updateReplyBox${reply.idx}"></div>
	          </td>


	          <!-- 작성일 -->
	          <td style="text-align:left; text-align: center;">${reply.date}</td>


	          <!-- 버튼처리 -->
	          <td style="text-align: center;">
          	<sec:authorize access="isAuthenticated()">
	         <c:if test = "${user.user.uid != null }">
	          <c:if test = "${reply.content != '삭제된 댓글' }">
	          	<a href="javascript:insertNestedRepForm('${reply.idx}','${reply.depth}','${reply.screenOrder}','${reply.nickname}')">답글<i class="glyphicon glyphicon-pencil"></i></a>
	           <%--  <input type="button" value="답글달기" id="openReply${reply.idx}" 
	            		onclick="insertNestedRepForm('${reply.idx}','${reply.depth}','${reply.screenOrder}','${reply.nickname}')"/> --%>
	            <%-- <input type="button" value="취소" id="closeReply${reply.idx}" 
	            		onclick="closeReply(${reply.idx})" style="display:none;"/> --%>
	           </c:if>
	           </c:if>
</sec:authorize>
	          </td>
	    <tr>
	    	<td><div id="replyBox${reply.idx}"></div></td>
        </tr>
      	</c:forEach>
    </table>
 	</div>
</div>			



<form id="re">
		<table style="width:600px;">
		<tr>
		<td>
		 <sec:authorize access="isAuthenticated()">
                  <label for="content">댓글</label> &nbsp;
                  <input type="hidden" name="nickname" value="${user.user.uid}" readonly/>
                  <input type="hidden" name=boardIdx value="${detail.sh_num }">
                  <textarea rows="2" name="content" id="content" class="form-control"></textarea>
                 <input type="button" class='btn btn-dark' value="댓글 달기" onclick="insertReply()"/>
</sec:authorize>

            <sec:authorize access="isAnonymous()">
            <a href="/loginForm">
                 <textarea rows="2" name="content" id="content" class="form-control" readonly>로그인이 필요한 서비스입니다</textarea>
                 </a>
</sec:authorize>
              </td>
            </tr>
       </table>
   </form>   




		</div>
	</article>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fefe54713afff65d5e6b73e9a2b6fd73&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch('${detail.sh_facAdd}', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">${detail.sh_facNM}<br>${detail.sh_facRoadAdd}<br>${detail.sh_facTel}</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});    
</script>

</body>
</html>