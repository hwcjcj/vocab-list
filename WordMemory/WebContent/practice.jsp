<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="dist/cropper.css">
<title>Insert title here</title>
<style>
    .container {
      max-width: 960px;
      margin: 20px auto;
    }

    img {
      max-width: 100%;
    }

    .row,
    .preview {
      overflow: hidden;
    }

    .col {
      float: left;
    }

    .col-6 {
      width: 50%;
    }

    .col-3 {
      width: 25%;
    }

  </style>
  <script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#imgInp").on('change', function(){
                readURL(this);
            });
        });

        function readURL(input) {
            if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                    $('#image').attr('src', e.target.result);
                }

              reader.readAsDataURL(input.files[0]);
            }
        }


    </script>
</head>
<body>

<div class="container">
    <h1>Customize preview for Cropper</h1>
    <h3>Cropper</h3>
    <input type="file" id="imgInp">
    <button id="ok">편집</button>
    <button id="reset" onclick="history.go(0);">리셋</button>
    <button id="remember">기억</button>
    <div class="row">
      <div class="col col-6">
        <img id="image" src="#" alt="Picture">
      </div>
      <div class="col col-3">
        <div id="preview"></div>
      </div>
    </div>
  </div>
  <table>
  	<tr><td>단어</td><td>뜻</td></tr>
  	<tr><td><div id="imsi"><img src="#"></div></td></tr>
  </table>

 <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js"></script>
  <script src="dist/cropper.js"></script>
  <script>
    $("#ok").click(function () {
      var $previews = $('#preview');

      $('#image').cropper({
          ready: function (e) {
            var $clone = $(this).clone().removeClass('cropper-hidden');

            $clone.css({
              display: 'block',
              width: '100%',
              minWidth: 0,
              minHeight: 0,
              maxWidth: 'none',
              maxHeight: 'none'
            });

            $previews.css({
              width: '100%',
              overflow: 'hidden'
            }).html($clone);
          },

          crop: function (e) {
            var imageData = $(this).cropper('getImageData');
            var previewAspectRatio = e.width / e.height;

            $previews.each(function () {
              var $preview = $(this);
              var previewWidth = $preview.width();
              var previewHeight = previewWidth / previewAspectRatio;
              var imageScaledRatio = e.width / previewWidth;

              $preview.height(previewHeight).find('img').css({
                width: imageData.naturalWidth / imageScaledRatio,
                height: imageData.naturalHeight / imageScaledRatio,
                marginLeft: -e.x / imageScaledRatio,
                marginTop: -e.y / imageScaledRatio
              });
            });
          }
        });
    });
    
    $("#remember").click(function() {
    	var imgData = $("#image").cropper('getCroppedCanvas').toDataURL();
    	$("#imsi").find('img').attr('src', imgData).appendTo('body');
    })
    
    
  </script>
</body>
</html>