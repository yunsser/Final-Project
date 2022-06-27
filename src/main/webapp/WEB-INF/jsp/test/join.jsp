<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>

<script type="text/javascript">

var idChecked = false;

function idcheck(uid){
	if($('#uid').val() == ''){
		alert('아이디를 입력하세요');
		return false;
	}

	var obj = {};
	obj.uid = uid;

	$.ajax({
		url:'/test/idcheck',
		method:'post',
		cache:false,
		data:obj,
		dataType:'json',
		success:function(res){
			alert(res.checked ? '사용 가능한 아이디입니다' : '중복된 아이디입니다');
			idChecked = res.checked;
		},
		error:function(xhr, status, err){
			alert('에러:'+err);
		}
	});
}

function memberJoin(){
	if($('#uid').val() == ''){
		alert('아이디를 입력하세요');
		return false;
	}else if($('#upw').val() == ''){
		alert('비밀번호를 입력하세요');
		return false;
	}else if($('#email').val() == ''){
		alert('이메일을 입력하세요');
		return false;
	}else if(!idChecked){
		alert('아이디 중복 확인 필요');
		return false;
	}else if(!confirm('입력하신 정보로 가입하시겠습니까?')){
		alert('정상적으로 취소 완료')
		return false;
	}

	var serData = $('#joinForm').serialize();

	$.ajax({
		url:'/test/join',
		method:'post',
		cache:false,
		data:serData,
		dataType:'json',
		success:function(res){
			alert(res.added ? '회원 가입 완료' : '회원 가입 실패');
			location.href='/test/login';
		},
		error:function(xhr, status, err){
			alert('에러:'+err);
		}
	});
	return false;
}

</script>

</head>
<body>
<h3>회원 가입</h3>

<form id="joinForm" onsubmit="return memberJoin();">
<div><label for="uid">아이디 </label><input type="text" id="uid" name="uid">
<button type="button" onclick="idcheck($('#uid').val());">중복 확인</button></div>

<div><label for="upw">비밀번호 </label><input type="password" id="upw" name="upw"></div>
<div><label for="email">이메일 </label><input type="text" id="email" name="email"></div>

<p></p>

<button type="submit">저장</button>
<button type="reset">취소</button>

</form>




</body>
</html>