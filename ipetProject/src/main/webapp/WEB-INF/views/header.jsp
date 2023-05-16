<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<script>
			$(document).ready(function () {
				if(${index}){
					if(${index} == 1) $("#index").attr("class",'current')
					if(${index} == 2) $("#product").attr("class",'current')
					if(${index} == 3) $("#hospital").attr("class",'current')
					if(${index} == 4) $("#community").attr("class",'current')
				}
			})
		</script>
		<!-- Header -->
		<div id="header">
			<c:choose>
				<c:when test="${empty loginMember.mno}">
					<span style="text-align: right; display: block">
						<a style="color: black;" href="/member/login">로그인</a> &nbsp; &nbsp;
						<a style="color: black;" href="/member/register">회원가입</a>
					</span>
					<br />
					<span id="timer"></span>
				</c:when>
				<c:when test="${not empty loginMember.mno && loginMember.auth eq 'm'}">
					<span style="text-align: right; display: block">
						<a style="color: black;" href="/member/mypage">마이페이지</a> &nbsp; &nbsp;
						<a style="color: black;">장바구니</a> &nbsp; &nbsp;
						<a style="color: black;" href="/member/logout">로그아웃</a>
						<br />
						<span style="text-align: right; display: block;">${loginMember.id}님</span>
					</span>

				</c:when>
				<c:when test="${not empty loginMember.mno && loginMember.auth eq 'a'}">
					<span style="text-align: right; display: block">
						<a style="color: black;" href="/admin/member">관리자 페이지</a> &nbsp; &nbsp;
						<a style="color: black;" href="/member/mypage">마이페이지</a> &nbsp; &nbsp;
						<a style="color: black;" href="/member/logout">로그아웃</a>
						<br />
						<span style="text-align: right; display: block;">${loginMember.id}님</span>
					</span>

				</c:when>

			</c:choose>
			<!-- Logo -->
			<div id="logo" style="align-items: center;">
				<h1><a href="/ipet/index" id="logo"><img src="../resources/images/ipetLogo_fin.jpg" /></a>
				</h1>
			</div>
			<!-- Nav -->
			<nav id="nav">
				<ul>
					<li id='index' ><a href="/ipet/index">메인 페이지</a></li>
					<li id='product'><a href="/ipet/pro">반려동물 용품 판매</a>
						<ul>
							<li><a href="/products/food">사료/간식</a></li>
							<li><a href="/products/pad">패드/장난감</a></li>
							<li><a href="/products/bath">목욕/하네스</a></li>
						</ul>
					</li>
					<li id='hospital'><a href="/ipet/hos">동물병원 검색</a></li>
					<li id='community'><a href="/ipet/commu">커뮤니티</a></li>
					<li id='cs'>
						<a href="#">고객관리</a>
						<ul>
							<li><a href="#">공지사항</a></li>
							<li><a href="#">QnA</a></li>
							<li><a href="#">이벤트</a></li>


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