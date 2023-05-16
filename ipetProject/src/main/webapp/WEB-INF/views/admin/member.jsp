<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <!DOCTYPE HTML>
    <html>

    <head>
      <title>회원정보 페이지</title>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
      <link rel="stylesheet" href="../resources/assets/css/main.css" />
      <link rel="stylesheet" href="../resources/assets/css/community.css" />
      <link rel="shortcut icon" type="image/x-icon" href="../resources/images/favicon.jpg">
      <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
      <script>
        $(document).ready(function () {

          $("#csvClick").click(function (e) {
            e.preventDefault();
            if (confirm("고객정보를 다운로드 하시겠습니까?")) {
              $.ajax({
                url: "http://localhost:5500/admin/getlist"
              })
              setTimeout(function () {
                $("#csvDownload")[0].click();
              }, 2000)
            }
          })
        })				
      </script>
    </head>

    <body class="is-preload">
      <div id="page-wrapper">

        <%@ include file="adminheader.jsp" %>
          <!-- Main -->
          <section class="wrapper style1">
            <div class="container">
              <div id="content">

                <!-- Content -->

                <article>
                  <header style="display: inline;">
                    <h2 style="display: inline;">회원 정보</h2>
                    <a id='csvClick' href="#"><span style="float:right;">고객정보 엑셀 다운로드</span></a>
                    <a id='csvDownload' href="/filepath/memberList.csv" download="고객리스트.csv" style="display: none;"></a>
                  </header>

                  <div class="board">
                    <table>
                      <thead>
                        <th>고객 번호</th>
                        <th>이름</th>
                        <th>주소</th>
                        <th>이메일</th>
                        <th>아이디</th>
                        <th>가입 날짜</th>
                        <th></th>
                      </thead>
                      <tbody>
                        <c:forEach var="list" items="${memberList}">
                          <tr>
                            <td>${list.mno }</td>
                            <td>${list.name}</td>
                            <td>${list.address1} ${list.address2 }</td>
                            <td>${list.email}</td>
                            <td>${list.id}</td>
                            <td><fmt:formatDate pattern="yyyy년 M월 d일 hh시 m분" value="${list.createDate}"/></td>
                            <td><a href="/admin/update?mno=${list.mno}"><input type="button" value="고객정보 수정" /></a>
                          </tr>
                        </c:forEach>
                      </tbody>
                    </table>
                    <c:if test="${paging.prev}">
                      <c:set var="prevPage" value="${paging.startNum-1}" />
                      <a href="/admin/member?pageNum=${prevPage}" class="pageClass">이전</a>
                    </c:if>

                    <c:forEach begin="${paging.startNum}"
                      end="${paging.startNum+9 > paging.lastNum ? paging.lastNum : paging.startNum+9}" var="page">
                      <a class="pageClass" href="/admin/member?pageNum=${page}">${page}</a>
                    </c:forEach>

                    <c:if test="${paging.next}">
                      <c:set var="nextPage" value="${paging.startNum+10}" />
                      <a class="pageClass" href="/admin/member?pageNum=${nextPage}">다음</a>
                    </c:if>
                  </div>
                </article>
              </div>
            </div>
          </section>

          <%@include file="../footer.jsp" %>

      </div>

      <!-- Scripts -->
      <script src="../resources/assets/js/jquery.min.js"></script>
      <script src="../resources/assets/js/jquery.dropotron.min.js"></script>
      <script src="../resources/assets/js/browser.min.js"></script>
      <script src="../resources/assets/js/breakpoints.min.js"></script>
      <script src="../resources/assets/js/util.js"></script>
      <script src="../resources/assets/js/main.js"></script>

    </body>

    </html>