<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/jsp/layout/headerSearch.jsp"%>


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
<style>
.pagination {
	display: flex;
	justify-content: center;
	margin-top: 15px;
}

.cate_wrap {
	display: flex;
	float: right;
	width: 33%;
	margin-bottom: 10px;
}

.cntBts {
	text-align: center;
}

.cntBts button {
	border: none;
	background: none;
}
a {text-decoration: none;}
</style>



<!-- 서치 -->
<div style="display: inline-block; float: right;"></div>
<div class="search" style="margin-top: -30px;">
	<label for="cateCodeA"></label>
	<p></p>
	<input type="hidden" id="cateCodeA" name="cateCodeA" class="data">
	<p></p>
	<form action="" method="get" onsubmit="return Searchsido();">
		<input type="hidden" id="pageNum" name="pageNum" value="${pageNum}">
		<div class="cate_wrap">
			<select class="form-select" name="sido" id="code"
				style="width: 133px; height: 40px;">
				<option selected value=''>시/도 선택</option>
				<!-- 오류나면 value="none" -->
				<c:forEach var="codemap" items="${codemap}">
					<option value="${codemap.sidoCd}"
						${sido == codemap.sidoCd ? "selected":""}>
						${codemap.sidoNm}</option>
				</c:forEach>
			</select> <select class="form-select" name="gugun"
				style="width: 133px; height: 40px;" id="gugunCD">
				<option value=''>군/구 선택</option>
				<c:forEach var="gugunmap" items="${gugunmap}">
					<option value="${gugunmap.gugunNm}"
						${gugun == gugunmap.gugunNm ? "selected":""}>
						${gugunmap.gugunNm}</option>
				</c:forEach>
			</select>
			<button class="btn btn-secondary" type="submit">검색</button>
		</div>
	</form>
</div>
<div style="clear: both;"></div>

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
	<c:forEach var="u" items="${pageInfo.list}" varStatus="status">

		<tr>
			<td>${u.num}</td>
			<td>${u.sido}｜${u.gugun}</td>
			<td><a href="/petmong/post/detail?uid=${user.user.uid}&num=${u.num}">${u.title}</a></td>
			<td><a href="/petmong/post/detail?uid=${user.user.uid}&num=${u.num}">${u.name}</a></td>
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
<!-- 게시판 -->

<P>

	<!-- 버튼 -->
<div class="btn-holder"
	style="display: flex; justify-content: flex-end; width: 84%">
	<button class="btn btn-outline-primary" type="button"
		onclick="location.href='/petmong/post/board'">
		<span>글작성</span>
	</button>
</div>
<!-- 버튼 -->


<!-- 숫자버튼 -->
<p>
<div>
	<ul class="pagination">
		<li class="page-item"><c:if test="${pageInfo.pages>5}">
				<a class="page-link"
					href="/petmong/post/list?uid=${user.user.uid}&pageNum=${pageInfo.navigateFirstPage-1}">&laquo;</a>
			</c:if></li>

		<c:forEach begin="${pageInfo.navigateFirstPage}"
			end="${pageInfo.navigateLastPage}" var="num">
			<c:choose>
				<c:when test="${pageInfo.pageNum==num}">
					<li class="page-item active"><a class="page-link" href="/petmong/post/list?uid=${user.user.uid}&pageNum=${num}">${num}</a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link"
						href="/petmong/post/list?uid=${user.user.uid}&pageNum=${num}">${num}</a></li>
				</c:otherwise>

			</c:choose>
		</c:forEach>
		<li class="page-item"><c:if test="${pageInfo.pages>5}">
				<a class="page-link"
					href="/petmong/post/list?uid=${user.user.uid}&pageNum=${pageInfo.navigateLastPage+1}">&raquo;</a>
			</c:if></li>
	</ul>
</div>
<!-- 숫자버튼 -->

</body>



<script>
	let codeList = JSON.parse('${codeList}');

	let cate1Array = new Array();
	let cate2Array = new Array();
	let cate1Obj = new Object();
	let cate2Obj = new Object();

	let cateSelect1 = $("#code");
	let cateSelect2 = $("#gugunCD");

	/* 카테고리 배열 초기화 메서드 */

	function makeCateArray(obj, array, codeList, tier) {
		for (let i = 0; i < codeList.length; i++) {
			if (codeList[i].tier == tier) {

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

	$(document).ready(function() {
		console.log(cate1Array);

	});

	/* 배열 초기화 */

	makeCateArray(cate1Obj, cate1Array, codeList, 1);
	makeCateArray(cate2Obj, cate2Array, codeList, 2);

	$(document).ready(function() {
		console.log(cate1Array);
		console.log(cate2Array);
	});

	/* 대분류 <option> 태그 */
	for (let i = 0; i < cate1Array.length; i++) {
		//cateSelect1.append("<option value='"+cate1Array[i].sidoCd+"'>" + cate1Array[i].sidoNm + "</option>");
	}

	/* 중분류 <option> 태그 */
	$(cateSelect1)
			.on(
					"change",
					function() {
						let selectVal1 = $(this).find("option:selected").val();

						cateSelect2.children().remove();

						cateSelect2.append("<option value=''>군/구 선택</option>");

						for (let i = 0; i < cate2Array.length; i++) {
							if (selectVal1 == cate2Array[i].parent) {
								cateSelect2
										.append("<option value='"+cate2Array[i].gugunNm+"'>"
												+ cate2Array[i].gugunNm
												+ "</option>")

								//cateSelect2.append("<option value='"+cate2Array[i].gugunCd+"'>" + cate2Array[i].gugunNm + "</option>")
								//location.href = "/test/code?gugunCD="+cate2Array[i].gugunCd;
							}
						}
					});

	$(cateSelect2).on("change", function() {
		let selectVal2 = $(this).find("option:selected").val();

	});

	function checkUserInfo() {
		var uid = '${user.user.uid}';
		var phone = '${user.user.phone}';
		var SNSphone = '${phone}';
		if (uid == '') {
			alert('로그인이 필요한 페이지입니다.');
			location.href = "/petmong/loginForm";
		} else if (phone == '' && SNSphone == '') {
			alert('회원정보 추가 입력이 필요합니다.');
			location.href = "/petmong/user/addUserInfo";
		} else {
			location.href = "/petmong/post/board";
		}
	}
</script>

</html>