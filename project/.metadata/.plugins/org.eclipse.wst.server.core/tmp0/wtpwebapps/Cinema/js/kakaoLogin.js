Kakao.init('150861f9345e869a9c4d77a2e7f04ea7'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단
kakaoLogout();
//카카오로그인
function kakaoLogin() {
    Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {
        	const kakaoForm = document.getElementById("kakao_L");
        	const userN = response.properties.nickname
        	const userId = response.id + userN + "#609%";
        	
			const input1 = document.createElement('input');
       		input1.type = "hidden"; input1.name = "id"; 	input1.value = userId;
       		const input2 = document.createElement('input');
       		input2.type = "hidden"; input2.name = "name";	input2.value = userN;
       		
       		kakaoForm.append(input1);
       		kakaoForm.append(input2);
       		//console.log(response);
       		kakaoForm.submit();
          },
          fail: function (error) {
            console.log(error)
          },
        })
      },
      fail: function (error) {
        console.log(error)
      },
    })
  }
//카카오로그아웃  
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
        	console.log(response)
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
   }
}  