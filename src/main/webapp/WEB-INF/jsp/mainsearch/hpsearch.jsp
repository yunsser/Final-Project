<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/layout/headerSearch.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지역 분류 카테고리</title>
<style>
   .search {margin-top : 15px; display: flex; justify-content: center;}
   .form-select { float:left; margin-right: 5px; }
   .pagination {display: flex; justify-content: center; margin-top: 15px; }
   .name { text-decoration:none; color:black;}
   .container{
      margin-top : 15px; 
   }
 
</style>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"
integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
 <!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<!-- 부트스트랩 스케치 -->
<link href="/css/bootstrap.min.css" rel="stylesheet" type="text/css"> 
<!-- 소셜로그인 아이콘 -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css"> 

</head>
<body>

<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>


<div class="container">

<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">No</th>
      <th scope="col">병원명</th>
      <th scope="col">주소</th>
      <th>
		<i class="material-icons" style = " font-size: 1.5em;">
			favorite
		</i>
	  </th>
    </tr>
  </thead>


<c:forEach begin="${hppage.start-1}" end="${hppage.end-1}" var="l" items="${hplist}"  varStatus="status">
<c:set var="i" value="${i+1 }"/>


  <tbody>
    <tr class="table-light">
      <th scope="row">${i}</th>
      <td><a class="name" href="/petmong/hp/detail?uid=${user.user.uid}&mgtno=${l.MGTNO}">${l.BPLCNM}</a></td>
      <td><a class="name" href="/petmong/hp/detail?uid=${user.user.uid}&mgtno=${l.MGTNO}">${l.SITEWHLADDR}</a></td>
      <td>
		<c:choose>
        	<c:when test="${hpnumList[status.index] eq l.MGTNO}">	
				<i id = "dibs" class="material-icons" style = "color : red; font-size: 1.5em;">
					favorite
				</i>
        	</c:when>
        	<c:otherwise>	
				<i id = "dibs" class="material-icons" style = "color : pink; font-size: 1.5em;">
					favorite
				</i>
        	</c:otherwise>
       	</c:choose>
      </td>
    </tr>

</c:forEach>

</tbody>
                  

  
  </table>


<div>
  <ul class="pagination">
     <li class="page-item">
        <c:if test="${hppage.prev}">
      <a class="page-link" href="/petmong/hpsearch?uid=${user.user.uid}&keyword=${keyword}&pageNum=${hppage.startPage-1}">&laquo;</a>
        </c:if>
    </li>
  
    <c:forEach begin="${hppage.startPage}" end="${hppage.endPage}" var="num">
<c:choose>
    <c:when test="${hppage.nowPage==num}">
    <li class="page-item active">
      <a class="page-link" href="/petmong/hpsearch?uid=${user.user.uid}&keyword=${keyword}&pageNum=${num}">${num}</a>
    </li>
    </c:when>
    <c:otherwise>
    <li class="page-item">
      <a class="page-link" href="/petmong/hpsearch?uid=${user.user.uid}&keyword=${keyword}&pageNum=${num}">${num}</a>
    </li>
    </c:otherwise>
    
</c:choose>
 </c:forEach>
     <li class="page-item">
        <c:if test="${hppage.next}">
      <a class="page-link" href="/petmong/hpsearch?uid=${user.user.uid}&keyword=${keyword}&pageNum=${hppage.endPage+1}">&raquo;</a>
        </c:if>
    </li>
  </ul>

</div>

</div>                                   
                    
                         
</body>
</html>