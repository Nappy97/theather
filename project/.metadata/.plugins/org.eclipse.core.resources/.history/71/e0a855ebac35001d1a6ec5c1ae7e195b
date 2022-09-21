let page = 0;
let out = [];
let rpage = 0;

$(function () {
    const id = $("input[name='id']").val().trim();
    loadMyReserve(id);
    loadMyService(id);

})

function loadMyReserve(user_id) {
	if (rpage == 0) out = [];
    const data = {
        "page": rpage,
    };
    $.ajax({
        url: conPath + "/myreserve/list?id=" + user_id,
        type: "GET",
        data: data,
        cache: false,
        success: function (data, status) {
            if (status == "success") {
                // 서버측 에러 메시지 있는 경우
                if (data.status != "OK") {
                    alert(data.status + "왜 안될까용!");
                    return;
                }
                rpage;
                buildMyReserve(data); // 댓글 목록 렌더링
            }
        },
    });
}

function loadNextMyReserve(user_id) {
    const data = {
        "page": rpage += 1,
    };


    $("#myReserve_list").html;
    $.ajax({
        url: conPath + "/myreserve/list?id=" + user_id,
        type: "GET",
        data: data,
        cache: false,
        success: function (data, status) {
            if (status == "success") {
                // 서버측 에러 메시지 있는 경우
                if (data.status != "OK") {
                    alert(data.status);
                    return;
                }
                if (data.count == 0) {
                    alert("마지막페이지에오!");
                    rpage -= 1;
                } else {

                    buildMyReserve(data); // 서비스목록

                }
            }
        },
    });
}

function loadPreviousMyReserve(user_id) {
    if (rpage == 0) out = [];
    const data = {
        "page": rpage -= 1,
    };

    if (rpage < 0) {
        alert("첫번째 페이지입니다");
        rpage = 0;
    } else {
        $("#myReserve_list").html;
        $.ajax({
            url: conPath + "/myreserve/list?id=" + user_id,
            type: "GET",
            data: data,
            cache: false,
            success: function (data, status) {
                if (status == "success") {
                    // 서버측 에러 메시지 있는 경우
                    if (data.status != "OK") {
                        alert(data.status);
                        return;
                    }
                    buildMyReserve(data);

                }
            },
        });
    }
}

function buildMyReserve(result1) {

    const out = [];


    result1.data.forEach(myReserve => {
        var id = myReserve.id;
        var seat = myReserve.seat;
        var regdate = myReserve.regdate;

        var title = myReserve.movie.title;
        var runtime = myReserve.movie.runtime;
        var synopsis = myReserve.movie.synopsis;
        var director = myReserve.movie.director;

        var user_id = parseInt(myReserve.user.id);
        var username = myReserve.user.username;


        const row = ` 
            <div class="d-flex flex-column flex-md-row justify-content-between mb-5">
                <div class="flex-grow-1">
                    <h3 class="mb-0">${title}</h3>
                        <div class="subheading mb-3">${director}</div>
                            <p>좌석: ${seat}</p>
                        </div>
                <div class="flex-shrink-0"><span class="text-primary">${runtime}분</span></div>
            </div>`
        ;
        out.push(row);
    });
    $("#myReserve_list").html(out.join("\n"));
    $("#page").text(rpage+1 + "page");
}


function loadMyService(user_id) {
    if (page == 0) out = [];
    const data = {
        "page": page,
    };
    $.ajax({
        url: conPath + "/myservice/list?id=" + user_id,
        type: "GET",
        data: data,
        cache: false,
        success: function (data, status) {
            if (status == "success") {
                // 서버측 에러 메시지 있는 경우
                if (data.status != "OK") {
                    alert(data.status);
                    return;
                }
                
                buildMyService(data); // 댓글 목록 렌더링

            }
        },
    });
}

function loadNextMyService(user_id) {
    const data = {
        "page": page += 1,
    };


    $("#myService_list").html;
    $.ajax({
        url: conPath + "/myservice/list?id=" + user_id,
        type: "GET",
        data: data,
        cache: false,
        success: function (data, status) {
            if (status == "success") {
                // 서버측 에러 메시지 있는 경우
                if (data.status != "OK") {
                    alert(data.status);
                    return;
                }
                if (data.count == 0) {
                    alert("마지막페이지에오!");
                    page -= 1;
                } else {

                    buildMyService(data); // 서비스목록

                }
            }
        },
    });
}

function loadPreviousMyService(user_id) {
    if (page == 0) out = [];
    const data = {
        "page": page -= 1,
    };

    if (page < 0) {
        alert("첫번째 페이지입니다");
        page = 0;
    } else {
        $("#myService_list").html;
        $.ajax({
            url: conPath + "/myservice/list?id=" + user_id,
            type: "GET",
            data: data,
            cache: false,
            success: function (data, status) {
                if (status == "success") {
                    // 서버측 에러 메시지 있는 경우
                    if (data.status != "OK") {
                        alert(data.status);
                        return;
                    }
                    buildMyService(data); // 댓글 목록 렌더링

                }
            },
        });
    }
}

function buildMyService(result) {

    const out = [];

    result.data.forEach(myService => {
        let id = myService.id;
        let title = myService.title.trim();
        let content = myService.content.trim();
        let regdate = myService.regdate;

        let user_id = parseInt(myService.user.id);
        let username = myService.user.username;
        let name = myService.user.name;

        let answerCnt = parseInt(myService.cmtCheck);
        

        if (answerCnt >= 1) {
            var answer = "답변완료";
        } else {
            var answer = "미완료";
        }


        const row = `
	        <tr>
		        <td>${name}</td>
		        <td>
		            <a href="${conPath}/service/detail?id=${id}">${title}</a>            
		        </td>
		        <td>${answer}</td>	
		        <td>${regdate}</td>
	        <tr>
	        `;
        out.push(row);

    });
    $("#myService_list").html(out.join("\n"));
    $("#page").text(page+1 + "page");
}

window.onload = function () {
    function onClick() {
        document.querySelector('.modal_wrap').style.display = 'block';
        document.querySelector('.black_bg').style.display = 'block';
    }

    function offClick() {
        document.querySelector('.modal_wrap').style.display = 'none';
        document.querySelector('.black_bg').style.display = 'none';
    }

    document.getElementById('modal_btn').addEventListener('click', onClick);
    document.querySelector('.modal_close').addEventListener('click', offClick);
};