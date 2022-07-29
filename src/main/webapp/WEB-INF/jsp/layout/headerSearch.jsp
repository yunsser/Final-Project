<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<!-- 부트스트랩 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<!-- 부트스트랩 스케치 -->
<link href="/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<!-- 구글 아이콘 CDN -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">

<title>pet`mong</title>
<style type="text/css">
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}

#sbtn {
	width: 95px;
	margin-right: 0.5em;
}

.btn.btn-outline-secondary.form-control {
	margin-left: 0.5em;
}

.form-control.me-2 {
	width: 380px;
}
</style>
</head>
<body>
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="user" />
	</sec:authorize>
	<div class="container">
		<!-- 네비바 시작 -->
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<div class="container-fluid">
				<a class="navbar-brand" href="/petmong">pet`mong</a>
				<!--검색창 시작 -->
				<div>
					<form id="searchForm" class="d-flex" action="/petmong/mainsearch">
						<div class="form-group">
							<input type="hidden" name="uid" id="uid" value="${user.user.uid }"/>
							<input class="form-control me-2" type="text" name="keyword"
								placeholder="검색어를 입력하세요.">
						</div>
						<button class="btn btn-secondary form-control" type="submit">검색</button>
					</form>
				</div>
				<!-- 검색창 끝 -->

				<!-- 마이페이지 로그아웃 로그인 회원가입 시작 -->
				<form class="d-flex">
					<sec:authorize access="isAuthenticated()">
						<!-- 권한에 관계없이 로그인 인증을 받은 경우 -->
						<button id="sbtn" type="button" class="btn btn-outline-primary"
							onclick="location.href='/petmong/user/mypage?uid=${user.user.uid}'">Mypage</button>
						<button id="sbtn" type="button" class="btn btn-outline-primary"
							onclick="location.href='/petmong/logout'">Log Out</button>
					</sec:authorize>
					<sec:authorize access="isAnonymous()">
						<button id="sbtn" type="button" class="btn btn-outline-primary"
							onclick="location.href='/petmong/loginForm'">Log In</button>
						<button id="sbtn" type="button" class="btn btn-outline-primary"
							onclick="location.href='/petmong/signupForm'">Sign Up</button>
					</sec:authorize>
				</form>
				<!-- 마이페이지 로그아웃 로그인 회원가입 끝 -->
			</div>
		</nav>
		<!-- 네비바 끝 -->
	</div>

	<div class="container">
		<div class="nav-scroller py-1 mb-2">
			<nav class="nav d-flex justify-content-between">
				<a class="p-2 link-secondary" href="/petmong/hp/search">병원게시판</a>
				<a class="p-2 link-secondary"
					href="/petmong/shfc/shfclist?uid=${user.user.uid}">후기게시판</a> <a
					class="p-2 link-secondary"
					href="/petmong/post/list?uid=${user.user.uid}">공유게시판</a> <a
					class="p-2 link-secondary" href="https://animal.seoul.go.kr/index"
					target='_blank'>서울동물복지지원센터</a>
			</nav>
		</div>
	</div>
</body>
</html>