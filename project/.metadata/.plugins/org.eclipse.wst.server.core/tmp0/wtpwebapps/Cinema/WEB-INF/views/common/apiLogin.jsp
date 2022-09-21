<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name ="google-signin-client_id" content="815201325834-i9cdubuv18imuu4srr19f6cbj5m82n0f.apps.googleusercontent.com">
<title></title>
<style>
	a {text-decoretion:none; color:black;}
	li {list-style:none;}
</style>
</head>
<body>
	<div id="kakao">
		<form id="kakao_L" action="apiLogin" method="POST">
		
		</form>
		<div onclick="kakaoLogin();">
	      <a href="javascript:void(0)" style="background-color: #fef01b" class="border border-2 w-100 btn btn-lg my-1">
	          <img style="height:30px; margin-top:-5px;" src="${pageContext.request.contextPath}/img/kakao.png"/>
	          <span>카카오 로그인</span>
	      </a>
		</div>
		<div>
          	<a id="naverIdLogin_loginButton" href="javascript:void(0)" style="background-color: #2db400" class="border border-2 w-100 btn btn-lg my-1">
	            <img style="height:30px; margin-top:-5px;" src="${pageContext.request.contextPath}/img/naver.png"/>
	            <span style="color:white;">네이버 로그인</span>
	        </a>
        </div>
		<div id="GgCustomLogin">
			<a href="javascript:void(0)" style="background-color: white" class="border border-2 w-100 btn btn-lg my-1">
				<img style="height:25px; margin-top:-5px;" src="${pageContext.request.contextPath}/img/google.png"/>
				<span>구글 로그인</span>
			</a>
		</div>
		<div id="message"></div>
	</div>
</body>
<!-- 카카오 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="${pageContext.request.contextPath}/js/kakaoLogin.js"></script>
<!-- 구글 스크립트 -->
<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
<script src="${pageContext.request.contextPath}/js/googleLogin.js"></script>
<!-- 네이버 스크립트 -->
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/naverLogin.js"></script>
</html>