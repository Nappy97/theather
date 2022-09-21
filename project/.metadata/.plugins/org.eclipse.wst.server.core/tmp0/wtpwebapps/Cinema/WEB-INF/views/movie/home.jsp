<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
 
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
 
    <title>영화목록</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="container mt-3">
    	<section>
    		<br><br><br>
	        <h2 class="float-start">영화</h2>
	        <c:if test="${fn:contains(PRINCIPAL.authorities, 'ROLE_ADMIN')}">
	        	<a class="btn btn-outline-dark mx-3 float-end mb-3" href="write">영화추가</a>
	        </c:if>
        </section>
        <div class=" row row-offcanvas row-offcanvas-right" style="width:100%;">
	        <div class="col-xs-12 col-sm-12">
	        	<div class="row">
	        		<hr>
			       	<c:forEach var="dto" items="${dtolist}">
				       	<div class="row col-xs-3 col-lg-3 mb-5 justify-content-center bgRed text-center">
				        	<a href="detail?id=${dto.id}" class="text-decoration-none rounded text-black" style="width:220px; height:300px; background-color:rgba(0,0,0,0);">
								<c:choose>
					        	<%-- 이미지 보여주기 --%>
					            <c:when test="${dto.fileName != null}">
									<img src="${pageContext.request.contextPath}/upload/${dto.fileName}" style="width:220px; height:300px;" class="rounded border border-white">
					            </c:when>
					            <c:otherwise>
					            	<div style="background-color:gray; width:220px; height:300px; text-align:center" class="rounded">
					            		NO IMAGE
					            	</div>
					            </c:otherwise>
								</c:choose>
				        	</a>
				        	<div><a href="detail?id=${dto.id}" class="text-decoration-none text-black" style="font-size:1.5rem;">
				        		&nbsp;&nbsp;&nbsp;${dto.title}
				        	</a></div>
				        	<div style="font-size:1.5rem; color:crimson; font-weight:bold;">&nbsp;&nbsp;★${dto.star}</div>
				        </div>
			       	</c:forEach>
		       	</div>
	       	</div>
       	</div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>