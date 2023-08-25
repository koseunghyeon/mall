<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${findingBoard.title}</title>
<link rel="stylesheet" href="css/g_view.css">
</head>
<body>
	<!-- 타이틀 -->
    <header>
        <h1>${findingBoard.title}</h1>
    </header>
    <!-- 계정 -->
    <div style='text-align:right;'>
	<c:if test="${name==''}">
	<a href="/login">로그인</a>&nbsp;&nbsp;
	<a href="/signup">회원가입</a>
	</c:if>
	<c:if test="${name != ''}">
	${name}님&nbsp;<a href="/logout">로그아웃</a>
	</c:if>
	</div>
	<!-- 메인 -->
    <main>
        <article id="post-content">
        	<input type="hidden" id="boardNum" value="${findingBoard.num}">
            <h2>${findingBoard.title}</h2>
            <p>작성자: ${findingBoard.userid}</p>
            <p>조회수: ${findingBoard.hit}</p>
            <p>작성일: ${findingBoard.created}</p>
            <p>최종수정일: ${findingBoard.updated}</p>
            <label style="border-top: 1px solid gold;">내용:</label>
			<textarea id="content" name="content" required readonly>${findingBoard.content}</textarea>	 
			<label>댓글:</label>
			<div id="writeComment" style='text-align:right; font-size: small; cursor:pointer;'>댓글달기</div>
			<form method="post" action="/insertComment">
			<input type="hidden" name="boardNum" value="${findingBoard.num}">
			<input type="hidden" id="userid" name="userid" value="${userid}">
			<input id="commentBox" name="commentBox" type=text style="display:none" required>
			<input id="sendComment" type=submit value="확인"><br><br>
			</form>
			<table>
			<c:forEach items="${findingComment}" var="findingComment">
			<tr>
			<td style="width:140px">${findingComment.userid}</td><td style="width:420px">${findingComment.comment}</td><td style="width:100px">${findingComment.updated}</td>
			<td><c:if test="${findingComment.userid==userid}"><a href="/g_commentDelete?c_num=${findingComment.c_num}">X</a><br>수정</c:if></td>
			</tr>
			</c:forEach>
			</table>         
        </article>
        <div style="width: 800px;">
        <span><a href="/g_board" class="back-button">게시판 목록으로 돌아가기</a></span>      
        <span style='margin-left:320px;'>
        <c:if test="${name==''}">
		글을 작성하려면 로그인하세요.
		</c:if>
		<c:if test="${name != ''}">
		<a href='/g_write'>글쓰기</a>&nbsp;&nbsp;
		</c:if>
		<c:if test="${findingBoard.userid==userid}">
		<button id=btnUpdate>수정</button>&nbsp;&nbsp;
		<button id=btnDelete>삭제</button>
		</c:if>
		</span>
		</div>
    </main>
</body>
<script src='https://code.jquery.com/jquery-Latest.js'></script>
<script>
$(document)
.on('click','#btnDelete',function(){
 	if(!confirm('정말로 지울까요?')) return false;
	
	document.location='/g_delete?boardNum='+$('#boardNum').val();
	return false;
})
.on('click','#btnUpdate',function(){
	document.location='/g_update?boardNum='+$('#boardNum').val();
	return false;
})
.on('click','#writeComment',function(){
	if(${name==''}){
	alert("댓글을 쓰려면 로그인하세요");
	return false;
	}
    if ($('#commentBox').css('display') == 'block') {
        $('#commentBox').css('display', 'none');
        $('#sendComment').css('display', 'none');
    } else {
        $('#commentBox').css('display', 'block');
        $('#sendComment').css('display', 'block');
    }
})
</script>
</html>