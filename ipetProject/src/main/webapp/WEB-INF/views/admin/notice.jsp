<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      <!DOCTYPE HTML>
      <html>

      <head>
        <title>글 목록</title>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
        <link rel="stylesheet" href="../resources/assets/css/main.css" />
        <link rel="stylesheet" href="../resources/assets/css/community.css" />
        <link rel="shortcut icon" type="image/x-icon" href="../resources/images/favicon.jpg">
        <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
        <script>
          $(document).ready(function () {
            // 게시글 추가 화면으로 이동
            $("#insertion").click(function () {
              location.href = "/community/insert"
            })
          })
        </script>
      </head>

      <body class="is-preload">
        <div id="page-wrapper">

          <%@ include file="../header.jsp" %>
            <!-- Main -->
            <section class="wrapper style1">
              <div class="container">
                <div id="content">

                  <!-- Content -->

                  <article>
                    <header style="display: inline;">
                      <h2 style="display: inline;">리스트</h2>
                    </header>

                    <button id="insertion" style="float: right;">게시글 추가</button>

                    <div class="board">
                      <table>
                        <thead>
                          <th>번호</th>
                          <th>제목</th>
                          <th>내용</th>
                          <th>저자</th>
                          <th>작성일</th>
                        </thead>
                        <tbody>
                          <c:forEach var="list" items="${list}">
                            <tr>
                              <td>${list.bno}</td>
                              <td><a href="/community/modify?bno=${list.bno}">${list.title}</a></td>
                              <td>${list.content}</td>
                              <td>${list.writer}</td>
                              <td>
                                <fmt:formatDate pattern="yyyy년 M월 d일 hh시 m분" value="${list.regDate}" />
                              </td>
                            </tr>
                          </c:forEach>
                        </tbody>
                      </table>
                      <c:if test="${paging.prev}">
                        <c:set var="prevPage" value="${paging.startNum-1}" />
                        <a href="/ipet/commu?pageNum=${prevPage}" class="pageClass">이전</a>
                      </c:if>

                      <c:forEach begin="${paging.startNum}"
                        end="${paging.startNum+9 > paging.lastNum ? paging.lastNum : paging.startNum+9}" var="page">
                        <%-- <c:if test="${page ne paging.pageNum}"> --%>
                          <a class="pageClass" href="/ipet/commu?pageNum=${page}">${page}</a>
                          <%-- </c:if> --%>
                      </c:forEach>

                      <c:if test="${paging.next}">
                        <c:set var="nextPage" value="${paging.startNum+10}" />
                        <a class="pageClass" href="/ipet/commu?pageNum=${nextPage}">다음</a>
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