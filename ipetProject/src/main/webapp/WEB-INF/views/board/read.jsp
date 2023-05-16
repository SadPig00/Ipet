<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            // "수정" 버튼: 데이터를 수정하기 위해 수정 페이지로 이동한다.
            $("#modify").click(function () {
              var bno = $("#bno").val();
              var loginMemberId = $("#id").val();
              var id = $("#writer").val();

              if (loginMemberId != id) {
                alert("작성자 이외에는 수정/삭제이(가) 불가능합니다.")
              }
              else if (loginMemberId === id) {
                location.href = "/community/modify?bno=" + bno
              }
            });

            // "이전으로" 버튼: 이전 페이지(메인 페이지로 이동)
            $("#back").click(function () {
              location.href = "/ipet/commu"
            });

            // 댓글 추가
            // $("#insertReply").submit(function (event) {
            //   event.preventDefault(); // 기본 동작 중단

            //   var formData = new FormData(this); // 현재 폼의 데이터를 FormData 객체로 생성

            //   $.ajax({
            //     type: 'POST',
            //     url: "/community/insertReply",
            //     data: formData,
            //     contentType: false, // 기본 contentType을 false로 설정
            //     processData: false, // 데이터를 처리하지 않도록 설정
            //     success: function (result) {
            //       alert(result);
            //     }
            //   });
            // });

            $("#submitButton").click(function (e) {
              e.preventDefault();
              var formData = new FormData();
              var uploadFile = $("#uploadFile")[0].files[0];
              var bno = $("#bno").val();
              var id = $("#id").val();
              var reply = $("#reply").val();

              formData.append("bno", bno);
              formData.append("id", id);
              formData.append("reply", reply);
              formData.append("uploadFile", uploadFile);

              for (var key of formData.keys()) {
                if (formData.get(key) == null)
                  alert("공란")
                else
                  alert(formData.get(key) + "|" + typeof (formData.get(key)))
              }

              $.ajax({
                type: 'post',
                url: "/community/insertReply",
                dataType: "text",
                contentType: false,
                processData: false,
                data: formData,
                success: function (result) {
                  alert(result)
                }
              });
            });

            // 댓글 수정
            $("#modifyReply").click(function () {
              var rno = $("#hiddenRno").val();
              var loginMemberId = $("#id").val();
              var rnoId = $("#hiddenId").val();

              if (loginMemberId != rnoId) {
                alert("작성자 이외에는 수정/삭제이(가) 불가능합니다.")
              }
              else if (loginMemberId === rnoId) {
                location.href = "/community/modifyReply?rno=" + rno
              }
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
                    제목: <input type="text" name="title" id="title" value="${data.title}" readonly>
                    내용: <textarea name="content" id="textcontent" cols="30" rows="10"
                      readonly>${data.content}</textarea>
                    <!-- <input type="hidden" name="writer" id="writer" value="writer"> -->
                    <!-- 나중에 지우기 -->
                    작성자: <input type="text" name="writer" id="writer" value="${data.writer}" readonly>

                    입력일: <input type="text" name="regDate" id="regDate" value="${data.regDate}" readonly>
                    수정일: <input type="text" name="updateDate" id="updateDate" value="${data.updateDate}" readonly>

                    <input type="button" id="modify" value="수정">
                    <input type="button" id="back" value="이전으로">
                  </form>
                </div>
                <div id="replyContent" style="padding-top: 20px;">
                  <div id="showReply">
                    <table style="text-align: center;">
                      <thead>
                        <th>아이디</th>
                        <th>댓글</th>
                        <th>작성일</th>
                        <th>이미지</th>
                        <th>수정</th>
                      </thead>
                      <c:forEach var="list" items="${replyList}">
                        <tbody>
                          <tr>
                            <input type="hidden" id="hiddenRno" value="${list.rno}">
                            <td>
                              ${list.id}
                              <input type="hidden" id="hiddenId" value="${list.id}">
                            </td>
                            <td>${list.reply}</td>
                            <c:if test="${not empty list.fileName}">
                              <td><img src="/community/display?fileName=" + ${list.fileName} /></td>
                            </c:if>
                            <fmt:formatDate pattern="yyyy년 M월 d일 hh시 m분" value="${list.replyDate}" />
                            </td>
                            <td><a id="modifyReply">수정</a></td>
                          </tr>
                        </tbody>
                      </c:forEach>
                    </table>
                  </div>
                  <div id="inputReply">
                    <form id="insertReply" enctype="multipart/form-data">
                      <input type="hidden" name="bno" id="bno" value="${data.bno}" readonly>
                      <input type="hidden" name="id" id="id" value="${loginMember.id}" readonly>
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