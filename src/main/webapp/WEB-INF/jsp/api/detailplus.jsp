<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/jsp/layout/headerSearch.jsp"%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="user" />
</sec:authorize>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
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
.title {
	align-items: center;
	margin-bottom: 2rem;
	font-size: 26px;
	margin-top: 1.3rem;
	color: gray;
}

.content {
	padding: 30px 30px 0px 42px;
	font-size: 18px;
}

.imagelabel {
	font-size: 15px;
	color: gray;
	margin-top: 3rem;
	border-bottom: 1px solid #80808073;
	width: 100%;
	margin-bottom: 10px;
	clear: both;
	display: table;
}

.table-info { 
	--bs-table-bg: #383838;
	color: #fff;
	border-color: #ffffff00;
}

.table>:not(caption)>*>* {
	border-bottom: none;
}

.cntBts {
	text-align: center;
}

.cntBts button {
	border: none;
	background: none;
	margin-top: 10px;
}
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
			url: '/petmong/shfc/shfcedit/delete',
			method: 'post',
			cache: false,
			data: obj,
			dataType: 'json',
			success: function(res) {
				alert(res.deleted ? '삭제 성공' : '삭제 실패!');
				location.href = "/petmong/shfc/shfclist";
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
  			url:"/petmong/shfc/insertReply",
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

  	/* 댓글 완전히 삭제 */
	function deleteReply1(idx) {
		if(!confirm("댓글을 삭제할까요?")) {
			return false;
		}
		
		var query = {idx : idx}
		$.ajax({
			url:"/petmong/shfc/deleteReply",
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
	
	/* 삭제된 댓글로 대체 */
	function deleteReply2(idx) {
		if(!confirm("댓글을 삭제할까요?")) {
			return false;
		}
		
		var query = {idx : idx}
		$.ajax({
			url:"/petmong/shfc/deleteReply2",
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
  			url:"/petmong/shfc/updateReply",
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
  		insReply += "<input type='hidden' style='float:left;' name='name' value="+name+" readonly/>";
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
  		var parent = idx; 
  		var boardIdx = "${detail.sh_num}";
		var nickname = "";
		nickname += "<sec:authorize access='isAuthenticated()'>";
		nickname += "${user.user.uid}";
		nickname += "</sec:authorize>";
		var name = "${user.user.name}";
		
		
  		var content = document.getElementById("content"+idx).value;
  		
  		
  		if(content == "") {
  			alert("내용을 입력하시오.");
  			return false;
  		}
  		else {
			var query = {
					parent   : parent,
					boardIdx : boardIdx,
					nickname : nickname,
					name : name,
					content  : content,
					depth    : depth,
					screenOrder : screenOrder
			}
  			
  			$.ajax({
  	  			url:"/petmong/shfc/insertNestedRep",
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
  		$("#hideReply").show();
  		$(".page-link").show();  // 페이징
  		
  		$("#showReply").click(function(){  // 댓글 보기 버튼을 클릭하면
  			$("#reply").slideDown(500);       // 댓글 출력
  			$("#showReply").hide();    // 댓글보기 버튼 안보이게 한다
  			$("#hideReply").show();  // 댓글숨기기 버튼을 보이게 한다
  			$(".page-link").show();  // 페이징
  		});
  		
  		$("#hideReply").click(function(){  // 댓글 숨기기를 클릭하면
  			$("#reply").slideUp(500);           // 댓글을 안 보이게 한다
  			$("#showReply").show();    // 댓글보기 버튼은 보이게 한다
  			$("#hideReply").hide();  // 댓글숨기기 버튼을 안보이게 한다
  			$(".page-link").hide();  // 페이징
  		});
  	});
  	
	/* 댓글 취소 버튼 */
  	function closeReply(idx) {
  		$("#openReply"+idx).slideDown(500);    
  		$("#closeReply"+idx).hide();   
  		$("#replyBox"+idx).slideUp(500);     
  	}  	
  	
  	
 </script>


<title>상세보기</title>
</head>
<body>

	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="user" />
	</sec:authorize>


	<article>
		<div class="container" role="main" style="margin-top: 3rem;">

			<span class="badge rounded-pill bg-primary" style="font-size: 15px;">
				${detail.sh_facCate}｜${detail.sh_facSido}｜${detail.sh_facGugun}</span>
			<br>
			<div class="d-flex col-12 title"
				style="border-bottom: 1px solid #80808073;">
				<div class="col-1"
					style="margin: 0rem 1.2rem 0rem 2rem; width: 80%;">
					${detail.sh_title}</div>
				<div style="width: 20%; font-size: 18px;">${detail.sh_nickname}</div>
			</div>

			<div class="col-12 content">
				<div style="margin-bottom: 4rem;">${detail.sh_content}</div>

				<div class="mb-3">
					<!-- 지도 -->
					<div id="map" style="width: 70%; height: 350px; margin: auto;"></div>
				</div>

				<span class="badge rounded-pill bg-dark"
					style="display: table; margin: auto; font-size: 16px;">${detail.sh_facSido}
					${detail.sh_facGugun} ${detail.sh_facNM } ${detail.sh_facAdd}</span>

				<div class="imagelabel">첨부파일</div>
				<c:choose>
					<c:when test="${fn:length(detail.attach)>0}">
						<c:forEach var="f" items="${detail.attach}">
							<fmt:formatNumber var="kilo" value="${f.filesize/1024}"
								maxFractionDigits="0" />
							<div>
								<a href="/petmong/shfc/shfcdetail/download/${f.att_num}"><img
									src="/upload/${f.filename}" width="20%" alt="" class="thumb"
									style="display: inline-block; float: left;" /></a>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<span>첨부파일 없음</span>
					</c:otherwise>
				</c:choose>

				<div style="clear: both;"></div>


				<!-- 수정 목록 버튼 -->
				<div class="btlistsav"
					style="margin-top: 5rem; float: right; display: block;">
					<sec:authorize access="isAuthenticated()">
						<c:if test="${user.user.uid == detail.sh_name}">
							<button type="button" class="btn btn btn-primary"
								onclick="location.href='/petmong/shfc/shfcedit?num=${detail.sh_num}'">수정</button>
							<button type="button" class="btn btn btn-primary"
								onclick="location.href=del_board('${detail.sh_num}')">삭제</button>
						</c:if>
					</sec:authorize>
					<button type="button" class="btn btn btn-primary"
						onclick="location.href='/petmong/shfc/shfclist?uid=${user.user.uid}'">목록</button>
				</div>
				<div style="clear: both;"></div>
				<!-- 추천 비추천 찜 -->
				<div class="cntBts">
					<c:choose>
						<c:when test="${detail.sumlike > 0}">
							<button type="button" onclick="like()">
								<div>${detail.sumlike}</div>
								<i class="material-icons" style="font-size: 3em;"> thumb_up
								</i>
							</button>
						</c:when>
						<c:otherwise>
							<button type="button" onclick="like()">
								<div>0</div>
								<i class="material-icons" style="font-size: 3em;"> thumb_up
								</i>
							</button>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${detail.sumdislike > 0}">
							<button type="button" onclick="dislike()">
								<div>${detail.sumdislike}</div>
								<i class="material-icons" style="font-size: 3em;">
									thumb_down </i>
							</button>
						</c:when>
						<c:otherwise>
							<button type="button" onclick="dislike()">
								<div>0</div>
								<i class="material-icons" style="font-size: 3em;">
									thumb_down </i>
							</button>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${spnum eq detail.sh_num}">
							<button type="button" onclick="dibsOn()">
								<div>&nbsp;</div>
								<i id="dibs" class="material-icons"
									style="color: red; font-size: 3em;"> favorite </i>
							</button>
						</c:when>
						<c:otherwise>
							<button type="button" onclick="dibsOn()">
								<div>&nbsp;</div>
								<i id="dibs" class="material-icons"
									style="color: pink; font-size: 3em;"> favorite </i>
							</button>
						</c:otherwise>
					</c:choose>
				</div>
				<!-- 추천 비추천 찜 -->

				<!-- 댓글 출력 -->
				<div style="margin-top: 2rem;">
					<div style="width: fit-content; margin: auto;">
						<input type="button" class="btn btn-primary"
							value="댓글보기(${replyCnt})" id="showReply"> <input
							type="button" class="btn btn-primary" value="댓글숨기기"
							id="hideReply">
					</div>
					<br>
					<div id="reply">
						<table class="table" id="replyList"
							style="margin: auto; width: 94.5%;">
							<tr class="table-info">
								<th style="text-align: center; width: 20%;">작성자</th>
								<th style="text-align: center; width: 50%;">내용</th>
								<th style="text-align: center; width: 20%;">작성시간</th>
								<th style="text-align: center; width: 10%;">답글달기</th>
							</tr>

							<!-- 닉네임과 들여쓰기 처리 -->
							<c:forEach var="reply" items="${pageInfo.list}">
								<c:if test="${reply.depth > 0}">
									<!-- 대댓글의 경우 하늘색으로 출력 -->
									<tr class="table-light" style="text-align: left;">
								</c:if>
								<c:if test="${reply.depth <= 0}">
									<tr class="table-active" style="text-align: left;">
								</c:if>
								<c:if test="${reply.depth > 0}">
									<!-- 대댓글의 경우 들여쓰기 -->
									<td style="text-align: left;"><c:forEach var="i" begin="1"
											end="${reply.depth}">&nbsp;&nbsp; </c:forEach> └
										${reply.name}
								</c:if>
								<c:if test="${reply.depth <= 0}">
									<td style="text-align: left;">${reply.name}
								</c:if>
								<c:if
									test="${reply.content != '삭제된 댓글' && reply.nickname eq user.user.uid}">
									<a
										href="javascript:updateReplyForm(${reply.idx}, '${reply.content}', '${reply.nickname}')">
										<i class="fa fa-eraser" aria-hidden="true"></i>
									</a>
									<c:if test="${reply.childCnt == 0}">
										<!-- 자식댓글이 없으면 아예 삭제 -->
										<a href="javascript:deleteReply1(${reply.idx})"><i
											class="fa fa-times" aria-hidden="true"></i></a>
									</c:if>
									<c:if test="${reply.childCnt != 0}">
										<!-- 자식댓글이 있으면 삭제된 댓글로 대체 -->
										<a href="javascript:deleteReply2(${reply.idx})"><i
											class="fa fa-times" aria-hidden="true"></i></a>
									</c:if>
								</c:if>



								<!-- 댓글내용 -->
								<td style="text-align: left;">${reply.content}
									<div id="updateReplyBox${reply.idx}"></div>
								</td>


								<!-- 작성일 -->
								<td style="text-align: left; text-align: center;">${reply.date}</td>


								<!-- 버튼처리 -->
								<c:if test="${reply.depth == 0}">
									<td style="text-align: center;"><a
										href="javascript:insertNestedRepForm('${reply.idx}','${reply.depth}','${reply.screenOrder}','${reply.nickname}','${user.user.uid}','${reply.name}')">
											<i class="fa fa-plus-square" aria-hidden="true"></i>
									</a></td>
								</c:if>
								<tr>
									<td><div id="replyBox${reply.idx}"></div></td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>

<!-- 페이징 시작 -->
         <nav class = "pageBtn" aria-label="Page navigation example">
           <ul class="pagination justify-content-center">
             <li class="page-item">
               <a class="page-link" href = "/petmong/shfc/shfcdetail?num=${detail.sh_num}&pageNum=${pageInfo.navigateFirstPage}" aria-label="Previous">
                 <span aria-hidden="true">&laquo;</span>
               </a>
             </li>
                <c:forEach var = "pageNum" items = "${pageInfo.navigatepageNums}">
                   <c:choose>                           
                     <c:when test = "${pageInfo.pageNum == pageNum}"> <!-- n이 현재 페이지와 같다면, -->
                         <li class="page-item active"><a class="page-link" href = "/petmong/shfc/shfcdetail?num=${detail.sh_num}&pageNum=${pageNum}">${pageNum}</a></li>
                      </c:when>
                      <c:otherwise>
                         <li class="page-item"><a class="page-link" href = "/petmong/shfc/shfcdetail?num=${detail.sh_num}&pageNum=${pageNum}">${pageNum}</a></li>
                      </c:otherwise>
                   </c:choose>      
                </c:forEach>
               <li class="page-item">
                <a class="page-link" href = "/petmong/shfc/shfcdetail?num=${detail.sh_num}&pageNum=${pageInfo.navigateLastPage}"  aria-label="Next">
                   <span aria-hidden="true">&raquo;</span>
                </a>
               </li> 
              </ul>
            </nav>
         <!-- 페이징 끝 -->


				<form id="re">
					<table style="width: 95%; margin: auto;">
						<tr>
							<td><sec:authorize access="isAuthenticated()">
									<label for="content">댓글</label> &nbsp;
                  <input type="hidden" name="nickname"
										value="${user.user.uid}" readonly />
                  <input type="hidden" name="name"
										value="${user.user.name}" readonly />
									<input type="hidden" name=boardIdx value="${detail.sh_num }">
									<textarea rows="2" name="content" id="content"
										class="form-control"></textarea>
									<input type="button" class='btn btn-primary' value="댓글 달기"
										onclick="insertReply()" style="margin-top: 5px;" />
								</sec:authorize> <sec:authorize access="isAnonymous()">
									<a href="/petmong/loginForm"> <textarea rows="2"
											name="content" id="content" class="form-control" readonly>로그인이 필요한 서비스입니다</textarea>
									</a>
								</sec:authorize></td>
						</tr>
					</table>
				</form>



			</div>
		</div>
	</article>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fefe54713afff65d5e6b73e9a2b6fd73&libraries=services"></script>
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


<!-- 게시글 추천하기 -->
function like() {
	var uid = "${user.user.uid}";
	var spnum = ${detail.sh_num};
	var category = "${detail.sh_facCate}";
	
	if(uid == '') {
		alert('로그인이 필요한 페이지입니다.');
		location.href="/petmong/loginForm";
		return;
	}
	
	obj = {};
	obj.uid = uid;
	obj.spnum = spnum;
	obj.category = category;

	$.ajax({
		url : '/petmong/shfc/like',
		method : 'post',
		cache : false,
		data : obj,
		dataType : 'json',
		success : function(res) {
			if (res.like) {
				alert('게시글을 추천하셨습니다.');
				location.reload();
			} else {
				alert('추천을 취소하셨습니다.');
				location.reload();
			}
		},
		error : function(xhr, status, err) {
			alert('에러 : ' + xhr + status + err);
		}
	});
}

<!-- 게시글 비추천하기 -->
function dislike() {
	var uid = "${user.user.uid}";
	var spnum = ${detail.sh_num};
	var category = "${detail.sh_facCate}";
	
	if(uid == '') {
		alert('로그인이 필요한 페이지입니다.');
		location.href="/petmong/loginForm";
		return;
	}
	
	obj = {};
	obj.uid = uid;
	obj.spnum = spnum;
	obj.category = category;
	
	$.ajax({
		url : '/petmong/shfc/dislike',
		method : 'post',
		cache : false,
		data : obj,
		dataType : 'json',
		success : function(res) {
			if (res.dislike) {
				alert('게시글을 비추천하셨습니다.');
				location.reload();
			} else {
				alert('비추천을 취소하셨습니다.');
				location.reload();
			}
		},
		error : function(xhr, status, err) {
			alert('에러 : ' + xhr + status + err);
		}
	});
}

// 찜 게시글 여부 위한 변수 선언.
const dibs = document.querySelector("#dibs");

<!-- 게시물 찜 하기. -->
function dibsOn() {
	var uid = "${user.user.uid}";
	var spnum = ${detail.sh_num};
	var category = "${detail.sh_facCate}";
	
	if(uid == '') {
		alert('로그인이 필요한 페이지입니다.');
		location.href="/petmong/loginForm";
		return;
	}
	
	obj = {};
	obj.uid = uid;
	obj.spnum = spnum;		
	obj.category = category;
	
	$.ajax({
		url : '/petmong/shfc/dibsOn',
		method : 'post',
		cache : false,
		data : obj,
		dataType : 'json',
		success : function(res) {
			if(res.dibsOn) {
				alert('게시글을 찜 하셨습니다.');
				dibs.style.color = "red";

			} else {
				alert('취소하셨습니다.');
				dibs.style.color = "pink";

			}

		},
		error : function(xhr, status, err) {
			alert('에러 : ' + xhr + status + err);
		}
	});
}   


</script>


</body>
</html>