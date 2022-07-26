<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>insert title</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
  		insReply += "<label for='content' style='float:left;'>댓글 작성자</label> &nbsp;";
  		insReply += "<input type='text' style='float:left;' name='nickname' value='nary2' readonly/>";
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
  		
  		var boardIdx = "${board.idx}";
  		var nickname = "nary2";
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

  <%-- <link rel = "stylesheet" href= "${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> --%>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
</head>
<body>
<h3>게시글</h3>
	<form>
		<table>
			<tr><th>글쓴이</th>
				<td>${board.name}</td>
			</tr>

			<tr><th>작성시간</th>
     	 		<td>${board.date}</td>
      		</tr>

			<tr><th>조회수</th>
        		<td>${board.readnum}</td>
			</tr>

			<tr><th>글제목</th>
				<td>${board.title}</td>
			</tr>

			<tr><th>글내용</th>
				<td colspan="3">
				<td>${board.content}</td>
			</tr>

     		<tr>
        		<td>
		         <%--  <c:if test="${smid == board.mid || smid == 'admin'}"> 만약 작성자와 접속자가 같으면
			          <input type="button" value="Update" onclick="updBoardCheck()"/> &nbsp;
			          <input type="button" value="Delete" onclick="delBoardCheck()"/> &nbsp;
		          </c:if> --%>
        	</td>
      		</tr>
    	</table>
  	</form>




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
          	
          	  <%--  <c:if test=""> 접속자와 닉네임이 같으면
	          </c:if> --%>
            	<a href="javascript:updateReplyForm(${reply.idx}, '${reply.content}', '${reply.nickname}')"><i class="glyphicon glyphicon-erase"></i></a>
          		<a href="javascript:deleteReply(${reply.idx})"><i class="glyphicon glyphicon-remove" style="color:#a35f65;"></i></a>
          	




	          <!-- 댓글내용 -->
	          <td style="text-align:left;">${reply.content}
	        	  <div id="updateReplyBox${reply.idx}"></div>
	          </td>


	          <!-- 작성일 -->
	          <td style="text-align:left; text-align: center;">${reply.date}</td>


	          <!-- 버튼처리 -->
	          <td style="text-align: center;">
	          	<a href="javascript:insertNestedRepForm('${reply.idx}','${reply.depth}','${reply.screenOrder}','${reply.nickname}')"><i class="glyphicon glyphicon-pencil"></i></a>
	           <%--  <input type="button" value="답글달기" id="openReply${reply.idx}" 
	            		onclick="insertNestedRepForm('${reply.idx}','${reply.depth}','${reply.screenOrder}','${reply.nickname}')"/> --%>
	            <%-- <input type="button" value="취소" id="closeReply${reply.idx}" 
	            		onclick="closeReply(${reply.idx})" style="display:none;"/> --%>
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
		            <label for="content">댓글 작성자</label> &nbsp;
		            <input type="text" name="nickname" value="nary" readonly/>
		            <input type="hidden" name=boardIdx value="${board.idx }">
		            <textarea rows="2" name="content" id="content" class="form-control"></textarea>
			        <input type="button" class='btn btn-dark' value="댓글 달기" onclick="insertReply()"/>
	        	</td>
	      	</tr>
	    </table>
	    <input type="hidden" name="boardIdx" value="${board.idx}"/>
	</form>

</body>
</html> 