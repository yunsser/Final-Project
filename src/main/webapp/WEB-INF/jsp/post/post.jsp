<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<!-- include libraries(jQuery, bootstrap) -->
<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<!-- include summernote css/js-->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
<!-- include summernote-ko-KR -->
<script src="/resources/js/summernote-ko-KR.js"></script>

<style>
form {
	width: 70%;
	margin: auto;
}
</style>

<title>글쓰기</title>

<script>
	$(document).ready(function() {
		$('#summernote').summernote({
			height : 300,
			minHeight : null,
			maxHeight : null,
			ocus : true,
			placeholder : '글을 작성하세요',
			focus : true,
			lang : 'ko-KR',
			callbacks : {
				onImageUpload : function(files, editor, welEditable) {
					sendFile(files[0], editor, welEditable);
				}
			}
		});
	});
	
	
	function sendFile(file,editor,welEditable) {
		  data = new FormData();
		  data.append('file',file);
		  $.ajax({
		    data: data,
		    type: "POST",
		    url: "/post/image",
		    enctype: 'multipart/form-data',
		    cache: false,
		    contentType: false,
		    processData: false,
		    success: function(url) {
		      editor.insertImage(welEditable, url);
		    }
		  });
		}
	
</script>

</head>
<body>

	<form id="articleForm" role="form" action="/article" method="post">
		<br style="clear:  both">  
		<h3 style="margin-bottom:  25px;">글쓰기</h3>
		<br style="clear:  both">
		<div class="form-group row">
			<label for="title" class="col-sm-2 col-form-label"
				style="font-size: 20px;">글내용</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="title">
			</div>
		</div>

		<div class="form-group row">
			<label for="author" class="col-sm-2 col-form-label"
				style="font-size: 20px;">작성자</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="author" name="author"
					placeholder="${id}" readonly>
			</div>
		</div>

		  
		<div class="form-group">
			<textarea class="form-control" id="summernote" name="content"></textarea>
		</div>
		  
		<button type="submit" id="submit" name="submit"
			class="btn btn-primary pull-right">글작성</button>
	</form>


</body>
</html>