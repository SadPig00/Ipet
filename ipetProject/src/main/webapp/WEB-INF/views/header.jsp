<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<script>
			$(document).ready(function () {
				let current = parseInt([[${ index }]]);
				for (let i = 0; i < $("li").length; i++) {
					$("li").eq(i).removeAttr("class")
				}
				$("li").eq(current).attr("class", "current")
			})
		</script>
		<!-- Header -->
		<div id="header">
			<c:choose>
				<c:when test="${empty mno}">
					<span style="text-align: right; display: block">
						<a style="color: black;">로그인</a> &nbsp; &nbsp;
						<a style="color: black;">회원가입</a>
					</span>
					<br />
					<span id="timer"></span>
				</c:when>
				<c:when test="${not empty mno && auth eq '0'}">
					<span style="text-align: right; display: block">
						<a style="color: black;">마이페이지</a> &nbsp; &nbsp;
						<a style="color: black;">장바구니</a>
					</span>
				</c:when>
				<c:when test="${mno != null && auth eq '1'}">
					<span style="text-align: right; display: block">
						<a style="color: black;">관리자 페이지</a> &nbsp; &nbsp;
						<a style="color: black;">고객정보 확인</a>
					</span>
				</c:when>
			</c:choose>
			<!-- Logo -->
			<div id="logo" style="align-items: center;">
				<h1><a href="/sample/index" id="logo"><img src="../resources/images/ipetLogo_fin.jpg" /></a>
				</h1>
			</div>
			<!-- Nav -->
			<nav id="nav">
				<ul>
					<li class="current"><a href="index">메인 페이지</a></li>
					<li><a href="/sample/pro">반려동물 용품 판매</a></li>
					<li><a href="/sample/hos">동물병원 검색</a></li>
					<li><a href="/sample/commu">커뮤니티</a></li>
					<li>
						<a href="#">고객관리</a>
						<ul>
							<li><a href="#">고객센터</a></li>
							<li><a href="#">QnA</a></li>
							<li><a href="#">이벤트</a></li>
							<!-- <li>
						<a href="#">Submenu</a>
						<ul>
							<li><a href="#">Lorem dolor</a></li>
							<li><a href="#">Phasellus magna</a></li>
							<li><a href="#">Magna phasellus</a></li>
							<li><a href="#">Etiam nisl</a></li>
							<li><a href="#">Veroeros feugiat</a></li>
						</ul>
					</li> -->
						</ul>
					</li>
				</ul>
				<!-- Scripts -->
				<script src="../resources/assets/js/jquery.min.js"></script>
				<script src="../resources/assets/js/jquery.dropotron.min.js"></script>
				<script src="../resources/assets/js/browser.min.js"></script>
				<script src="../resources/assets/js/breakpoints.min.js"></script>
				<script src="../resources/assets/js/util.js"></script>
				<script src="../resources/assets/js/main.js"></script>
			</nav>

		</div>