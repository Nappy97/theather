<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>


<head>

<style>

	#nav li {margin-left:40px}
	#nav li a {border-bottom:5px solid rgba(0,0,0,0); font-size:1.25rem; color:white;}
	#nav li a:hover{border-bottom:5px solid red;}	
	.log {margin-top:2px;background-color: crimson; text-decoration:none; color:white; height:35px; width:80px; border:0px; border-radius:10%;}
</style>


    <title>NavBar</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/51772bd9bd.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>

<nav class="navbar navbar-expand-sm navbar-dark" style="position: fixed; left: 0; top:0; height:50px; width:100%; z-index:999;border-radius:0; background-color:darkslateblue;">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/movie/home"><em style="font-size:1.8rem;color:greenyellow; font-weight:bolder;">KORIN</em></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mynavbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="mynavbar">
            <ul class="navbar-nav me-auto" style="top:0;" id="nav">
              
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/movie/home">영화</a>
                </li>

           
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/service/list">문의</a>
                </li>
                
            
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/map">오시는길</a>
                </li>
            </ul>

            <c:choose>
                <c:when test="${empty sessionScope.PRINCIPAL }">
                    <!-- 로그인 안했을때는 로그인 form 보여주기 -->
                    <button class="log">
                    	<a type="submit" href="${pageContext.request.contextPath}/user/login" style="text-decoration:none; color:white;">
                    		<b>로그인</b>
                    	</a>
                    </button>
                </c:when>
                <c:otherwise>
                    <!-- 로그인 했을때는 username 과 로그아웃 form 보여주기 -->
                    <form action="${pageContext.request.contextPath}/user/logout" method="POST" TODO="" onsubmit="return confirm('로그아웃 하시겠습니까?');" style="margin:5px;">
                        <!--TODO : 로그아웃후 다시 돌아오기 -->
                        <span class="d-flex" style="height:100%">
			                <span class="text-light p-2" style="height:100%">
			                	<span style="height:100%; vertical-align:center;">${sessionScope.PRINCIPAL.name }</span>
                                님 환영합니다&nbsp;
                                <a href="${pageContext.request.contextPath}/userinfo/main" style="color:white; height:100%"><i class="fa-solid fa-gears"></i></a></span>
			                <span><button class="log" type="submit"><b>로그아웃</b></button></span>
			            </span>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

</body>


</html>