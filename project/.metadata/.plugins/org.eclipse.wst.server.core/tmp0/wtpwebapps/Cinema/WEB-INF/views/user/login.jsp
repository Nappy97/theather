<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<title>로그인</title>
</head>

<body>
	<div class="container mt-3 text-center"style="width:500px;">
		<form action="${pageContext.request.contextPath }/user/login"
			method="POST">
			<h1 class="h3 mb-3 fw-normal" style="font-weight:bold;">KORIN-MOVIE<br>로그인</h1>
			<div class="row mt-5">
				<div class="col-12 text-danger">${REDIRECT_ATTR.error }</div>
			</div>
			<div class="form-floating">
				<input type="text" class="form-control" name="username"
					id="username" value="${REDIRECT_ATTR.username }"
					placeholder="name@example.com" required> <label
					for="username">Username</label>
			</div>
			<div class="form-floating mt-1">
				<input type="password" class="form-control" name="password"
					id="password" value="" placeholder="Password" required> <label
					for="password">Password</label>
			</div>	
	
			<br>
			<br>


			<button style="background-color: #483D8B" class="w-100 btn btn-lg my-1 text-white" type="submit">로그인</button>

			<a  style="background-color: #483D8B" class="w-100 btn btn-lg my-1 text-white"
				href="${pageContext.request.contextPath}/user/register">회원가입</a>
			<p class="mt-2 mb-3 text-muted"></p>



		</form>
		<jsp:include page="/WEB-INF/views/common/apiLogin.jsp"/>
	</div>
</body>
</html>