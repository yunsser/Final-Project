<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pet`mong</title>
<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<!-- 부트스트랩 스케치 -->
<link href="/css/bootstrap.min.css" rel="stylesheet" type="text/css"> 
<!-- 소셜로그인 아이콘 -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css"> 
<style>
      #sbtn {
      	width: 95px; 
      	margin-right: 0.5em;
      	}
      	a {text-decoration: none;}
</style>
</head> 
<body>
<div class="container"> 
<!-- 네비바 시작 -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="/petmong">pet`mong</a>    
      <form class="d-flex">
      	<sec:authorize access="isAuthenticated()"> <!-- 권한에 관계없이 로그인 인증을 받은 경우 -->
	      	<button id = "sbtn" type="button" class="btn btn-outline-primary" onclick ="location.href='/user/mypage?uid=${user.uid}'">Mypage</button>
	      	<button id = "sbtn" type="button" class="btn btn-outline-primary" onclick ="location.href='/petmong/logout'">Log Out</button>
      	</sec:authorize>
		<sec:authorize access="isAnonymous()">
	      	<button id = "sbtn" type="button" class="btn btn-outline-primary" onclick ="location.href='/petmong/loginForm'">Log In</button>
	      	<button id = "sbtn" type="button" class="btn btn-outline-primary" onclick ="location.href='/petmong/signupForm'">Sign Up</button>
		</sec:authorize>
      </form>
    </div>
</nav>
<!-- 네비바 끝 -->
</div>