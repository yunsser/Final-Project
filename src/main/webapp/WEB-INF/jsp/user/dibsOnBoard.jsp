<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../layout/headerMypage.jsp"%>
<style>
#btitle {
	width: fit-content;
	margin: 0 auto;
	font-family: sans-serif;
}
a{text-decoration: none;}
.pageBtn {
	margin-bottom: 15px;
}
</style>
<!-- 본문 시작 -->
<div id="info" class="container">
	<!-- 병원 게시판 -->
		<h4 id="btitle">병원게시판</h4>
	
	 <table class="table table-hover" style="text-align: center; width: 80%; margin: auto;">

      <tr>
      	<th>No</th>
         <th>지역</th>
         <th>병원이름</th>
         <th>
			<i class="material-icons" style = " font-size: 1.5em;">
				favorite
			</i>
		</th>

      </tr>
      

      <c:forEach var="h" items="${hplist.list}" >

         <tr>
         
         <c:set var="sido" value="${fn:split(h.hp_roadadd,' ')[0]}"/>
         <c:set var="gugun" value="${fn:split(h.hp_roadadd,' ')[1]}"/>
			<c:set var="i" value="${i+1 }"/>
     		 <td scope="row">${i}</td>
         	<td><a href="/petmong/hp/detail?uid=${user.user.uid}&mgtno=${h.hp_mgtno}"> ${sido} ${gugun }</a></td>
            <td><a href="/petmong/hp/detail?uid=${user.user.uid}&mgtno=${h.hp_mgtno}">${h.hp_name}</a></td>
            <td>
        		<i id = "dibs" class="material-icons" style = "color : red; font-size: 1.5em;">
						favorite
				</i>
     		</td>

         </tr>
      </c:forEach>
   </table>
	<!-- 병원 게시판 -->
		<br>
		<!-- 병원 페이징 시작 -->
	<nav class="pageBtn" aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<li class="page-item"><a class="page-link"
				href="/petmong/user/dibsOnBoard?pageNum=${hplist.navigateFirstPage}&uid=${user.user.uid}"
				aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
			</a></li>
			<c:forEach var="pageNum" items="${hplist.navigatepageNums}">
				<c:choose>
					<c:when test="${hplist.pageNum == pageNum}">
						<!-- n이 현재 페이지와 같다면, -->
						<li class="page-item active"><a class="page-link"
							href="/petmong/user/dibsOnBoard?pageNum=${pageNum}&uid=${user.user.uid}">${pageNum}</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link"
							href="/petmong/user/dibsOnBoard?pageNum=${pageNum}&uid=${user.user.uid}">${pageNum}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<li class="page-item"><a class="page-link"
				href="/petmong/user/dibsOnBoard?pageNum=${hplist.navigateLastPage}&uid=${user.user.uid}"
				aria-label="Next"> <span aria-hidden="true">&raquo;</span>
			</a></li>
		</ul>
	</nav>
	<!-- 병원 페이징 끝 -->
	

	<br>
	<!-- 공유게시판 -->
	<h4 id="btitle">공유게시판</h4>
	<table class="table"
		style="text-align: center; width: 80%; margin: auto;">
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

		<c:forEach var="u" items="${hpageInfo.list}" varStatus="status">
			<tr>
				<td>${u.num}</td>
				<td>${u.sido}｜${u.gugun}</td>
				<td><a
					href="/petmong/post/detail?uid=${user.user.uid}&num=${u.num}">${u.title}</a></td>
				<td>${u.name}</td>
				<td>${u.viewCnt}</td>
				<td>${u.sumlike }</td>
				<td>${u.sumdislike }</td>
				<td><c:choose>
						<c:when test="${hpnumList[status.index] eq u.num}">
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
	</table>
	<!-- 공유게시판 -->
	<br />
	<!-- 공유 페이징 시작 -->
	<nav class="pageBtn" aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<li class="page-item"><a class="page-link"
				href="/petmong/user/dibsOnBoard?pageNum=${hpageInfo.navigateFirstPage}&uid=${user.user.uid}"
				aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
			</a></li>
			<c:forEach var="pageNum" items="${hpageInfo.navigatepageNums}">
				<c:choose>
					<c:when test="${hpageInfo.pageNum == pageNum}">
						<!-- n이 현재 페이지와 같다면, -->
						<li class="page-item active"><a class="page-link"
							href="/petmong/user/dibsOnBoard?pageNum=${pageNum}&uid=${user.user.uid}">${pageNum}</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link"
							href="/petmong/user/dibsOnBoard?pageNum=${pageNum}&uid=${user.user.uid}">${pageNum}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<li class="page-item"><a class="page-link"
				href="/petmong/user/dibsOnBoard?pageNum=${hpageInfo.navigateLastPage}&uid=${user.user.uid}"
				aria-label="Next"> <span aria-hidden="true">&raquo;</span>
			</a></li>
		</ul>
	</nav>
	<!-- 공유 페이징 끝 -->
<br>
	<!-- 후기게시판 -->
	<h4 id="btitle">후기게시판</h4>
	<table class="table"
		style="text-align: center; width: 80%; margin: auto;">
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

		<c:forEach var="l" items="${spageInfo.list}" varStatus="status">

			<tr>
				<td>${l.sh_num}</td>
				<td>${l.sh_facCate}</td>
				<td>${l.sh_facSido}｜${l.sh_facGugun}</td>
				<td><a
					href="/petmong/shfc/shfcdetail?uid=${user.user.uid}&num=${l.sh_num}">${l.sh_facNM }</a></td>
				<td><a href="/petmong/shfc/shfcdetail?uid=${user.user.uid}&num=${l.sh_num}">${l.sh_title}</a></td>
				<td>${l.sh_nickname}</td>
				<td>${l.sh_viewCnt}</td>
				<td>${l.sumlike }</td>
				<td>${l.sumdislike }</td>
				<td><c:choose>
						<c:when test="${spnumList[status.index] eq l.sh_num}">
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
	</table>
	<!-- 후기게시판 -->
	<br />
	<!-- 후기 페이징 시작 -->
	<nav class="pageBtn" aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<li class="page-item"><a class="page-link"
				href="/petmong/user/dibsOnBoard?pageNum=${spageInfo.navigateFirstPage}&uid=${user.user.uid}"
				aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
			</a></li>
			<c:forEach var="pageNum" items="${spageInfo.navigatepageNums}">
				<c:choose>
					<c:when test="${spageInfo.pageNum == pageNum}">
						<!-- n이 현재 페이지와 같다면, -->
						<li class="page-item active"><a class="page-link"
							href="/petmong/user/dibsOnBoard?pageNum=${pageNum}&uid=${user.user.uid}">${pageNum}</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link"
							href="/petmong/user/dibsOnBoard?pageNum=${pageNum}&uid=${user.user.uid}">${pageNum}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<li class="page-item"><a class="page-link"
				href="/petmong/user/dibsOnBoard?pageNum=${spageInfo.navigateLastPage}&uid=${user.user.uid}"
				aria-label="Next"> <span aria-hidden="true">&raquo;</span>
			</a></li>
		</ul>
	</nav>
	<!-- 후기 페이징 끝 -->

	<!-- 푸터 시작 -->
	<%@ include file="../layout/footer.jsp"%>
	<!-- 푸터 끝 -->
</div>
<!-- 본문 끝 -->
</div>
</body>
</html>