<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/jsp/layout/headerSearch.jsp"%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="user" />
</sec:authorize>

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
			url:"/reply/insertReply",
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
			url:"/reply/deleteReply",
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
	updateReply += "<label for='content'>작성자:</label> &nbsp;";
	updateReply += "<input type='text' name='nickname' size='2' value='nary2' readonly/>";
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
			url:"/reply/updateReply",
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
	function insertNestedRepForm(idx,depth,screenOrder,nickname, uid) {
		var insReply = "";
		insReply += "<table style='width:210%'>";
		insReply += "<tr>";
		insReply += "<td style='border:none;width:85%;text-align:right;padding:0px;' class='reply_cont'>";
		insReply += "<div class='form-group'>";
		insReply += "<label for='content' style='float:left;'>댓글 작성자</label> &nbsp;";
		insReply += "<input type='text' style='float:left;' name='nickname' value="+uid+" readonly/>";
		insReply += "<textarea rows='2' class='form-control' id='content"+idx+"' name='content'></textarea>"; //@"+nickname+"\n
		insReply += "</div>";
		insReply += "</td>";
		insReply += "</tr>";
		insReply += "<tr>";
		insReply += "<td style='border:none;width:15%;text-align:left;padding:0px;' class='reply_cont'>";
		insReply += "<input type='button' class='btn btn-primary' value='댓글 달기' onclick='insertNestedRep("+idx+","+depth+","+screenOrder+")'/>";
		insReply += "<input type='button' class='btn btn-primary' value='취소' id='closeReply"+idx+"' onclick='closeReply("+idx+")'/>";
		insReply += "</td>";
		insReply += "</tr>";
		
		insReply += "</table>";
		/* insReply += "<hr style='margin:0px;'/>"; */
		
		$("#openReply"+idx).hide();    // '답글'버튼 가리기
		$("#closeReply"+idx).show();   // '닫기'버튼 보이기
		$("#replyBox"+idx).slideDown(500);
		$("#replyBox"+idx).html(insReply);
	}
	
	/* 대댓글입력 */
	function insertNestedRep(idx,depth,screenOrder) {
		
		var boardIdx = "${post.num}";
		var nickname = "${user.user.uid}";
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
	  			url:"/reply/insertNestedRep",
	  			method:'post',
	  			cache:false,
	  			data:query,
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
			url: '/post/delete',
			method: 'post',
			cache: false,
			data: obj,
			dataType: 'json',
			success: function(res) {
				alert(res.deleted ? '삭제 성공' : '삭제 실패!');
				location.href = "/post/list";
			},
			error: function(xhr, status, err) {
				alert('에러 : ' + err);
			}
		}); 
	}
</script>
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
	margin-top: 5rem;
	border-bottom: 1px solid #8080803d;
	width: 100%;
    margin-bottom: 10px;
    clear: both;
    display:table;
}

.table-info { 
	--bs-table-bg: #383838;
	color: #fff;
	border-color: #ffffff00;
}

.table>:not(caption)>*>* {
	border-bottom: none;
}
</style>
<!-- <script>
var newText = text.replace(/(<([^>]+)>)/ig,"");
</script> -->

<title>상세보기</title>


<!-- 글 디테일부분 -->
<article>
	<div class="container" role="main">

		<div class="d-flex" style="margin-top: 3rem;">
			<div>카테고리</div>
			<div>, ${post.category}</div>
		</div>
		<br>
		<div class="d-flex col-12 title">
			<div class="col-1" style="margin: 0rem 1.2rem 0rem 2rem; width: 80%">
				${post.title}</div>
			<div style="width: 20%; font-size: 18px;">${post.author}</div>
		</div>
		<div class="col-12 content">
			<div style="margin-bottom: 4rem;">${post.summernote}</div>

			<div class="imagelabel">첨부파일</div>
			<c:choose>
				<c:when test="${fn:length(post.attach)>0}">
					<c:forEach var="f" items="${post.attach}">
						<fmt:formatNumber var="kilo" value="${f.filesize/1024}"
							maxFractionDigits="0" />
						<div>
							<a href="/post/file/download/${f.att_num}"><img
								src="/upload/${f.filename}" width="20%" alt="" class="thumb"
								style="display: inline-block; float: left;"/></a>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<span>첨부파일 없음</span>
				</c:otherwise>
			</c:choose>
			
<div style="clear:both;"></div>

			<!-- 수정 목록 버튼 -->
			<div class="btlistsav" style="margin-top: 5rem; float: right; display: block;">
				<button type="button" class="btn btn btn-primary"
					onclick="location.href='/post/edit?num=${post.num}'">수정</button>
				<button type="button" class="btn btn btn-primary"
					onclick="location.href=del_board('${post.num}')">삭제</button>

				<button type="button" class="btn btn btn-primary"
					onclick="location.href='/post/list'">목록</button>
			</div>

		</div>
	</div>
</article>
<div style="clear:both;"></div>
<br>


<!-- 댓글 출력 -->
<div style="margin-top: 2rem;">
	<div style="width: fit-content; margin: auto;">
		<input type="button" class="btn btn-secondary" value="댓글보기"
			id="showReply"> <input type="button"
			class="btn btn-secondary" value="댓글숨기기" id="hideReply">
	</div>
	<br>
	<div id="reply">
		<table class="table" id="replyList" style="margin: auto; width: 70%;">
			<tr class="table-info">
				<th style="text-align: center; width: 20%;">작성자</th>
				<th style="text-align: center; width: 50%;">내용</th>
				<th style="text-align: center; width: 20%;">작성시간</th>
				<th style="text-align: center; width: 10%;">답글달기</th>
			</tr>

			<!-- 닉네임과 들여쓰기 처리 -->

			<c:forEach var="reply" items="${replyList}">
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
						${reply.nickname}
				</c:if>
				<c:if test="${reply.depth <= 0}">
					<td style="text-align: left;">${reply.nickname}
				</c:if>
				<c:if
					test="${reply.content != '삭제된 댓글' && reply.nickname eq user.user.uid}">
					<a
						href="javascript:updateReplyForm(${reply.idx}, '${reply.content}', '${reply.nickname}')">
						<i class="fa fa-eraser" aria-hidden="true"></i>
					</a>
					<a href="javascript:deleteReply(${reply.idx})"><i
						class="fa fa-times" aria-hidden="true"></i></a>
				</c:if>



				<!-- 댓글내용 -->
				<td style="text-align: left;">${reply.content}
					<div id="updateReplyBox${reply.idx}"></div>
				</td>


				<!-- 작성일 -->
				<td style="text-align: left; text-align: center;">${reply.date}</td>


				<!-- 버튼처리 -->
				<td style="text-align: center;"><a
					href="javascript:insertNestedRepForm('${reply.idx}','${reply.depth}','${reply.screenOrder}','${reply.nickname}','${user.user.uid}')">
						<i class="fa fa-plus-square" aria-hidden="true"></i>
				</a></td>
				<tr>
					<td><div id="replyBox${reply.idx}"></div></td>
				</tr>
			</c:forEach>

		</table>
	</div>
</div>

<br>

<form id="re">
	<table style="width: 70%; margin: auto;">
		<tr>
			<td><label for="content">댓글 작성자</label> &nbsp; <input
				type="text" name="nickname" value=${user.user.uid } readonly /> <input
				type="hidden" name=boardIdx value="${post.num }"> <textarea
					rows="2" name="content" id="content" class="form-control"></textarea>
				<input type="button" class="btn btn-primary" value="댓글 달기"
				onclick="insertReply()" /></td>
		</tr>
	</table>
	<input type="hidden" name="boardIdx" value="${post.num}" />
</form>
</body>
</html>