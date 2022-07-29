<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/jsp/layout/headerSearch.jsp"%>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="user" />
</sec:authorize>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동물병원 상세 정보</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- 부트스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<!-- 부트스트랩 스케치 -->
<link href="/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<!-- 소셜로그인 아이콘 -->
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
</head>
<style>
.cntBts {
	text-align: center;
}

.cntBts button {
	border: none;
	background: none;
	float: right;
}

.container {
	margin-top: 15px;
}

.review {
	margin-top: 10px;
}

.rv_button {
	margin-top: 10px;
	margin-left: 10px;
}

#reviewlist {
	margin-top: 15px;
}

a {
	text-decoration: none;
}

.pagination {
	display: flex;
	justify-content: center;
	margin-top: 15px;
}

#map {
	margin-top: 5px;
}
</style>
<body>
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="user" />
	</sec:authorize>

	<c:choose>
		<c:when test="${seouldetail != null }">

<div class="container">

				<div class="cntBts">
					<c:choose>
						<c:when test="${hp_mgtno eq seouldetail.MGTNO}">
							<button type="button" onclick="dibsOn()">
								<div>&nbsp;</div>
								<i id="dibs" class="material-icons"
									style="color: red; font-size: 3em;"> favorite </i>
							</button>
						</c:when>
						<c:otherwise>
							<button type="button" onclick="dibsOn()">
								<div>&nbsp;</div>
								<i id="dibs" class="material-icons"
									style="color: pink; font-size: 3em;"> favorite </i>
							</button>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="card border-primary mb-3" style="max-width: 20rem;">
					<div class="card-header">${seouldetail.BPLCNM}</div>
				</div>


				<c:if test="${seouldetail.SITETEL != '' }">
					<dt>
						<span class="badge bg-primary">전화</span> ${seouldetail.SITETEL}
					</dt>
				</c:if>
				<c:if test="${seouldetail.SITETEL == '' }">
					<dt>
						<span class="badge bg-primary">전화</span> <span class="text-muted">정보없음</span>
					</dt>
				</c:if>
				<c:if test="${seouldetail.RDNWHLADDR != '' }">
					<dt>
						<span class="badge bg-primary">주소</span> ${seouldetail.RDNWHLADDR}
					</dt>
				</c:if>
				<c:if test="${seouldetail.RDNWHLADDR == '' }">
					<dt>
						<span class="badge bg-primary">주소</span> <span class="text-muted">정보없음</span>
					</dt>
				</c:if>
				<c:if test="${seouldetail.SITEWHLADDR != '' }">
					<dt>
						<span class="badge bg-primary">지번 주소</span>
						${seouldetail.SITEWHLADDR}
					</dt>
				</c:if>
				<c:if test="${seouldetail.SITEWHLADDR == '' }">
					<dt>
						<span class="badge bg-primary">지번 주소</span> <span
							class="text-muted">정보없음</span>
					</dt>
				</c:if>
				</dl>



				<div id="map" style="width: 100%; height: 350px;"></div>
			</div>

			<script type="text/javascript"
				src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fefe54713afff65d5e6b73e9a2b6fd73&libraries=services"></script>
			<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    }; 
    
// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch('${seouldetail.SITEWHLADDR}', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">${seouldetail.BPLCNM}</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    }  else{
              
              var ps = new kakao.maps.services.Places(); 
              
              // 키워드로 장소를 검색합니다
              ps.keywordSearch('${seouldetail.BPLCNM}', placesSearchCB); 

              // 키워드 검색 완료 시 호출되는 콜백함수 입니다
              function placesSearchCB (data, status, pagination) {
                  if (status === kakao.maps.services.Status.OK) {

                      // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
                      // LatLngBounds 객체에 좌표를 추가합니다
                      var bounds = new kakao.maps.LatLngBounds();

                      for (var i=0; i<data.length; i++) {
                          displayMarker(data[i]);    
                          bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
                      }       

                      // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
                      map.setBounds(bounds);
                  } 
              }


       // 지도에 마커를 표시하는 함수입니다
       function displayMarker(place) {
           
           // 마커를 생성하고 지도에 표시합니다
           var marker = new kakao.maps.Marker({
               map: map,
               position: new kakao.maps.LatLng(place.y, place.x) 
           });

           // 마커에 클릭이벤트를 등록합니다
            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="width:150px;text-align:center;padding:6px 0;">${seouldetail.BPLCNM}</div>'
            });
            infowindow.open(map, marker);
       }
    }
});    
</script>



		</c:when>

		<c:when test="${csvdetail !=null }">
			<div class="container">
				<dl>

					<div class="cntBts">
						<c:choose>
							<c:when test="${hp_mgtno eq csvdetail.MGTNO}">
								<button type="button" onclick="dibsOn()">
									<div>&nbsp;</div>
									<i id="dibs" class="material-icons"
										style="color: red; font-size: 3em;"> favorite </i>
								</button>
							</c:when>
							<c:otherwise>
								<button type="button" onclick="dibsOn()">
									<div>&nbsp;</div>
									<i id="dibs" class="material-icons"
										style="color: pink; font-size: 3em;"> favorite </i>
								</button>
							</c:otherwise>
						</c:choose>
					</div>

					<div class="card border-primary mb-3" style="max-width: 20rem;">
						<div class="card-header">${csvdetail.BPLCNM}</div>
					</div>

					<c:if test="${csvdetail.SITETEL != '' }">
						<dt>
							<span class="badge bg-primary">전화번호</span> ${csvdetail.SITETEL}
						</dt>
					</c:if>
					<c:if test="${csvdetail.SITETEL == '' }">
						<dt>
							<span class="badge bg-primary">전화번호</span> <span
								class="text-muted">정보없음</span>
						</dt>
					</c:if>
					<c:if test="${csvdetail.RDNWHLADDR != '' }">
						<dt>
							<span class="badge bg-primary">주소</span> ${csvdetail.RDNWHLADDR}
						</dt>
					</c:if>
					<c:if test="${csvdetail.RDNWHLADDR == '' }">
						<dt>
							<span class="badge bg-primary">주소</span> <span class="text-muted">정보없음</span>
						</dt>
					</c:if>
					<c:if test="${csvdetail.SITEWHLADDR != '' }">
						<dt>
							<span class="badge bg-primary">지번 주소</span>
							${csvdetail.SITEWHLADDR}
						</dt>
					</c:if>
					<c:if test="${csvdetail.SITEWHLADDR == '' }">
						<dt>
							<span class="badge bg-primary">지번 주소</span> <span
								class="text-muted">정보없음</span>
						</dt>
					</c:if>
				</dl>

				<div id="map" style="width: 100%; height: 350px;"></div>
			</div>
			<script type="text/javascript"
				src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fefe54713afff65d5e6b73e9a2b6fd73&libraries=services"></script>
			<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    }; 
    
// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch('${csvdetail.SITEWHLADDR}', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">${csvdetail.BPLCNM}</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } else{
              
             var ps = new kakao.maps.services.Places(); 
             
             // 키워드로 장소를 검색합니다
             ps.keywordSearch('${csvdetail.BPLCNM}', placesSearchCB); 

             // 키워드 검색 완료 시 호출되는 콜백함수 입니다
             function placesSearchCB (data, status, pagination) {
                 if (status === kakao.maps.services.Status.OK) {

                     // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
                     // LatLngBounds 객체에 좌표를 추가합니다
                     var bounds = new kakao.maps.LatLngBounds();

                     for (var i=0; i<data.length; i++) {
                         displayMarker(data[i]);    
                         bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
                     }       

                     // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
                     map.setBounds(bounds);
                 }
           }
       }

       // 지도에 마커를 표시하는 함수입니다
       function displayMarker(place) {
           
           // 마커를 생성하고 지도에 표시합니다
           var marker = new kakao.maps.Marker({
               map: map,
               position: new kakao.maps.LatLng(place.y, place.x) 
           });

           // 마커에 클릭이벤트를 등록합니다
            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="width:150px;text-align:center;padding:6px 0;">${csvdetail.BPLCNM}</div>'
            });
            infowindow.open(map, marker);
       }
    
});    
</script>

		</c:when>
		<c:otherwise>

		</c:otherwise>

	</c:choose>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
		crossorigin="anonymous"></script>
	<script>
 	$(document).ready(function(){
		
		document.body.scrollIntoView(false)
	});



   function addReview(){
      var title = $('#rv_title').val();
       var content = $('#rv_contents').val();
        
       if(title == ""){
          alert("제목을 입력하세요.");
          conForm.title.focus();
          return false;
       } 
       else if(content == "") {
           alert("내용을 입력하시오.");
           conForm.content.focus();
           return false;
        }
      
      var serData = $('#addReview').serialize();
      
      $.ajax({
         url:'/petmong/hp/detail',
         method:'post',
         cache:false,
         data:serData,
         dataType:'json',
         success:function(res){
            alert(res.addReview ? "리뷰 등록 성공" : "리뷰 등록 실패");
            location.href='/petmong/hp/detailrv?mgtno=${mgtno}';
         },
         error:function(xhr, status, err){
            //alert("에러:" + err);
            alert("code:"+xhr.status+"\n"+"message:"+xhr.responseText+"\n"+"error:"+err);
         }
      });
   }
   
   function deleted(rv_num){
      if(!confirm('정말 삭제하시겠어요?')){
         return;
      }
      
      var obj = {};
      obj.rv_num = rv_num;
      
      $.ajax({
         url:'/petmong/hp/detail/delete',
         method:'post',
         cache:false,
         data:obj,
         dataType:'json',
         success:function(res){
            alert(res.deleteReview ? "삭제 성공" : "삭제 실패");
            location.reload();
         },
         error:function(xhr, status,err){
            alert("code:"+xhr.status+"\n"+"message:"+xhr.responseText+"\n"+"error:"+err);
         }
      });   
   }
   
   function updateForm(rv_num,rv_title,rv_contents) {
      
      var updateReview = "";
      updateReview += "<div>";
      updateReview += "<label for='rv_title'>제목</label> &nbsp;";
      updateReview += "<textarea rows='1' class='form-control' id='rv_title" + rv_num + "' name='rv_title'>"+rv_title+"</textarea>";
      updateReview += "<label for='rv_contents'>내용</label> &nbsp;";
      updateReview += "<textarea rows='1' class='form-control' id='rv_contents" + rv_num + "' name='rv_contents'>"+rv_contents+"</textarea>";
      updateReview += "</div>";
      updateReview += "<input type='button' class='btn btn-dark' value='수정하기' onclick='updateReview("+rv_num+", )'/>";
      updateReview += "<input type='button' class='btn btn-dark' value='취소' onclick='cancleUpdateReview("+rv_num+")'/>";
      

         $("#updateReviewBox"+rv_num).slideDown(500);
         $("#updateReviewBox"+rv_num).html(updateReview); 
   }
   
   function cancleUpdateReview(rv_num){
         $("#updateReviewBox"+rv_num).slideUp(500);
   }
   
   /* 댓글 수정 */
   function updateReview(rv_num){
     var rv_title = document.getElementById("rv_title"+rv_num).value;
      var rv_contents = document.getElementById("rv_contents"+rv_num).value;
      var query = {
               rv_title : rv_title,
               rv_contents  : rv_contents,
                rv_num : rv_num}
      $.ajax({
         url:'/petmong/hp/detail/update',
         method:'post',
         cache:false,
         data:query,
         dataType:'json',
         success:function(res){
            alert(res.updateReview ? '수정 성공':'수정 실패');
            location.reload();
         },
         error:function(xhr,status,err){
            alert("code:"+xhr.status+"\n"+"message:"+xhr.responseText+"\n"+"error:"+err);
         }
      });
   }

   /* 댓글 취소 버튼 */
     function closeReview(rv_num) {
        $("#openReply"+rv_num).slideDown(500);    
        $("#closeReply"+rv_num).hide();   
        $("#updateForm"+rv_num).slideUp(500);     
     }
  
   
    //var reviewContainer = document.getElementById('reviewlist'),
   
	//$("#reviewlist").show();
    
   	    
   
   function listreview(num){
	    	//window.scrollTo(0,document.body.scrollHeight);
	   
	    	
	    var url = "/petmong/hp/detailrv?mgtno=${mgtno}&pageNum=" +num
			   location.href=url; 
	    

   }
   

   
</script>
	<div>
		<input type="hidden" id="pageNum" value="${pageNum}">
	</div>
	<div class="container">
		<div class="review">
			<form id="addReview">
				<div class="form-group">
					<h2>Review</h2>
					<input type="hidden" name="rv_mgtno" value="${mgtno}">

					<sec:authorize access="isAuthenticated()">
						<input type="hidden" name="rv_id" value="${user.user.uid}">
						<input type="hidden" name="rv_name" value="${user.user.name}">
						<c:if test="${user.user.uid != null}">
							<label for="rv_title" class="form-label mt-4" style="width: 5%">제
								목</label>
							<input type="text" class="form-control" placeholder="제목을 적어주세요."
								name="rv_title" id="rv_title"
								style="width: 50%; display: inline-block;">
							<!-- <label for="rv_contents" class="form-label mt-4">내용</label> -->
							<textarea class="form-control" name="rv_contents"
								id="rv_contents" rows="3" placeholder="내용을 적어주세요."></textarea>
							<div class="rv_button">
								<input type="button" class="btn btn-primary"
									onclick="addReview()" value="리뷰 작성" style="float: right;" />
							</div>
						</c:if>
					</sec:authorize>

					<sec:authorize access="isAnonymous()">
						<a href="/petmong/loginForm"> <textarea rows="2"
								name="rv_contents" id="rv_contents" class="form-control"
								disabled style="text-align: center; justify-content: center;">
                  로그인이 필요한 서비스입니다</textarea></a>
					</sec:authorize>
				</div>

			</form>
		</div>
		<div></div>

		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
			crossorigin="anonymous"></script>

		<br> <br>
		<div id="reviewlist">

			<c:if test="${pageInfo.total != 0}">
				<c:choose>
					<c:when test="${pageInfo.startRow == pageInfo.endRow }">
						<div class="accordion" id="accordionExample">
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingOne">
									<button class="accordion-button" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseOne"
										aria-expanded="true" aria-controls="collapseOne">
										<c:forEach begin="0" end="0" var="page"
											items="${pageInfo.list}">
											<strong>${page.rv_title}</strong>&nbsp&nbsp
           <code>${page.rv_name}</code>
										</c:forEach>
									</button>
								</h2>
								<div id="collapseOne" class="accordion-collapse collapse show"
									aria-labelledby="headingOne" data-bs-parent="#accordionExample"
									style="">
									<div class="accordion-body">
										<c:forEach begin="0" end="0" var="page"
											items="${pageInfo.list}">
											<c:set var="date" value="${page.rv_date}" />
											<p class="text-secondary">${page.rv_contents}</p>
											<div id="updateReviewBox${page.rv_num}"></div>
											<span class="rv_info"> <code>${fn:substring(date,0,10)}</code>&nbsp&nbsp
												<sec:authorize access="isAuthenticated()">
													<c:if test="${user.user.uid == page.rv_id}">
														<a
															href="javascript:updateForm(${page.rv_num},'${page.rv_title}', '${page.rv_contents}')">수정</a>
														<span>｜</span>
														<a href="javascript:deleted('${page.rv_num}')">삭제</a>
													</c:if>
												</sec:authorize>
											</span>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
					</c:when>
					<c:when test="${pageInfo.endRow - pageInfo.startRow == 1}">
						<div class="accordion" id="accordionExample">
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingOne">
									<button class="accordion-button" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseOne"
										aria-expanded="true" aria-controls="collapseOne">
										<c:forEach begin="0" end="0" var="page"
											items="${pageInfo.list}">
											<strong>${page.rv_title}</strong>&nbsp&nbsp
           <code>${page.rv_name }</code>
										</c:forEach>
									</button>
								</h2>
								<div id="collapseOne" class="accordion-collapse collapse show"
									aria-labelledby="headingOne" data-bs-parent="#accordionExample"
									style="">
									<div class="accordion-body">
										<c:forEach begin="0" end="0" var="page"
											items="${pageInfo.list}">
											<c:set var="date" value="${page.rv_date}" />
											<p class="text-secondary">${page.rv_contents}</p>
											<div id="updateReviewBox${page.rv_num}"></div>
											<span class="rv_info"> <code>${fn:substring(date,0,10)}</code>&nbsp&nbsp
												<sec:authorize access="isAuthenticated()">
													<c:if test="${user.user.uid == page.rv_id}">
														<a
															href="javascript:updateForm(${page.rv_num},'${page.rv_title}', '${page.rv_contents}')">수정</a>
														<span>｜</span>
														<a href="javascript:deleted('${page.rv_num}')">삭제</a>
													</c:if>
												</sec:authorize>
											</span>
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingTwo">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseTwo"
										aria-expanded="false" aria-controls="collapseTwo">
										<c:forEach begin="1" end="1" var="page"
											items="${pageInfo.list}">
											<strong>${page.rv_title}</strong>&nbsp&nbsp
           <code>${page.rv_name }</code>
										</c:forEach>
									</button>
								</h2>
								<div id="collapseTwo" class="accordion-collapse collapse"
									aria-labelledby="headingTwo" data-bs-parent="#accordionExample"
									style="">
									<div class="accordion-body">
										<c:forEach begin="1" end="1" var="page"
											items="${pageInfo.list}">
											<c:set var="date" value="${page.rv_date}" />
											<p class="text-secondary">${page.rv_contents}</p>
											<div id="updateReviewBox${page.rv_num}"></div>
											<span class="rv_info"> <code>${fn:substring(date,0,10)}</code>&nbsp&nbsp

												<sec:authorize access="isAuthenticated()">
													<c:if test="${user.user.uid == page.rv_id}">
														<a
															href="javascript:updateForm(${page.rv_num},'${page.rv_title}', '${page.rv_contents}')">수정</a>
														<span>｜</span>
														<a href="javascript:deleted('${page.rv_num}')">삭제</a>
													</c:if>
												</sec:authorize>
											</span>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
					</c:when>
					<c:when test="${pageInfo.endRow - pageInfo.startRow == 2}">
						<div class="accordion" id="accordionExample">
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingOne">
									<button class="accordion-button" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseOne"
										aria-expanded="true" aria-controls="collapseOne">
										<c:forEach begin="0" end="0" var="page"
											items="${pageInfo.list}">
											<strong>${page.rv_title}</strong>&nbsp&nbsp
           <code>${page.rv_name }</code>
										</c:forEach>
									</button>
								</h2>
								<div id="collapseOne" class="accordion-collapse collapse show"
									aria-labelledby="headingOne" data-bs-parent="#accordionExample"
									style="">
									<div class="accordion-body">
										<c:forEach begin="0" end="0" var="page"
											items="${pageInfo.list}">
											<c:set var="date" value="${page.rv_date}" />
											<p class="text-secondary">${page.rv_contents}</p>
											<div id="updateReviewBox${page.rv_num}"></div>
											<span class="rv_info"> <code>${fn:substring(date,0,10)}</code>&nbsp&nbsp
												<sec:authorize access="isAuthenticated()">
													<c:if test="${user.user.uid == page.rv_id}">
														<a
															href="javascript:updateForm(${page.rv_num},'${page.rv_title}', '${page.rv_contents}')">수정</a>
														<span>｜</span>
														<a href="javascript:deleted('${page.rv_num}')">삭제</a>
													</c:if>
												</sec:authorize>
											</span>
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingTwo">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseTwo"
										aria-expanded="false" aria-controls="collapseTwo">
										<c:forEach begin="1" end="1" var="page"
											items="${pageInfo.list}">
											<strong>${page.rv_title}</strong>&nbsp&nbsp
           <code>${page.rv_name }</code>
										</c:forEach>
									</button>
								</h2>
								<div id="collapseTwo" class="accordion-collapse collapse"
									aria-labelledby="headingTwo" data-bs-parent="#accordionExample"
									style="">
									<div class="accordion-body">
										<c:forEach begin="1" end="1" var="page"
											items="${pageInfo.list}">
											<c:set var="date" value="${page.rv_date}" />
											<p class="text-secondary">${page.rv_contents}</p>
											<div id="updateReviewBox${page.rv_num}"></div>
											<span class="rv_info"> <code>${fn:substring(date,0,10)}</code>&nbsp&nbsp
												<sec:authorize access="isAuthenticated()">
													<c:if test="${user.user.uid == page.rv_id}">
														<a
															href="javascript:updateForm(${page.rv_num},'${page.rv_title}', '${page.rv_contents}')">수정</a>
														<span>｜</span>
														<a href="javascript:deleted('${page.rv_num}')">삭제</a>
													</c:if>
												</sec:authorize>
											</span>
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingThree">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseThree"
										aria-expanded="false" aria-controls="collapseThree">
										<c:forEach begin="2" end="2" var="page"
											items="${pageInfo.list}">
											<strong>${page.rv_title}</strong>&nbsp&nbsp
           <code>${page.rv_name}</code>
										</c:forEach>
									</button>
								</h2>
								<div id="collapseThree" class="accordion-collapse collapse"
									aria-labelledby="headingThree"
									data-bs-parent="#accordionExample" style="">
									<div class="accordion-body">
										<c:forEach begin="2" end="2" var="page"
											items="${pageInfo.list}">
											<c:set var="date" value="${page.rv_date}" />
											<p class="text-secondary">${page.rv_contents}</p>
											<div id="updateReviewBox${page.rv_num}"></div>
											<span class="rv_info"> <code>${fn:substring(date,0,10)}</code>&nbsp&nbsp
												<sec:authorize access="isAuthenticated()">
													<c:if test="${user.user.uid == page.rv_id}">
														<a
															href="javascript:updateForm(${page.rv_num},'${page.rv_title}', '${page.rv_contents}')">수정</a>
														<span>｜</span>
														<a href="javascript:deleted('${page.rv_num}')">삭제</a>
													</c:if>
												</sec:authorize>
											</span>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
					</c:when>
					<c:when test="${pageInfo.endRow - pageInfo.startRow == 3}">
						<div class="accordion" id="accordionExample">
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingOne">
									<button class="accordion-button" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseOne"
										aria-expanded="true" aria-controls="collapseOne">
										<c:forEach begin="0" end="0" var="page"
											items="${pageInfo.list}">
											<strong>${page.rv_title}</strong>&nbsp&nbsp
           <code>${page.rv_name }</code>
										</c:forEach>
									</button>
								</h2>
								<div id="collapseOne" class="accordion-collapse collapse show"
									aria-labelledby="headingOne" data-bs-parent="#accordionExample"
									style="">
									<div class="accordion-body">
										<c:forEach begin="0" end="0" var="page"
											items="${pageInfo.list}">
											<c:set var="date" value="${page.rv_date}" />
											<p class="text-secondary">${page.rv_contents}</p>
											<div id="updateReviewBox${page.rv_num}"></div>
											<span class="rv_info"> <code>${fn:substring(date,0,10)}</code>&nbsp&nbsp
												<sec:authorize access="isAuthenticated()">
													<c:if test="${user.user.uid == page.rv_id}">
														<a
															href="javascript:updateForm(${page.rv_num},'${page.rv_title}', '${page.rv_contents}')">수정</a>
														<span>｜</span>
														<a href="javascript:deleted('${page.rv_num}')">삭제</a>
													</c:if>
												</sec:authorize>
											</span>
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingTwo">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseTwo"
										aria-expanded="false" aria-controls="collapseTwo">
										<c:forEach begin="1" end="1" var="page"
											items="${pageInfo.list}">
											<strong>${page.rv_title}</strong>&nbsp&nbsp
           <code>${page.rv_name }</code>
										</c:forEach>
									</button>
								</h2>
								<div id="collapseTwo" class="accordion-collapse collapse"
									aria-labelledby="headingTwo" data-bs-parent="#accordionExample"
									style="">
									<div class="accordion-body">
										<c:forEach begin="1" end="1" var="page"
											items="${pageInfo.list}">
											<c:set var="date" value="${page.rv_date}" />
											<p class="text-secondary">${page.rv_contents}</p>
											<div id="updateReviewBox${page.rv_num}"></div>
											<span class="rv_info"> <code>${fn:substring(date,0,10)}</code>&nbsp&nbsp
												<sec:authorize access="isAuthenticated()">
													<c:if test="${user.user.uid == page.rv_id}">
														<a
															href="javascript:updateForm(${page.rv_num},'${page.rv_title}', '${page.rv_contents}')">수정</a>
														<span>｜</span>
														<a href="javascript:deleted('${page.rv_num}')">삭제</a>
													</c:if>
												</sec:authorize>
											</span>
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingThree">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseThree"
										aria-expanded="false" aria-controls="collapseThree">
										<c:forEach begin="2" end="2" var="page"
											items="${pageInfo.list}">
											<strong>${page.rv_title}</strong>&nbsp&nbsp
           <code>${page.rv_name}</code>
										</c:forEach>
									</button>
								</h2>
								<div id="collapseThree" class="accordion-collapse collapse"
									aria-labelledby="headingThree"
									data-bs-parent="#accordionExample" style="">
									<div class="accordion-body">
										<c:forEach begin="2" end="2" var="page"
											items="${pageInfo.list}">
											<c:set var="date" value="${page.rv_date}" />
											<p class="text-secondary">${page.rv_contents}</p>
											<div id="updateReviewBox${page.rv_num}"></div>
											<span class="rv_info"> <code>${fn:substring(date,0,10)}</code>&nbsp&nbsp
												<sec:authorize access="isAuthenticated()">
													<c:if test="${user.user.uid == page.rv_id}">
														<a
															href="javascript:updateForm(${page.rv_num},'${page.rv_title}', '${page.rv_contents}')">수정</a>
														<span>｜</span>
														<a href="javascript:deleted('${page.rv_num}')">삭제</a>
													</c:if>
												</sec:authorize>
											</span>
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingFour">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseFour"
										aria-expanded="false" aria-controls="collapseFour">
										<c:forEach begin="3" end="3" var="page"
											items="${pageInfo.list}">
											<strong>${page.rv_title}</strong>&nbsp&nbsp
           <code>${page.rv_name}</code>
										</c:forEach>
									</button>
								</h2>
								<div id="collapseFour" class="accordion-collapse collapse"
									aria-labelledby="headingFour"
									data-bs-parent="#accordionExample" style="">
									<div class="accordion-body">
										<c:forEach begin="3" end="3" var="page"
											items="${pageInfo.list}">
											<c:set var="date" value="${page.rv_date}" />
											<p class="text-secondary">${page.rv_contents}</p>
											<div id="updateReviewBox${page.rv_num}"></div>
											<span class="rv_info"> <code>${fn:substring(date,0,10)}</code>&nbsp&nbsp
												<sec:authorize access="isAuthenticated()">
													<c:if test="${user.user.uid == page.rv_id}">
														<a
															href="javascript:updateForm(${page.rv_num},'${page.rv_title}', '${page.rv_contents}')">수정</a>
														<span>｜</span>
														<a href="javascript:deleted('${page.rv_num}')">삭제</a>
													</c:if>
												</sec:authorize>
											</span>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="accordion" id="accordionExample">
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingOne">
									<button class="accordion-button" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseOne"
										aria-expanded="true" aria-controls="collapseOne">
										<c:forEach begin="0" end="0" var="page"
											items="${pageInfo.list}">
											<strong>${page.rv_title}</strong>&nbsp&nbsp
           <code>${page.rv_name}</code>
										</c:forEach>
									</button>
								</h2>
								<div id="collapseOne" class="accordion-collapse collapse show"
									aria-labelledby="headingOne" data-bs-parent="#accordionExample"
									style="">
									<div class="accordion-body">
										<c:forEach begin="0" end="0" var="page"
											items="${pageInfo.list}">
											<c:set var="date" value="${page.rv_date}" />
											<p class="text-secondary">${page.rv_contents}</p>
											<div id="updateReviewBox${page.rv_num}"></div>
											<span class="rv_info"> <code>${fn:substring(date,0,10)}</code>&nbsp&nbsp
												<sec:authorize access="isAuthenticated()">
													<c:if test="${user.user.uid == page.rv_id}">
														<a
															href="javascript:updateForm(${page.rv_num},'${page.rv_title}', '${page.rv_contents}')">수정</a>
														<span>｜</span>
														<a href="javascript:deleted('${page.rv_num}')">삭제</a>
													</c:if>
												</sec:authorize>
											</span>
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingTwo">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseTwo"
										aria-expanded="false" aria-controls="collapseTwo">
										<c:forEach begin="1" end="1" var="page"
											items="${pageInfo.list}">
											<strong>${page.rv_title}</strong>&nbsp&nbsp
           <code>${page.rv_name}</code>
										</c:forEach>
									</button>
								</h2>
								<div id="collapseTwo" class="accordion-collapse collapse"
									aria-labelledby="headingTwo" data-bs-parent="#accordionExample"
									style="">
									<div class="accordion-body">
										<c:forEach begin="1" end="1" var="page"
											items="${pageInfo.list}">
											<c:set var="date" value="${page.rv_date}" />
											<p class="text-secondary">${page.rv_contents}</p>
											<div id="updateReviewBox${page.rv_num}"></div>
											<span class="rv_info"> <code>${fn:substring(date,0,10)}</code>&nbsp&nbsp
												<sec:authorize access="isAuthenticated()">
													<c:if test="${user.user.uid == page.rv_id}">
														<a
															href="javascript:updateForm(${page.rv_num},'${page.rv_title}', '${page.rv_contents}')">수정</a>
														<span>｜</span>
														<a href="javascript:deleted('${page.rv_num}')">삭제</a>
													</c:if>
												</sec:authorize>
											</span>
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingThree">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseThree"
										aria-expanded="false" aria-controls="collapseThree">
										<c:forEach begin="2" end="2" var="page"
											items="${pageInfo.list}">
											<strong>${page.rv_title}</strong>&nbsp&nbsp
           <code>${page.rv_name}</code>
										</c:forEach>
									</button>
								</h2>
								<div id="collapseThree" class="accordion-collapse collapse"
									aria-labelledby="headingThree"
									data-bs-parent="#accordionExample" style="">
									<div class="accordion-body">
										<c:forEach begin="2" end="2" var="page"
											items="${pageInfo.list}">
											<c:set var="date" value="${page.rv_date}" />
											<p class="text-secondary">${page.rv_contents}</p>
											<div id="updateReviewBox${page.rv_num}"></div>
											<span class="rv_info"> <code>${fn:substring(date,0,10)}</code>&nbsp&nbsp
												<sec:authorize access="isAuthenticated()">
													<c:if test="${user.user.uid == page.rv_id}">
														<a
															href="javascript:updateForm(${page.rv_num},'${page.rv_title}', '${page.rv_contents}')">수정</a>
														<span>｜</span>
														<a href="javascript:deleted('${page.rv_num}')">삭제</a>
													</c:if>
												</sec:authorize>
											</span>
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingFour">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseFour"
										aria-expanded="false" aria-controls="collapseFour">
										<c:forEach begin="3" end="3" var="page"
											items="${pageInfo.list}">
											<strong>${page.rv_title}</strong>&nbsp&nbsp
           <code>${page.rv_name}</code>
										</c:forEach>
									</button>
								</h2>
								<div id="collapseFour" class="accordion-collapse collapse"
									aria-labelledby="headingFour"
									data-bs-parent="#accordionExample" style="">
									<div class="accordion-body">
										<c:forEach begin="3" end="3" var="page"
											items="${pageInfo.list}">
											<c:set var="date" value="${page.rv_date}" />
											<p class="text-secondary">${page.rv_contents}</p>
											<div id="updateReviewBox${page.rv_num}"></div>
											<span class="rv_info"> <code>${fn:substring(date,0,10)}</code>&nbsp&nbsp
												<sec:authorize access="isAuthenticated()">
													<c:if test="${user.user.uid == page.rv_id}">
														<a
															href="javascript:updateForm(${page.rv_num},'${page.rv_title}', '${page.rv_contents}')">수정</a>
														<span>｜</span>
														<a href="javascript:deleted('${page.rv_num}')">삭제</a>
													</c:if>
												</sec:authorize>
											</span>
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingFive">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#collapseFive"
										aria-expanded="false" aria-controls="collapseFive">
										<c:forEach begin="4" end="4" var="page"
											items="${pageInfo.list}">
											<strong>${page.rv_title}</strong>&nbsp&nbsp
           <code>${page.rv_name}</code>
										</c:forEach>
									</button>
								</h2>
								<div id="collapseFive" class="accordion-collapse collapse"
									aria-labelledby="headingFive"
									data-bs-parent="#accordionExample" style="">
									<div class="accordion-body">
										<c:forEach begin="4" end="4" var="page"
											items="${pageInfo.list}">
											<c:set var="date" value="${page.rv_date}" />
											<p class="text-secondary">${page.rv_contents}</p>
											<div id="updateReviewBox${page.rv_num}"></div>
											<span class="rv_info"> <code>${fn:substring(date,0,10)}</code>&nbsp&nbsp
												<sec:authorize access="isAuthenticated()">
													<c:if test="${user.user.uid == page.rv_id}">
														<a
															href="javascript:updateForm(${page.rv_num},'${page.rv_title}', '${page.rv_contents}')">수정</a>
														<span>｜</span>
														<a href="javascript:deleted('${page.rv_num}')">삭제</a>
													</c:if>
												</sec:authorize>
											</span>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
					</c:otherwise>
				</c:choose>

				<div>
					<ul class="pagination">
						<li class="page-item"><c:if
								test="${pageInfo.pages>5 && pageInfo.navigateFirstPage>=2 && pageInfo.hasPreviousPage}">
								<a class="page-link"
									href="javascript:listreview('${pageInfo.navigateFirstPage-1}'); review();">&laquo;</a>
							</c:if></li>

						<c:forEach begin="${pageInfo.navigateFirstPage}"
							end="${pageInfo.navigateLastPage}" var="num">
							<c:choose>
								<c:when test="${pageInfo.pageNum==num}">
									<li class="page-item active"><a class="page-link"
										href="javascript:listreview('${num}'); review();">${num}</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a class="page-link"
										href="javascript:listreview('${num}'); review();">${num}</a></li>
								</c:otherwise>

							</c:choose>
						</c:forEach>
						<li class="page-item"><c:if
								test="${pageInfo.pages>5 && pageInfo.pages>=pageInfo.nextPage+2 && pageInfo.hasNextPage}">
								<a class="page-link"
									href="javascript:listreview('${pageInfo.navigateLastPage+1}'); review();">&raquo;</a>
							</c:if></li>
					</ul>
				</div>
			</c:if>
		</div>
	</div>
	<script>
// 찜 게시글 여부 위한 변수 선언.
const dibs = document.querySelector("#dibs");
<!-- 게시물 찜 하기. -->
function dibsOn() {
	var uid = "${user.user.uid}";
	
	var detail = "${seouldetail}";
	if(detail != ''){
		
		var hp_mgtno = "${seouldetail.MGTNO}";
		var hp_name = "${seouldetail.BPLCNM}";
		var hp_tel = "${seouldetail.SITETEL}";
		var hp_roadadd = "${seouldetail.RDNWHLADDR}";
		var hp_add = "${seouldetail.SITEWHLADDR}";
		var hp_sido = "";
		var hp_gugun = "";
		var add = [];
		
	    if(hp_roadadd != ''){
	        var add = hp_roadadd.split(' ');
	        hp_sido = add[0];
	        hp_gugun = add[1];           
	      } else {
	         var add = hp_add.split(' ');
	         hp_sido = add[0];
	         hp_gugun = add[1];
	      }
		
	}else {
		var hp_mgtno = "${csvdetail.MGTNO}";
		var hp_name = "${csvdetail.BPLCNM}";
		var hp_tel = "${csvdetail.SITETEL}";
		var hp_roadadd = "${csvdetail.RDNWHLADDR}";
		var hp_add = "${csvdetail.SITEWHLADDR}";
		var hp_sido = "";
		var hp_gugun = "";
		var add = [];
		
	    if(hp_roadadd != ''){
	        var add = hp_roadadd.split(' ');
	        hp_sido = add[0];
	        hp_gugun = add[1];           
	      } else {
	         var add = hp_add.split(' ');
	         hp_sido = add[0];
	         hp_gugun = add[1];
	      }
	}
	

	
	
	if(uid == '') {
		alert('로그인이 필요한 페이지입니다.');
		location.href="/petmong/loginForm";
		return;
	}
	
	obj = {};
	obj.uid = uid;
	obj.hp_mgtno = hp_mgtno;		
	obj.hp_name = hp_name;
	obj.hp_tel = hp_tel;
	obj.hp_roadadd = hp_roadadd;
	obj.hp_add = hp_add;
	obj.hp_sido = hp_sido;
	obj.hp_gugun = hp_gugun;
	
	$.ajax({
		url : '/petmong/hp/dibsOn',
		method : 'post',
		cache : false,
		data : obj,
		dataType : 'json',
		success : function(res) {
			if(res.dibsOn) {
				alert('게시글을 찜 하셨습니다.');
				dibs.style.color = "red";

			} else {
				alert('취소하셨습니다.');
				dibs.style.color = "pink";

			}

		},
		error : function(xhr, status, err) {
			alert('에러 : ' + xhr + status + err);
		}
	});
}   
</script>
</body>
</html>