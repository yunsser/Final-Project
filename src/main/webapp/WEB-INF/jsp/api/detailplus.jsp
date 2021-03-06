<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/jsp/layout/headerSearch.jsp"%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="user" />
</sec:authorize>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<!-- include summernote css/js-->

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
<!-- include summernote-ko-KR -->
<script src="/resources/js/summernote-ko-KR.js"></script>
<style>
.title {
	align-items: center;
	margin-bottom: 2rem;
	font-size: 26px;
	margin-top: 1.3rem;
	color: gray;
}

.content {
	padding: 30px 30px 0px 42px;
	font-size: 18px;
}

.imagelabel {
	font-size: 15px;
	color: gray;
	margin-top: 3rem;
	border-bottom: 1px solid #80808073;
	width: 100%;
	margin-bottom: 10px;
	clear: both;
	display: table;
}

.table-info { 
	--bs-table-bg: #383838;
	color: #fff;
	border-color: #ffffff00;
}

.table>:not(caption)>*>* {
	border-bottom: none;
}

.cntBts {
	text-align: center;
}

.cntBts button {
	border: none;
	background: none;
	margin-top: 10px;
}
</style>
<script>
function setThumbnail(event) {
	   for (var image of event.target.files) {
	      var reader = new FileReader();
	 
	      reader.onload = function(event) {
	         var img = document.createElement("img");
	         img.setAttribute("src", event.target.result);
	         img.setAttribute("style", "width:50%;height:width;");               
	         document.querySelector("span#form-control").appendChild(img);         
	 
	      };
	      
	      console.log(image);
	      reader.readAsDataURL(image);
	   }
	}


	function del_board(num) {

		if (!confirm('?????? ?????? ???????????????????')) {
			return;
		}

		var obj = {};
		obj.num = num;

		$.ajax({
			url: '/petmong/shfc/shfcedit/delete',
			method: 'post',
			cache: false,
			data: obj,
			dataType: 'json',
			success: function(res) {
				alert(res.deleted ? '?????? ??????' : '?????? ??????!');
				location.href = "/petmong/shfc/shfclist";
			},
			error: function(xhr, status, err) {
				alert('?????? : ' + err);
			}
		}); 
	}
</script>

<script>
  	/* ?????? ?????? */
  	function insertReply() {
  		
  		
  		var serData = $('#re').serialize();
  		var content = $('#content').val();
  		
  		if(content == "") {
  			alert("????????? ???????????????.");
  			conForm.content.focus();
  			return false;
  		}
  		
  		$.ajax({
  			url:"/petmong/shfc/insertReply",
  			method:'post',
  			cache:false,
  			data:serData,
  			dataType:'json',
  			success:function(res){
  				alert(res.inserted ? '????????? ???????????????.':'????????? ??? ??? ????????????.');
  				location.reload();
  			},
  			error:function(xhr,status,err){
  				alert('??????:'+err);
  			}
  		});
  	}

  	/* ?????? ????????? ?????? */
	function deleteReply1(idx) {
		if(!confirm("????????? ????????????????")) {
			return false;
		}
		
		var query = {idx : idx}
		$.ajax({
			url:"/petmong/shfc/deleteReply",
			method:'post',
			cache:false,
			data:query,
			dataType:'json',
			success:function(res){
				alert(res.deleted ? '?????? ??????':'?????? ??????');
				location.reload();
			},
			error:function(xhr,status,err){
				alert('??????:'+err);
			}
		});
	}
	
	/* ????????? ????????? ?????? */
	function deleteReply2(idx) {
		if(!confirm("????????? ????????????????")) {
			return false;
		}
		
		var query = {idx : idx}
		$.ajax({
			url:"/petmong/shfc/deleteReply2",
			method:'post',
			cache:false,
			data:query,
			dataType:'json',
			success:function(res){
				alert(res.deleted ? '?????? ??????':'?????? ??????');
				location.reload();
			},
			error:function(xhr,status,err){
				alert('??????:'+err);
			}
		});
	}
  	
  	/* ?????? ?????? ??? ??????*/
  	function updateReplyForm(idx,content,nickname) {
		var updateReply = "";
		updateReply += "<div>";
		updateReply += "<textarea rows='1' class='form-control' id='content"+idx+"' name='content'>"+content+"</textarea>";
		updateReply += "</div>";
		updateReply += "<input type='button' class='btn btn-dark' value='????????????' onclick='updateRep("+idx+", )'/>";
		updateReply += "<input type='button' class='btn btn-dark' value='??????' onclick='cancleUpdateRep("+idx+")'/>";
  		$("#updateReplyBox"+idx).slideDown(500);
  		$("#updateReplyBox"+idx).html(updateReply); 
  	}
  	
  	function cancleUpdateRep(idx){
  		$("#updateReplyBox"+idx).slideUp(500);
  	}
  	
  	/* ?????? ?????? */
  	function updateRep(idx){
  		var content = document.getElementById("content"+idx).value;
  		var query = {
  						content  : content,
  						idx : idx}
  		
  		$.ajax({
  			url:"/petmong/shfc/updateReply",
  			method:'post',
  			cache:false,
  			data:query,
  			dataType:'json',
  			success:function(res){
  				alert(res.updated ? '?????? ??????':'?????? ??????');
  				location.reload();
  			},
  			error:function(xhr,status,err){
  				alert('??????:'+err);
  			}
  		});
  	} 
  	
  	/* ????????? ????????? ?????? */
  	function insertNestedRepForm(idx,depth,screenOrder,nickname) {
  		var insReply = "";
  		insReply += "<table style='width:210%'>";
  		insReply += "<tr>";
  		insReply += "<td style='border:none;width:85%;text-align:right;padding:0px;' class='reply_cont'>";
  		insReply += "<div class='form-group'>";
  		insReply += "<label for='content' style='float:left;'>??????</label> &nbsp;";
  		insReply += "<input type='hidden' style='float:left;' name='nickname' value="+nickname+" readonly/>";
  		insReply += "<input type='hidden' style='float:left;' name='name' value="+name+" readonly/>";
  		insReply += "<textarea rows='2' class='form-control' id='content"+idx+"' name='content'></textarea>"; //@"+nickname+"\n
  		insReply += "</div>";
  		insReply += "</td>";
  		insReply += "</tr>";
  		insReply += "<tr>";
  		insReply += "<td style='border:none;width:15%;text-align:left;padding:0px;' class='reply_cont'>";
  		insReply += "<input type='button' class='btn btn-dark' value='?????? ??????' onclick='insertNestedRep("+idx+","+depth+","+screenOrder+")'/>";
  		insReply += "<input type='button' class='btn btn-dark' value='??????' id='closeReply"+idx+"' onclick='closeReply("+idx+")'/>";
  		insReply += "</td>";
  		insReply += "</tr>";
  		
  		insReply += "</table>";
  		insReply += "<hr style='margin:0px;'/>";
  		
  		$("#openReply"+idx).hide();    // '??????'?????? ?????????
  		$("#closeReply"+idx).show();   // '??????'?????? ?????????
  		$("#replyBox"+idx).slideDown(500);
  		$("#replyBox"+idx).html(insReply);
  	}
  	
  	/* ??????????????? */
  	function insertNestedRep(idx,depth,screenOrder) {
  		var parent = idx; 
  		var boardIdx = "${detail.sh_num}";
		var nickname = "";
		nickname += "<sec:authorize access='isAuthenticated()'>";
		nickname += "${user.user.uid}";
		nickname += "</sec:authorize>";
		var name = "${user.user.name}";
		
		
  		var content = document.getElementById("content"+idx).value;
  		
  		
  		if(content == "") {
  			alert("????????? ???????????????.");
  			return false;
  		}
  		else {
			var query = {
					parent   : parent,
					boardIdx : boardIdx,
					nickname : nickname,
					name : name,
					content  : content,
					depth    : depth,
					screenOrder : screenOrder
			}
  			
  			$.ajax({
  	  			url:"/petmong/shfc/insertNestedRep",
  	  			method:'post',
  	  			cache:false,
  	  			data:query,
  	  			dataType:'json',
  	  			success:function(res){
  	  				alert(res.inserted ? '?????? ??????':'?????? ??????');
  	  				location.reload();
  	  			},
  	  			error:function(xhr,status,err){
  	  				alert('??????:'+err);
  	  			}
  	  		});
  		}
  	}
  	
  	/* ????????????, ??????????????? */
  	$(document).ready(function(){
  		$("#reply").show();         // ?????? ??????
  		$("#showReply").hide();  // ???????????? ?????? ?????????
  		$("#hideReply").show();
  		$(".page-link").show();  // ?????????
  		
  		$("#showReply").click(function(){  // ?????? ?????? ????????? ????????????
  			$("#reply").slideDown(500);       // ?????? ??????
  			$("#showReply").hide();    // ???????????? ?????? ???????????? ??????
  			$("#hideReply").show();  // ??????????????? ????????? ????????? ??????
  			$(".page-link").show();  // ?????????
  		});
  		
  		$("#hideReply").click(function(){  // ?????? ???????????? ????????????
  			$("#reply").slideUp(500);           // ????????? ??? ????????? ??????
  			$("#showReply").show();    // ???????????? ????????? ????????? ??????
  			$("#hideReply").hide();  // ??????????????? ????????? ???????????? ??????
  			$(".page-link").hide();  // ?????????
  		});
  	});
  	
	/* ?????? ?????? ?????? */
  	function closeReply(idx) {
  		$("#openReply"+idx).slideDown(500);    
  		$("#closeReply"+idx).hide();   
  		$("#replyBox"+idx).slideUp(500);     
  	}  	
  	
  	
 </script>


<title>????????????</title>
</head>
<body>

	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="user" />
	</sec:authorize>


	<article>
		<div class="container" role="main" style="margin-top: 3rem;">

			<span class="badge rounded-pill bg-primary" style="font-size: 15px;">
				${detail.sh_facCate}???${detail.sh_facSido}???${detail.sh_facGugun}</span>
			<br>
			<div class="d-flex col-12 title"
				style="border-bottom: 1px solid #80808073;">
				<div class="col-1"
					style="margin: 0rem 1.2rem 0rem 2rem; width: 80%;">
					${detail.sh_title}</div>
				<div style="width: 20%; font-size: 18px;">${detail.sh_nickname}</div>
			</div>

			<div class="col-12 content">
				<div style="margin-bottom: 4rem;">${detail.sh_content}</div>

				<div class="mb-3">
					<!-- ?????? -->
					<div id="map" style="width: 70%; height: 350px; margin: auto;"></div>
				</div>

				<span class="badge rounded-pill bg-dark"
					style="display: table; margin: auto; font-size: 16px;">${detail.sh_facSido}
					${detail.sh_facGugun} ${detail.sh_facNM } ${detail.sh_facAdd}</span>

				<div class="imagelabel">????????????</div>
				<c:choose>
					<c:when test="${fn:length(detail.attach)>0}">
						<c:forEach var="f" items="${detail.attach}">
							<fmt:formatNumber var="kilo" value="${f.filesize/1024}"
								maxFractionDigits="0" />
							<div>
								<a href="/petmong/shfc/shfcdetail/download/${f.att_num}"><img
									src="/upload/${f.filename}" width="20%" alt="" class="thumb"
									style="display: inline-block; float: left;" /></a>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<span>???????????? ??????</span>
					</c:otherwise>
				</c:choose>

				<div style="clear: both;"></div>


				<!-- ?????? ?????? ?????? -->
				<div class="btlistsav"
					style="margin-top: 5rem; float: right; display: block;">
					<sec:authorize access="isAuthenticated()">
						<c:if test="${user.user.uid == detail.sh_name}">
							<button type="button" class="btn btn btn-primary"
								onclick="location.href='/petmong/shfc/shfcedit?num=${detail.sh_num}'">??????</button>
							<button type="button" class="btn btn btn-primary"
								onclick="location.href=del_board('${detail.sh_num}')">??????</button>
						</c:if>
					</sec:authorize>
					<button type="button" class="btn btn btn-primary"
						onclick="location.href='/petmong/shfc/shfclist?uid=${user.user.uid}'">??????</button>
				</div>
				<div style="clear: both;"></div>
				<!-- ?????? ????????? ??? -->
				<div class="cntBts">
					<c:choose>
						<c:when test="${detail.sumlike > 0}">
							<button type="button" onclick="like()">
								<div>${detail.sumlike}</div>
								<i class="material-icons" style="font-size: 3em;"> thumb_up
								</i>
							</button>
						</c:when>
						<c:otherwise>
							<button type="button" onclick="like()">
								<div>0</div>
								<i class="material-icons" style="font-size: 3em;"> thumb_up
								</i>
							</button>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${detail.sumdislike > 0}">
							<button type="button" onclick="dislike()">
								<div>${detail.sumdislike}</div>
								<i class="material-icons" style="font-size: 3em;">
									thumb_down </i>
							</button>
						</c:when>
						<c:otherwise>
							<button type="button" onclick="dislike()">
								<div>0</div>
								<i class="material-icons" style="font-size: 3em;">
									thumb_down </i>
							</button>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${spnum eq detail.sh_num}">
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
				<!-- ?????? ????????? ??? -->

				<!-- ?????? ?????? -->
				<div style="margin-top: 2rem;">
					<div style="width: fit-content; margin: auto;">
						<input type="button" class="btn btn-primary"
							value="????????????(${replyCnt})" id="showReply"> <input
							type="button" class="btn btn-primary" value="???????????????"
							id="hideReply">
					</div>
					<br>
					<div id="reply">
						<table class="table" id="replyList"
							style="margin: auto; width: 94.5%;">
							<tr class="table-info">
								<th style="text-align: center; width: 20%;">?????????</th>
								<th style="text-align: center; width: 50%;">??????</th>
								<th style="text-align: center; width: 20%;">????????????</th>
								<th style="text-align: center; width: 10%;">????????????</th>
							</tr>

							<!-- ???????????? ???????????? ?????? -->
							<c:forEach var="reply" items="${pageInfo.list}">
								<c:if test="${reply.depth > 0}">
									<!-- ???????????? ?????? ??????????????? ?????? -->
									<tr class="table-light" style="text-align: left;">
								</c:if>
								<c:if test="${reply.depth <= 0}">
									<tr class="table-active" style="text-align: left;">
								</c:if>
								<c:if test="${reply.depth > 0}">
									<!-- ???????????? ?????? ???????????? -->
									<td style="text-align: left;"><c:forEach var="i" begin="1"
											end="${reply.depth}">&nbsp;&nbsp; </c:forEach> ???
										${reply.name}
								</c:if>
								<c:if test="${reply.depth <= 0}">
									<td style="text-align: left;">${reply.name}
								</c:if>
								<c:if
									test="${reply.content != '????????? ??????' && reply.nickname eq user.user.uid}">
									<a
										href="javascript:updateReplyForm(${reply.idx}, '${reply.content}', '${reply.nickname}')">
										<i class="fa fa-eraser" aria-hidden="true"></i>
									</a>
									<c:if test="${reply.childCnt == 0}">
										<!-- ??????????????? ????????? ?????? ?????? -->
										<a href="javascript:deleteReply1(${reply.idx})"><i
											class="fa fa-times" aria-hidden="true"></i></a>
									</c:if>
									<c:if test="${reply.childCnt != 0}">
										<!-- ??????????????? ????????? ????????? ????????? ?????? -->
										<a href="javascript:deleteReply2(${reply.idx})"><i
											class="fa fa-times" aria-hidden="true"></i></a>
									</c:if>
								</c:if>



								<!-- ???????????? -->
								<td style="text-align: left;">${reply.content}
									<div id="updateReplyBox${reply.idx}"></div>
								</td>


								<!-- ????????? -->
								<td style="text-align: left; text-align: center;">${reply.date}</td>


								<!-- ???????????? -->
								<c:if test="${reply.depth == 0}">
									<td style="text-align: center;"><a
										href="javascript:insertNestedRepForm('${reply.idx}','${reply.depth}','${reply.screenOrder}','${reply.nickname}','${user.user.uid}','${reply.name}')">
											<i class="fa fa-plus-square" aria-hidden="true"></i>
									</a></td>
								</c:if>
								<tr>
									<td><div id="replyBox${reply.idx}"></div></td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>

<!-- ????????? ?????? -->
         <nav class = "pageBtn" aria-label="Page navigation example">
           <ul class="pagination justify-content-center">
             <li class="page-item">
               <a class="page-link" href = "/petmong/shfc/shfcdetail?num=${detail.sh_num}&pageNum=${pageInfo.navigateFirstPage}" aria-label="Previous">
                 <span aria-hidden="true">&laquo;</span>
               </a>
             </li>
                <c:forEach var = "pageNum" items = "${pageInfo.navigatepageNums}">
                   <c:choose>                           
                     <c:when test = "${pageInfo.pageNum == pageNum}"> <!-- n??? ?????? ???????????? ?????????, -->
                         <li class="page-item active"><a class="page-link" href = "/petmong/shfc/shfcdetail?num=${detail.sh_num}&pageNum=${pageNum}">${pageNum}</a></li>
                      </c:when>
                      <c:otherwise>
                         <li class="page-item"><a class="page-link" href = "/petmong/shfc/shfcdetail?num=${detail.sh_num}&pageNum=${pageNum}">${pageNum}</a></li>
                      </c:otherwise>
                   </c:choose>      
                </c:forEach>
               <li class="page-item">
                <a class="page-link" href = "/petmong/shfc/shfcdetail?num=${detail.sh_num}&pageNum=${pageInfo.navigateLastPage}"  aria-label="Next">
                   <span aria-hidden="true">&raquo;</span>
                </a>
               </li> 
              </ul>
            </nav>
         <!-- ????????? ??? -->


				<form id="re">
					<table style="width: 95%; margin: auto;">
						<tr>
							<td><sec:authorize access="isAuthenticated()">
									<label for="content">??????</label> &nbsp;
                  <input type="hidden" name="nickname"
										value="${user.user.uid}" readonly />
                  <input type="hidden" name="name"
										value="${user.user.name}" readonly />
									<input type="hidden" name=boardIdx value="${detail.sh_num }">
									<textarea rows="2" name="content" id="content"
										class="form-control"></textarea>
									<input type="button" class='btn btn-primary' value="?????? ??????"
										onclick="insertReply()" style="margin-top: 5px;" />
								</sec:authorize> <sec:authorize access="isAnonymous()">
									<a href="/petmong/loginForm"> <textarea rows="2"
											name="content" id="content" class="form-control" readonly>???????????? ????????? ??????????????????</textarea>
									</a>
								</sec:authorize></td>
						</tr>
					</table>
				</form>



			</div>
		</div>
	</article>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fefe54713afff65d5e6b73e9a2b6fd73&libraries=services"></script>
	<script>
var mapContainer = document.getElementById('map'), // ????????? ????????? div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // ????????? ????????????
        level: 3 // ????????? ?????? ??????
    };  

// ????????? ???????????????    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// ??????-?????? ?????? ????????? ???????????????
var geocoder = new kakao.maps.services.Geocoder();

// ????????? ????????? ???????????????
geocoder.addressSearch('${detail.sh_facAdd}', function(result, status) {

    // ??????????????? ????????? ??????????????? 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // ??????????????? ?????? ????????? ????????? ???????????????
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // ?????????????????? ????????? ?????? ????????? ???????????????
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">${detail.sh_facNM}<br>${detail.sh_facRoadAdd}<br>${detail.sh_facTel}</div>'
        });
        infowindow.open(map, marker);

        // ????????? ????????? ??????????????? ?????? ????????? ??????????????????
        map.setCenter(coords);
    } 
});   


<!-- ????????? ???????????? -->
function like() {
	var uid = "${user.user.uid}";
	var spnum = ${detail.sh_num};
	var category = "${detail.sh_facCate}";
	
	if(uid == '') {
		alert('???????????? ????????? ??????????????????.');
		location.href="/petmong/loginForm";
		return;
	}
	
	obj = {};
	obj.uid = uid;
	obj.spnum = spnum;
	obj.category = category;

	$.ajax({
		url : '/petmong/shfc/like',
		method : 'post',
		cache : false,
		data : obj,
		dataType : 'json',
		success : function(res) {
			if (res.like) {
				alert('???????????? ?????????????????????.');
				location.reload();
			} else {
				alert('????????? ?????????????????????.');
				location.reload();
			}
		},
		error : function(xhr, status, err) {
			alert('?????? : ' + xhr + status + err);
		}
	});
}

<!-- ????????? ??????????????? -->
function dislike() {
	var uid = "${user.user.uid}";
	var spnum = ${detail.sh_num};
	var category = "${detail.sh_facCate}";
	
	if(uid == '') {
		alert('???????????? ????????? ??????????????????.');
		location.href="/petmong/loginForm";
		return;
	}
	
	obj = {};
	obj.uid = uid;
	obj.spnum = spnum;
	obj.category = category;
	
	$.ajax({
		url : '/petmong/shfc/dislike',
		method : 'post',
		cache : false,
		data : obj,
		dataType : 'json',
		success : function(res) {
			if (res.dislike) {
				alert('???????????? ????????????????????????.');
				location.reload();
			} else {
				alert('???????????? ?????????????????????.');
				location.reload();
			}
		},
		error : function(xhr, status, err) {
			alert('?????? : ' + xhr + status + err);
		}
	});
}

// ??? ????????? ?????? ?????? ?????? ??????.
const dibs = document.querySelector("#dibs");

<!-- ????????? ??? ??????. -->
function dibsOn() {
	var uid = "${user.user.uid}";
	var spnum = ${detail.sh_num};
	var category = "${detail.sh_facCate}";
	
	if(uid == '') {
		alert('???????????? ????????? ??????????????????.');
		location.href="/petmong/loginForm";
		return;
	}
	
	obj = {};
	obj.uid = uid;
	obj.spnum = spnum;		
	obj.category = category;
	
	$.ajax({
		url : '/petmong/shfc/dibsOn',
		method : 'post',
		cache : false,
		data : obj,
		dataType : 'json',
		success : function(res) {
			if(res.dibsOn) {
				alert('???????????? ??? ???????????????.');
				dibs.style.color = "red";

			} else {
				alert('?????????????????????.');
				dibs.style.color = "pink";

			}

		},
		error : function(xhr, status, err) {
			alert('?????? : ' + xhr + status + err);
		}
	});
}   


</script>


</body>
</html>