<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
 
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <title>문의 작성</title>
</head>
 
<body>
	<%-- 인증 헤더 --%>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="container mt-3">
    	<br>
    	<br>
    	<br>
        <h2>작성</h2>
        <hr>
        <form name="frm" action="write" method="post">
            <div style="display: flex; flex-wrap: wrap">
            <div class="mb-3" style="width: 60%; display: flex; flex-wrap: wrap">
            	<span style="margin-top: 6px">제목 :&nbsp;</span><input  type="text" class="form-control" style="border-radius: 0; width: 60%" id="title" placeholder="제목을 입력하세요" name="title" required>
            </div>
            <div class="mb-3" style="width: 30%; display: flex; flex-wrap: wrap;margin-left: auto">
                <span style="margin-top: 6px">작성자 :&nbsp;</span> <span class="form-control" style="border: 0; width: 20%">${PRINCIPAL.name }</span>
            </div>
            </div>
            
            <div class="mb-3 mt-3">
                <label for="content">문의 내용:</label>
                <textarea style="width: 100%; height:300px" rows="5" id="content" placeholder="내용을 입력하세요" name="content"></textarea>
            </div> 
            
			<div align="right">
            <button type="submit" class="btn btn-outline-dark">작성완료</button>
            <a class="btn btn-outline-dark" href="list">목록</a>
            </div>
        </form>
        
 
    </div>
 	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
 
</html>