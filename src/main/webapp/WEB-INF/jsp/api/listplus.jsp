<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	function changeCate() {

		var category = $('#cate').val();

		if (category == 'none') {
			alert('카테고리를 선택해주세요.');
			return;
		}

		//location.href="/shfclist?cate="+category;
	}
</script>
<style>
   .search {margin-top : 15px; display: flex; justify-content: center;}
   .form-select { float:left; margin-right: 5px;}
   .pagination {     display: flex; justify-content: center; margin-top: 15px;
   }
   .search {margin-top : -52px; display: inline-block; float: right; width: 34%;}
   a { text-decoration:none; }
</style>
<title>목록</title>


<div class="container">
	<div class="nav-scroller py-1 mb-2" style="margin-top: 25px;">
		<nav class="nav d-flex justify-content-between" style="width:20%;font-size: 17px; float: left; display: inline-block;">
			<a class="p-2 link-secondary" href="/petmong/shfc/shfclist?uid=${user.user.uid}">전체</a> <a
				class="p-2 link-secondary" href="/petmong/shfc/shfclist?uid=${user.user.uid}&cate=카페">카페</a> <a
				class="p-2 link-secondary" href="/petmong/shfc/shfclist?uid=${user.user.uid}&cate=식당">식당</a> <a
				class="p-2 link-secondary" href="/petmong/shfc/shfclist?uid=${user.user.uid}&cate=숙박">숙박</a>
		</nav>
	</div>
</div>
<!-- 버튼 -->

<div class="search">
	<label for="cateCodeA"></label>
	<p></p>
	<input type="hidden" id="cateCodeA" name="cateCodeA" class="data">
	<p></p>
	<form action="" method="get" onsubmit="return Searchsido();">
		<input type="hidden" id="uid" name="uid" value="${user.user.uid }">
		<input type="hidden" id="pageNum" name="pageNum" value="${pageNum}">
		<div class="cate_wrap" style="margin-top: 13px;">
			<select class="form-select" name="sido" id="code"
				style="width: 133px; height: 40px;">
				<option selected value='none'>시/도 선택</option>
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
			</select> <input type="hidden" id="cate" name="cate" value="${cate}">
			
			<button class="btn btn-secondary" type="submit">검색</button>
		</div>
	</form>
</div>
  <div style="clear: both;"></div>
<br>
	<!-- 게시판 -->
	<table class="table" style="text-align: center; width: 67%; margin: auto;">
		<tr>
			<th>No</th>
			<th>카테고리</th>
			<th>지역</th>
			<th>장소</th>
			<th>제목</th>
			<th>작성자</th>
			<th>
				<i class="material-icons" style = " font-size: 1.5em;">
					visibility
				</i>
			</th>
			<th>
				<i class="material-icons" style = " font-size: 1.5em;">
					thumb_up
				</i>
			</th>
			<th>
				<i class="material-icons" style = " font-size: 1.5em;">
					thumb_down
				</i>
			</th>
			<th>
				<i class="material-icons" style = " font-size: 1.5em;">
					favorite
				</i>
			</th>
		</tr>
		<c:forEach var="l" items="${pageInfo.list}" varStatus="status">

			<tr>
				<td>${l.sh_num}</td>
				<td>${l.sh_facCate}</td>
				<td>${l.sh_facSido}｜${l.sh_facGugun} </td>
				<td><a href="/petmong/shfc/shfcdetail?uid=${user.user.uid}&num=${l.sh_num}">${l.sh_facNM }</a></td>
				<td><a href="/petmong/shfc/shfcdetail?uid=${user.user.uid}&num=${l.sh_num}">${l.sh_title}</a></td>
				<td>${l.sh_nickname}</td>
				<td>${l.sh_viewCnt}</td>
				<td>${l.sumlike }</td>	
				<td>${l.sumdislike }</td>	
				<td>
					<c:choose>
			        	<c:when test="${spnumList[status.index] eq l.sh_num}">	
							<i id = "dibs" class="material-icons" style = "color : red; font-size: 1.5em;">
								favorite
							</i>
			        	</c:when>
			        	<c:otherwise>	
							<i id = "dibs" class="material-icons" style = "color : pink; font-size: 1.5em;">
								favorite
							</i>
			        	</c:otherwise>
		        	</c:choose>
        		</td>
			</tr>
		</c:forEach>
	</table>

<P>

	<!-- 버튼 -->
	<sec:authorize access="isAuthenticated()">
		<div class="btn-holder"
			style="display: flex; justify-content: right; margin-right: 16.2%;">
			<c:if test="${user.user.uid != null }">

				<input type="button" class="btn btn-primary"
					onclick="location.href='/petmong/shfc/shfcboard'" value="글 작성"
					style="float: right;" />
			</c:if>
		</div>
	</sec:authorize>


	<!-- 페이지네이션 -->
<p>
<div>
	<ul class="pagination">
		<li class="page-item"><c:if test="${pageInfo.pages>5}">
				<a class="page-link"
					href="/petmong/shfc/shfclist?cate=${cate}&pageNum=${pageInfo.navigateFirstPage-1}">&laquo;</a>
			</c:if></li>

		<c:forEach begin="${pageInfo.navigateFirstPage}"
			end="${pageInfo.navigateLastPage}" var="num">
			<c:choose>
				<c:when test="${pageInfo.pageNum==num}">
					<li class="page-item active"><a class="page-link"
						href="/petmong/shfc/shfclist?cate=${cate}&pageNum=${num}">${num}</a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link"
						href="/petmong/shfc/shfclist?&cate=${cate}&pageNum=${num}">${num}</a></li>
				</c:otherwise>

			</c:choose>
		</c:forEach>
		<li class="page-item"><c:if test="${pageInfo.pages>5}">
				<a class="page-link"
					href="/petmong/shfc/shfclist?cate=${cate}&pageNum=${pageInfo.navigateLastPage+1}">&raquo;</a>
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
</script>
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