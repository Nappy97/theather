<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:choose>
    <c:when test="${empty list || fn:length(list) == 0}">
        <script>
            alert("해당 영화가 삭제되거나 없습니다");
            history.back();
        </script>
    </c:when>
    <c:otherwise>
        <c:set var="list" value="${list[0]}"/>
        <c:set var="fileDto" value="${filelist[0]}"/>
        <c:set var="movieDto" value="${movielist[0]}"/>
        <c:set var="userDto" value="${userlist[0]}"/>

        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
            <link href='${pageContext.request.contextPath}/css/resdetail.css' rel='stylesheet'/>
            <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/qrcode.js"></script>
            <title>영화 - ${movieDto.title}</title>
            
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
        <jsp:include page="/WEB-INF/views/common/header.jsp"/>
        <br>
        <br>
        <br>

        <div class="container mt-3">
            <h2>${movieDto.title}</h2>
            <hr>
            <section>
                <div class="container mt-3 mb-3 rounded float-start rounded"
                     style="width:220px; height:300px; background-color:rgba(0,0,0,0);">
                    <c:choose>
                        <%-- 이미지 보여주기 --%>
                        <c:when test="${fileDto.image == true }">
                            <img src="${pageContext.request.contextPath}/upload/${fileDto.file }"
                                 style="width:220px; height:300px;" class="rounded">
                        </c:when>
                        <c:otherwise>
                            <div style="background-color:gray; width:220px; height:300px; text-align:center">
                                NO IMAGE
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <form name="frmDelete" action="delete" method="POST">
                    <input type="hidden" name="id" value="${list.id}">
                </form>
                <br>
                <div class="mb-3">
                    &nbsp;&nbsp;

                    제목 : ${movieDto.title }
                </div>
                <div class="mb-3 mt-3">
                    &nbsp;&nbsp;
                    장르 : ${movieDto.genre}
                </div>
                <div class="mb-3 mt-3">
                    &nbsp;&nbsp;
                    상영시간 : ${movieDto.runtime}분
                </div>
                <div class="mb-3 mt-3">
                    &nbsp;&nbsp;
                    감독 : ${movieDto.director}
                </div>
                <div class="mb-3 mt-3">
                    &nbsp;&nbsp;
                    출연 : ${movieDto.actor}
                </div>
            </section>
            <section>
                <div class="box1">
                    <h4><p> 좌석: ${list.seat}</p></h4>
                </div>
            </section>
            <section style="margin-top:200px;">
                ※ 주의사항
                <hr>
                1. 환불 요청시 영수증 또는 영화티켓 필수로 지참하셔야 취소가 가능합니다!<br>
                2. 입장 지연에 따른 관람 불편을 최소화하고자 본 영화는 약 10여분 후에 시작합니다.<br>
                3. 관람 에티켓을 위한 사전입장을 부탁드립니다!

            </section>
        </div>
        <c:if
                test="${fn:contains(PRINCIPAL.authorities, 'ROLE_MEMBER' ) && (PRINCIPAL.id == userDto.id)}">
            <button type="button" class="btn btn-outline-dark"
                    onclick="chkDelete()">삭제
            </button>
            <input id="text" type="text" value="http://localhost:8080/Cinema/userinfo/resdetail?id=${list.id }" style="width:80%" /><br />
			<div id="qrcode" style="width:100px; height:100px; margin-top:15px;"></div>
			<script type="text/javascript">
			var qrcode = new QRCode(document.getElementById("qrcode"), {
				width : 100,
			height : 100
			});

function makeCode () {		
	var elText = document.getElementById("text");
	
	if (!elText.value) {
		alert("Input a text");
		elText.focus();
		return;
	}
	
	qrcode.makeCode(elText.value);
}

makeCode();

$("#text").
	on("blur", function () {
		makeCode();
	}).
	on("keydown", function (e) {
		if (e.keyCode == 13) {
			makeCode();
		}
	});
</script>
        </c:if>
        <c:choose>
            <c:when test="${empty sessionScope.PRINCIPAL}">
                <script> const logged_id = 0;</script>
            </c:when>
            <c:otherwise>
                <script>logged_id = ${PRINCIPAL.id};</script>
            </c:otherwise>
        </c:choose>
        



        </body>

        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
        <script>
            const conPath = "${pageContext.request.contextPath}";
        </script>
        </html>
    </c:otherwise>
</c:choose>   