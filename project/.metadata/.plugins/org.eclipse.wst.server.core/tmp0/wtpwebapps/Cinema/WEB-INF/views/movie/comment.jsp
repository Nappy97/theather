<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="https://kit.fontawesome.com/51772bd9bd.js" crossorigin="anonymous"></script>

<!-- 댓글 -->
<div class="container my-3">
    <div class="mb-3 mt-3">
		<%--  ROLE_MEMBER 가진 사용자만 댓글 작성 가능 --%>
  		<c:if test="${fn:contains(sessionScope.PRINCIPAL.authorities, 'ROLE_MEMBER')}">                    

	        <div class="input-group my-2" style="height:100px;">
	            <textarea class="form-control" id="input_comment" style="resize: none; font-size:1.3rem;"></textarea>
	            <div class="border align-items-center row" style="height:100%; width:200px; margin:auto;">
	            	<div class="vertical-center-row">
	            	<span style="font-size:1.5rem; font-weight:bold;">평점 :</span> 
	            	<select name="star" id="selectStar" style="width:80px; height:40px;font-size:1.3rem;">
	            		<c:forEach var="i" begin="0" end="9" step="1" varStatus="x">
 							<option value='${i}' style="font-size:1.3rem">${i}</option>
						</c:forEach>
						<option value='10' selected>10</option>
	            	</select>
	            	</div>
	            </div>
	            <button type="button" class="btn btn-outline-primary" id="btn_comment" style="font-size:1.3rem">작성</button>
	        </div>
		</c:if>
        <table class="table table-hover mt-3" id="cmt_table">
            <thead>
              <tr>
                <th style="width: 16.5%">작성자</th>
                <th style="width: 56%">내용</th>
                <th style="width: 10%">평점</th>
                <th style="width: 16.5%">작성일</th>
                <th style="width: 1%"></th>
              </tr>
            </thead>
            <tbody id="cmt_list">
              
            </tbody>
        </table>
    </div>
</div>
<!-- 댓글 -->
