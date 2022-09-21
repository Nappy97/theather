<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
 
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

	<title>영화 추가</title>
	<style>
		input[type="number"]::-webkit-outer-spin-button,input[type="number"]::-webkit-inner-spin-button {-webkit-appearance: none;margin: 0;}
		label {font-size:1.3rem;}
	</style>
</head>
 
<body>


	<%-- 인증 헤더 --%>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="container mt-3">
    	<br><br><br>
        <h2>영화 추가</h2>
        <hr>
        <form name="frm" action="write" method="post"
        	enctype="Multipart/form-data">
            <div class="mb-3 mt-3">
                <label for="subject">제목:</label>
                <input type="text" class="form-control" id="title" placeholder="제목을 입력하세요" name="title" required>
            </div>
            <div class="mb-3 mt-3">
                <label for="subject">장르:</label>
                <input type="text" class="form-control" id="genre" placeholder="장르를 입력하세요" name="genre" required>
            </div>
            <div class="mb-3 mt-3">
                <label for="subject">상영시간:</label>
                <input type="number" class="form-control" id="runtime" placeholder="상영시간을 입력하세요" name="runtime" required>
            </div>
            <div class="mb-3 mt-3">
                <label for="subject">감독:</label>
                <input type="text" class="form-control" id="director" placeholder="감독을 입력하세요" name="director" required>
            </div>
            <div class="mb-3 mt-3">
                <label for="subject">출연:</label>
                <input type="text" class="form-control" id="actor" placeholder="출연배우들을 입력하세요" name="actor" required>
            </div>
            <div class="mb-3 mt-3">
                <label for="content">시놉시스:</label>
                <textarea class="form-control" rows="10" id="synopsis" placeholder="시놉시스를 입력하세요" name="synopsis"></textarea>
            </div>
			
			<!-- 첨부파일 -->
			<%-- 상단에 jQuery 추가하기--%>
			<div class="container mt-3 mb-3 border rounded">
			    <div class="mb-3 mt-3">
			        <label>영화 포스터</label>
			        <div id="files">
			       		<div class="input-group mb-2">
		                	<input class="form-control col-xs-3" type="file" name="upfile"/>
		                </div>
			        </div>
			    </div>
			</div>
			<!-- 첨부파일 -->
			
            <button type="submit" class="btn btn-outline-dark">작성완료</button>
            <a class="btn btn-outline-dark" href="home">취소</a>
        </form><br><br><br>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
 
</html>
