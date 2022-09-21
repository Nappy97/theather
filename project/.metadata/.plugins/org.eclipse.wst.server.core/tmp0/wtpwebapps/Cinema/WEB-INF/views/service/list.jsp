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

	<script src="https://kit.fontawesome.com/51772bd9bd.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath }/js/list.js"></script>
    <title>목록</title>

</head>

<body>
    <%-- 인증 헤더 --%>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/> 
 
    
    <div class="container mt-3">
    	<br><br><br>
        <h2>문의 목록</h2>
        
        <form action="list">
		<div style="float: right">
			<input type="text" id="find" name="search" placeholder="입력">&nbsp;&nbsp;<button onclick="submit();">검색</button>
		</div>
		</form>
		
		
		<table id="A">
		<tbody>
            <c:forEach var="dto" items="${list }">
            <c:set var="name"       value="${dto.user.name}" />
              	<tr>
                    <!-- <td>${dto.user.name}</td> -->
					<c:if test="${name eq fname}"><td><c:out value="${first}*${last}"/></td>
                    
                    <td><a style="text-decoration: none; color: black" href="detail?id=${dto.id }">${dto.title }</a></td>
                    <td>${dto.cmtCheck }개</td>
                    <td>${dto.regDateTime}</td>
                    </c:if>
                </tr>            
            </c:forEach>           
            </tbody>
		</table>
		
		
		
		<br>
        
         <div class="mb-3 mt-3 clearfix">
           <span class="float-start me-2">총 ${cnt }개</span>
           <span class="float-start">page ${page }/${totalPage }</span>
           <span class="float-end">
               <form name="frmPageRows">
                   <input type="hidden" name="page" value="${page }">
                   <select class="form-select" name="pageRows">
                       <option value="10" ${pageRows==10 ? 'selected' : '' }>10</option>
                       <option value="15" ${pageRows==15 ? 'selected' : '' }>15</option>
                       <option value="20" ${pageRows==20 ? 'selected' : '' }>20</option>
                   </select>
               </form>
               
           </span>
        </div>          
        
        <table class="table table" id="B">
            <thead style="background-color: #483D8B">
                <tr>
                    
                    <th class="text-white" style="width: 10%">작성자</th>
                    <th class="text-white" style="width: 50%">제목</th>
                    <th class="text-white" style="width: 10%">답변개수</th>
                    <th class="text-white" style="width: 30%">작성일</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="dto" items="${list }">
            <c:set var="name"       value="${dto.user.name}" />
			<c:set var="totalLength" value="${fn:length(dto.user.name) }" />
			<c:set var="first"      value="${fn:substring(name, 0, 1) }" />
			<c:set var="last"      value="${fn:substring(name, 2, totalLength) }" />
              	<tr>
                    <!-- <td>${dto.user.name}</td> -->
					<td><c:if test="${!empty  name}"><c:out value="${first}*${last}"/></c:if></td>
                    
                    <td><a style="text-decoration: none; color: black" href="detail?id=${dto.id }">${dto.title }</a></td>
                    <td>${dto.cmtCheck }개</td>
                    <td>${dto.regDateTime}</td>
                </tr>            
            </c:forEach>           
            </tbody>
        </table>
        <div class="row">
        	<c:if test="${fn:contains(sessionScope.PRINCIPAL.authorities, 'ROLE_MEMBER' )}">
	            <div class="col-12 float-right" align="right">
	                <a class="btn btn-outline-dark" href="write">작성</a>
	            </div>
	        </c:if>
        </div>
        
      <!-- pagination -->
    <div class="container mt-1">
        <ul class="pagination justify-content-center">
            <%-- << 표시 여부 --%>   
            <li class="page-item"><a style="background-color: LightGrey" class="page-link text-white" href="${url }" title="처음"><i class='fas fa-angle-double-left'></i></a></li>
        
            <%-- < 표시 여부 --%>
            <li class="page-item"><a style="background-color: LightGrey" class="page-link text-white" href="${url }?page=${startPage - 1 }"><i class='fas fa-angle-left'></i></a></li>
            
            <%-- 페이징 안의 '숫자' 표시 --%> 
            <c:if test="${totalPage > 1 }">
                <c:forEach var="k" begin="${startPage }" end="${endPage }">
                <c:choose>
                    <c:when test="${k != page }">
                        <li class="page-item"><a style="background-color: white" class="page-link text-black" href="${url }?page=${k }">${k }</a></li>        			
                    </c:when>
                    <c:otherwise>
                        <li class="page-item active"><a style="background-color: #483D8B" class="page-link text-white" href="javascript:void(0);">${k }</a></li>
                    </c:otherwise>
                </c:choose>
                </c:forEach>    
            </c:if>
                        
            <%-- > 표시 여부 --%>
            <li class="page-item"><a style="background-color: LightGrey" class="page-link text-white" href="${url }?page=${endPage + 1 }"><i class='fas fa-angle-right'></i></a></li>
            
            <%-- >> 표시 여부 --%>
            <li class="page-item"><a style="background-color: LightGrey" class="page-link text-white" href="${url }?page=${totalPage }"><i class='fas fa-angle-double-right'></i></a></li>
            
        </ul>
    </div>
    <!-- pagination -->        
        
        
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

    
    
</body>
</html>


