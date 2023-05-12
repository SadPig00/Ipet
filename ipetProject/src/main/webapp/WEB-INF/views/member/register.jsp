<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <link rel="stylesheet" href="../resources/assets/css/main.css" />
    <link rel="stylesheet" href="../resources/assets/css/community.css" />
    <title>회원 가입</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <script>
      function chkCharCode(event) {
        const regExp = /[^0-9a-zA-Z]/g;
        const ele = event.target;
        $("#krCheck").text("");
        if (regExp.test(ele.value)) {
          ele.value = ele.value.replace(regExp, '');
          $("#krCheck").text("한글 및 특수문자는 입력할수 없습니다").css("color", "red");
        }
      };
      $(document).ready(function () {

        // 아이디 중복 확인
        $("#idCheck").click(function () {
          console.log("클릭됨")
          var id = $("#id").val();
          console.log(id)

          $.ajax({
            type: "post",
            url: "/member/checkId",
            data: JSON.stringify({ "id": id }),
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (result) {
              if (result['status'] == "0") {
                alert(result['result'])
                $("#idResult").val(id)
              }
              else {
                alert(result['result'])
                $("#idResult").val(null)
              }
            }
          });
        })

        // 비밀번호 중복 확인
        $(".pwd").keyup(function (e) {
          var password = $("#password").val();
          var hiddenPwd = $("#hiddenPwd").val();

          if (password == hiddenPwd && $(this).val().length != 0) {
            $("#checkPwd").text("비밀번호 확인이 비밀번호와 동일합니다.").css("color", "blue")
            $("#pwdResult").val("Y")

          }
          else {
            $("#checkPwd").text("비밀번호 확인이 비밀번호와 동일하지 않습니다. 다시 입력해주세요.").css("color", "red")
            $("#pwdResult").val("N")
          }
        })

        // 데이터 전송
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

        // 주소 가져오기
        $("#kakaoaddr").click(function () {
          new daum.Postcode({
            oncomplete: function (data) {
              document.getElementById("address").value = data.address;
              document.querySelector("input[name=address2]").focus();
            }
          }).open();
        })

        // 이메일 인증 버튼을 눌렀을때 인증번호를 발급한다.
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

        // 사용자가 인증번호를 입력하면 컨트롤러로 전송하여 성공 여부를 판별한다.
        $("#authEmail").on("click", "#authButton", function () {
          var authNum = $("#authNum").val();
          var email = $("#email").val();

          if (authNum != "") {
            console.log(authNum)

            data = {
              "email": email,
              "auth": authNum
            }

            $.ajax({
              type: "post",
              url: "/member/vaildAuth",
              data: JSON.stringify(data),
              dataType: "json",
              contentType: "application/json; charset=utf-8",
              success: function (outcome) {
                if (outcome["status"] == 1) {
                  alert(outcome["word"]);
                  $("#emailResult").val("Y");
                  $("#email").prop("readonly", true);
                  $("#authNum").prop("readonly", true);
                  $("#authButton").remove();
                }
                else if (outcome["status"] == 0) {
                  alert(outcome["word"]);
                  $("#authNum").val("");
                  $("#emailResult").val("N");
                }
              }
            });
          }
        });

      })
    </script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  </head>
  <style>
      input:read-only,
      textarea:read-only {	
        box-shadow: none;
        background-color: rgba(134, 130, 130, 0.349);
      }
    </style>
  <body class="is_preload">
    <div class="page_wrapper">
      <%@ include file="../header.jsp" %>
        <section class="wrapper style1">
          <section class="container">
            <div id="content">
              <form action="#" method="post">
                아이디: <input type="text" name="id" id="id" onkeyup="chkCharCode(event)">
                <span id="krCheck"></span>
                <br />
                <a id="idCheck">중복 확인</a>
                <br />
                <br />
                <input type="hidden" id="idResult" value="N" readonly>
                비밀번호: <input type="password" name="password" id="password" class="pwd">
                비밀번호 확인: <input type="password" name="hiddenPwd" id="hiddenPwd" class="pwd">
                <input type="hidden" id="pwdResult" readonly>
                <span id="checkPwd"></span><br />
                이름: <input type="text" name="name" id="name">
                전화번호: <input type="text" name="phone" id="phone"><br />
                주소 : <a id="kakaoaddr">주소찾기</a>
                <input type="text" name="address" id="address" readonly>
                상세주소 : <input type="text" name="address2">
                이메일: <input type="email" name="email" id="email">
                <div id="authEmail">
                  <a id="emailCheck">이메일 인증</a>
                </div>
                <input type="button" id="button" value="전송" style="background-color: #50c8fc;">
              </form>
            </div>
          </section>
        </section>
    </div>


    <%@include file="../footer.jsp" %>
  </body>

  </html>