<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<!DOCTYPE HTML>
		<!--
	Arcana by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
		<html>


		<head>
			<title>동물병원 리스트</title>
			<meta charset="utf-8" />
			<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
			<link rel="stylesheet" href="../resources/assets/css/main.css" />

		</head>
		<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
		<script>
			$(document).ready(function () {
				$("#chkbtn").click(function () {
					$("#frm").submit()
				})
				$(".a_map").click(function (e) {
					e.preventDefault()
					$("iframe").remove()
					let str = ""
					let url = e.target.href
					console.log(url)
					$.ajax({
						url: url
					})

					str += "<iframe src =" + e.target.href + " width = '600' height = '500' ></iframe>"
					$("#mapTd").append(str)


				})
			})
		</script>


		<body class="is-preload">
			<div id="page-wrapper">

				<%@include file="header.jsp" %>

					<!-- Main -->
					<section class="wrapper style1">
						<div class="container">
							<div class="row gtr-200">
								<div class="col-8 col-12-narrower">
									<div id="content">

										<!-- Content -->

										<article>
											<header>
												<h2>동물병원 탐색</h2>
												<p>지역을 체크해 주세요</p>
											</header>
											<form id="frm" action="/hospital/check_hos" method="get">
												<label for='add'>지역</label>
												<ul style="list-style-type: none;" id="hospitalList">
													<li>서울<input type="radio" value="서울" name="add" checked="checked">
													</li>
													<li>부산<input type="radio" value="부산" name="add"></li>
													<li>대구<input type="radio" value="대구" name="add"></li>
													<li>인천<input type="radio" value="인천" name="add"></li>
													<li>광주<input type="radio" value="광주" name="add"></li>
													<li>대전<input type="radio" value="대전" name="add"></li>
													<li>울산<input type="radio" value="울산" name="add"></li>
													<li>세종<input type="radio" value="세종" name="add"></li>
													<li>경기<input type="radio" value="경기" name="add"></li>
													<li>강원<input type="radio" value="강원" name="add"></li>
													<li>충북<input type="radio" value="충청북도" name="add"></li>
													<li>충남<input type="radio" value="충청남도" name="add"></li>
													<li>전북<input type="radio" value="전라북도" name="add"></li>
													<li>전남<input type="radio" value="전라남도" name="add"></li>
													<li>경북<input type="radio" value="경상북도" name="add"></li>
													<li>경남<input type="radio" value="경상남도" name="add"></li>
													<li>제주<input type="radio" value="제주" name="add"></li>
												</ul>
											</form>
										</article>

									</div>
								</div>

								<div class="col-8 col-12-narrower">
									<button id="chkbtn">검색</button>
								</div>
								<table>
									<tr>
										<th>동물병원 이름</th>
										<th>동물병원 주소</th>
										<th>동물병원 지도</th>
									</tr>
									<c:if test="${not empty voList}">
										<c:forEach var="vo" items="${voList}">
											<tr>
												<td><a class='a_map' href="http://localhost:5500/hospital/map/${vo.address}">
														${vo.name}</a></td>

												<td>${vo.address}</td>
												<td id="mapTd"></td>
											</tr>

										</c:forEach>

									</c:if>
								</table>

								<div class="col-4 col-12-narrower">
									<div id="sidebar">



										<!-- <section>
										<h3>Another Subheading</h3>
										<ul class="links">
											<li><a href="#">Amet turpis, feugiat et sit amet</a></li>
											<li><a href="#">Ornare in hendrerit in lectus</a></li>
											<li><a href="#">Semper mod quis eget mi dolore</a></li>
											<li><a href="#">Consequat etiam lorem phasellus</a></li>
											<li><a href="#">Amet turpis, feugiat et sit amet</a></li>
											<li><a href="#">Semper mod quisturpis nisi</a></li>
										</ul>
										<footer>
											<a href="#" class="button">More Random Links</a>
										</footer>
									</section> -->

									</div>
								</div>
							</div>
						</div>

					</section>

					<%@include file="footer.jsp" %>
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