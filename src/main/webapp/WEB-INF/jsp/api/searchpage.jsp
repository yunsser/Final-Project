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
   #load { text-align: center; margin-top:130px; display: grid; justify-content: center; }
   .progress { width:400px;  }
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

<div class="search">
   <label for="cateCodeA"></label><p></p><input type="hidden" id="cateCodeA" name="cateCodeA" class="data"><p></p>
      <form action ="/petmong/hp/pagelist" method="get" onsubmit="return Searchsido();">
      <input type="hidden" id="uid" name="uid" value="${user.user.uid }">
      <input type="hidden" id="pageNum" name="pageNum" value="${pageNum}">
         <div class="cate_wrap">
            <select class="form-select" name="code" id="code" style="width:133px;height:40px;">
               <option selected value='none'>시/도 선택</option>
            <c:forEach var="codemap" items="${codemap}">
               <option value="${codemap.code}" ${code == codemap.code ? "selected":""}>
               ${codemap.sidoNm}
               </option>
            </c:forEach>
            </select>
            
            <select class="form-select" name="gugunCD"  style="width:133px;height:40px;"  id="gugunCD" >
               <option value='none'>군/구 선택</option>
            <c:forEach var="gugunmap" items="${gugunmap}">
               <option value="${gugunmap.gugunCd}" ${gugunCD == gugunmap.gugunCd ? "selected":""} >
               ${gugunmap.gugunNm}
               </option>
            </c:forEach>
            </select>
         <input type="text" id="keyword" name="keyword" style="width:150px;height:40px;" placeholder="Search" value="${keyword}"/>
         <button class="btn btn-secondary" type="submit" >검색</button>
         </div>
      </form>
</div>

<div id ="load">
<p class="lead">동물병원을 검색해보세요</p>
 <div class="progress" style="display:none; justify-content: center;">
  <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 100%;"></div>
</div>
</div>

<script>
   let codeList = JSON.parse('${codeList}');
  
   let cate1Array = new Array();
   let cate2Array = new Array();
   let cate1Obj = new Object();
   let cate2Obj = new Object();
   
   let cateSelect1 = $("#code");      
   let cateSelect2 = $("#gugunCD");
   
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script type="text/javascript">
   function Searchsido(){
      if($("#code").val() == 'none'){
         alert('시/도 를 선택해주세요.');
         return false;
      }  
      
      window.onbeforeunload = function (){ ////현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
    	  $('.progress').show();
      }
      
      $(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
          $('.progress').hide();
      });
      
      
   }

   
</script>

<body>


</body>
</html>