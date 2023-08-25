<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 작성</title>
<link rel="stylesheet" href="css/g_write.css">
</head>
<body>
<header>
    <h1>글 작성</h1>
</header>
    <div style='text-align:right;'>
	<c:if test="${name==''}">
	<a href="/login">로그인</a>&nbsp;&nbsp;
	<a href="/signup">회원가입</a>
	</c:if>
	<c:if test="${name != ''}">
	${name}님&nbsp;<a href="/logout">로그아웃</a>
	</c:if>
	</div>
<main>
<form id="post" method="post" action="/boardInsert">
        <label for="title">제목:</label>
        <input type="text" id="title" name="title" required>
        <label for="author">작성자:</label>
        <input type="text" id="author" name="author" value="${userid}" readonly required>
        <label for="content">내용:</label>
        <textarea id="content" name="content" required></textarea>
        <input type="submit" id="btnSend" value="작성">
</form>
</main>
</body>
<script src='https://code.jquery.com/jquery-Latest.js'></script>
<script>
$(document)
.on('submit','#btnSend',function(){
	if($('#title').val()==''){
		alert('제목을 입력하시오'); return false;
	}
	if($('#content').val()==''){
		alert('게시물 내용을 입력하시오'); return false;
	}
	return true;
})
;
</script>
</html>