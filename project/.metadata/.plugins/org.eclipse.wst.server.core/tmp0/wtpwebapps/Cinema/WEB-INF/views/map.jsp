<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	
	<title>오시는길</title>
	<script src="https://kit.fontawesome.com/542764a3e1.js" crossorigin="anonymous"></script>
	
</head>
<body>

	 <jsp:include page="/WEB-INF/views/common/header.jsp"/> 
	
	<div class="container ml-3">
	<br>
	<br>
	<br>
	<h3>오시는길</h3>
	
	<div id="map" style="width:1295px;height:500px;"></div>
	
	<hr>
	
	<table>
		<tr>
			<th>주소</th>
			<td>서울 강남구 테헤란로 146 현익빌딩 4층</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>&nbsp&nbsp&nbspkorin@email.com</td>
		</tr>
	</table>
	
	<hr>
	
	<h4 class="text-danger">교통편</h4>
	<table>
		<tr>
			<th><i class="fa-solid fa-train-subway" style="font-size:25px"></i></th>
			<td>&nbsp&nbsp&nbsp역삼역 3번출구 바로 앞(신한은행 건물)</td>
		</tr>
	</table>
	
	
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=58b7f7f1223b1914b77c46c8f98fc9ca"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(37.5, 127.0356), // 지도의 중심좌표
		        level: 4, // 지도의 확대 레벨
		        mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
		    }; 

		// 지도를 생성한다 
		var map = new kakao.maps.Map(mapContainer, mapOption); 

		// 지도 타입 변경 컨트롤을 생성한다
		var mapTypeControl = new kakao.maps.MapTypeControl();

		// 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);	

		// 지도에 확대 축소 컨트롤을 생성한다
		var zoomControl = new kakao.maps.ZoomControl();

		// 지도의 우측에 확대 축소 컨트롤을 추가한다
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

		// 지도에 마커를 생성하고 표시한다
		var marker = new kakao.maps.Marker({
		    position: new kakao.maps.LatLng(37.5, 127.0356), // 마커의 좌표
		    map: map // 마커를 표시할 지도 객체
		});
	</script>
	</div>
</body>
</html>