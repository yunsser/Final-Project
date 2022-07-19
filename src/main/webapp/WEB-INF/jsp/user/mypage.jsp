<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../layout/headerMypage.jsp" %>
<style>
	#info{
		margin-top : 15px;
	}
	.box {
		width: 150px;
   	 	height: 150px; 
   		border-radius: 45%;
   	 	overflow: hidden;
   		border : solid 1px; color: black;
   		margin : 0 auto;
	}
	   
	.img {
		width: 100%;
	    height: 100%;
	  }
	  .Cnt{
	  	padding-top: 50px;
	  	text-align: center;
	  }
	  .col-md-4.Cnt {
	  	font-size: 25px;
	  }
</style>
<!-- 본문 시작 -->
	<div id = "info" class = "container">
		<div id = "article">
			<div class="container">
				<div class="row">
					<div class="col-md-4">
						<div class="box">
							<img id = "img" class="img" onerror="this.src='/image/seokgu.jpg'" src="/resources/userProfile/${imgName}" />
						</div>
						<div style = "font-size: 25px; text-align: center;">
							${user.uid}
							${imgName}
							resources/userProfile/${imgName}
						</div>
					</div>
					<div class="col-md-4 Cnt">
						<div>
							13
						</div>
						게시글 수
					</div>
					<div class="col-md-4 Cnt">
						<div >
							5
						</div>
						찜한 게시글
					</div>
				</div>
			</div>
principal : <sec:authentication property="principal"/>
		</div>
		<!-- 푸터 시작 -->
	<%@ include file = "../layout/footer.jsp" %>
		<!-- 푸터 끝 -->
	</div>
<!-- 본문 끝 -->
</div>
</body>
</html>