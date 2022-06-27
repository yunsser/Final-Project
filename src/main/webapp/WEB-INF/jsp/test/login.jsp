<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
a {	text-decoration:none;}
</style>

<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>

</head>
<body>
<h3>로그인</h3>

<div><label>아이디 </label><input type="text" id="uid" name="uid"></div>
<div><label>비밀번호 </label><input type="password" id="upw" name="upw"></div>

<p></p>
<button type="submit">로그인</button>
<button type="reset">취소</button>
<button type="button"><a href="/test/join">회원 가입</a></button>
</body>
</html>