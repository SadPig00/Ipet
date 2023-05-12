<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8">
    <title>이미지 업로드</title>
    <link rel="shortcut icon" type="image/x-icon" href="../resources/images/favicon.jpg">
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <script>
      $(document).ready(function () {
        // 이미지 업로드
        // $("#submitButton").click(function () {
        //   var formData = new FormData();
        //   var uploadImage = $("#uploadImage");
        //   var files = uploadImage[0].files;

        //   for (var i = 0; i < files.length; i++) {
        //     formData.append("uploadFile", files[i])
        //   }

        //   if (formData != null) {
        //     alert("uploadImage" + uploadImage)
        //   }

        //   $.ajax({
        //     url: "/community/uploadFile",
        //     processData: false,
        //     contentType: false,
        //     data: formData,
        //     type: 'post',
        //     success: function (result) {
        //       alert("전송 완료")
        //     }
        //   });
        // });

        // 파일 가져오기
        $("#imageGetter").click(function (e) {
          var fileName = $("#fileName").val();
          var source = "";
          // source = "downloadFile?fileName=" + fileName;
          // alert("링크: " + source);
          // var img;
          // $("#imageContainer").append("이미지: <img src='" + source + "' />");
          // alert(fileName);
          // e.preventDefault()
          $.ajax({
            url: "/community/display?fileName=" + fileName,
            type: "get",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (image) {
              source = "display?fileName=" + fileName;
              alert("링크: " + source);
              var img = $("#imageContainer img")
              img.attr("src", source)
              e.preventDefault()
            }
          });



          // 이거는 강사님 버전
          // var fileName = $("#fileName").val();
          // var source = "";
          // source = "display?fileName=" + fileName;
          // alert("링크: " + source);
          // var img;
          // $("#imageContainer").append("이미지: <img src='" + source + "' />");
          // alert(fileName);
          // e.preventDefault()

          // $.ajax({
          //   url: "/community/display?fileName=" + fileName,
          //   type: "get",
          //   dataType: "json",
          //   contentType: "application/json; charset=utf-8",
          //   success: function (image) {
          //     source = "/upload/" + fileName;
          //     alert("링크: " + source);
          //     var img = $("#imageContainer img")
          //     img.attr("src", source)
          //     e.preventDefault()
          //   }
          // });
        });
      });
    </script>
  </head>

  <body>
    <form id="uploadFile" enctype="multipart/form-data">
      <input type="file" id="uploadImage" multiple>
      <input type="submit" value="전송" id="submitButton">
    </form>

    <form id="downloadFile">
      파일 이름: <input type="text" name="fileName" id="fileName">
      <input type="submit" value="사진 불러오기" id="imageGetter">
    </form>

    <div id="imageContainer" style="width: 1000px; height: 1000px">
      <img src="" />
    </div>
  </body>


  </html>