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
	/* $(document).ready(function() {
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
					for (var i = files.length - 1; i >= 0; i--) {
						uploadSummernoteImageFile(files[i], this);
					}
				}
			}
		});
	});
	// 이미지 업로드시 ajax로 파일 업로드를 하고 성공 후 파일 경로를 return받음
	function uploadSummernoteImageFile(file, editor) {
		data = new FormData();
		data.append("file", file);
		$.ajax({
			url : "/summernoteImage",
			data : data,
			type : "POST",
			dataType : 'JSON',
			contentType : false,
			processData : false,
			success : function(data) {
				//항상 업로드된 파일의 url이 있어야 한다.
				$(editor).summernote('insertImage', contextPath + data.url);
			}
		});
	} */
	$(document).ready(function() {
	 $('#summernote').summernote( {
				height : 300, // 에디터 높이
				minHeight : null, // 최소 높이
				maxHeight : null, // 최대 높이
				focus : true, // 에디터 로딩후 포커스를 맞출지 여부
				lang : "ko-KR", // 한글 설정
				placeholder : '최대 2048자까지 쓸 수 있습니다', //placeholder 설정
				callbacks : { //여기 부분이 이미지를 첨부하는 부분
					onImageUpload : function(files) {
						uploadSummernoteImageFile(files[0], this);
					},
					onPaste : function(e) {
						var clipboardData = e.originalEvent.clipboardData;
						if (clipboardData && clipboardData.items
								&& clipboardData.items.length) {
							var item = clipboardData.items[0];
							if (item.kind === 'file'
									&& item.type.indexOf('image/') !== -1) {
								e.preventDefault();
							}
						}
					}
				}

			});
		})
	/**
	 * 이미지 파일 업로드
	 */
	function uploadSummernoteImageFile(file, editor) {
		data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			url : "/uploadSummernoteImageFile",
			contentType : false,
			processData : false,
			success : function(data) {
				//항상 업로드된 파일의 url이 있어야 한다.
				$(editor).summernote('insertImage', data.url);
			}
		});
	}

	/* 폼값 넘겨주기 */
	function add() {

		if (!confirm('정말로 저장하시겠습니까?')) {
			alert('정상적으로 취소했습니다.');
			return false;
		}

		var formData = new FormData($("#form")[0]);

		$.ajax({
			url : '/post/upload',
			method : 'post',
			enctype : 'multipart/form-data',
			cache : false,
			data : formData,
			processData : false,
			contentType : false,
			dataType : 'json',
			success : function(res) {
				if (res.added) {
					alert('저장 성공!');
				} else {
					alert('저장 실패');
				}
				location.href = "/post/list";
			},
			error : function(xhr, status, err) {
				alert('err' + err);
			}
		});
		//alert('데이터'+formData);
		return false;
	}
</script>

</head>
<body>

	<form id="form" role="form" method="post" onsubmit="return add();">

		<br style="clear:  both">  
		<h3 style="margin-bottom:  25px;">글쓰기</h3>
		<br style="clear:  both">

		<div class="form-group row">
			<label for="category" required class="col-sm-2 col-form-label"
				style="font-size: 20px;">구 선택</label> <select name="category"
				id="category">
				<option>강남구</option>
				<option>강동구</option>
				<option>강북구</option>
				<option>강서구</option>
				<option>관악구</option>
				<option>광진구</option>
				<option>구로구</option>
				<option>금천구</option>
				<option>노원구</option>
				<option>도봉구</option>
				<option>동대문구</option>
				<option>동작구</option>
				<option>마포구</option>
				<option>서대문구</option>
				<option>서초구</option>
				<option>성동구</option>
				<option>성북구</option>
				<option>송파구</option>
				<option>양천구</option>
				<option>영등포구</option>
				<option>용산구</option>
				<option>은평구</option>
				<option>종로구</option>
				<option>중구</option>
				<option>중랑구</option>
			</select>
		</div>


		<div class="form-group row">
			<label for="title" class="col-sm-2 col-form-label"
				style="font-size: 20px;">글내용</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="title" name="title">
			</div>
		</div>

		<div class="form-group row">
			<label for="author" class="col-sm-2 col-form-label"
				style="font-size: 20px;">작성자</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="author" name="author"
					placeholder="${id}">
				<!-- readonly -->
			</div>
		</div>

		  
		<div class="form-group">
			<textarea class="form-control" id="summernote" name="summernote"></textarea>
		</div>
		  
		<div id="count" name="count" style="display: none" placeholder="0"></div>


		<button type="submit" id="submit" name="submit"
			class="btn btn-primary pull-right">글작성</button>
	</form>


</body>
</html>