<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
   


<c:set var="list" value="${list}"/>
<c:set var="mov" value="${mov[0]}"/>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>    
    <title>${mov.title} - 좌석예매</title>
    <style>
    	.seat {width:50px; height:50px;}
    	.none {background-color:dimgray;}
    	.clicked {background-color:red; color:white;}
    	.inv {opacity:0;}
    </style>
</head>
<body>
    <%-- 인증 헤더 --%>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <br><br><br>
    <div class="container"><h3>좌석예매 - ${mov.title}</h3></div>
    <div class="container mt-3"style="display:flex; justify-content:center;">
        <div class="seat-wrapper">
			<div style="width:800px; height:50px; text-align:center; background-color:dimgray" class="mb-5 btn btn-outline-dark">
				<span style="color:white; font-size:1.5rem;">SCREEN</span>
			</div>
        </div>
        <p><button style="height:50px; width:70px;" class="btn btn-outline-dark mx-3" onClick="frmSubmit()">예매</button></p>
    </div>
    <p><br><br></p>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
<script>
	let reserved = [];
	let movie_id = ${mov.id}
</script>
<c:forEach var="item" items="${list}">
	<script>
		reserved.push("${item}");
	</script>
</c:forEach>

<script src="${pageContext.request.contextPath}/js/reservMovie.js"></script>
</html>