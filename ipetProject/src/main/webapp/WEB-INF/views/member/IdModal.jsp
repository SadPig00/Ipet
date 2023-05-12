<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID 찾기</title>

<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<!-- 부트스트랩 JavaScript -->
<script
	src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>

</head>
<script>
$(document).ready(function(){
	

$("#emailCheck").click(function () {
    var email = $("#email").val();

    if (email != "") {
      $("#emailauth").remove()
      $("#authEmail").append("<div id='emailauth' style='width: 40%'>인증번호를 입력해 주세요: <input type='text' id='authNum'/><p id='ckTime' style='font-weight: bold;'></p><a id='authButton'>인증번호 입력</a><input type='hidden' id='emailResult' value='N' readonly></div>")
      let time = 120;
      let timer = setInterval(function () {
        let min = parseInt(time / 60);
        let sec = time % 60;
        $("#ckTime").text(min + "분 " + sec + "초");
        time--;
        if (time < 0) {
          clearInterval(timer);
          $("#ckTime").text("시간초과");
          $("#authNum").prop("readonly", true);
          $("#authNum").val("");
          $("#emailResult").val("N");
          alert("이메일 인증 시간초과")
        }
      }, 1000);
      console.log(email)

      $.ajax({
        type: "post",
        url: "/member/emailCheck",
        data: JSON.stringify({ "email": email }),
        contentType: "application/json; charset=utf-8",
      });
    }
  });
})
$("#button").click(function (e) {
    e.preventDefault();

    if ($("#idResult") == "N" || $("#id").val() != $("#idResult").val()) {
      alert("아이디 중복 확인을 눌러주세요.")
    }
    else if ($("#pwdResult").val() == "N" || $("#password").val().length == 0) {
      alert("비밀번호를 확인해 주세요.")
    }
    else if ($("#emailResult").val() == "N" || $("#emailResult").val().length == 0) {
      alert("이메일 인증을 진행해 주세요.")
    }
    else if ($("#pwdResult").val() == "Y" && $("#idResult").val() == $("#id").val()) {
      $("form").submit();
    }
  })
  </script>
<style>
/* 전체 화면을 덮는 모달 */
.modal-dialog {
  height: 66%;
}
.modal {
  display: none; /* 모달을 숨김 */
  position: fixed; /* 모달 위치를 고정 */
  z-index: 1; /* 모달을 다른 요소보다 위에 표시 */
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto; /* 모달이 스크롤되도록 설정 */
  background-color: rgba(0,0,0,0.4); /* 모달 배경 색상 */
}

/* 모달 내용 */
.modal-content {
  background-color: #fefefe;
  margin: 15% auto; /* 모달이 중앙에 위치하도록 설정 */
  padding: 20px;
  border: 1px solid #888;
  width: 40%;
  height: 66%;
  border-radius: 20px;
  border-color: gray;
}

/* 닫기 버튼 */
.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}
</style>
<body>

	<!-- 모달 버튼 -->
	<h3>아이디 찾기</h3>


				<!-- 모달 본문 -->
				<div class="modal-body">
					<form action="findId.jsp" method="post">
						<div class="form-group">
							<label for="name">이름:</label>
							<input type="text" class="form-control" id="name" name="name" required>
						</div>
						<div class="form-group">
							<label for="email">이메일:</label>
							이메일: <input type="email" name="email" id="email">
                		<div id="authEmail">
                  			<a id="emailCheck" onclick="alert('인증번호를 발송했습니다.')">이메일 인증</a>
                		</div>
						</div>
						<br/>
						<br/>
						<div>
							<button type="submit" class="btn btn-primary">ID 찾기</button>
						
								<button type="button" class="btn btn-secondary"
					data-dismiss="modal">닫기</button>
					</div>
				
					</form>
				</div>

</body>
</html>
