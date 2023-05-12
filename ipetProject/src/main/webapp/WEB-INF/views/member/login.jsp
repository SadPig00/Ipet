<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <link rel="stylesheet" href="../resources/assets/css/main.css" />
    <title>로그인</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
  </head>
  <script>
    $(document).ready(function () {
    	// 로그인 비밀번호찾기 아이디찾기 버튼 클릭시 해당 주소로 이동하는 기능
      $("button").click(function (e) {
        e.preventDefault()
        let id = $(this).attr("id")
        $("form").attr("action", "/member/" + id)
        if (id == "findId") {
          $("form").attr("method", "get")
          $("form").submit()
        }
        else if (id == "findPassword") {
          $("form").attr("method", "get")
          $("form").submit()
        }
        else {
          if ($("input[name=id]").val().length == 0) alert("아이디를 입력해주세요.")
          else if ($("input[name=password]").val().length == 0) alert('비밀번호를 입력해 주세요.')
          // 입력된 id가 없거나 password가 틀리면 error로 이동
          else{
	          let vo = $("form").serialize()
	          $.ajax({
	            url: "/member/login",
	            type: "post",
	            dataType: "json",
	            data: vo,
	            success: function (result) {
	         		console.log(result)
	            	if(result['message'] == "1"){
		            	window.location.href = '/ipet/index';
		            	}
	            	else alert(result['message'])
	            	
	            },
	            error: function (result, textStatus, errorThrown) {
	              alert(result)
	            }
	          })
          }
        }
      })

    })
  </script>

  <body class="is_preload">
    <div class="page_wrapper">
      <%@ include file="../header.jsp" %>
        <section class="wrapper style1">
          <section class="container">
            <div id="content">
              <form action="#" method="post">
                아이디&nbsp; <input id="mid" name="id" /><br />
                비밀번호 <input id="mpassword" type="password" name='password' /><br />
                <button id="login" type="button"> 로그인 </button> &nbsp;
                <button id="findId" type="button"> 아이디 찾기 </button>&nbsp;
                <button id="findPassword" type="button"> 비밀번호 찾기 </button>&nbsp;
              </form>
            </div>
          </section>
        </section>
    </div>

    <%@include file="../footer.jsp" %>
  </body>

  </html>