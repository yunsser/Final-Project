<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="layout/headerSearch.jsp"%>
<sec:authentication property="principal" var="user" />
<!-- 다중슬라이드 -->
<script
	src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />
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
.carousel-inner {
	height: 400px;
}

.carousel-item.active {
	height: 100%;
}

.carousel-item {
	height: 100%;
}

/* 리셋 CSS */
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

[name="slide"] {
	display: none;
}

#slide01:checked ~ .slidelist .slideitem {
	transform: translateX(0);
	animation: slide01 15s infinite;
}

#slide02:checked ~ .slidelist .slideitem {
	transform: translateX(-100%);
	animation: slide02 15s infinite;
}

@
keyframes slide01 { 0% {
	left: 0%;
}

49
%
{
left
:
0%;
}
50
%
{
left
:
-100%
}
99
%
{
left
:
-100%;
}
100
%
{
left
:
0;
}
}
@
keyframes slide02 { 0% {
	left: 0%;
}
49
%
{
left
:
0%;
}
50
%
{
left
:
100;
}
99
%
{
left
:
100;
}
100
%
{
left
:
0%;
}
}
</style>
<div class="container">
	<div class="nav-scroller py-1 mb-2">
		<nav class="nav d-flex justify-content-between">
			<a class="p-2 link-secondary" href="#">병원게시판</a> <a
				class="p-2 link-secondary" href="#">공유게시판</a> <a
				class="p-2 link-secondary" href="#">유기동물게시판</a>
			<!--       <a class="p-2 link-secondary" href="#">Design</a>
      <a class="p-2 link-secondary" href="#">Culture</a>
      <a class="p-2 link-secondary" href="#">Business</a>
      <a class="p-2 link-secondary" href="#">Politics</a>
      <a class="p-2 link-secondary" href="#">Opinion</a>
      <a class="p-2 link-secondary" href="#">Science</a>
      <a class="p-2 link-secondary" href="#">Health</a>
      <a class="p-2 link-secondary" href="#">Style</a>
      <a class="p-2 link-secondary" href="#">Travel</a> -->
		</nav>
	</div>
</div>
<main class="container">

	<!--   <div class="p-4 p-md-5 mb-4 text-white rounded bg-dark">
    <div class="col-md-6 px-0">
      <h1 class="display-4 fst-italic">Title of a longer featured blog post</h1>
      <p class="lead my-3">Multiple lines of text that form the lede, informing new readers quickly and efficiently about what’s most interesting in this post’s contents.</p>
      <p class="lead mb-0"><a href="#" class="text-white fw-bold">Continue reading...</a></p>
    </div>
  </div> -->

	<!-- 캐러셀 시작 -->
	<div class="slidebox">
		<input type="radio" name="slide" id="slide01" checked> <input
			type="radio" name="slide" id="slide02">
		<ul class="slidelist">
			<li class="slideitem"><a> <label for="slide02" class="prev"></label>
					<img src="/image/main/pet2.png" onclick="k_cat();"> <label
					for="slide02" class="next"></label>
			</a></li>
			<li class="slideitem"><a> <label for="slide01" class="prev"></label>
					<img src="/image/main/jojo2.png" onclick="zuzuzu();"> <label
					for="slide01" class="next"></label>
			</a></li>
		</ul>
	</div>
	<!-- 캐러셀 끝 -->

	<!-- 카드 시작 -->
	<div class="row mb-2">

		<%-- 		<div class="col-md-6">

			<div
				class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
				<div class="col p-4 d-flex flex-column position-static">

					<c:forEach var="list" items="${list}" begin="0" end="0"
						varStatus="status">
						<div>
							<a
								href="https://animal.seoul.go.kr/animalInfo/view?aniNo=${list.ANIMAL_NO}&curPage=1"><img
								alt="사진" src="https://${list.PHOTO_URL}"
								style="width: 200px; height: 150px;"> </a>
						</div>
					</c:forEach>

				</div>
			</div>
		</div> --%>

		<c:forEach var="list" items="${list}" begin="0" end="0"
			varStatus="status">
			<div class="col-md-6">
				<div
					class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
					<div class="col p-4 d-flex flex-column position-static">
						<strong class="d-inline-block mb-2 text-primary">Adoption</strong>
						<h3 class="mb-0">Waiting for adoption</h3>
						<div class="mb-1 text-muted"></div>
						<p class="card-text mb-auto"></p>
					</div>
					<div class="col-auto d-none d-lg-block">
						
					</div>
				</div>
			</div>
		</c:forEach>


		<div class="col-md-6">
			<div
				class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
				<div class="col p-4 d-flex flex-column position-static">
					<strong class="d-inline-block mb-2 text-success">Design</strong>
					<h3 class="mb-0">Post title</h3>
					<div class="mb-1 text-muted">Nov 11</div>
					<p class="mb-auto">This is a wider card with supporting text
						below as a natural lead-in to additional content.</p>
					<a href="#" class="stretched-link">Continue reading</a>
				</div>
				<div class="col-auto d-none d-lg-block">
					<svg class="bd-placeholder-img" width="200" height="250"
						xmlns="http://www.w3.org/2000/svg" role="img"
						aria-label="Placeholder: Thumbnail"
						preserveAspectRatio="xMidYMid slice" focusable="false">
						<title>Placeholder</title><rect width="100%" height="100%"
							fill="#55595c" />
						<text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>

				</div>
			</div>
		</div>
	</div>
	<!-- 카드 끝 -->
	<div class="slider">
		<c:forEach var="c" items="${list}" varStatus="status">
			<div>
				<a
					href="https://animal.seoul.go.kr/animalInfo/view?aniNo=${c.ANIMAL_NO}&curPage=1"><img
					src="https://animal.seoul.go.kr/comm/getImage?srvcId=MEDIA&upperNo=${c.ANIMAL_NO}&fileTy=ADOPTIMG&fileNo=${c.PHOTO_NO}&thumbTy=L"
					alt="" style="width: 200px"></a>
			</div>

		</c:forEach>
	</div>
	<fmt:formatNumber type="number" maxFractionDigits="0"
		value="${c.PHOTO_NO }" />
</main>

</body>
</html>