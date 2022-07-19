<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<!-- 부트스트랩 스케치 -->
<link href="/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>


<title>pet`mong</title>

<style type="text/css">
		.bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
       
      #sbtn {
      	width: 95px; 
      	margin-right: 0.5em;
      	}
      	
      .btn.btn-outline-secondary.form-control {
      	margin-left : 0.5em;
      }
      
      .form-control.me-2 {
      	width : 380px;
      }
      
      
</style>
</head>
<body>
<!-- 네비바 시작 -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="/">pet`mong</a>
	<!--검색창 시작 -->
	    <div>
	      <form id = "searchForm" class="d-flex" action = "/tripfu/pc" >
	      <div class="form-group">
		        <input class="form-control me-2" type="text" name = "search" placeholder="검색어를 입력하세요.">
		  </div>
		        <button class="btn btn-secondary form-control" type="submit">검색</button>
	      </form>
	    </div>
	 <!-- 검색창 끝 -->
	 
	  <!-- 마이페이지 로그아웃 로그인 회원가입 시작 -->
      <form class="d-flex">
	        <sec:authorize access="isAuthenticated()"> <!-- 권한에 관계없이 로그인 인증을 받은 경우 -->
			      	<button id = "sbtn" type="button" class="btn btn-outline-primary" onclick ="location.href='/loginForm'">Mypage</button>
			      	<button id = "sbtn" type="button" class="btn btn-outline-primary" onclick ="location.href='/logout'">Log Out</button>
	        </sec:authorize>
			<sec:authorize access="isAnonymous()">
			      	<button id = "sbtn" type="button" class="btn btn-outline-primary" onclick ="location.href='/loginForm'">Log In</button>
			      	<button id = "sbtn" type="button" class="btn btn-outline-primary" onclick ="location.href='/signupForm'">Sign Up</button>
	        </sec:authorize>
      </form>
      <!-- 마이페이지 로그아웃 로그인 회원가입 끝 -->
    </div>
</nav>
<!-- 네비바 끝 -->

</body>


</html>