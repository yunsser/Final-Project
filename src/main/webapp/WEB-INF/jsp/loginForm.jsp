<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file = "layout/headerBasic.jsp" %>
<style type="text/css">
    
      .form-signin {
      	margin : 150px auto; 
      	width : 500px; 
      	}
      	
      #signBtn {
      	margin-top: 0.5em;
      	}
      	
      .form-control{
      	margin-top: 0.5em;
      }
     
      .btn-social-login {
		  transition: all .2s;
		  outline: 0;
		  border: 1px solid transparent;
		  padding: .5rem !important;
		  border-radius: 50%;
		  color: #fff;
	  }
	  .btn-social-login:focus {
	 	  box-shadow: 0 0 0 .2rem rgba(0,123,255,.25);
		}
	.text-dark {
	 	color: #343a40!important; 
	 }
	 .socialbts {
		text-align: center;
		margin: 1em auto 2em; 
	 }
      .hr-sect {
        display: flex;
        flex-basis: 100%;
        align-items: center;
        color: rgba(0, 0, 0, 0.35);
        font-size: 13px;
        margin: 8px 0px;
      }
      .hr-sect::before,
      .hr-sect::after {
        content: "";
        flex-grow: 1;
        background: rgba(0, 0, 0, 0.35);
        height: 1px;
        font-size: 0px;
        line-height: 0px;
        margin: 0px 16px;
      }
</style>

    		<!-- 본문 들어가는 부분 -->	
			<main class="form-signin">
				<form id = "loginForm" onsubmit ="return login();">
<!-- 				    <img class="mx-auto d-block" src="/image/kakao_login_button.png" alt=""> -->
					<div class="container-fluid" style = "text-align: center;">
						<a class="navbar-brand" href="/">pet`mong</a>
					</div>
				    <div class="form-floating">
				      <input type="text" class="form-control" id="uid" name ="uid" placeholder="아이디를 입력해주세요.">
				      <label for="floatingInput">아이디</label>
				      
				    </div>
				    <div class="form-floating">
				      <input type="password" class="form-control" id="upw" name = "upw" placeholder="비밀번호를 입력해주세요.">
				      <label for="floatingPassword">비밀번호</label>
				    </div>
				
	<!-- 			    시간 남으면 해봄 -->
	<!-- 			    <div class="checkbox mb-3"> -->
	<!-- 			      <label> -->
	<!-- 			        <input type="checkbox" value="remember-me"> Remember me -->
	<!-- 			      </label> -->
	<!-- 			    </div> -->
				    <button type = "submit" class="w-100 btn btn-lg btn-outline-secondary" style = "margin-top : 0.5em;">로그인</button>
				</form>
				    <button id = "signBtn" class="w-100 btn btn-lg btn-outline-success" type="button" onclick = "location.href = '/signupForm'">회원가입</button>
				    
				    <!-- 소설로그인 시작 -->
	  					<div class="hr-sect">
	  						<span style = "color :blue;">소셜 계정으로</span>간편하게 로그인 하세요.
	  					</div>
					    <div class = "socialbts">
							<button class='btn-social-login' style='background:#D93025' 
									onclick = "location.href = '/oauth2/authorization/google'" ><i class="xi-2x xi-google"></i></button>
							<button class='btn-social-login' style='background:#4267B2' 
									onclick = "location.href = '/oauth2/authorization/facebook'"><i class="xi-2x xi-facebook"></i></button>
							<button class='btn-social-login' style='background:#1FC700' 
									onclick = "location.href = '/oauth2/authorization/naver'"><i class="xi-2x xi-naver"></i></button>
							<button class='btn-social-login' style='background:#FFEB00' 
									onclick = "location.href = '/oauth2/authorization/kakao'"><i class="xi-2x xi-kakaotalk text-dark"></i></button>
					    </div>
				    <!-- 소설로그인 끝 -->
				    <p class="text-center"  style = "margin-top : 3em">&copy; 2022.06.27–ing</p>
			</main>
			<!-- 본문 들어가는 부분 끝 -->

<script type="text/javascript">
 //로그인 체크
function login(){
			var serData = $('#loginForm').serialize();
			$.ajax({
				url:'/login',
				method:'post',
				cache:false,
				data:serData,
				dataType:'json',
				// 시간남으면 해봄
// 				beforeSend : function(xhr) {
// 					//이거 안하면 403 error
// 					//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
// 					var $token = $("#token");
// 					xhr.setRequestHeader($token.data("token-name"), $token.val());
// 				},
				success : function(json, statusText, xhr, $form) {
					if (json.success == true) {
						alert('로그인성공!')
						var url = json.returnUrl || './';
						document.location.href = url;
					} else {
						alert(json.message);
					}
				},
				error : function(xhr) {
					alert(xhr.statusText);
				}
			});
			return false;
		}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>
