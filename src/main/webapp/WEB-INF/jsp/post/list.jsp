<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

<title>목록</title>


<!-- 페이지네이션 -->
	<div id="outter">
		<div class="right">

			<select id="cntPerPage" class="select_btn" name="sel"
				onchange="selChange()" style="display: none;">
				<option value="15"
					<c:if test="${paging.cntPerPage == 15}">selected</c:if>>15줄
					보기</option>
			</select>

		</div>
	</div>
	<!-- 페이지네이션 -->
	
	<!-- 게시판 -->
	<table class="table" style="text-align: center; width: 67%; margin: auto;">
		<tr>
			<th>#</th>
			<th>카테고리</th>
			<th>제목</th>
			<th>작성자</th>
			<th>조회수</th>
		</tr>
		<c:forEach var="u" items="${viewAll}">

			<tr>
				<td>${u.num}</td>
				<td>${u.category}</td>
				<td><a href="/post/detail?num=${u.num}">${u.title}</a></td>
				<td>${u.author}</td>
				<td>${u.count}</td>
			</tr>
		</c:forEach>
	</table>
	<!-- 게시판 -->

	<P>

		<!-- 버튼 -->
	<div class="btn-holder" style="display: flex; justify-content: flex-end; width: 84%">
		<button class="btn btn-outline-primary" type="button"
			onclick="location.href='/post/board'">
			<span>글작성</span>
		</button>
	</div> 
	<!-- 버튼 -->


	<!-- 숫자버튼 -->
	<p>
	<div>
		<ul class="pagination" id="pagination" style="margin: auto; justify-content: center;">

			<c:if test="${paging.startPage != 1 }">
				<a id="be" class="page-link"
					href="list?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">Before</a>
			</c:if>

			<c:forEach begin="${paging.startPage }" end="${paging.endPage }"
				var="p">
				<c:choose>
					<c:when test="${p == paging.nowPage }">
						<li class="page-item"><span aria-hidden="true"><b
								class="page-link">${p }</b></span></li>
					</c:when>
					<c:when test="${p != paging.nowPage }">
						<li class="page-item"><span aria-hidden="true"><a
								class="page-link"
								href="list?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a></span></li>
					</c:when>
				</c:choose>
			</c:forEach>

			<c:if test="${paging.endPage ne paging.lastPage}">
				<a class="page-link"
					href="list?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">Next</a>
			</c:if>

		</ul>
	</div>
	<!-- 숫자버튼 -->

</body>
</html>