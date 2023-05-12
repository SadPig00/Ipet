<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
	Arcana by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>

<head>
	<title>반려동물 용품 판매</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="../resources/assets/css/main.css" />
	<link rel="shortcut icon" type="image/x-icon" href="../resources/images/favicon.jpg">
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
      <script>
        $(document).ready(function () {
          // 게시글 추가 화면으로 이동
          $("#insertproduct").click(function () {
            location.href = "/products/insert"
          })
        })
      </script>
</head>

<body class="is-preload">
	<div id="page-wrapper">

		<%@include file ="../header.jsp" %>
			<section class="wrapper style1">
	            <div class="container">
	              <div id="content">
	
	                <!-- Content -->
	
	                <article>
	                  <header style="display: inline;">
	                    <h2 style="display: inline;">상품 추가</h2>
	                  </header>
	
	                  <button id="insertproduct" style="float: right;">상품 추가</button>
	
	                  <div class="product">
	                    <table>
	                      <thead>
	                        <th>번호오우</th>
	                        <th>카테고리</th>
	                        <th>상품이름</th>
	                        <th>상품가격</th>
	                        <th>상품설명</th>
	                        <th>상품사진</th>
	                        <th>등로옥일</th>
	                        <th>수저엉일</th>
	                        <th>수정하냐</th>
	                      </thead>
	                      <tbody>
	                        <c:forEach var="productList" items="${productList}">
	                          <tr>
	                            <td>${productList.pno}</td>
	                            <td>${productList.cate}</td>
	                            <td>${productList.item}</td>
	                            <td>${productList.price}</td>
	                            <td>${productList.des}</td>
	                            <td>${productList.img}</td>
	                            <td>${productList.regtime}</td>
	                            <td>${productList.uptime}</td>
	                            <td><a href="/products/update?pno=${productList.pno}">수정</a></td>
	                          </tr>
	                        </c:forEach>
	                      </tbody>
	                    </table>
	                  </div>
	                </article>
	              </div>
           		</div>
          	</section>
		<%@include file ="../footer.jsp" %>

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