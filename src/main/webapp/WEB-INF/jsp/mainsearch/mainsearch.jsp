<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/jsp/layout/headerSearch.jsp"%>

<style>
.search {
	margin-top: 15px;
	display: flex;
	justify-content: center;
}

.form-select {
	float: left;
	margin-right: 5px;
}

.pagination {
	display: flex;
	justify-content: center;
	margin-top: 15px;
}

.search {
	margin-top: 15px;
	display: flex;
	justify-content: center;
}

a {
	text-decoration: none;
}

.serch-result {
	width: 68%;
	margin: auto;
	font-size: large;
}

.serch-in {
	float: right;
}

.label_name{
	width: 67%;
	margin: auto;
}
</style>
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
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	
</script>
<title>목록</title>
<c:if test="${fn:length(keyword) == 0}">
   검색어를 입력해주세요.
   </c:if>
<!-- 버튼 -->

<br>
<!-- 게시판 -->
	<c:if test="${fn:length(keyword) != 0}">


		<div class="serch-result">
			<div class="serch-in">
				<span class="text-info">${keyword } </span> 검색 결과입니다.
			</div>
		</div>
		<br>
		<div class="label_name"><span class="badge bg-secondary">병원 게시판</span>

			<c:if test="${fn:length(hplist)!=0}">
				<small>${hptotal}개의 검색결과 <a
					href="/petmong/hpsearch?uid=${user.user.uid}&keyword=${keyword}">더보기</a></small>
			</c:if></div>
			
		<table class="table table-hover"
			style="text-align: center; width: 67%; margin: auto;">
			<tr>
				<th>지역</th>
				<th>병원이름</th>
				<th>주소</th>
				<th><i class="material-icons" style="font-size: 1.5em;">
						favorite </i></th>

			</tr>

			<c:if test="${fn:length(hplist)==0}">
				<tr>
					<td></td>
					<td>검색결과 없음</td>
					<td></td>
					<td></td>
				</tr>

			</c:if>
			<c:if test="${fn:length(hplist)!=0}">
				<c:forEach begin="0" end="4" var="h" items="${hplist}"
					varStatus="status">

					<tr>

						<c:set var="sido" value="${fn:split(h.RDNWHLADDR,' ')[0]}" />
						<c:set var="gugun" value="${fn:split(h.RDNWHLADDR,' ')[1]}" />

						<td>${sido} ${gugun }</td>
						<td><a
							href="/petmong/hp/detail?uid=${user.user.uid}&mgtno=${h.MGTNO}">${h.BPLCNM}</a></td>
						<td><a
							href="/petmong/hp/detail?uid=${user.user.uid}&mgtno=${h.MGTNO}">${h.RDNWHLADDR}</a></td>
						<td><c:choose>
								<c:when test="${hpnumList[status.index] eq h.MGTNO}">
									<i id="dibs" class="material-icons"
										style="color: red; font-size: 1.5em;"> favorite </i>
								</c:when>
								<c:otherwise>
									<i id="dibs" class="material-icons"
										style="color: pink; font-size: 1.5em;"> favorite </i>
								</c:otherwise>
							</c:choose></td>

					</tr>
				</c:forEach>
			</c:if>
		</table>

		<br>
		<br>

		<!-- 게시판 -->
		<div class="label_name">
		<span class="badge bg-secondary">후기 게시판</span>
			<c:if test="${fn:length(sflist)!=0}">
				<small> ${sftotal}개의 검색결과 <a
					href="/petmong/sfsearch?uid=${user.user.uid}&keyword=${keyword}">더보기</a></small>
			</c:if></div>
		<table class="table"
			style="text-align: center; width: 67%; margin: auto;">
			<tr>
				<th>No</th>
				<th>카테고리</th>
				<th>지역</th>
				<th>장소</th>
				<th>제목</th>
				<th>작성자</th>
				<th><i class="material-icons" style="font-size: 1.5em;">
						visibility </i></th>
				<th><i class="material-icons" style="font-size: 1.5em;">
						thumb_up </i></th>
				<th><i class="material-icons" style="font-size: 1.5em;">
						thumb_down </i></th>
				<th><i class="material-icons" style="font-size: 1.5em;">
						favorite </i></th>
			</tr>

			<c:if test="${fn:length(sflist)==0}">
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>

					<td>검색결과 없음</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>

				</tr>
			</c:if>

			<c:if test="${fn:length(sflist)!=0}">
				<c:forEach begin="0" end="4" var="s" items="${sflist}"
					varStatus="status">

					<tr>

						<td>${s.sh_num}</td>
						<td>${s.sh_facCate}</td>
						<td><a
							href="/petmong/shfc/shfcdetail?uid=${user.user.uid}&num=${s.sh_num}">${s.sh_facSido}｜${s.sh_facGugun}</a></td>
						<td><a
							href="/petmong/shfc/shfcdetail?uid=${user.user.uid}&num=${s.sh_num}">${s.sh_facNM }</a></td>
						<td><a
							href="/petmong/shfc/shfcdetail?uid=${user.user.uid}&num=${s.sh_num}">${s.sh_title}</a></td>
						<td>${s.sh_nickname}</td>
						<td>${s.sh_viewCnt}</td>
						<td>${s.sumlike }</td>
						<td>${s.sumdislike }</td>
						<td><c:choose>
								<c:when test="${sfnumList[status.index] eq s.sh_num}">
									<i id="dibs" class="material-icons"
										style="color: red; font-size: 1.5em;"> favorite </i>
								</c:when>
								<c:otherwise>
									<i id="dibs" class="material-icons"
										style="color: pink; font-size: 1.5em;"> favorite </i>
								</c:otherwise>
							</c:choose></td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<br>
		<br>
		<div class="label_name"><span class="badge bg-secondary">공유 게시판</span>
		<c:if test="${fn:length(bdlist)!=0}">
			<small> ${bdtotal}개의 검색결과 <a
				href="/petmong/bdsearch?uid=${user.user.uid}&keyword=${keyword}">더보기</a></small>
		</c:if></div>
		<table class="table"
			style="text-align: center; width: 67%; margin: auto;">
			<tr>
				<th>No</th>
				<th>지역</th>
				<th>제목</th>
				<th>작성자</th>
				<th><i class="material-icons" style="font-size: 1.5em;">
						visibility </i></th>
				<th><i class="material-icons" style="font-size: 1.5em;">
						thumb_up </i></th>
				<th><i class="material-icons" style="font-size: 1.5em;">
						thumb_down </i></th>
				<th><i class="material-icons" style="font-size: 1.5em;">
						favorite </i></th>

			</tr>

			<c:if test="${fn:length(bdlist)==0}">
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td>검색결과 없음</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</c:if>

			<c:if test="${fn:length(bdlist)!=0}">
				<c:forEach begin="0" end="4" var="u" items="${bdlist}"
					varStatus="status">
					<tr>
						<td>${u.num}</td>
						<td><a
							href="/petmong/post/detail?uid=${user.user.uid}&num=${u.num}">${u.sido}｜${u.gugun}</a></td>
						<td><a
							href="/petmong/post/detail?uid=${user.user.uid}&num=${u.num}">${u.title}</a></td>
						<td><a
							href="/petmong/post/detail?uid=${user.user.uid}&num=${u.num}">${u.name}</a></td>
						<td>${u.viewCnt}</td>
						<td>${u.sumlike }</td>
						<td>${u.sumdislike }</td>
						<td><c:choose>
								<c:when test="${bdnumList[status.index] eq u.num}">
									<i id="dibs" class="material-icons"
										style="color: red; font-size: 1.5em;"> favorite </i>
								</c:when>
								<c:otherwise>
									<i id="dibs" class="material-icons"
										style="color: pink; font-size: 1.5em;"> favorite </i>
								</c:otherwise>
							</c:choose></td>
					</tr>
				</c:forEach>
			</c:if>
		</table>

	</c:if>

	<!-- 페이지네이션 -->
	<p>

		<!-- 숫자버튼 -->
		</body>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"
			integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
			crossorigin="anonymous"></script>
		<script type="text/javascript">
			function Searchsido() {
				if ($("#code").val() == 'none') {
					alert('시/도 를 선택해주세요.');
					return false;
				}

			}
		</script>




		</html>