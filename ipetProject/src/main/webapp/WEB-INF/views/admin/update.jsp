<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <link rel="stylesheet" href="../resources/assets/css/main.css" />
    <link rel="stylesheet" href="../resources/assets/css/community.css" />
    <link rel="shortcut icon" type="image/x-icon" href="../resources/images/favicon.jpg">
    <title>회원 가입</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <style>
      input:read-only {
        box-shadow: none;
        background-color: rgba(134, 130, 130, 0.349);
      }
    </style>
    <script>
      $(document).ready(function () {
        $("#update").click(function () {
          if (confirm("수정 하시겠습니까?")) {
            $.ajax({
              url: "/admin/update",
              type: "put",
              data: JSON.stringify({
                mno: $("#mno").val(),
                name: $("#name").val(),
                phone: $("#phone").val(),
                address: $("#address").val(),
                email: $("#email").val()
              }),
              contentType: 'application/json; charset=utf-8',
              dataType: "json",
              success: function (result) {
                alert(result["message"]);
                window.location.href = "/admin/member";
              }
            })
          } else { alert("수정을 취소했습니다.") }
        })
        $("#delete").click(function () {
          if (confirm("삭제 하시겠습니까?")) {
            $.ajax({
              url: "/admin/delete/" + $("#mno").val(),
              type: "delete",
              dataType: "json",
              success: function (result) {
                alert(result["message"]);
                window.location.href = "/admin/member";
              }
            })
          } else { alert("삭제를 취소했습니다.") }
        })
      })
    </script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  </head>

  <body class="is_preload">
    <div class="page_wrapper">
      <%@ include file="adminheader.jsp" %>
        <section class="wrapper style1">
          <section class="container">
            <div id="content">
              <form action="#" method="post">
                회원 번호: <input type="text" name="mno" id="mno" value="${member.mno}" readonly />
                아이디: <input type="text" name="id" id="id" value="${member.id}" readonly />
                이름: <input type="text" name="name" id="name" value="${member.name}">
                전화번호: <input type="text" name="phone" id="phone" value="${member.phone }"><br />
                주소 : <input type="text" name="address" id="address" value="${member.address }">
                이메일: <input type="email" name="email" id="email" value="${member.email }" readonly>
                <!-- <div id="authEmail">
                  <a id="emailCheck">이메일 인증</a>
                </div> -->
                <input type="button" value="수정" id="update" style="background-color: #50c8fc;">
                <input type="button" id="delete" value="삭제" style="background-color: #50c8fc;">
                <a href=" /admin/member"><input type="button" id="button" value="목록"
                    style="background-color: #50c8fc;"></a>
              </form>
            </div>
          </section>
        </section>
    </div>


    <%@include file="../footer.jsp" %>
  </body>

  </html>