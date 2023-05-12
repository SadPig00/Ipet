<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html>

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
      <link rel="stylesheet" href="../resources/assets/css/main.css" />
      <link rel="stylesheet" href="../resources/assets/css/community.css" />
      <title>새 글 작성</title>
      <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
      <script>
        $(document).ready(function () {
          // "수정" 버튼: 데이터를 수정하고 해당 페이지에 잔류한다.
          $("#modify").click(function () {
            if (confirm("수정 하시겠습니까?")) {
              data = {
                bno: $("#bno").val(),
                title: $("#title").val(),
                content: $("#textcontent").val(),
                writer: $("#writer").val(),
              }

              $.ajax({
                type: "put",
                url: "/community/modfiy",
                data: JSON.stringify(data),
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (result) {
                  alert("수정 완료")
                  location.href = "/ipet/commu"
                }
              });
            }
          });

          // "삭제" 버튼: 데이터를 수정하고 메인 페이지로 돌아간다.
          $("#delete").click(function () {
            if (confirm("삭제 하시겠습니까?")) {
              var bno = $("#bno").val()

              $.ajax({
                type: "delete",
                url: "/community/delete",
                data: JSON.stringify(bno),
                contentType: "application/json; charset=utf-8",
                success: function (result) {
                  alert("삭제 완료")
                  location.href = "/ipet/commu"
                }
              });
            }
          });

          // "이전으로" 버튼: 이전 페이지(메인 페이지로 이동)
          $("#back").click(function () {
            location.href = "/sample/commu"
          });

          // 댓글 추가
          $("#submitButton").click(function () {
            var formData = new FormData();
            var uploadFile = $("#uploadFile")[0].files[0];
            var bno = $("#bno").val();
            var id = $("#id").val();
            var reply = $("#reply").val();

            formData.append("bno", bno);
            formData.append("id", id);
            formData.append("reply", reply);
            formData.append("uploadFile", uploadFile);

            alert(bno + id + reply)

            $.ajax({
              url: "/community/insertReply",
              dataType: "json",
              contentType: false,
              processData: false,
              data: formData,
              type: 'post',
              success: function (result) {
                alert("전송 완료")
              }
            });
          });

        });
      </script>
    </head>

    <body class="is_preload">
      <div class="page_wrapper">
        <%@ include file="../header.jsp" %>
          <section class="wrapper style1">
            <section class="container">
              <div id="content">
                <form action="#" method="post">
                  번호: <input type="text" name="bno" id="bno" value="${data.bno}" readonly>
                  제목: <input type="text" name="title" id="title" value="${data.title}">
                  내용: <textarea name="content" id="textcontent" cols="30" rows="10">${data.content}</textarea>
                  <!-- <input type="hidden" name="writer" id="writer" value="writer"> -->
                  <!-- 나중에 지우기 -->
                  작성자: <input type="text" name="writer" id="writer" value="${data.writer}" readonly>
                  입력일: <input type="text" name="regDate" id="regDate" value="${data.regDate}" readonly>
                  수정일: <input type="text" name="updateDate" id="updateDate" value="${data.updateDate}" readonly>
                  <input type="button" id="modify" value="수정">
                  <input type="button" id="delete" value="삭제">
                  <input type="button" id="back" value="이전으로">
                </form>
                <div id="replyContent">
                  <form id="insertReply" enctype="multipart/form-data">
                    <input type="hidden" name="bno" id="bno" value="${data.bno}" readonly>
                    <input type="hidden" name="id" id="id" value="${data.writer}" readonly>
                    <input type="text" id="reply">
                    <input type="file" id="uploadFile" multiple>
                    <input type="submit" value="전송" id="submitButton">
                  </form>
                </div>
              </div>
            </section>
          </section>
      </div>

      <%@include file="../footer.jsp" %>
    </body>

    </html>