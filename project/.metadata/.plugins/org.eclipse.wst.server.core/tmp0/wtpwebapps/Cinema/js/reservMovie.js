let test = [];
let selectedSeats = new Array();
let selectedSeatsMap = [];
const seatWrapper = document.querySelector(".seat-wrapper");
let clicked = "";
let div = "";

for (let i = 0; i < 7; i++) {
    div = document.createElement("div");
    seatWrapper.append(div);
    for (let j = 1; j < 15; j++) {
		if (j == 4 || j == 12) { // 빈 열
			const input = document.createElement('input');
	        input.type = "button";
	        input.classList = "seat inv";
	        mapping(input, i, j);
	        div.append(input);
		}
		if (reserved.includes(returnSeat(i, j))) {
			const input = document.createElement('input');
	        input.type = "button";
	        input.classList = "seat none";
	        mapping(input, i, j);
	        div.append(input);
		} else {
	        const input = document.createElement('input');
	        input.type = "button";
	        input.name = "seats"
	        input.classList = "seat";
	        mapping(input, i, j);
	        div.append(input);
	        input.addEventListener('click', function(e) {
	            console.log(e.target.value);
	            //중복방지 함수
	            selectedSeats = selectedSeats.filter((element, index) => selectedSeats.indexOf(element) != index);
				
	            //click class가 존재할때 제거
	            if (input.classList.contains("clicked")) {
	                input.classList.remove("clicked");
	                clicked = document.querySelectorAll(".clicked");
	                selectedSeats.splice(selectedSeats.indexOf(e.target.value), 1);
	                clicked.forEach((data) => {
	                    selectedSeats.push(data.value);
	                });
	            //click class가 존재하지 않을때 추가
	            } else {
	                input.classList.add("clicked");
	                clicked = document.querySelectorAll(".clicked");
	                clicked.forEach((data) => {
	                    selectedSeats.push(data.value);
	                })
	            }
	            console.log(selectedSeats);
	        })
		}
    }
}
function returnSeat(i, j) {
	if 		(i === 0)return "A" + j;
	else if (i === 1)return "B" + j;
	else if (i === 2)return "C" + j;
	else if (i === 3)return "D" + j;
	else if (i === 4)return "E" + j;
	else if (i === 5)return "F" + j;
	else if (i === 6)return "G" + j;
}

function mapping(input, i, j) {
    if (i === 0) {
        input.value = "A" + j;
    } else if (i === 1) {
        input.value = "B" + j;
    } else if (i === 2) {
        input.value = "C" + j;
    } else if (i === 3) {
        input.value = "D" + j;
    } else if (i === 4) {
        input.value = "E" + j;
    } else if (i === 5) {
        input.value = "F" + j;
    } else if (i === 6) {
        input.value = "G" + j;
    }
}
function frmSubmit() {
	let newForm = document.createElement('form');
	newForm.name = 'newForm';
	newForm.method = 'post';
	newForm.action = 'reservOK?id=' + movie_id;

	for (let i = 0; i < selectedSeats.length; i++) {
		let input = document.createElement('input');

		input.setAttribute("type", "hidden");
		input.setAttribute("name", "seats");
		input.setAttribute("value", selectedSeats[i]);

		newForm.appendChild(input);
	}

	document.body.appendChild(newForm);
	
	if (selectedSeats.length == 0) alert("좌석을 선택해주세요");
	else if (confirm("예매하시겠습니까?")) newForm.submit();
	else return;
}