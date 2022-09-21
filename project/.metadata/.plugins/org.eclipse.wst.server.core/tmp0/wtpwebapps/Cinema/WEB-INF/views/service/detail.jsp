<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:choose>
	<c:when test="${empty list || fn:length(list) == 0}">
		<script>
			alert("해당 정보가 삭제되거나 없습니다");
			history.back();
		</script>
	</c:when>
	<c:otherwise>
		<c:set var="dto" value="${list[0]}" />
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- ajax있다 -->
<script>
		    	const conPath = "${pageContext.request.contextPath}";
		    	const logged_id = ${PRINCIPAL.id};	// 현재 로그인사람의 정보
</script>
<script src="${pageContext.request.contextPath }/js/detail.js"></script>
<!-- detail.js로 끌고간다 -->


<title>문의상세 - ${dto.title}</title>
</head>

<script>
			function chkDelete(){
				let answer = confirm("삭제하시겠습니까?");
				if(answer){
					document.forms['frmDelete'].submit();
				}
			}
		</script>

<body>
	<%-- 인증 헤더 --%>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="container mt-3">
		<br><br><br>
		<h2>문의 상세</h2>
		<hr>
		<div class="mb-3 mt-3 clearfix">
			<span class="float-start me-2">id: ${dto.id}</span> 
			<span class="float-end ms-4">작성일: ${dto.regDateTime }</span>
			<span class="float-end">조회수: ${dto.viewCnt }</span>
		</div>

		<section>
			<form name="frmDelete" action="delete" method="POST">
				<input type="hidden" name="id" value="${dto.id }">
			</form>
			
			<div style="display: flex; flex-wrap: wrap">
			<div class="mb-3" style="width: 60%; display: flex; flex-wrap: wrap">
				<span style="margin-top: 6px">제목 :&nbsp;</span><span class="form-control" style="border-radius: 0; width: 60%">${dto.title }</span>
			</div>
			<div class="mb-3" style="width: 30%; display: flex; flex-wrap: wrap; margin-left: auto">
                <span style="margin-top: 6px">작성자 :&nbsp;</span> <span class="form-control" style="border: 0; width: 20%">${dto.user.name }</span>
            </div>
            </div>
			
			<div class="mb-3 mt-3">
				<textarea style="width: 100%; height:300px" rows="5" id="content" placeholder="내용을 입력하세요" name="content" readonly>${dto.content }</textarea>
			</div>

			<!-- 하단 링크 -->
			<div align="right">
			<c:if
				test="${fn:contains(PRINCIPAL.authorities, 'ROLE_MEMBER' ) && (PRINCIPAL.id == dto.user.id)}">
				<a class="btn btn-outline-dark" href="update?id=${dto.id }">수정</a>
			</c:if>

			<a class="btn btn-outline-dark" href="list?page=${page != null ? page : '' }">목록</a>

			<c:if
				test="${fn:contains(PRINCIPAL.authorities, 'ROLE_MEMBER' ) && (PRINCIPAL.id == dto.user.id)}">
				<button type="button" class="btn btn-outline-dark"
					onclick="chkDelete()">삭제</button>
			</c:if>

			<c:if test="${fn:contains(PRINCIPAL.authorities, 'ROLE_MEMBER' )}">
				<a class="btn btn-outline-dark" href="write">작성</a>
			</c:if>
			<!-- 하단 링크 -->
			</div>

			<!-- 댓글 -->
			<jsp:include page="comment.jsp" />
			<!-- 댓글 -->

		</section>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>

</html>
	</c:otherwise>
</c:choose>

