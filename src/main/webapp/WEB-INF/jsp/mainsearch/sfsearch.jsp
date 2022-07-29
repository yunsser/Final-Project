<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/jsp/layout/headerSearch.jsp"%>

<style>
   .search {margin-top : 15px; display: flex; justify-content: center;}
   .form-select { float:left; margin-right: 5px; }
   .pagination {     display: flex; justify-content: center; margin-top: 15px;
   }
   .search {margin-top : 15px; display: flex; justify-content: center;}
   a { text-decoration:none; }
</style>
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
<script src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<script type="text/javascript">

function changeCate(){

   var category = $('#cate').val();
   
   if(category=='none'){
      alert('카테고리를 선택해주세요.');
      return;
   }
   
   //location.href="/shfclist?cate="+category;
}

</script>
<title>목록</title>



</div>
   <br>
   <!-- 게시판 -->
   <table class="table" style="text-align: center; width: 67%; margin: auto;">
      <tr>
         <th>No</th>
         <th>카테고리</th>
         <th>지역</th>
         <th>장소</th>
         <th>제목</th>
         <th>작성자</th>
    	 <th>
			<i class="material-icons" style = " font-size: 1.5em;">
				visibility
			</i>
		 </th>
		 <th>
			<i class="material-icons" style = " font-size: 1.5em;">
				thumb_up
			</i>
		  </th>
		  <th>
			<i class="material-icons" style = " font-size: 1.5em;">
				thumb_down
			</i>
		   </th>
		   <th>
			<i class="material-icons" style = " font-size: 1.5em;">
				favorite
			</i>
			</th>
      </tr>
      <c:forEach var="s" items="${sfpage.list}" varStatus="status">

         <tr>
         
          	<td>${s.sh_num}</td>
            <td>${s.sh_facCate}</td>
            <td>${s.sh_facSido}｜${s.sh_facGugun}</td>
            <td><a href="/petmong/shfc/shfcdetail?uid=${user.user.uid}&num=${s.sh_num}">${s.sh_facNM }</a></td>
            <td><a href="/petmong/shfc/shfcdetail?uid=${user.user.uid}&num=${s.sh_num}">${s.sh_title}</a></td>
            <td>${s.sh_nickname}</td>
            <td>${s.sh_viewCnt}</td>
			<td>${s.sumlike }</td>	
			<td>${s.sumdislike }</td>	
            <td>
			<c:choose>
	        	<c:when test="${sfnumList[status.index] eq s.sh_num}">	
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
   </table>
   <!-- 게시판 -->

   <P>

   <!-- 페이지네이션 -->
   <p>
<div>
  <ul class="pagination">
     <li class="page-item">
        <c:if test="${sfpage.pages>5}">
      <a class="page-link" href="/petmong/sfsearch?uid=${user.user.uid}&keyword=${keyword}&pageNum=${sfpage.navigateFirstPage-1}">&laquo;</a>
        </c:if>
    </li>
  
    <c:forEach begin="${sfpage.navigateFirstPage}" end="${sfpage.navigateLastPage}" var="num">
<c:choose>
    <c:when test="${sfpage.pageNum==num}">
    <li class="page-item active">
      <a class="page-link" href="/petmong/sfsearch?uid=${user.user.uid}&keyword=${keyword}&pageNum=${num}">${num}</a>
    </li>
    </c:when>
    <c:otherwise>
    <li class="page-item">
      <a class="page-link" href="/petmong/sfsearch?uid=${user.user.uid}&keyword=${keyword}&pageNum=${num}">${num}</a>
    </li>
    </c:otherwise>
    
</c:choose>
 </c:forEach>
     <li class="page-item">
        <c:if test="${sfpage.pages>5}">
      <a class="page-link" href="/petmong/sfsearch?uid=${user.user.uid}&keyword=${keyword}&pageNum=${sfpage.navigateLastPage+1}">&raquo;</a>
        </c:if>
    </li>
  </ul>
</div>
   <!-- 숫자버튼 -->
</body>




</html>