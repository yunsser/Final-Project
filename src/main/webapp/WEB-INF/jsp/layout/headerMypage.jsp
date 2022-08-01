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
<!-- 구글 아이콘 CDN -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<style>
	#sbtn {
      	width: 95px; 
      	margin-right: 0.5em;
	}
	#grid {
		display : grid;
		grid-template-columns : 280px 1fr;
	}
	#grid #article{
      padding-left:25px;
    }
    @media(max-width:800px){
    	#grid {
    		display : block;
		}
    }
	#info{
		margin-top : 15px;
	  }
	  a {text-decoration: none;}
</style>
</head> 
<body>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var = "user" />
</sec:authorize>
<div class="container"> 
<!-- 네비바 시작 -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="/petmong">pet`mong</a>    
      <form class="d-flex">
      	<sec:authorize access="isAuthenticated()"> <!-- 권한에 관계없이 로그인 인증을 받은 경우 -->
	      	<button id = "sbtn" type="button" class="btn btn-outline-info" onclick ="location.href='/petmong/user/mypage?uid=${user.user.uid}'">Mypage</button>
	      	<button id = "sbtn" type="button" class="btn btn-outline-secondary" onclick ="location.href='/petmong/logout'">Log Out</button>
      	</sec:authorize>
		<sec:authorize access="isAnonymous()">
	      	<button id = "sbtn" type="button" class="btn btn-outline-secondary" onclick ="location.href='/petmong/loginForm'">Log In</button>
	      	<button id = "sbtn" type="button" class="btn btn-outline-success" onclick ="location.href='/petmong/signupForm'">Sign Up</button>
		</sec:authorize>
      </form>
    </div>
</nav>
</div>
<!-- 네비바 끝 -->
<div id = "grid" class="container"> 
<!-- 사이드바 시작 -->
 <div class="flex-shrink-0 p-3 bg-white" style="width: 280px;">
    <a href="/" class="d-flex align-items-center pb-3 mb-3 link-dark text-decoration-none border-bottom">
      <span class="fs-5 fw-semibold">${user.user.name}님 반갑습니다.</span>
    </a>
    <ul class="list-unstyled ps-0">
      <li class="mb-1">
        <button class="btn btn-toggle align-items-center rounded collapsed" 
        data-bs-toggle="collapse" data-bs-target="#home-collapse"
        onclick="location.href='/petmong/user/userInfo?uid=${user.user.uid}'">
          개인정보수정
        </button>
      </li>
      
      <li class="mb-1">
        <button class="btn btn-toggle align-items-center rounded collapsed" 
        data-bs-toggle="collapse" data-bs-target="#dashboard-collapse" 
        onclick = "location.href='/petmong/user/myBoard?uid=${user.user.uid}'">
          작성한 게시글
        </button>
      </li>
      
      <li class="mb-1">
        <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" 
        data-bs-target="#orders-collapse" aria-expanded="false" onclick = "location.href='/petmong/user/dibsOnBoard?uid=${user.user.uid}'">
          찜한 게시글
        </button>
        
      </li>
      
    </ul>
  </div>
<!-- 사이드바 끝 -->