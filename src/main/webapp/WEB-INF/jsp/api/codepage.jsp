<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지역 분류 카테고리</title>
<style>
 .pagination {text-align:center; color:black;}
 .name { text-decoration:none; color:black;}
 
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
<label for="cateCodeA">지역 분류 카테고리 </label><p></p><input type="hidden" id="cateCodeA" name="cateCodeA" class="data"><p></p>
<form action ="" method="get">
<input type="hidden" id="pageNum" name="pageNum" value="${pageNum}">
<div class="cate_wrap">
<select class="cate1" name="code" style="width:130px;height:30px;" id="data" >
<option selected value='none'>시/도 선택</option>
<c:forEach var="codemap" items="${codemap}">
<option value="${codemap.code}" ${code == codemap.code ? "selected":""}>
${codemap.sidoNm}
</option>
</c:forEach>
</select>
<select class="cate2" name="gugunCD"  style="width:130px;height:30px;"  id="gugunCD" >
<option value='none'>군/구 선택</option>
<c:forEach var="gugunmap" items="${gugunmap}">
<option value="${gugunmap.gugunCd}" ${gugunCD == gugunmap.gugunCd ? "selected":""} >
${gugunmap.gugunNm}
</option>
</c:forEach>
</select>
<input type="text" id="keyword" name="keyword" style="width:150px;height:30px;" placeholder="Search" value="${keyword}"/>
<button class="bt" type="submit">검색</button>
</div>
</form>

<script>
   let codeList = JSON.parse('${codeList}');
  
   let cate1Array = new Array();
   let cate2Array = new Array();
   let cate1Obj = new Object();
   let cate2Obj = new Object();
   
   let cateSelect1 = $(".cate1");      
   let cateSelect2 = $(".cate2");
   
   /* 카테고리 배열 초기화 메서드 */
   
   
function makeCateArray(obj,array,codeList, tier){
for(let i = 0; i < codeList.length; i++){
      if(codeList[i].tier == tier){
         
         obj = new Object();
         
         obj.code = codeList[i].code;
         obj.sidoNm = codeList[i].sidoNm;
         obj.gugunNm = codeList[i].gugunNm;
         obj.parent = codeList[i].parent;
         obj.gugunCd = codeList[i].gugunCd;
         
         array.push(obj);            
         
      }
   }   
   }
    

   $(document).ready(function(){
      console.log(cate1Array);
      
   });

   /* 배열 초기화 */
   
   makeCateArray(cate1Obj,cate1Array,codeList,1);
   makeCateArray(cate2Obj,cate2Array,codeList,2);

   $(document).ready(function(){
      console.log(cate1Array);
      console.log(cate2Array);
   });
   
   /* 대분류 <option> 태그 */
   for(let i = 0; i < cate1Array.length; i++){
	   //cateSelect1.append("<option value='"+cate1Array[i].code+"'>" + cate1Array[i].sidoNm + "</option>");
   }
   
   /* 중분류 <option> 태그 */
   $(cateSelect1).on("change",function(){
      let selectVal1 = $(this).find("option:selected").val();
      
      cateSelect2.children().remove();

      cateSelect2.append("<option value='none'>군/구 선택</option>");
   
      for(let i = 0; i < cate2Array.length; i++){
         if(selectVal1 == cate2Array[i].parent){
        	 cateSelect2.append("<option value='"+cate2Array[i].gugunCd+"'>" + cate2Array[i].gugunNm + "</option>")
        	 	
            //cateSelect2.append("<option value='"+cate2Array[i].gugunCd+"'>" + cate2Array[i].gugunNm + "</option>")
            //location.href = "/test/code?gugunCD="+cate2Array[i].gugunCd;
         }
      }      
   });
   
   $(cateSelect2).on("change",function(){
	      let selectVal2 = $(this).find("option:selected").val();
	      
	 });   
   

   
 
</script>

<div>

<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">No</th>
      <th scope="col">병원명</th>
      <th scope="col">주소</th>
    </tr>
  </thead>

<c:set var="texts" value="${gugunCD}"/>
<c:forEach begin="${page.start-1}" end="${page.end-1}" var="l" items="${list}" >
<c:set var="i" value="${i+1 }"/>
<div>

  <tbody>
    <tr class="table-light">
      <th scope="row">${i}</th>
      <td><a class="name" href="/test/detail?mgtno=${l.MGTNO}">${l.BPLCNM}</a></td>
      <td>${l.SITEWHLADDR}</td>
    </tr>

</c:forEach>
</div>
</tbody>
                  

  
  </table>


<div>
  <ul class="pagination">
     <li class="page-item">
     	<c:if test="${page.prev}">
      <a class="page-link" href="/test/pagelist?code=${code}&gugunCD=${gugunCD}&pageNum=${page.startPage-1}">&laquo;</a>
     	</c:if>
    </li>
  
    <c:forEach begin="${page.startPage}" end="${page.endPage}" var="num">
<c:choose>
    <c:when test="${page.nowPage==num}">
    <li class="page-item active">
      <a class="page-link" href="/test/pagelist?code=${code}&gugunCD=${gugunCD}&pageNum=${num}">${num}</a>
    </li>
    </c:when>
    <c:otherwise>
    <li class="page-item">
      <a class="page-link" href="/test/pagelist?code=${code}&gugunCD=${gugunCD}&pageNum=${num}">${num}</a>
    </li>
    </c:otherwise>
    
</c:choose>
 </c:forEach>
     <li class="page-item">
     	<c:if test="${page.next}">
      <a class="page-link" href="/test/pagelist?code=${code}&gugunCD=${gugunCD}&pageNum=${page.endPage+1}">&raquo;</a>
     	</c:if>
    </li>
  </ul>

</div>


  </ul>
</div>                                   
                    
                         
</body>
</html>