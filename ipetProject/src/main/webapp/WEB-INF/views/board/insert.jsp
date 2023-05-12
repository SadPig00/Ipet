<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <link rel="stylesheet" href="../resources/assets/css/main.css" />
    <link rel="stylesheet" href="../resources/assets/css/community.css" />
    <link rel="shortcut icon" type="image/x-icon" href="../resources/images/favicon.jpg">
    <title>새 글 작성</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <script>
      $(document).ready(function () {
        // 새 글 추가 후 메인 페이지로 이동
        $("#button").click(function () {
          if (confirm("게시글을 등록 하시겠습니까?")) {
            data = {
              title: $("#title").val(),
              content: $("#textcontent").val(),
              writer: $("#writer").val()
            }

            $.ajax({
              type: "post",
              url: "/community/insert",
              data: JSON.stringify(data),
              contentType: "application/json; charset=utf-8",
              success: function (result) {
                location.href = "/ipet/commu"
              }
            });
          }
        })
      })
    </script>
  </head>

  <body class="is_preload">
    <div class="page_wrapper">
      <%@ include file="../header.jsp" %>
        <section class="wrapper style1">
          <section class="container">
            <div id="content">
              <form action="#" method="post">
                제목: <input type="text" name="title" id="title">
                내용: <textarea name="content" id="textcontent" cols="30" rows="10"></textarea>
                <!-- <input type="hidden" name="writer" id="writer" value="writer"> -->
                <!-- 나중에 지우기 -->
                작성자: <input type="text" name="writer" id="writer">
                <input type="button" id="button" value="전송">
              </form>
            </div>
          </section>
        </section>
    </div>

    <%@include file="../footer.jsp" %>
  </body>

  </html>