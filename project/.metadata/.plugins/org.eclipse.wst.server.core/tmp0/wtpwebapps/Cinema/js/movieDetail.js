let st = 0;
let out = [];

$(function() {
	// 현재 글의 id값
	const id = $("input[name='id']").val().trim();
	
	loadComment(id);
	
	// 댓글 작성 버튼 누르면 댓글 등록 하기.  
    // 1. 어느글에 대한 댓글인지? --> 위에 id 변수에 담겨있다
    // 2. 어느 사용자가 작성한 댓글인지? --> logged_uid 값
    // 3. 댓글 내용은 무엇인지?  --> 아래 content
    $("#btn_comment").click(function(){
		// 입력한 값
        const content = $("#input_comment").val();
        const star = $("#selectStar").val();

        // 검증
        if(!content){
            alert("댓글 입력을 하세요");
            return;
        }
		
		// 전달할 parameter 준비
		const data = {
			"movie_id":id,
			"user_id":logged_id,
			"content":content,
			"star":star,
		};
		$.ajax({
			url:conPath + "/mcomment/write",
			type:"POST",
			data:data,
			cache:false,
			success : function(data, status, xhr){
                if(status == "success") {
                    //alert(xhr.responseText);  // JSON 데이터 확인용.
                    if(data.status !== "OK"){
                        alert(data.status) ;
                        return;
                    }
                    st = 0;
                    loadComment(id); // 댓글 목록 다시 업데이트
                    $("#input_comment").val('');
                }
            }
		});

	});
})

// 특정 영화(movie_id)의 댓글 목록 읽어오기
function loadComment(movie_id) {
	if (st == 0) out = [];

	const data = {
		"start": st,
	};

	$.ajax({
		url: conPath + "/mcomment/list?id=" + movie_id,
		type: "POST",
		data: data,
		cache: false,
		success: function(data, status) {
			if (status == "success") {
				// 서버측 에러 메시지 있는 경우
				if (data.status != "OK") {
					alert(data.status);
					return;
				}
				buildComment(data); // 댓글 목록 렌더링
				st += 1;
				addDelete(); //댓글 목록 불러온 뒤 삭제에 대한 이벤트리스너 등록
			}
		},
	});	
}

function buildComment(result) {	
	result.data.forEach(comment => {
		let id = comment.id;
        let content = comment.content.trim();
        let star = comment.star;
        let regdate = comment.regdate;

        let user_id = parseInt(comment.user.id);
        let name = comment.user.name;
        
        if (name == myName) name += ' <small class="text-secondary">(내 댓글)</small>';
        
        String.prototype.replaceAt = function(index, replacement) {
		    if (index >= this.length) return this.valueOf();
		    return this.substring(0, index) + replacement + this.substring(index + 1);
		}
        name = name.replaceAt(1, "*");
        
        
        // 삭제버튼 여부 : 작성자 본인의 댓글인 경우에만 보이기
        const delBtn = (logged_id !== user_id && role !== 'ROLE_ADMIN') ? '' : `
        	<i class="btn fa-regular fa-square-minus text-danger" data-bs-toggle="tooltip"
            data-cmtdel-id="${id}" title="삭제" style="font-size:1.5rem;"></i>`;
		const row = `
	        <tr>
	        <td><span><strong style="font-size:1.2rem;">${name}</strong></span></td>
	        <td>
	            <span><pre style="font-size:1.2rem; font-family:sans-serif; word-wrap: break-word;white-space: pre-wrap;white-space: -moz-pre-wrap;white-space: -pre-wrap;white-space: -o-pre-wrap;word-break:break-all;">${content}</pre></span>            
	        </td>
	        <td class="p-3"><span><small style="font-size:1.2rem; color:crimson">★${star}</small></span></td>
	        <td><span><small class="text-secondary">${regdate}</small></span></td>
	        <td><span><small class="text-secondary">${delBtn}</small></span></td>
	        </tr>`;
		out.push(row);
	});
	$("#cmt_list").html(out.join("\n"));
}

// 댓글삭제버튼이 눌렸을때 해당 댓글 삭제하는 이벤트리스너를 삭제버튼에 등록
function addDelete() {
	// 현재 글의 id
	const id = $("input[name='id']").val().trim();
	
	$("[data-cmtdel-id]").click(function() {
		if (!confirm("댓글을 삭제하시겠습니까?")) return;
		
		// 삭제할 댓글의 id
		const comment_id = $(this).attr("data-cmtdel-id");
		$.ajax({
			url: conPath + "/mcomment/delete",
			type: "POST",
			cache: false,
			data: {"id": comment_id},
			success: function(data, status) {
				if (status == "success") {
					if (data.status !== "OK") {
						alert(data.status);
						return;
					}
					
					// 삭제후에는 다시 목록 불러오기
					st = 0;
					loadComment(id);
				}
			},
		});
	})
}
