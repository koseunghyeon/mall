<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시판</title>
<link rel="stylesheet" href="css/g_board.css">
</head>
<body>
    <header>
        <h1>게시판</h1>
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
	<div style='text-align:right;'>
	<c:if test="${name==''}">
	</c:if>
	<c:if test="${name != ''}">
	<input type="button" id="btnSend" value="작성">
	</c:if>
	</div>
    <main>
        <table>
            <thead>
                <tr>
                    <th>번호</th>
                    <th style="width:500px">제목</th>
                    <th>작성자</th>
                    <th>최종수정일</th>
                    <th>조회수</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach items="${getBoard}" var="getBoard">
                <tr>
                    <td>${getBoard.num}</td>
                    <td><a href="/g_view?boardNum=${getBoard.num}">${getBoard.title}</a></td>
                    <td>${getBoard.userid}</td>
                    <td>${getBoard.updated}</td>
                    <td>${getBoard.hit}</td>
                </tr>
            </c:forEach>
                <tr>
            </tbody>
        </table>
    </main>
</body>
<script src='https://code.jquery.com/jquery-Latest.js'></script>
<script>
$(document)
.on('click','#boardUl > li',function(){
	alert($(this).attr("id"));
})
.on('click','#btnSend',function(){
	document.location="/g_write"
})
</script>
</html>