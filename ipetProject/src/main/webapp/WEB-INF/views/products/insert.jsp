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
	<style>
		.inputArea { margin:10px 0; }
		select { width:100px; }
		label { display:inline-block; width:70px; padding:5px; }
		label[for='des'] { display:block; }
		input { width:150px; }
		textarea#des { width:400px; height:180px; }
		.select_img img { margin:20px 0; }
	</style>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="../resources/assets/css/main.css" />
	<link rel="shortcut icon" type="image/x-icon" href="../resources/images/favicon.jpg">
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <script>
	    $(document).ready(function () {
	        // 새 글 추가 후 메인 페이지로 이동
	        $("#button").click(function () {
	            data = {
	                cate: $("#cate").val(),
	                item: $("#item").val(),
	                price: $("#price").val(),
	                des: $("#des").val(),
	                img: $("#frm input[name='img']").val(),
	            };
	
	            $.ajax({
	                type: "post",
	                url: "/products/insert",
	                data: JSON.stringify(data),
	                contentType: "application/json; charset=utf-8",
	                success: function (result) {
	                    location.href = "/ipet/pro";
	                },
	            });
	        });
	
	        $(frm.img).on("change", function (e) {
	        	var reader = new FileReader();
	        	reader.onload = function (e) {
	        		$("#img").attr("src", e.target.result);
	        	};
	        	reader.readAsDataURL(this.files[0]);
	        });
	
	        // 이미지 업로드 시 파일 선택 창이 뜨도록 변경
	        $("#proimg").on("click", function () {
	            $("#frm input[name='img']").click();
	        });
	    });
	</script>
</head>

<body class="is-preload">
	<div id="page-wrapper">

		<%@include file ="../header.jsp" %>
		    <div class="page_wrapper">
		        <section class="wrapper style1">
		          <section class="container">
		            <div id="content">
		              <form action="#" method="post" id="frm">
							<div>
								<label for="cate">카테고리:</label>
								<select name="cate" id="cate">
									<option value="food" selected="selected">food</option>
									<option value="pad">pad</option>
									<option value="bath">bath</option>
								</select>
							</div>
							<div>
								<label for="item">상품이름:</label>
								<input type="text" name="item" id="item">
							</div>
							<div>
								<label for="price">상품가격:</label>
								<input type="text" name="price" id="price">
							</div>
							<div>
								<label for="des">상품내용:</label>
								<textarea name="des" id="des" cols="30" rows="10"></textarea>
							</div>
							<div>
								<label for="img">상품사진:</label>
								<a id="proimg" class="title">파일 선택</a>
								<div>
									<img src="http://placehold.it/150x120" id="img" width=150 />
									<input type="file" name="img" accept="img/*" style="visibility: hidden;">
								</div>
							</div>
							<input type="button" id="button" value="전송">
						</form>
		            </div>
		          </section>
		        </section>
		    </div>
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