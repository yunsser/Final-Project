<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="layout/headerSearch.jsp"%>
<!-- 다중슬라이드 -->
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script
	src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="user" />
</sec:authorize>

<script>
	$(document).ready(function() {
		$('.slider').slick({
			autoplay : true,
			autoplaySpeed : 1000,
			slidesToShow : 5,
			slidesToScroll : 1,
			responsive : [ {
				breakpoint : 768,
				settings : {
					slidesToShow : 3,
					arrows : false,
				}
			}, {
				breakpoint : 600,
				settings : {
					slidesToShow : 1,
					arrows : false,
				}
			} ]
		});
	});
</script>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

ul, li {
	list-style: none;
}

ol, ul {
	padding-left: 0rem;
}

/* 슬라이드 Style */
.slidebox {
	max-width: 1000px;
	margin: 0 auto;
}

.slidebox .slidelist {
	white-space: nowrap;
	font-size: 0;
	overflow: hidden;
}

.slidebox .slidelist .slideitem {
	position: relative;
	display: inline-block;
	vertical-align: middle;
	width: 100%;
	transition: all 1s;
}

.slidebox .slidelist .slideitem>a {
	display: block;
	width: auto;
	position: relative;
}

.slidebox .slidelist .slideitem>a img {
	max-width: 100%;
}

.slidebox .slidelist .slideitem>a label {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	padding: 20px;
	border-radius: 50%;
	cursor: pointer;
}

.slidebox .slidelist .slideitem>a label.prev {
	left: 20px;
	background: url('/image/main/left-arrow.png') center center/50%
		no-repeat;
}

.slidebox .slidelist .slideitem>a label.next {
	right: 20px;
	background: url('/image/main/right-arrow.png') center center/50%
		no-repeat;
}

/* 슬라이드 Style */
.slidebox {
	max-width: 1000px;
	margin: 0 auto;
}

.slidebox .slidelist {
	white-space: nowrap;
	font-size: 0;
	overflow: hidden;
}

.slidebox .slidelist .slideitem {
	position: relative;
	display: inline-block;
	vertical-align: middle;
	width: 100%;
	transition: all 1s;
}

.slidebox .slidelist .slideitem>a {
	display: block;
	width: auto;
	position: relative;
}

.slidebox .slidelist .slideitem>a img {
	max-width: 100%;
}

.slidebox .slidelist .slideitem>a label {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	padding: 20px;
	border-radius: 50%;
	cursor: pointer;
}

.slidebox .slidelist .slideitem>a label.prev {
	left: 20px;
	background: url('/image/main/left-arrow.png') center center/50%
		no-repeat;
}

.slidebox .slidelist .slideitem>a label.next {
	right: 20px;
	background: url('/image/main/right-arrow.png') center center/50%
		no-repeat;
}

/* 슬라이드 Style */
.slidebox {max-width:1000px;margin:0 auto;}
.slidebox .slidelist {white-space:nowrap;font-size:0;overflow:hidden;}
.slidebox .slidelist .slideitem {position:relative;display:inline-block;vertical-align:middle;width:100%;transition:all 1s;}
.slidebox .slidelist .slideitem > a {display:block;width:auto;position:relative;}
.slidebox .slidelist .slideitem > a img {max-width:100%;}
.slidebox .slidelist .slideitem > a label {position:absolute;top:50%;transform:translateY(-50%);padding:20px;border-radius:50%;cursor:pointer;}
.slidebox .slidelist .slideitem > a label.prev {left:20px;background:url('/image/main/left-arrow.png') center center / 50% no-repeat;}
.slidebox .slidelist .slideitem > a label.next {right:20px;background:url('/image/main/right-arrow.png') center center / 50% no-repeat;}


[name="slide"] {display:none;}
#slide01:checked ~ .slidelist .slideitem {transform:translateX(0);animation:slide01 15s infinite;}
#slide02:checked ~ .slidelist .slideitem {transform:translateX(-100%);animation:slide02 15s infinite;}

@keyframes slide01 {
	0% {left:0%;}
	49% {left:0%;}
	50% {left:-100%}
	99% {left:-100%;}
	100% {left:0;}
}

@keyframes slide02 {
	0% {left:0%;}
	49% {left:0%;}
	50% {left:100;}
	99% {left:100;}
	100% {left:0%;}
}
      
.border {
    border: 1px solid #dee2e600!important
}

.shadow-sm{
	box-shadow: 0 .125rem .25rem rgba(0,0,0,0.0)!important;
}

.see-more{
	margin-left: 84%;
    margin-bottom: 3%;
    margin-top: -5px;
}

.namename{
	margin-bottom: -34px;
    margin-left: 11px;
    border-bottom: 2px solid #cfcfcf;
    width: 95.5%;
    padding-bottom: 8px;
}
</style>

<main class="container">

	<!-- 슬라이더 -->
	<div class="slidebox">
		<input type="radio" name="slide" id="slide01" checked> <input
			type="radio" name="slide" id="slide02">
		<ul class="slidelist">
			<li class="slideitem"><a href="https://k-pet.co.kr/" target="_brank"> <label for="slide02" class="prev"></label>
					<img src="/image/main/main1.jpg"> <label for="slide02"
					class="next"></label>
			</a></li>
			<li class="slideitem"><a href="https://k-pet.co.kr/22pet_sc/" target="_brank"> <label for="slide01" class="prev"></label>
					<img src="/image/main/main2.jpg"> <label for="slide01"
					class="next"></label>
			</a></li>
		</ul>
	</div>

	<!-- 카드 시작 -->
	<div class="row mb-2">
		<div class="col-md-6">
			<div
				class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
				<div class="col p-4 d-flex flex-column position-static">
					<div class="namename">후기게시판</div>
					<div class="see-more">
						<a href="/petmong/shfc/shfclist?uid=${user.user.uid }"><span
							class="badge rounded-pill bg-primary"> 더보기</span></a>
					</div>
					<!-- 게시판 -->
					<table class="table"
						style="text-align: center; width: 95%; margin: auto; border-color: gainsboro;">
						<c:forEach var="u" items="${pageInfo2.list}">
							<tr>
								<td>${u.sh_facSido},${u.sh_facGugun}</td>
								<td><a
									href="/petmong/shfc/shfcdetail?uid=${user.user.uid}&num=${u.sh_num}">${u.sh_title}</a></td>
								<td>${u.sh_nickname}</td>
								<td>${u.sh_viewCnt}</td>
							</tr>
						</c:forEach>
					</table>
					<!-- 게시판 -->
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div
				class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
				<div class="col p-4 d-flex flex-column position-static">
					<div class="namename">공유게시판</div>
					<div class="see-more">
						<a href="/petmong/post/list?uid=${user.user.uid }"><span
							class="badge rounded-pill bg-primary"> 더보기</span></a>
					</div>

					<!-- 게시판 -->
					<table class="table"
						style="text-align: center; width: 95%; margin: auto; border-color: gainsboro;">
						<c:forEach var="u" items="${pageInfo.list}">
							<tr>
								<td>${u.sido},${u.gugun}</td>
								<td><a
									href="/petmong/post/detail?uid=${user.user.uid}&num=${u.num}">${u.title}</a></td>
								<td>${u.name}</td>
								<td>${u.viewCnt}</td>
							</tr>
						</c:forEach>
					</table>
					<!-- 게시판 -->
				</div>
			</div>
		</div>
	</div>

	<div class="slider" style="margin-top: -25px;">
		<c:forEach var="c" items="${list}" varStatus="status">
			<div>
				<a
					href="https://animal.seoul.go.kr/animalInfo/view?aniNo=${c.ANIMAL_NO}&curPage=1"
					target='_blank'> <img
					src="https://animal.seoul.go.kr/comm/getImage?srvcId=MEDIA&upperNo=${c.ANIMAL_NO}&fileTy=ADOPTIMG&fileNo=${c.PHOTO_NO}&thumbTy=L"
					alt="" style="width: 200px;"></a>
			</div>
		</c:forEach>
	</div>


	<!-- 푸터 시작 -->
	<%@ include file="layout/footer.jsp"%>
	<!-- 푸터 끝 -->
</main>

</body>
</html>