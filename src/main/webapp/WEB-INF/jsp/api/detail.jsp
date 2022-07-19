<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동물병원 상세 정보</title>
</head>
<body>
<h3>동물병원 상세 정보</h3>

<c:choose>
 <c:when test="${seouldetail != null }">


<dl>
<dt><h3> ${seouldetail.BPLCNM} </h3></dt>
<dt>전화번호: ${seouldetail.SITETEL}</dt>
<dt>도로명 주소: ${seouldetail.RDNWHLADDR}</dt>
<dt>지번 주소: ${seouldetail.SITEWHLADDR}</dt>

</dl>


<div id="map" style="width:100%;height:350px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	fefe54713afff65d5e6b73e9a2b6fd73&libraries=services"></script>
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
 
 <dl>
<dt><h3> ${csvdetail.BPLCNM} </h3></dt>
<dt>전화번호: ${csvdetail.SITETEL}</dt>
<dt>도로명 주소: ${csvdetail.RDNWHLADDR}</dt>
<dt>지번 주소: ${csvdetail.SITEWHLADDR}</dt>
 </dl>
 
<div id="map" style="width:100%;height:350px;"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	fefe54713afff65d5e6b73e9a2b6fd73&libraries=services"></script>
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


</body>
</html>