<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="../css/style_join.css">
    <script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>



    <title>회원가입</title>
</head>

<body>

<div class="row mt-5">
    <div class="col-12 text-danger">
        ${REDIRECT_ATTR.error }
    </div>
</div>
<div id="form-container">
    <h2> 회원가입 </h2>
    <form id="registerForm" method="POST" action="${pageContext.request.contextPath}/user/register">
        <div class="fieldset">
            <label>아이디<span>*</span></label>
            <input type="text" class="input" placeholder="아이디" id="username"
                   name="username" title="아이디"
                   value="${REDIRECT_ATTR.username}" required>
            <div class='failure-message hide msg'>4자 이상의 영문 혹은 영문과 숫자를 조합</div>
            <div class='success-message hide msg success'>사용할 수 있는 아이디입니다.</div>
        </div>


        <div class="fieldset">
            <label>비밀번호<span>*</span></label>
            <input type="password" placeholder="비밀번호" name="password" title="비밀번호" id="password"
                   required>
            <div class='password-message-wrap'>
                <span class='password-failure-length hide msg'>10자 이상 입력</span>
                <span class='password-failure-comb hide msg'>영문/숫자/특수문자(공백 제외)만 허용하며, 2개 이상 조합</span>
                <span class='password-failure-contn hide msg'>동일한 숫자 3개 이상 연속 사용 불가</span>
                <span class='password-failure-upper hide msg'>영어 대문자 하나 이상 포함</span>
                <span class='password-success-message hide msg success'>사용할 수 있는 비밀번호입니다.</span>
            </div>
        </div>

        <div class="fieldset">
            <label>비밀번호 확인<span>*</span></label>
            <input type="password" placeholder="비밀번호체크" name="re_password" title="비밀번호체크"
                   id="re_password" required>
            <div class="mismatch-message hide msg">동일한 비밀번호를 입력해주세요.</div>
            <div class="match-message hide msg success">동일한 비밀번호가 입력되었습니다.</div>
        </div>

        <div class="fieldset">
            <label>이름<span>*</span></label>
            <input type="text" class="input" placeholder="이름" name="name" title="이름" id="name"
                   value="${REDIRECT_ATTR.name}" required>
            <div class="illegible-message hide msg">한글만 입력해주세요</div>
            <div class="readable-message hide msg success">한글만 입력되었습니다!</div>

        </div>

        <button id="subit-button" type="submit" value="회원가입"> 회원가입</button>

    </form>
</div>
</body>
<script src="${pageContext.request.contextPath}/js/join.js"></script>
</html>
