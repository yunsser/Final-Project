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
<!-- <script>
var newText = text.replace(/(<([^>]+)>)/ig,"");
</script> -->

<title>상세보기</title>

<div class="container">
	<div class="nav-scroller py-1 mb-2">
		<nav class="nav d-flex justify-content-between">
			<a class="p-2 link-secondary" href="#">병원게시판</a> <a
				class="p-2 link-secondary" href="#">공유게시판</a> <a
				class="p-2 link-secondary" href="#">유기동물게시판</a>
		</nav>
	</div>
</div>

<article>
		<div class="container" role="main">

			<p>
			<div name="addForm" id="form">
				<div class="mb-3">
					<label for="title">제목</label> <span type="text"
						class="form-control">${post.title}</span>
				</div>


				<div class="mb-3">
					<label for="author">작성자</label> <span class="form-control"
						name="reg_id" id="reg_id"><input type="hidden"
						name="author" value="${post.author}"
						style="border: none; color: gray;" readonly>${post.author}</span>
				</div>


				<div class="mb-3">
					<label for="category">카테고리</label>
					<span class="form-control">${post.category}</span>
				</div>
				
				<div class="mb-3">
					<label for="title">내용</label>
					<span class="form-control">${post.summernote}</span>
				</div>

				<div>
					<!-- class="form-control" -->
					<label for="content">파일</label>

					<c:choose>
						<c:when test="${fn:length(post.attach)>0}">
							<c:forEach var="f" items="${post.attach}">
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
			<div class="btlistsav">
					<button type="button" class="btn btn-sm btn-primary"
						onclick="location.href='/post/edit?num=${post.num}'">수정</button>
					<button type="button" class="btn btn-sm btn-primary"
						onclick="location.href=del_board('${post.num}')">삭제</button>

				<button type="button" class="btn btn-sm btn-primary"
					onclick="location.href='/post/list'">목록</button>
			</div>

		</div>
	</article>

</body>
</html>