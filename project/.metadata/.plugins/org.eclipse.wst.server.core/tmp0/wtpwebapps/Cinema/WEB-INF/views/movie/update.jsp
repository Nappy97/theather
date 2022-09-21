<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
   
<c:choose>
	<c:when test="${empty list || fn:length(list) == 0}">
		<script>
			alert("해당 정보가 삭제되거나 없습니다");
			history.back();
		</script>
	</c:when>
	<c:otherwise>
		<c:set var="fileDto" value="${fileList[0]}"/>
    	<c:set var="dto" value="${list[0]}"/>    
			<!DOCTYPE html>
			<html lang="ko">
			
			<head>
			    <meta charset="utf-8">
			    <meta name="viewport" content="width=device-width, initial-scale=1">
			    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
			    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
			    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

			    <title>수정 - ${dto.title }, ${fileDto.id}</title>
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
			        <h2>수정 <button type="button" class="btn btn-outline-dark float-end" onclick="history.back()">취소</button></h2>
			 
			        <hr>
			
			        <form action="update" method="POST" enctype="Multipart/form-data">
			            <input type="hidden" name="id" value="${dto.id }"/>
			            <div class="mb-3 mt-3">
			                <label for="subject">제목:</label>
			                <input type="text" class="form-control" id="title" placeholder="제목을 입력하세요" name="title" value="${dto.title }" required>
			            </div>
			            <div class="mb-3 mt-3">
			                <label for="subject">장르:</label>
			                <input type="text" class="form-control" id="genre" placeholder="제목을 입력하세요" name="genre" value="${dto.genre }" required>
			            </div>
			            <div class="mb-3 mt-3">
			                <label for="subject">상영시간:</label>
			                <input type="number" class="form-control" id="runtime" placeholder="제목을 입력하세요" name="runtime" value="${dto.runtime }" required>
			            </div>
			            <div class="mb-3 mt-3">
			                <label for="subject">감독:</label>
			                <input type="text" class="form-control" id="director" placeholder="제목을 입력하세요" name="director" value="${dto.director }" required>
			            </div>
			            <div class="mb-3 mt-3">
			                <label for="subject">출연:</label>
			                <input type="text" class="form-control" id="actor" placeholder="제목을 입력하세요" name="actor" value="${dto.actor }" required>
			            </div>
			            <div class="mb-3 mt-3">
			                <label for="content">시놉시스:</label>
			                <textarea class="form-control" rows="10" id="synopsis" placeholder="내용을 입력하세요" name="synopsis">${dto.synopsis }</textarea>
			            </div>
			            
						<!-- 기존 첨부파일  목록 (삭제 가능) -->
						<div class="container mt-3 mb-3 border rounded">
						    <div id="delFiles"></div>  <!-- 삭제할 file 의 id 값(들)을 담기위한 div -->
						    <div class="mb-3 mt-3">
						        <label>첨부파일:</label>
						        <div class="input-group mb-2">
						            <input class="form-control col-xs-3" type="text" readonly value="${fileDto.file}">
						            <button type="button" class="btn btn-outline-danger"
						            	onclick="deleteFiles(${fileDto.id}); $(this).parent().remove()">삭제</button>
						        </div>
						        <div class="input-group mb-2" id="files"></div>
						    </div>
						</div>
						<script>
						function deleteFiles(fileId){
						    // 삭제할 file 의 id 값(들)을 #delFiles 에 담아 submit 한다
						    $("#delFiles").append(`<input type='hidden' name='delfile' value='\${fileId}'>`);
						    $("#files").append(`
						            <div class="input-group mb-2">
						                <input class="form-control col-xs-3" type="file" name="upfile"/>
						            </div>`);
						}
						</script>
						
			            <!-- 하단 링크 -->
			            <button type="submit" class="btn btn-outline-dark">수정완료</button>
			            <!-- 하단 링크 -->
			
			        </form><br><br><br>
			    </div>
			    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
			</body>
			
			</html>
	</c:otherwise>
</c:choose>  